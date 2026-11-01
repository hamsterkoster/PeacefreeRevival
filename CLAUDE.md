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
- `patched/`: rebuilt .swf files with versioned names (`PeacefreeKong-vNN-name.swf`), made by `scripts/build.py`, gitignored (SHA-256 in NOTES.md); never overwrite an older one. `patched/air/`: AIR apps made from them (`PeacefreeRevival-vNN-name-N/`) by `scripts/package_air.py`, and each app's installer and zip (`...-N-Setup.exe`, `...-N.zip`) by `scripts/release_air.py`, gitignored, never overwritten either. `patched/release/PeacefreeRevival-vNN-name-N/`: the release files (`Peacefree-Revival-X.Y.swf`, `-Windows-Setup.exe`, `-Windows.zip`), copied from that app folder by `release_air.py --release`, gitignored, never overwritten.
- `air/`: the AIR app's descriptor (`application.xml`), icons (`icons/`), readme (`README.txt`, packed into the app with its `{version}` filled in, shown by the installer; the root's `THIRD-PARTY-NOTICES.txt` is packed next to it) and installer script (`installer.iss`, Inno Setup), tracked.
- `scripts/`: our own scripts (Python), tracked.
- `tools/`: downloaded tools (ffdec, Ruffle, Flash Player projector, the AIR SDK in `tools/air/`, Inno Setup in `tools/innosetup/`), gitignored.
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
    - Shared save: the same with `--shared-save` before the file (about 7 s) must print PASS (an old `game` save put in first is carried over to `peacefree-game` under the root path and left unchanged).
    - Settings: the same with `--settings` before the file (about 40-55 s) must print PASS (Settings on the title screen opens the options panel, dragging the muted music slider saves 75% and unmutes, the Start Speed row's 1x is saved, Controls opens its page and the page's Back returns, Back closes it).
    - Mission: the same with `--mission` before the file (about 60-90 s) must print PASS (the settings steps, then Unlock All Acts, Act 2 starts at the saved 1x).
    - Resize: the same with `--resize` before the file (about 15 s) must print PASS (a 1400x810 player shows the game at 1200x810 with black bars; Settings clicked at its scaled place opens the panel).
    - AIR app: `.venv/Scripts/python scripts/package_air.py patched/PeacefreeKong-vNN-name.swf` (about 5 s; the build must hold `REVIVAL_VERSION` from `src/`) prints the new folder, then the same with `--check` before that folder (about 10 s) must print PASS (the app's window reaches the title screen; a window opens and closes; it starts the app's real save, as a player would).
    - AIR downloads: `.venv/Scripts/python scripts/release_air.py patched/air/PeacefreeRevival-vNN-name-N` (about 8 s) makes the installer and the zip next to that folder, each with its SHA-256, then the same with `--check` before that folder (about 18 s; it refuses while the app is installed for real) must print PASS (a silent install into a temp folder holds the README.txt and THIRD-PARTY-NOTICES.txt, reaches the title screen and uninstalls without leftovers; the unzipped app holds them and reaches the title too).
- Release files (not a per-step check; once per release, after the AIR checks): `.venv/Scripts/python scripts/release_air.py --release patched/air/PeacefreeRevival-vNN-name-N` (about 18 s) runs the downloads' check, then copies the app's .swf, installer and zip into `patched/release/<app folder>/` under their release names and prints their SHA-256s; steps in docs/building.md "Make a release".
- Re-decompile (not a per-step check; only after an ffdec update, on a committed tree): `.venv/Scripts/python scripts/decompile.py` (about 4 s) must end with "All scripts decompiled without errors." It refuses to replace a folder with uncommitted changes.
- Docs to update when behaviour changes: NOTES.md (patches, test results, the patched-files list); docs/research/ (findings and dead ends, by topic); docs/decisions.md; docs/local.md (run commands); README.md (for players: download and play, what's new, privacy, Credits; when a section grows past about a screen, move it into docs/NAME.md and link it from the README); CHANGELOG.md (one plain line under Unreleased for each change players see); docs/building.md (status, setup, build, check and release steps); air/README.txt (the Windows app's readme).
- Must keep working: the game reaches its title screen (the headless check), also as the AIR app (the AIR check); in patched builds, P shows and hides the FPS box, premium is unlocked (the premium check), all builds share one save (the shared-save check), the Settings button opens the options panel on the title and campaign screens, its volume sliders are saved and its Controls page opens (the settings check covers the title), mission keys do nothing while the panel is open, a new act other than Act 1 starts at the Start Speed (the mission check), mute pauses and unmute continues the same song (a projector test: the checks can't hear), resizing the projector window doesn't stop the game, the game fits its window with black bars (the resize check covers a bigger player), and the panel's Fullscreen button and Esc work (a projector test).
- Review checklist: none yet: the built-in code-review skill. Add docs/review.md once the project has its own rules to check.

## Status
Done: To do 1-3 and 5-13, and to-do 14's steps A and B (latest build v21, latest AIR app `PeacefreeRevival-v21-release-9` with its installer and zip; release 1.0's files in `patched/release/PeacefreeRevival-v21-release-9/`; to-do 10 is the release report, docs/research/release.md; 12 is the AIR app; 13 the browser test, failed); what each added: CHANGELOG.md and NOTES.md.
Next: To do 14, step C (publishing: the repo goes public, the GitHub release, then Flashpoint and Kongregate; docs/todo/14-release.md).

## Decisions
One line per decision a chat must follow. Reasons, who decided and what was rejected: docs/decisions.md. The gitignore rules in Folder layout come from there too.
- Private now, public later: "Never in tracked files" applies from the first commit.
- Play in the Flash Player projector; no fixes for Ruffle. Ruffle's web version is only the headless smoke test.
- Patches are edited copies of whole classes in `src/`, compiled in with ffdec's `-replace`; `decompiled/` stays exactly the original.
- The game's Kongregate API key stays in the tracked decompiled code: it's the developer's, not an account token.
- Kongregate is replaced by an offline stand-in (`src/game/library/KongregateAPI.as`): premium owned, bombs counted locally, no network calls.
- The options menu's "Unlock All Acts" button stays in every build, the public release included.
- The release has everything in v19, free bombs included; the shop's texts say free instead of Kreds, and the title shows a release version (`TitleScreen.REVIVAL_VERSION`, "Revival 1.0"; raise it for each release) and "unofficial fan patch" (to-do 10's report, choice 1; to-do 11).
- The release is the patched .swf for any player, plus a Windows AIR app (the .swf packaged as it is, with its own runtime) if a test build runs well; never a projector .exe with the game inside (Adobe's terms).
- The AIR app (`air/application.xml`, `scripts/package_air.py`; Wipro's free tier, 64-bit, .exe unsigned) ships as both an installer and a zip; its ID `io.github.hamsterkoster.PeacefreeRevival` decides the save folder and never changes after the release.
- The installer (`air/installer.iss`, Inno Setup 6, made with the zip by `scripts/release_air.py`) installs for the current user with no admin prompt, uses the app's ID as its AppId, and keeps the saves on uninstall.
- The README lists the players as: AIR app (if its test works), projector (linked to Adobe's own download, the Wayback Machine's copy as backup, with its SHA-256; never bundled), Ruffle app. No browser version of the Flash release: Ruffle's WebGPU renderer froze the tab and WebGL ran about 15 fps (to-do 13); browser play waits for the refactor.
- No request to the developer before the release: it's an unofficial fan patch, taken down if they ask, with full credits to Adventure Cat, LLC and Helgravis (README Credits, release notes, the AIR download's readme).
- The release is a GitHub release in this repo (the repo goes public first); afterwards, ask Flashpoint's curators and announce on the game's Kongregate page. Not on itch.io, Newgrounds, Kongregate or the Internet Archive. Where the refactor lives is to-do 4's question.
- The personal push account may show on GitHub (the release, the Activity page, commits through the commit email, which stays on it); only tracked files keep its login out.
- Release 1.0: tag `v1.0`, files `Peacefree-Revival-1.0.swf`, `-Windows-Setup.exe` and `-Windows.zip` (`release_air.py --release`, all three from one app folder).
- The LICENSE is MIT for our own work only: everything in the repo except the game (`decompiled/`, `src/`, `air/icons/`, `docs/images/`, which stay Adventure Cat, LLC's) and `THIRD-PARTY-NOTICES.txt`.
- Other people's parts of the game (Starling and its particle extension, AGALMiniAssembler, the Cuprum font, Audionautix's music) are named with their license texts in `THIRD-PARTY-NOTICES.txt`, packed into the app; LICENSE and the README point to it.
- The AIR license's privacy policy is the README's "Privacy" section; its link is in `air/README.txt`, inside the app and shown by the installer, not in the game.
- Starling's `handleLostContext` stays on (`src/StarlingPreloader.as`): without it, resizing the projector window kills the game.
- All builds share one save: `src/game/library/FileLibrary.as` passes `"/"` to `getLocal`; from v20 it adds `peacefree-` to every save name and carries over a copy of the old-name save while the new one is empty (old saves never changed or deleted).
- One options panel (`OptionsInterfacer`) for the mission, title and campaign screens; it's outside a mission when the screen passes a callback (`inMission()`), never judged from `pgame.map`.
- The Flash version gets quality-of-life changes only, no new gameplay changes; gameplay changes and modding wait for the refactored version (roadmap: to-dos 7-9, release 10, refactor 4).
- Music and SFX volume (0-100%) and the start speed live in their own `settings` save, read and written by `src/game/library/SoundLibrary.as`; the mute flags stay in the game's save, and the mute icons stay the way to mute.
- The start speed applies in `CampaignSelectorScreen.startAct` to every new act but Act 1 (the tutorial keeps 4x); loaded saves keep their own speed.
- Window sizes come from the game scaling to fit its window (its own shape, black bars, at most 2048 wide), fullscreen included; no launcher, no stretching.
- Only `StarlingPreloader.fitToWindow` sets Starling's viewport; Flash objects over the game go on `Starling.current.nativeOverlay`, and game code reads the mouse from it, not from the stage (window pixels).
- Mute pauses and unmute continues the song (`SoundLibrary.pauseBGM`/`resumeBGM`; a paused song counts as playing in `isBGMPlaying`); only screen and story changes stop it for good. Missions go through `src/game/peacefree/Map.as` (`setEnableBGM`, `nextBGM` for the panel's Next button).
- Keys aren't rebindable in the Flash version: the panel's Controls page (`OptionsInterfacer.CONTROLS`) only lists them, and a changed or new key goes there too; rebinding waits for the refactored version. Mission keys do nothing while the panel is open (`Map.onKeyDown`).

## Project docs
- README.md: for players: what the project is, download and play, what's new, privacy, Credits, license.
- docs/building.md: for developers: status, how it works, setup, build, check and release steps.
- CHANGELOG.md: what changed for players, per release (Keep a Changelog). LICENSE: MIT for our own work only. THIRD-PARTY-NOTICES.txt: the game's parts by others and their license texts.
- docs/local.md: this PC's paths and commands (gitignored).
- docs/todo.md: the to-do list; a bigger to-do has its own file in docs/todo/ with its Progress list.
- docs/decisions.md: every decision with its reason.
- docs/research/: findings by topic: game-code.md (the file, code map, content format, saves), premium.md, network.md, performance.md, release.md (to-do 10's release report: what goes in, form, player, permission, where, save names; the AIR SDK's terms and the AIR app, measured; section 7, before going public: the history search, what GitHub shows, the docs check).
- NOTES.md: patch, build and test log.

## Never in tracked files
The repo goes public later, with its full history.
- Personal paths (user folder, drive paths): they go in docs/local.md.
- Kongregate account names, IDs or tokens (for example from save data or test logs).
- The GitHub login used for pushes: it goes in docs/local.md. Current files only; old commits that hold it are fine.
