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
- git 2.56, Java 8 (1.8.0_431), Python 3.13, winget, gh (signed in). No Node.
- GitHub: the repo is hamsterkoster/PeacefreeRevival (private), owned by the hamsterkoster organization; pushes and gh use a personal account, an admin of it (named in docs/local.md).
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
    - Settings: the same with `--settings` before the file (about 40-55 s) must print PASS (Settings on the title screen opens the options panel, dragging the muted music slider saves 75% and unmutes, the Start Speed row's 1x is saved, Controls opens its page and the page's Back returns, Back closes it).
    - Mission: the same with `--mission` before the file (about 60-80 s) must print PASS (the settings steps, then Unlock All Acts, Act 2 starts at the saved 1x).
    - Resize: the same with `--resize` before the file (about 15 s) must print PASS (a 1400x810 player shows the game at 1200x810 with black bars; Settings clicked at its scaled place opens the panel).
- Re-decompile (not a per-step check; only after an ffdec update, on a committed tree): `.venv/Scripts/python scripts/decompile.py` (about 4 s) must end with "All scripts decompiled without errors." It refuses to replace a folder with uncommitted changes.
- Docs to update when behaviour changes: NOTES.md (patches, test results, the patched-files list); docs/research/ (findings and dead ends, by topic); docs/decisions.md; docs/local.md (run commands); README.md (status, setup, build and play steps, Credits; when a section grows past about a screen, move it into docs/NAME.md and link it from the README).
- Must keep working: the game reaches its title screen (the headless check); in patched builds, P shows and hides the FPS box, premium is unlocked (the premium check), all builds share one save (the shared-save check), the Settings button opens the options panel on the title and campaign screens, its volume sliders are saved and its Controls page opens (the settings check covers the title), mission keys do nothing while the panel is open, a new act other than Act 1 starts at the Start Speed (the mission check), mute pauses and unmute continues the same song (a projector test: the checks can't hear), resizing the projector window doesn't stop the game, the game fits its window with black bars (the resize check covers a bigger player), and the panel's Fullscreen button and Esc work (a projector test).
- Review checklist: none yet: the built-in code-review skill. Add docs/review.md once the project has its own rules to check.

## Status
Done: To do 1-3 and 5-10 (latest build v19; to-do 10 is the release report, docs/research/release.md); what each added: README.md Status and NOTES.md.
Next: To do 11 (release patches); the release decisions are made (docs/decisions.md, 2026-10-31), built in to-dos 11-14.

## Decisions
One line per decision a chat must follow. Reasons, who decided and what was rejected: docs/decisions.md. The gitignore rules in Folder layout come from there too.
- Private now, public later: "Never in tracked files" applies from the first commit.
- Play in the Flash Player projector; no fixes for Ruffle. Ruffle's web version is only the headless smoke test.
- Patches are edited copies of whole classes in `src/`, compiled in with ffdec's `-replace`; `decompiled/` stays exactly the original.
- The game's Kongregate API key stays in the tracked decompiled code: it's the developer's, not an account token.
- Kongregate is replaced by an offline stand-in (`src/game/library/KongregateAPI.as`): premium owned, bombs counted locally, no network calls.
- The options menu's "Unlock All Acts" button stays in every build, the public release included.
- The release has everything in v19, free bombs included; the shop's texts say free instead of Kreds, and the title shows a release version (to-do 10's report, choice 1).
- The release is the patched .swf for any player, plus a Windows AIR app (the .swf packaged as it is, with its own runtime) if a test build runs well; never a projector .exe with the game inside (Adobe's terms).
- The README lists the players as: AIR app (if its test works), projector (linked to the Wayback Machine's copy of Adobe's download, with its SHA-256; never bundled), Ruffle app. No browser version until Ruffle's WebGPU renderer passes a test.
- No request to the developer before the release: it's an unofficial fan patch, taken down if they ask, with full credits to Adventure Cat, LLC and Helgravis (README Credits, release notes, the AIR download's readme).
- The release is a GitHub release in this repo (the repo goes public first); afterwards, ask Flashpoint's curators and announce on the game's Kongregate page. Not on itch.io, Newgrounds, Kongregate or the Internet Archive.
- Starling's `handleLostContext` stays on (`src/StarlingPreloader.as`): without it, resizing the projector window kills the game.
- All builds share one save: `src/game/library/FileLibrary.as` passes `"/"` to `getLocal`; save names are `game`, `settings` and `save-N` until the release patches give them a `peacefree-` prefix, with a one-time read of the old names (old saves never deleted).
- One options panel (`OptionsInterfacer`) for the mission, title and campaign screens; it's outside a mission when the screen passes a callback (`inMission()`), never judged from `pgame.map`.
- The Flash version gets quality-of-life changes only, no new gameplay changes; gameplay changes and modding wait for the refactored version (roadmap: to-dos 7-9, release 10, refactor 4).
- Music and SFX volume (0-100%) and the start speed live in their own `settings` save, read and written by `src/game/library/SoundLibrary.as`; the mute flags stay in the game's save, and the mute icons stay the way to mute.
- The start speed applies in `CampaignSelectorScreen.startAct` to every new act but Act 1 (the tutorial keeps 4x); loaded saves keep their own speed.
- Window sizes come from the game scaling to fit its window (its own shape, black bars, at most 2048 wide), fullscreen included; no launcher, no stretching.
- Only `StarlingPreloader.fitToWindow` sets Starling's viewport; Flash objects over the game go on `Starling.current.nativeOverlay`, and game code reads the mouse from it, not from the stage (window pixels).
- Mute pauses and unmute continues the song (`SoundLibrary.pauseBGM`/`resumeBGM`; a paused song counts as playing in `isBGMPlaying`); only screen and story changes stop it for good. Missions go through `src/game/peacefree/Map.as` (`setEnableBGM`, `nextBGM` for the panel's Next button).
- Keys aren't rebindable in the Flash version: the panel's Controls page (`OptionsInterfacer.CONTROLS`) only lists them, and a changed or new key goes there too; rebinding waits for the refactored version. Mission keys do nothing while the panel is open (`Map.onKeyDown`).

## Project docs
- README.md: what the project is, setup, build and play, Credits.
- docs/local.md: this PC's paths and commands (gitignored).
- docs/todo.md: the to-do list.
- docs/decisions.md: every decision with its reason.
- docs/research/: findings by topic: game-code.md (the file, code map, content format, saves), premium.md, network.md, performance.md, release.md (to-do 10's release report: what goes in, form, player, permission, where, save names).
- NOTES.md: patch, build and test log.

## Never in tracked files
The repo goes public later, with its full history.
- Personal paths (user folder, drive paths): they go in docs/local.md.
- Kongregate account names, IDs or tokens (for example from save data or test logs).
- The GitHub login used for pushes: it goes in docs/local.md. Current files only; old commits that hold it are fine.
