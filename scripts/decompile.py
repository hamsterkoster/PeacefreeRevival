"""Decompile a .swf into decompiled/<name>/ with JPEXS ffdec.

Run from the project folder:
    .venv/Scripts/python scripts/decompile.py [path/to/game.swf] [--force]

The default input is original/PeacefreeKong.swf. The export goes into
decompiled/<name>.new/ first and replaces decompiled/<name>/ only when ffdec
succeeds, so the result always matches the .swf exactly. Refuses to replace a
folder that git shows uncommitted changes in, unless --force is given.
Exports every item type; .gitignore decides what is tracked.
"""

import argparse
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FFDEC_JAR = ROOT / "tools" / "ffdec" / "ffdec-cli.jar"
DECOMPILED = ROOT / "decompiled"
DEFAULT_SWF = ROOT / "original" / "PeacefreeKong.swf"

# Text ffdec writes into a script it could not fully decompile.
FAILURE_MARKERS = re.compile(r"Decompilation error|Not decompiled due to timeout|§§[a-z]+\(")


def ffdec_problem() -> str | None:
    """Why ffdec can't run (missing jar or java), or None when it can."""
    if not FFDEC_JAR.is_file():
        return f"ffdec not found at {FFDEC_JAR} (unzip the ffdec release zip into tools/ffdec/)"
    if shutil.which("java") is None:
        return "java is not on PATH"
    return None


def output_dir_for(swf: Path) -> Path:
    """The export folder for a .swf: decompiled/<file name without .swf>."""
    out = (DECOMPILED / swf.stem).resolve()
    if out.parent != DECOMPILED.resolve():
        raise ValueError(f"refusing to use a folder outside {DECOMPILED}: {out}")
    return out


def has_uncommitted_changes(folder: Path) -> bool:
    """True if git shows changed, deleted or new files in folder (gitignored media don't count)."""
    try:
        result = subprocess.run(
            ["git", "status", "--porcelain", "--", str(folder)],
            cwd=ROOT,
            capture_output=True,
            text=True,
            check=False,
        )
    except FileNotFoundError:  # no git installed, so no history to protect
        return False
    return bool(result.stdout.strip())


def failed_scripts(out: Path) -> list[Path]:
    """Exported scripts that contain one of ffdec's failure markers."""
    return [
        path
        for path in sorted((out / "scripts").rglob("*.as"))
        if FAILURE_MARKERS.search(path.read_text(encoding="utf-8", errors="replace"))
    ]


def main() -> int:
    parser = argparse.ArgumentParser(description="Decompile a .swf into decompiled/<name>/ with ffdec.")
    parser.add_argument("swf", nargs="?", type=Path, default=DEFAULT_SWF, help="the .swf file (default: %(default)s)")
    parser.add_argument("--force", action="store_true", help="replace the folder even if it has uncommitted changes")
    args = parser.parse_args()
    swf = args.swf.resolve()

    if not swf.is_file():
        print(f"error: file not found: {swf}", file=sys.stderr)
        return 1
    problem = ffdec_problem()
    if problem:
        print(f"error: {problem}", file=sys.stderr)
        return 1
    try:
        out = output_dir_for(swf)
    except ValueError as error:
        print(f"error: {error}", file=sys.stderr)
        return 1
    shown = out.relative_to(ROOT)
    if not args.force and has_uncommitted_changes(out):
        print(f"error: {shown} has uncommitted changes (see git status); commit them first,", file=sys.stderr)
        print("or re-run with --force to replace them with a fresh export", file=sys.stderr)
        return 1

    staging = out.with_name(out.name + ".new")
    try:
        if staging.exists():
            shutil.rmtree(staging)
        start = time.monotonic()
        command = ["java", "-jar", str(FFDEC_JAR), "-export", "all", str(staging), str(swf)]
        result = subprocess.run(command, check=False)
        seconds = time.monotonic() - start
        if result.returncode != 0:
            shutil.rmtree(staging, ignore_errors=True)
            print(f"error: ffdec exited with code {result.returncode}; {shown} was left unchanged", file=sys.stderr)
            return result.returncode
        if not staging.is_dir():  # ffdec still exits 0 when it can't read the file
            print(f"error: ffdec exported nothing (is {swf.name} a valid .swf?); {shown} was left unchanged", file=sys.stderr)
            return 1
        if out.exists():
            shutil.rmtree(out)
        staging.rename(out)
    except OSError as error:
        print(f"error: could not replace {shown}: {error}", file=sys.stderr)
        print("Close any program using files there, then re-run with --force.", file=sys.stderr)
        return 1

    print(f"\nExported {swf.name} to {shown} in {seconds:.1f} s")
    for folder in sorted(p for p in out.iterdir() if p.is_dir()):
        count = sum(1 for p in folder.rglob("*") if p.is_file())
        if count:
            print(f"  {folder.name}: {count} files")

    failed = failed_scripts(out)
    if failed:
        print(f"warning: {len(failed)} scripts were not fully decompiled:", file=sys.stderr)
        for path in failed:
            print(f"  {path.relative_to(out)}", file=sys.stderr)
        return 2
    print("All scripts decompiled without errors.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
