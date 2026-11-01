"""Package a patched .swf as a Windows app with its own AIR runtime, and check that it starts.

Run from the project folder:
    .venv/Scripts/python scripts/package_air.py patched/PeacefreeKong-v21-release.swf
    .venv/Scripts/python scripts/package_air.py --check patched/air/PeacefreeRevival-v21-release-1

Packaging copies the .swf into a temporary folder as Peacefree.swf, next to air/application.xml
with its version filled in from TitleScreen.REVIVAL_VERSION, the icons from air/icons/ and
air/README.txt with the same version (the release's readme, shown by the installer), and runs the AIR SDK's ADT with
-target bundle -arch x64: a 64-bit app with the runtime in its folder (AIR's free tier adds a
splash screen). It writes patched/air/PeacefreeRevival-<label>-N/, after the .swf's label with
the next free N, so it never overwrites an older folder.

--check starts the folder's .exe and takes a picture of its window every second until the
title screen's blue PEACEFREE logo shows (as check.py does), or 60 s pass, then closes its window.
The picture comes from the window itself, so it works with other windows over it. It runs the real app with the real saves (in AppData, in a folder named after the descriptor's
<id>), like a player who starts the game and quits on the title screen: the game writes its
save as it starts (measured in to-do 12), a new empty one if there was none.
"""

import argparse
import ctypes
import lzma
import re
import secrets
import shutil
import subprocess
import sys
import tempfile
import time
import xml.etree.ElementTree as ET
import zlib
from ctypes import wintypes
from io import BytesIO
from pathlib import Path

from build import LABEL, PATCHED
from check import (
    LOGO_AREA,
    MIN_LOGO_BLUE,
    SCREENSHOTS,
    TIMEOUT_SECONDS,
    is_logo_blue,
    share,
)
from decompile import DEFAULT_SWF, ROOT
from PIL import Image

# Change the folder name with an SDK update (it comes through Wipro's AIR SDK Manager).
ADT_JAR = ROOT / "tools" / "air" / "AIRSDK_51.5.1" / "lib" / "adt.jar"
# ADT signs the package inside the app; a self-signed certificate does (Windows doesn't see it,
# so the .exe stays unsigned). Made on first use, with a random password next to it.
CERTIFICATE = ROOT / "tools" / "air" / "peacefree-revival.p12"
CERTIFICATE_PASSWORD = CERTIFICATE.with_suffix(".password")
DESCRIPTOR = ROOT / "air" / "application.xml"
ICONS = ROOT / "air" / "icons"  # the descriptor's <icon> files, packaged as icons/
README = ROOT / "air" / "README.txt"  # packaged next to the .exe, with its {version} filled in
PACKAGED_DESCRIPTOR = Path("META-INF", "AIR", "application.xml")  # in an app folder, as ADT filled it in
TITLE_SCREEN = ROOT / "src" / "game" / "peacefree" / "TitleScreen.as"
APPS = PATCHED / "air"
APP_NAME = "PeacefreeRevival"
CONTENT = "Peacefree.swf"  # the descriptor's <content>
GAME_WIDTH, GAME_HEIGHT = 800, 540  # the size LOGO_AREA is measured in
REVIVAL_VERSION = re.compile(r'REVIVAL_VERSION:String = "(Revival (\d+(?:\.\d+){0,2}))"')
DPI_AWARENESS_UNAWARE = ctypes.c_void_p(-1)
WM_CLOSE = 0x0010
PW_CLIENTONLY = 0x1
PW_RENDERFULLCONTENT = 0x2


def shown(path: Path) -> Path:
    """The path to print: relative to the project folder when it's in it."""
    return path.resolve().relative_to(ROOT) if path.resolve().is_relative_to(ROOT) else path


def descriptor_text(name: str, descriptor: Path = DESCRIPTOR) -> str:
    """The text of the descriptor's top-level or initialWindow element of this name."""
    root = ET.parse(descriptor).getroot()
    text = root.findtext(f"{{*}}{name}") or root.findtext(f"{{*}}initialWindow/{{*}}{name}")
    if not text:
        raise SystemExit(f"error: no <{name}> in {shown(descriptor)}")
    return text


def revival_version() -> tuple[str, str]:
    """TitleScreen.REVIVAL_VERSION in src/, and AIR's three-part number: ("Revival 1.0", "1.0.0")."""
    match = REVIVAL_VERSION.search(TITLE_SCREEN.read_text(encoding="utf-8"))
    if not match:
        raise SystemExit(f"error: no REVIVAL_VERSION like \"Revival 1.0\" in {TITLE_SCREEN.relative_to(ROOT)}")
    label, number = match.groups()
    parts = number.split(".")
    return label, ".".join(parts + ["0"] * (3 - len(parts)))


def swf_body(swf: Path) -> bytes:
    """The .swf's contents after its 8-byte header, uncompressed (ffdec's builds are LZMA, ZWS)."""
    data = swf.read_bytes()
    if data[:3] == b"CWS":
        return zlib.decompress(data[8:])
    if data[:3] == b"ZWS":
        # After the header: the compressed length (4 bytes), LZMA's properties (5) and the stream.
        # As an .lzma file, the properties and the uncompressed size (8 bytes) come first; the size
        # is given as unknown, because ffdec ends the stream with an end marker, which liblzma
        # rejects as corrupt when the size is given (measured in to-do 12).
        unknown_size = b"\xff" * 8
        return lzma.LZMADecompressor(lzma.FORMAT_ALONE).decompress(data[12:17] + unknown_size + data[17:])
    return data[8:]


def filled_descriptor(label: str, number: str) -> str:
    """The descriptor with this <versionLabel> and <versionNumber>."""
    text = DESCRIPTOR.read_text(encoding="utf-8")
    text, numbers = re.subn(r"<versionNumber>[^<]*</versionNumber>", f"<versionNumber>{number}</versionNumber>", text)
    text, labels = re.subn(r"<versionLabel>[^<]*</versionLabel>", f"<versionLabel>{label}</versionLabel>", text)
    if numbers != 1 or labels != 1:
        raise SystemExit(f"error: {DESCRIPTOR.relative_to(ROOT)} needs one <versionNumber> and one <versionLabel>")
    return text


def short_version(label: str) -> str:
    """The version players see in file names and the readme: "1.0" from "Revival 1.0"."""
    return label.removeprefix("Revival ")


def filled_readme(label: str) -> str:
    """air/README.txt with its {version} filled in."""
    text = README.read_text(encoding="utf-8")
    # Plain ASCII, so Inno Setup's info page and Notepad show it the same.
    if "{version}" not in text or not text.isascii():
        raise SystemExit(f"error: {README.relative_to(ROOT)} needs a {{version}} and only plain ASCII characters")
    return text.replace("{version}", short_version(label))


def signing_options() -> list[str]:
    """ADT's options to sign with CERTIFICATE, which it makes first if it's missing."""
    if not CERTIFICATE.is_file():
        password = secrets.token_urlsafe(24)
        command = ["java", "-jar", str(ADT_JAR), "-certificate", "-cn", "Peacefree Revival",
                   "-validityPeriod", "25", "2048-RSA", str(CERTIFICATE), password]
        result = subprocess.run(command, capture_output=True, text=True, check=False)
        if result.returncode != 0 or not CERTIFICATE.is_file():
            raise SystemExit(f"{result.stdout}{result.stderr}error: ADT couldn't make the certificate")
        CERTIFICATE_PASSWORD.write_text(password, encoding="utf-8")
    if not CERTIFICATE_PASSWORD.is_file():
        raise SystemExit(f"error: {CERTIFICATE_PASSWORD.relative_to(ROOT)} is missing; delete "
                         f"{CERTIFICATE.relative_to(ROOT)} too, and the next run makes a new certificate")
    password = CERTIFICATE_PASSWORD.read_text(encoding="utf-8").strip()
    return ["-storetype", "pkcs12", "-keystore", str(CERTIFICATE), "-storepass", password]


def folder_size(folder: Path) -> tuple[int, int]:
    files = [path for path in folder.rglob("*") if path.is_file()]
    return len(files), sum(path.stat().st_size for path in files)


def package(swf: Path) -> int:
    label = swf.stem.removeprefix(f"{DEFAULT_SWF.stem}-")
    if swf.parent.resolve() != PATCHED.resolve() or not LABEL.fullmatch(label):
        print(f"error: {swf} is not a patched build like patched/{DEFAULT_SWF.stem}-v21-release.swf", file=sys.stderr)
        return 1
    if not swf.is_file():
        print(f"error: {swf} doesn't exist", file=sys.stderr)
        return 1
    if not ADT_JAR.is_file():
        print(f"error: the AIR SDK is missing: {ADT_JAR.relative_to(ROOT)} (docs/local.md says how to get it)", file=sys.stderr)
        return 1
    # The app's version comes from src/, so the build must be one made from it.
    version_label, version_number = revival_version()
    if version_label.encode() not in swf_body(swf):
        print(f"error: {swf.name} doesn't hold {version_label!r} (TitleScreen.REVIVAL_VERSION in src/); "
              "package a build of the current src/", file=sys.stderr)
        return 1
    count = 1
    while (APPS / f"{APP_NAME}-{label}-{count}").exists():
        count += 1
    out = APPS / f"{APP_NAME}-{label}-{count}"

    # ADT writes into a temporary folder (gitignored), renamed only when it succeeds.
    APPS.mkdir(parents=True, exist_ok=True)
    staging = out.with_name(out.name + ".tmp")
    shutil.rmtree(staging, ignore_errors=True)
    start = time.monotonic()
    with tempfile.TemporaryDirectory() as temp:
        inputs = Path(temp)
        shutil.copyfile(swf, inputs / CONTENT)
        shutil.copytree(ICONS, inputs / ICONS.name)
        (inputs / "application.xml").write_text(filled_descriptor(version_label, version_number), encoding="utf-8")
        (inputs / README.name).write_text(filled_readme(version_label), encoding="ascii", newline="\r\n")
        command = ["java", "-jar", str(ADT_JAR), "-package", *signing_options(), "-target", "bundle", "-arch", "x64",
                   str(staging), str(inputs / "application.xml"), "-C", str(inputs), CONTENT, ICONS.name, README.name]
        result = subprocess.run(command, capture_output=True, text=True, check=False)
    seconds = time.monotonic() - start
    exe = staging / f"{descriptor_text('filename')}.exe"
    if result.returncode != 0 or not exe.is_file():
        shutil.rmtree(staging, ignore_errors=True)
        print(result.stdout + result.stderr, file=sys.stderr)
        print(f"error: ADT failed (exit code {result.returncode}); nothing was written", file=sys.stderr)
        return 1
    staging.rename(out)

    if result.stdout.strip() or result.stderr.strip():
        print((result.stdout + result.stderr).strip())
    files, size = folder_size(out)
    # No SHA-256 of the .exe: it's AIR's launcher with the icons in it, the same in every package
    # with the same icons (measured), so it says nothing about the game inside.
    print(f"Packaged {out.relative_to(ROOT)} in {seconds:.1f} s ({files} files, {size:,} bytes), from {swf.name}")
    return 0


def find_window(pid: int, title: str) -> int | None:
    """The visible top-level window of process pid with this title, if there is one."""
    user32 = ctypes.windll.user32
    found = []

    @ctypes.WINFUNCTYPE(wintypes.BOOL, wintypes.HWND, wintypes.LPARAM)
    def visit(hwnd, _lparam):
        owner = wintypes.DWORD()
        user32.GetWindowThreadProcessId(hwnd, ctypes.byref(owner))
        text = ctypes.create_unicode_buffer(256)
        user32.GetWindowTextW(hwnd, text, len(text))
        if owner.value == pid and user32.IsWindowVisible(hwnd) and text.value == title:
            found.append(hwnd)
        return True

    user32.EnumWindows(visit, 0)
    return found[0] if found else None


class BITMAPINFOHEADER(ctypes.Structure):
    _fields_ = [("biSize", wintypes.DWORD), ("biWidth", wintypes.LONG), ("biHeight", wintypes.LONG),
                ("biPlanes", wintypes.WORD), ("biBitCount", wintypes.WORD), ("biCompression", wintypes.DWORD),
                ("biSizeImage", wintypes.DWORD), ("biXPelsPerMeter", wintypes.LONG),
                ("biYPelsPerMeter", wintypes.LONG), ("biClrUsed", wintypes.DWORD), ("biClrImportant", wintypes.DWORD)]


def grab_game(hwnd: int) -> bytes:
    """A picture of the game in the window, as an 800x540 PNG. PrintWindow has the window draw
    itself, so other windows over it don't matter, and it includes the game's Stage3D drawing
    (both measured in to-do 12). StarlingPreloader.fitToWindow scales the game to fit the
    window's inside and centres it, with black bars."""
    user32, gdi32 = ctypes.windll.user32, ctypes.windll.gdi32
    inside = wintypes.RECT()
    user32.GetClientRect(hwnd, ctypes.byref(inside))
    width, height = inside.right, inside.bottom
    window_dc = user32.GetDC(hwnd)
    memory_dc = gdi32.CreateCompatibleDC(window_dc)
    bitmap = gdi32.CreateCompatibleBitmap(window_dc, width, height)
    gdi32.SelectObject(memory_dc, bitmap)
    user32.PrintWindow(hwnd, memory_dc, PW_CLIENTONLY | PW_RENDERFULLCONTENT)
    header = BITMAPINFOHEADER(ctypes.sizeof(BITMAPINFOHEADER), width, -height, 1, 32)  # rows top-down
    pixels = ctypes.create_string_buffer(width * height * 4)
    gdi32.GetDIBits(memory_dc, bitmap, 0, height, pixels, ctypes.byref(header), 0)
    gdi32.DeleteObject(bitmap)
    gdi32.DeleteDC(memory_dc)
    user32.ReleaseDC(hwnd, window_dc)
    window = Image.frombuffer("RGB", (width, height), pixels, "raw", "BGRX", 0, 1)
    scale = min(width / GAME_WIDTH, height / GAME_HEIGHT)
    game_width, game_height = round(GAME_WIDTH * scale), round(GAME_HEIGHT * scale)
    left, top = (width - game_width) // 2, (height - game_height) // 2
    game = window.crop((left, top, left + game_width, top + game_height)).resize((GAME_WIDTH, GAME_HEIGHT))
    png = BytesIO()
    game.save(png, "PNG")
    return png.getvalue()


def check(folder: Path, name: str = "") -> int:
    """PASS if the app in folder reaches its title screen; its screenshot is named after name,
    or the folder."""
    descriptor = folder / PACKAGED_DESCRIPTOR
    if not descriptor.is_file():
        print(f"error: {shown(folder)} is not an app folder (no {PACKAGED_DESCRIPTOR.as_posix()})", file=sys.stderr)
        return 1
    exe = folder / f"{descriptor_text('filename', descriptor)}.exe"
    if not exe.is_file():
        print(f"error: no {exe.name} in {folder}", file=sys.stderr)
        return 1
    title = descriptor_text("title", descriptor)
    # PrintWindow draws the window at its own size; AIR's windows ignore Windows' display scaling,
    # and so does this process then, so GetClientRect gives the same size (measured at 150%).
    ctypes.windll.user32.SetProcessDpiAwarenessContext(DPI_AWARENESS_UNAWARE)
    SCREENSHOTS.mkdir(exist_ok=True)
    screenshot = SCREENSHOTS / f"check-air-{name or folder.name}.png"
    png = hwnd = None
    error = f"no title screen after {TIMEOUT_SECONDS} s"
    start = time.monotonic()
    app = subprocess.Popen([str(exe)])
    try:
        while time.monotonic() - start < TIMEOUT_SECONDS:
            time.sleep(1)
            if app.poll() is not None:
                error = f"the app closed after {time.monotonic() - start:.0f} s (exit code {app.returncode})"
                break
            hwnd = find_window(app.pid, title)
            if hwnd is None:
                error = f"no window titled {title!r} after {TIMEOUT_SECONDS} s"
                continue
            error = f"no title screen after {TIMEOUT_SECONDS} s"
            png = grab_game(hwnd)
            if share(png, LOGO_AREA, is_logo_blue) >= MIN_LOGO_BLUE:
                error = ""
                break
        seconds = time.monotonic() - start
    finally:
        # Closing the window ends the app the way a player does, so it can finish writing its
        # save (it writes one on start-up); ended by force only when that doesn't work.
        if hwnd and app.poll() is None:
            ctypes.windll.user32.PostMessageW(hwnd, WM_CLOSE, 0, 0)
        try:
            app.wait(10)
        except subprocess.TimeoutExpired:
            app.terminate()
            app.wait(10)
    if png:
        screenshot.write_bytes(png)

    picture = screenshot.relative_to(ROOT) if png else "none"
    if not error:
        print(f"PASS: {exe.name} shows the title screen after {seconds:.0f} s (screenshot: {picture})")
        return 0
    print(f"FAIL: {exe.name}: {error} (last screenshot: {picture})", file=sys.stderr)
    return 1


def main() -> int:
    parser = argparse.ArgumentParser(description="Package a patched .swf as a Windows AIR app, or check that one starts.")
    parser.add_argument("target", type=Path, help="a patched .swf to package, or with --check an app folder in patched/air/")
    parser.add_argument("--check", action="store_true", help="start the app and wait for its title screen")
    args = parser.parse_args()
    return check(args.target) if args.check else package(args.target)


if __name__ == "__main__":
    sys.exit(main())
