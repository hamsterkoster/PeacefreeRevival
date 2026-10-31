"""Make the AIR app's two release downloads, an installer and a zip, and check that both work.

Run from the project folder:
    .venv/Scripts/python scripts/release_air.py patched/air/PeacefreeRevival-v21-release-5
    .venv/Scripts/python scripts/release_air.py --check patched/air/PeacefreeRevival-v21-release-5

From an app folder made by package_air.py, it writes next to it <folder>-Setup.exe, built by
Inno Setup from air/installer.iss, and <folder>.zip, with the app's files in a "Peacefree Revival"
folder; it never overwrites either. The installer's names and version come from the descriptor
ADT put in the app.

--check installs the installer silently into a temporary folder, without the desktop shortcut,
checks that the installed app reaches its title screen (package_air.py's check), uninstalls it
silently and checks that its folder, Start menu entry and installed-apps entry are gone. Then it
unzips the zip into a temporary folder and checks that app too. It refuses while the app is
installed for real, whose installed-apps entry a test install would share. Like package_air.py
--check, it starts the app with its real saves, and the uninstall leaves them.
"""

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
import winreg
import zipfile
from pathlib import Path

from build import LABEL, sha256
from decompile import ROOT
from package_air import (
    APP_NAME,
    APPS,
    ICONS,
    PACKAGED_DESCRIPTOR,
    check,
    descriptor_text,
    shown,
)
from PIL import Image

# Installed with winget into tools/ (docs/local.md).
ISCC = ROOT / "tools" / "innosetup" / "ISCC.exe"
INSTALLER_SCRIPT = ROOT / "air" / "installer.iss"
ICON_SIZES = [16, 32, 48, 256]  # the installer's own icon, from air/icons/icon-256.png
# Inno Setup's entry for a per-user install, under the installer's AppId.
UNINSTALL_KEY = r"Software\Microsoft\Windows\CurrentVersion\Uninstall\{}_is1"
START_MENU = Path(os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs")
INSTALL_SECONDS = 120
UNINSTALL_SECONDS = 60


def app_info(folder: Path) -> dict[str, str]:
    """The names and version the installer needs, from the app's own descriptor."""
    descriptor = folder / PACKAGED_DESCRIPTOR
    label = descriptor_text("versionLabel", descriptor)
    return {
        "AppId": descriptor_text("id", descriptor),
        "AppName": descriptor_text("name", descriptor),
        "ExeName": f"{descriptor_text('filename', descriptor)}.exe",
        "AppVersion": label.removeprefix("Revival "),
        "VersionNumber": descriptor_text("versionNumber", descriptor),
    }


def downloads(folder: Path) -> tuple[Path, Path]:
    return folder.with_name(f"{folder.name}-Setup.exe"), folder.with_name(f"{folder.name}.zip")


def app_folder(folder: Path) -> bool:
    """Whether folder is a finished app folder of package_air.py's (not its .tmp while packaging)."""
    name = re.fullmatch(rf"{APP_NAME}-{LABEL.pattern}-\d+", folder.name)
    if folder.parent.resolve() != APPS.resolve() or not name or not (folder / PACKAGED_DESCRIPTOR).is_file():
        print(f"error: {shown(folder)} is not an app folder made by package_air.py, like "
              f"{shown(APPS / f'{APP_NAME}-v21-release-1')}", file=sys.stderr)
        return False
    return True


def make(folder: Path) -> int:
    if not app_folder(folder):
        return 1
    setup, archive = downloads(folder)
    for path in (setup, archive):
        if path.exists():
            print(f"error: {path.relative_to(ROOT)} exists already; delete both to make them again", file=sys.stderr)
            return 1
    if not ISCC.is_file():
        print(f"error: Inno Setup is missing: {ISCC.relative_to(ROOT)} (docs/local.md says how to get it)", file=sys.stderr)
        return 1
    info = app_info(folder)

    # Both are made in a temporary folder and moved next to the app only when both succeed.
    with tempfile.TemporaryDirectory() as temp:
        start = time.monotonic()
        icon = Path(temp, "setup.ico")
        Image.open(ICONS / "icon-256.png").save(icon, sizes=[(size, size) for size in ICON_SIZES])
        defines = {**info, "AppFolder": str(folder), "SetupIcon": str(icon), "OutputDir": temp,
                   "OutputName": setup.stem}
        command = [str(ISCC), "/Q", *(f"/D{name}={value}" for name, value in defines.items()), str(INSTALLER_SCRIPT)]
        result = subprocess.run(command, capture_output=True, text=True, check=False)
        built_setup = Path(temp, setup.name)
        if result.returncode != 0 or not built_setup.is_file():
            print(result.stdout + result.stderr, file=sys.stderr)
            print(f"error: Inno Setup failed (exit code {result.returncode}); nothing was written", file=sys.stderr)
            return 1
        setup_seconds = time.monotonic() - start

        start = time.monotonic()
        built_archive = Path(temp, archive.name)
        with zipfile.ZipFile(built_archive, "w", zipfile.ZIP_DEFLATED, compresslevel=9) as zip_file:
            for path in sorted(folder.rglob("*")):
                if path.is_file():
                    zip_file.write(path, Path(info["AppName"], path.relative_to(folder)).as_posix())
        zip_seconds = time.monotonic() - start
        shutil.move(built_setup, setup)
        shutil.move(built_archive, archive)

    for path, seconds in ((setup, setup_seconds), (archive, zip_seconds)):
        print(f"Made {path.relative_to(ROOT)} in {seconds:.1f} s ({path.stat().st_size:,} bytes), SHA-256 {sha256(path)}")
    return 0


def installed(app_id: str) -> bool:
    """Whether Windows' installed apps list has the app, installed for the current user."""
    try:
        winreg.CloseKey(winreg.OpenKey(winreg.HKEY_CURRENT_USER, UNINSTALL_KEY.format(app_id)))
    except FileNotFoundError:
        return False
    return True


def check_installer(setup: Path, folder: Path, info: dict[str, str], temp: Path) -> list[str]:
    """Install, check and uninstall; the problems found, if any."""
    target = temp / f"{folder.name}-installed"
    shortcut = START_MENU / f"{info['AppName']}.lnk"
    log = temp / "install.log"
    command = [str(setup), "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART", "/MERGETASKS=!desktopicon",
               f"/DIR={target}", f"/LOG={log}"]
    problems = []
    try:
        installer = subprocess.Popen(command)
        try:
            code = installer.wait(INSTALL_SECONDS)
        except subprocess.TimeoutExpired:
            # Setup.exe runs the real installer as a child process: end both.
            subprocess.run(["taskkill", "/T", "/F", "/PID", str(installer.pid)], capture_output=True, check=False)
            installer.wait()
            code = None
        if code != 0:
            last_lines = log.read_text(encoding="utf-8", errors="replace").splitlines()[-5:] if log.is_file() else []
            ended = f"didn't finish in {INSTALL_SECONDS} s" if code is None else f"ended with exit code {code}"
            problems.append(f"the installer {ended}: {' / '.join(last_lines)}")
        else:
            if not shortcut.is_file():
                problems.append(f"no Start menu entry {shortcut.name}")
            if not installed(info["AppId"]):
                problems.append("no entry in Windows' installed apps")
            if check(target, target.name) != 0:
                problems.append("the installed app didn't reach its title screen")
    finally:
        uninstaller = target / "unins000.exe"
        if uninstaller.is_file():
            # The uninstaller runs a copy of itself and ends at once, so the test waits until
            # everything it removes is gone.
            subprocess.run([str(uninstaller), "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART"], check=False)
            start = time.monotonic()
            while leftovers(target, shortcut, info["AppId"]) and time.monotonic() - start < UNINSTALL_SECONDS:
                time.sleep(1)
    left = leftovers(target, shortcut, info["AppId"])
    if left:
        problems.append(f"after uninstalling, still there: {', '.join(left)} "
                        "(uninstall Peacefree Revival in Windows' Settings > Apps)")
    return problems


def leftovers(target: Path, shortcut: Path, app_id: str) -> list[str]:
    """What the uninstaller should have removed but is still there."""
    things = ((f"the folder {target}", target.exists()), (f"the Start menu entry {shortcut.name}", shortcut.exists()),
              ("the installed-apps entry", installed(app_id)))
    return [name for name, there in things if there]


def check_downloads(folder: Path) -> int:
    if not app_folder(folder):
        return 1
    setup, archive = downloads(folder)
    for path in (setup, archive):
        if not path.is_file():
            print(f"error: {path.relative_to(ROOT)} is missing; make it first (without --check)", file=sys.stderr)
            return 1
    info = app_info(folder)
    if installed(info["AppId"]):
        print(f"error: {info['AppName']} is installed; uninstall it first (Windows' Settings > Apps), since a test "
              "install would share its installed-apps entry", file=sys.stderr)
        return 1

    # A closed app may hold its files for a moment; a leftover temporary file does no harm.
    with tempfile.TemporaryDirectory(ignore_cleanup_errors=True) as temp:
        problems = check_installer(setup, folder, info, Path(temp))
        unzipped = Path(temp, f"{folder.name}-unzipped")
        with zipfile.ZipFile(archive) as zip_file:
            zip_file.extractall(unzipped)
        if check(unzipped / info["AppName"], unzipped.name) != 0:
            problems.append("the unzipped app didn't reach its title screen")

    if problems:
        print("FAIL: " + "; ".join(problems), file=sys.stderr)
        return 1
    print(f"PASS: {setup.name} installs, its app starts and it uninstalls; {archive.name}'s app starts")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description="Make the AIR app's installer and zip, or check that both work.")
    parser.add_argument("folder", type=Path, help="an app folder in patched/air/, made by package_air.py")
    parser.add_argument("--check", action="store_true", help="install, start and uninstall the installer's app, "
                        "and start the zip's")
    args = parser.parse_args()
    folder = args.folder.resolve()
    return check_downloads(folder) if args.check else make(folder)


if __name__ == "__main__":
    sys.exit(main())
