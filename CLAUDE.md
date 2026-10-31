# Peacefree: Tactical Warfare - Revival

## Goal
Revive "Peacefree: Tactical Warfare" (by Helgravis, an abandoned Kongregate Flash game) from its original .swf:
1. Make it run smoothly (it lags badly now).
2. Unlock the premium features. Kongregate's purchase service shut down with Flash, so they can no longer be bought or verified.
3. Later: make it moddable (new levels, enemies, mechanics).

Only the user plays it for now; a public release for fans is planned later.

## User and environment
- Windows 11, PowerShell in the VS Code terminal.
- git 2.56, Java 8 (1.8.0_431), Python 3.13, winget, gh (signed in as HaminKo). No Node.
- Real paths: docs/local.md (gitignored).

## Folder layout
- `original/`: the original .swf files, gitignored (SHA-256 in NOTES.md). Never edit, move or overwrite anything here.
- `decompiled/`: ffdec output, one folder per .swf, made by `scripts/decompile.py`. Scripts, texts and binaryData are tracked; exported media is gitignored.
- `src/`: our edited copies of only the classes we patch, same layout as `decompiled/PeacefreeKong/scripts/`, tracked.
- `patched/`: rebuilt .swf files with versioned names (`PeacefreeKong-vNN-name.swf`), made by `scripts/build.py`, gitignored (SHA-256 in NOTES.md); never overwrite an older one.
- `scripts/`: our own scripts (Python), tracked.
- `tools/`: downloaded tools (ffdec, Ruffle, Flash Player projector), gitignored.
- `NOTES.md`: log of every patch, finding and test result.

Git doesn't track empty folders; each shows up in the repo once it holds files.

## Working style
- One to-do per chat, built with the /build-todo skill ("Build To do N"); new ones written with /add-todo.
- Commit after each working step; end a step with the finish-step skill.
- If a change breaks the rebuild or the game, revert to the last working commit instead of piling on fixes.
- Installing tools (into `tools/` or with winget) is fine; ask before anything else outside this folder or anything that can't be undone.

## Build specifics
- Checks:
  - Fast, after edits: `.venv/Scripts/ruff check scripts` (under 1 s).
  - Slow, once per step, each in its own call:
    - Rebuild: `.venv/Scripts/python scripts/build.py vNN-name` (about 16 s) must end with the SHA-256 line.
    - Headless Ruffle: `.venv/Scripts/python scripts/check.py patched/PeacefreeKong-vNN-name.swf` (about 7 s; a fail takes 60 s) must print PASS. It also lists blocked network requests and Ruffle's errors.
- Re-decompile (not a per-step check; only after an ffdec update, on a committed tree): `.venv/Scripts/python scripts/decompile.py` (about 4 s) must end with "All scripts decompiled without errors." It refuses to replace a folder with uncommitted changes.
- Docs to update when behaviour changes: NOTES.md (patches, findings, test results, the patched-files list); docs/local.md (run commands); README.md once it exists.
- Must keep working: the game reaches its title screen (the headless check); in patched builds, P shows and hides the FPS box.
- Review checklist: none yet: the built-in code-review skill. Add docs/review.md once the project has its own rules to check.

## Status
Done: To do 1 (decompiled into `decompiled/PeacefreeKong/`; findings in NOTES.md), To do 2 (performance: the projector runs it at about 60 fps; build, check and play scripts).
Next: To do 3 (premium unlock).

## Decisions
Decisions go here with their reason.
- Private now, public later (2026-10-30, user's decision): premium can no longer be bought, and Helgravis didn't answer requests about a re-release. Git history goes public with the repo, so "Never in tracked files" applies from the first commit.
- `tools/` is gitignored (downloads only); our own scripts live in `scripts/`.
- Decompiled scripts are tracked so patches show as readable diffs; exported media is not (bulky, re-exportable).
- `original/` is gitignored (2026-10-30, user's decision): Helgravis's .swf stays out of the public history, the hardest thing to take back later. Its SHA-256 in NOTES.md proves which file we worked from.
- `patched/*.swf` is gitignored too (2026-10-30, follows from the decision above): each build contains the whole original. `src/` and `scripts/build.py` make it again; its SHA-256 goes in NOTES.md.
- Play in the Flash Player projector; no fixes for Ruffle (2026-10-30, user's decision, to-do 2): the projector ran the game at about 60 fps, the Ruffle app at about 40 and Ruffle in the browser at 15-20, and Ruffle drew some graphics wrong. The headless check still uses Ruffle's web version, as a smoke test that a build loads.
- Patches live in `src/` as edited copies of whole classes, compiled in with ffdec's `-replace` (2026-10-30, to-do 2): `decompiled/` stays exactly the original, and `git diff --no-index` shows each patch.

## Project docs
- docs/local.md: this PC's paths and commands (gitignored).
- docs/todo.md: the to-do list.
- NOTES.md: patch, finding and test log.

## Never in tracked files
The repo goes public later, with its full history.
- Personal paths (user folder, drive paths): they go in docs/local.md.
- Kongregate account names, IDs or tokens (for example from save data or test logs).
