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
- `original/`: the original .swf files. Never edit, move or overwrite anything here.
- `decompiled/`: ffdec output. Scripts, texts and binaryData are tracked; exported media is gitignored.
- `patched/`: rebuilt .swf files with versioned names; never overwrite an older one.
- `scripts/`: our own scripts (Python), tracked.
- `tools/`: downloaded tools (ffdec, Ruffle, Flash Player projector), gitignored.
- `NOTES.md`: log of every patch, finding and test result.

Each folder is created by the to-do that first uses it.

## Working style
- One to-do per chat, built with the /build-todo skill ("Build To do N"); new ones written with /add-todo.
- Commit after each working step; end a step with the finish-step skill.
- If a change breaks the rebuild or the game, revert to the last working commit instead of piling on fixes.
- Installing tools (into `tools/` or with winget) is fine; ask before anything else outside this folder or anything that can't be undone.

## Build specifics
- Checks:
  - Fast, after edits: `ruff check scripts` (a few seconds; once `scripts/` exists).
  - Slow, once per step (from to-do 2 on): the patched .swf rebuilds with ffdec without errors, and a headless Ruffle screenshot (Playwright) shows the game past the loading screen. Commands and measured times get added by to-do 2.
- Docs to update when behaviour changes: NOTES.md (patches, findings, test results, the patched-files list); docs/local.md (run commands); README.md once it exists.
- Must keep working: nothing yet.
- Review checklist: none yet: the built-in code-review skill. Add docs/review.md once the project has its own rules to check.

## Status
Next: To do 1 (inspect and decompile). Needs the .swf files in `original/` first.

## Decisions
Decisions go here with their reason.
- Private now, public later (2026-10-30, user's decision): premium can no longer be bought, and Helgravis didn't answer requests about a re-release. Git history goes public with the repo, so "Never in tracked files" applies from the first commit.
- `tools/` is gitignored (downloads only); our own scripts live in `scripts/`.
- Decompiled scripts are tracked so patches show as readable diffs; exported media is not (bulky, re-exportable).

## Project docs
- docs/local.md: this PC's paths and commands (gitignored).
- docs/todo.md: the to-do list.
- NOTES.md: patch, finding and test log.

## Never in tracked files
The repo goes public later, with its full history.
- Personal paths (user folder, drive paths): they go in docs/local.md.
- Kongregate account names, IDs or tokens (for example from save data or test logs).
