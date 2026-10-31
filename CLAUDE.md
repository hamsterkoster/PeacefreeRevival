# Peacefree: Tactical Warfare - Revival

## Goal
Revive "Peacefree: Tactical Warfare" (by Helgravis, an abandoned Kongregate Flash game) from its original .swf:
1. Make it run smoothly (it lags badly now).
2. Unlock the premium features. Kongregate's purchase service shut down with Flash, so they can no longer be bought or verified.
3. Quality-of-life changes, no gameplay changes, then a public release of this Flash version for fans.
4. Later: a refactored version (to-do 4 decides how) that's moddable (new levels, enemies, mechanics).

Only the user plays it for now. Don't build what's under "Later" in docs/todo.md until asked.

## User and environment
- Windows 11, PowerShell in the VS Code terminal.
- git 2.56, Java 8 (1.8.0_431), Python 3.13, winget, gh (signed in as HaminKo). No Node.
- GitHub: the repo is hamsterkoster/PeacefreeRevival (private), owned by the hamsterkoster organization; pushes and gh use the HaminKo account, an admin of it.
- Real paths: docs/local.md (gitignored).

## Folder layout
- `original/`: the original .swf files, gitignored (SHA-256 in NOTES.md). Never edit, move or overwrite anything here.
- `decompiled/`: ffdec output, one folder per .swf, made by `scripts/decompile.py`. Scripts, texts and binaryData are tracked; exported media is gitignored.
- `src/`: our edited copies of only the classes we patch, same layout as `decompiled/PeacefreeKong/scripts/`, tracked.
- `patched/`: rebuilt .swf files with versioned names (`PeacefreeKong-vNN-name.swf`), made by `scripts/build.py`, gitignored (SHA-256 in NOTES.md); never overwrite an older one.
- `scripts/`: our own scripts (Python), tracked.
- `tools/`: downloaded tools (ffdec, Ruffle, Flash Player projector), gitignored.
- `NOTES.md`: log of every patch, build and test result.

Git doesn't track empty folders; each shows up in the repo once it holds files.

## Working style
- One to-do per chat, built with the /build-todo skill (`/build-todo N`, or `/build-todo N, step B` for one step of a bigger to-do); new ones written with /add-todo.
- Commit after each working step; end a step with the finish-step skill.
- If a change breaks the rebuild or the game, revert to the last working commit instead of piling on fixes.
- Installing tools (into `tools/` or with winget) is fine; ask before anything else outside this folder or anything that can't be undone.

## Build specifics
- Checks:
  - Fast, after edits: `.venv/Scripts/ruff check scripts` (under 1 s).
  - Slow, once per step, each in its own call:
    - Rebuild: `.venv/Scripts/python scripts/build.py vNN-name` (about 16 s) must end with the SHA-256 line.
    - Headless Ruffle: `.venv/Scripts/python scripts/check.py patched/PeacefreeKong-vNN-name.swf` (about 7 s; a fail takes 60 s) must print PASS. It also lists blocked network requests and Ruffle's errors.
    - Premium: the same with `--premium` before the file (about 11 s) must print PASS (Shop button on the campaign screen).
    - Shared save: the same with `--shared-save` before the file (about 6 s) must print PASS (the save is under the root path).
    - Settings: the same with `--settings` before the file (about 15 s) must print PASS (Settings on the title screen opens the options panel, dragging the muted music slider saves 75% and unmutes, Back closes it).
- Re-decompile (not a per-step check; only after an ffdec update, on a committed tree): `.venv/Scripts/python scripts/decompile.py` (about 4 s) must end with "All scripts decompiled without errors." It refuses to replace a folder with uncommitted changes.
- Docs to update when behaviour changes: NOTES.md (patches, test results, the patched-files list); docs/research/ (findings and dead ends, by topic); docs/decisions.md; docs/local.md (run commands); README.md (status, setup, build and play steps, Credits; when a section grows past about a screen, move it into docs/NAME.md and link it from the README).
- Must keep working: the game reaches its title screen (the headless check); in patched builds, P shows and hides the FPS box, premium is unlocked (the premium check), all builds share one save (the shared-save check), the Settings button opens the options panel on the title and campaign screens and its volume sliders are saved (the settings check covers the title), mute pauses and unmute continues the same song (a projector test: the checks can't hear), and resizing the projector window doesn't stop the game.
- Review checklist: none yet: the built-in code-review skill. Add docs/review.md once the project has its own rules to check.

## Status
Done: To do 1-3 and 5-7 (latest build v13); what each added: README.md Status and NOTES.md.
Next: To do 8 (game options: start speed, fullscreen, window sizes).

## Decisions
One line per decision a chat must follow. Reasons, who decided and what was rejected: docs/decisions.md. The gitignore rules in Folder layout come from there too.
- Private now, public later: "Never in tracked files" applies from the first commit.
- Play in the Flash Player projector; no fixes for Ruffle. Ruffle's web version is only the headless smoke test.
- Patches are edited copies of whole classes in `src/`, compiled in with ffdec's `-replace`; `decompiled/` stays exactly the original.
- The game's Kongregate API key stays in the tracked decompiled code: it's the developer's, not an account token.
- Kongregate is replaced by an offline stand-in (`src/game/library/KongregateAPI.as`): premium owned, bombs counted locally, no network calls.
- The options menu's "Unlock All Acts" button stays in every build until the public-release decision.
- Starling's `handleLostContext` stays on (`src/StarlingPreloader.as`): without it, resizing the projector window kills the game.
- All builds share one save: `src/game/library/FileLibrary.as` passes `"/"` to `getLocal`; save names stay `game` and `save-N`.
- One options panel (`OptionsInterfacer`) for the mission, title and campaign screens; it's outside a mission when the screen passes a callback (`inMission()`), never judged from `pgame.map`.
- The Flash version gets quality-of-life changes only, no new gameplay changes; gameplay changes and modding wait for the refactored version (roadmap: to-dos 7-9, release 10, refactor 4).
- Music and SFX volume (0-100%) live in their own `settings` save, read and written by `src/game/library/SoundLibrary.as`; the mute flags stay in the game's save, and the mute icons stay the way to mute.
- Mute pauses and unmute continues the song (`SoundLibrary.pauseBGM`/`resumeBGM`; a paused song counts as playing in `isBGMPlaying`); only screen and story changes stop it for good. Missions go through `src/game/peacefree/Map.as` (`setEnableBGM`, `nextBGM` for the panel's Next button).

## Project docs
- README.md: what the project is, setup, build and play, Credits.
- docs/local.md: this PC's paths and commands (gitignored).
- docs/todo.md: the to-do list.
- docs/decisions.md: every decision with its reason.
- docs/research/: findings by topic: game-code.md (the file, code map, content format, saves), premium.md, network.md, performance.md.
- NOTES.md: patch, build and test log.

## Never in tracked files
The repo goes public later, with its full history.
- Personal paths (user folder, drive paths): they go in docs/local.md.
- Kongregate account names, IDs or tokens (for example from save data or test logs).
