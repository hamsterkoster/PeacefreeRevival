"""Build a patched .swf: the original with our edited classes from src/ swapped in.

Run from the project folder:
    .venv/Scripts/python scripts/build.py v01-fpsmeter

Checks that original/PeacefreeKong.swf is unchanged (its SHA-256 from NOTES.md),
then compiles every .as file under src/ into a copy of it with ffdec's -replace and
writes patched/PeacefreeKong-<label>.swf. src/ uses the same folder layout as
decompiled/PeacefreeKong/scripts/, so src/game/peacefree/Map.as replaces the class
game.peacefree.Map. Never overwrites an existing patched file.
"""

import argparse
import hashlib
import re
import subprocess
import sys
import time
from pathlib import Path

from decompile import DEFAULT_SWF, FFDEC_JAR, ROOT, ffdec_problem

# The same SHA-256 as "Original file" in NOTES.md; change both together.
ORIGINAL_SHA256 = "3faa86dcb2ae923a149957778535d2a2ebbb5820a9fc4dbfd6ae011b958ad943"
SRC = ROOT / "src"
PATCHED = ROOT / "patched"
LABEL = re.compile(r"v\d{2,}-[a-z0-9]+(-[a-z0-9]+)*")


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def class_name(source: Path) -> str:
    """The AS3 class a file in src/ replaces: src/game/peacefree/Map.as -> game.peacefree.Map."""
    return ".".join(source.relative_to(SRC).with_suffix("").parts)


def main() -> int:
    parser = argparse.ArgumentParser(description="Build patched/PeacefreeKong-<label>.swf from the original and src/.")
    parser.add_argument("label", help="version and short name, for example v01-fpsmeter")
    args = parser.parse_args()

    if not LABEL.fullmatch(args.label):
        print(f"error: label {args.label!r} must look like v01-fpsmeter (lowercase, digits, dashes)", file=sys.stderr)
        return 1
    out = PATCHED / f"{DEFAULT_SWF.stem}-{args.label}.swf"
    version = args.label.split("-")[0]
    used = sorted(PATCHED.glob(f"{DEFAULT_SWF.stem}-{version}-*.swf"))
    if used:
        print(f"error: {used[0].relative_to(ROOT)} already uses {version}; use a new version number", file=sys.stderr)
        return 1
    if not DEFAULT_SWF.is_file():
        print(f"error: the original is missing: {DEFAULT_SWF.relative_to(ROOT)}", file=sys.stderr)
        return 1
    if sha256(DEFAULT_SWF) != ORIGINAL_SHA256:
        print(f"error: {DEFAULT_SWF.relative_to(ROOT)} does not match the SHA-256 in NOTES.md", file=sys.stderr)
        return 1
    problem = ffdec_problem()
    if problem:
        print(f"error: {problem}", file=sys.stderr)
        return 1
    sources = sorted(SRC.rglob("*.as"))
    if not sources:
        print("error: no .as files in src/", file=sys.stderr)
        return 1

    # Compile into a temporary file (gitignored) and rename it only when ffdec succeeds.
    PATCHED.mkdir(exist_ok=True)
    staging = out.with_name(out.name + ".tmp")
    staging.unlink(missing_ok=True)
    command = ["java", "-jar", str(FFDEC_JAR), "-replace", str(DEFAULT_SWF), str(staging)]
    for source in sources:
        command += [class_name(source), str(source)]
    start = time.monotonic()
    result = subprocess.run(command, capture_output=True, text=True, check=False)
    seconds = time.monotonic() - start
    # ffdec's -export exits 0 after some failures (see decompile.py), so the log is checked
    # too: ffdec reports compile errors as Java log lines that start with "SEVERE:".
    severe = re.search(r"^SEVERE:", result.stdout + result.stderr, re.MULTILINE)
    if result.returncode != 0 or not staging.is_file() or severe:
        staging.unlink(missing_ok=True)
        print(result.stdout + result.stderr, file=sys.stderr)
        print(f"error: ffdec failed (exit code {result.returncode}); nothing was written", file=sys.stderr)
        return 1
    staging.rename(out)

    print(f"Built {out.relative_to(ROOT)} in {seconds:.1f} s ({out.stat().st_size:,} bytes), with:")
    for source in sources:
        print(f"  {class_name(source)}")
    print(f"SHA-256 {sha256(out)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
