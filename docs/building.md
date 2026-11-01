# Building Peacefree Revival

For developers: how the patches are made, and how to set up, build, check and release them. For players: [README.md](../README.md).

## Status
Revival 1.0 was released on 2026-11-01 ([release page](https://github.com/hamsterkoster/PeacefreeRevival/releases/tag/v1.0)). What changed for players: [CHANGELOG.md](../CHANGELOG.md). Every patch, build and test: [NOTES.md](../NOTES.md). What's next: [todo.md](todo.md).

## How it works
The patches are edited copies of the game's classes in `src/`. `scripts/build.py` compiles them into a copy of the original .swf with ffdec and writes `patched/PeacefreeKong-vNN-name.swf`. The original file is never changed. The Windows app is that .swf packaged as it is with the AIR SDK, with its own runtime (`scripts/package_air.py`), and its installer and zip are made by `scripts/release_air.py`.

## Set up (Windows)
Needs Java 8 or newer and Python 3.13.

1. Download the original `PeacefreeKong.swf` from Kongregate's server (the one the [game's page](https://www.kongregate.com/en/games/helgravis/peacefree-tactical-warfare) loads) into `original/`. It's 6,526,889 bytes, and its SHA-256 must be `3FAA86DCB2AE923A149957778535D2A2EBBB5820A9FC4DBFD6AE011B958AD943` (also in [NOTES.md](../NOTES.md)); `scripts/build.py` refuses any other file. In PowerShell, from the project folder:

   ```powershell
   New-Item -ItemType Directory -Force original
   Invoke-WebRequest "https://game213675.konggames.com/gamez/0021/3675/live/PeacefreeKong.swf" -OutFile original\PeacefreeKong.swf
   (Get-FileHash original\PeacefreeKong.swf).Hash
   ```
2. Put the tools in `tools/`:
   - [ffdec](https://github.com/jindrapetrik/jpexs-decompiler/releases) 26.4.0: unzip into `tools/ffdec/`.
   - [Ruffle](https://github.com/ruffle-rs/ruffle/releases), the nightly of 2026-10-29 (the checks are run with it): the Windows app into `tools/ruffle/desktop/`, the web version into `tools/ruffle/web/`.
   - Flash Player projector 32 (`flashplayer_32_sa.exe`, Adobe's standalone player) into `tools/flashplayer/`: Adobe's own download or the Wayback Machine's copy, both linked with its SHA-256 in the README's "Download and play".
   - Only to make the Windows app: the [AIR SDK](https://airsdk.wxlift.com/download) 51.5.1, through Wipro's [AIR SDK Manager](https://github.com/airsdk/airsdkmanager-releases/releases) (accept its license there), into `tools/air/AIRSDK_51.5.1/`.
   - Only to make the Windows app's installer: [Inno Setup](https://jrsoftware.org/isinfo.php) 6, into `tools/innosetup/`. From the project folder: `winget install --id JRSoftware.InnoSetup --version 6.7.3 --scope user --location "$PWD\tools\innosetup"`.
3. In PowerShell, from the project folder:

   ```powershell
   python -m venv .venv
   .venv\Scripts\python -m pip install -r requirements-dev.txt
   $env:PLAYWRIGHT_BROWSERS_PATH = "$PWD\tools\ms-playwright"
   .venv\Scripts\python -m playwright install --only-shell chromium
   ```

## Build and play
Build a patched file (pick the next free version number and a short name), check in headless Ruffle that it reaches the title screen, that premium is unlocked, that the save is shared by all builds, that Settings opens the options panel and its Controls page, that a new act starts at the Start Speed and that the game fits a bigger player, then play it in the projector:

```powershell
.venv\Scripts\python scripts\build.py v10-shortname
.venv\Scripts\python scripts\check.py patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\check.py --premium patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\check.py --shared-save patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\check.py --settings patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\check.py --mission patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\check.py --resize patched\PeacefreeKong-v10-shortname.swf
& "$PWD\tools\flashplayer\flashplayer_32_sa.exe" "$PWD\patched\PeacefreeKong-v10-shortname.swf"
```

In patched builds, the P key shows or hides the FPS box, and the options menu has an "Unlock All Acts" button (it can't be undone). From v09, the options menu also opens from the Settings button at the top left of the title and campaign screens. From v05, all builds share one save, so progress carries over to each new build; the original keeps its own. From v16, the game fits its window, and the options menu has a Fullscreen button (the projector's View > Full Screen, Ctrl+F, works too). From v19, the options menu's Controls button lists the keys. From v20, the saves are named `peacefree-game`, `peacefree-settings` and `peacefree-save-N`; the first start copies the older builds' saves over, and those stay for the older builds.

Make the Windows app from a build of the current `src/` (it writes `patched\air\PeacefreeRevival-v10-shortname-1\`, the next free number, with `air\README.txt` and `THIRD-PARTY-NOTICES.txt` in it), check that it reaches its title screen, and play it. It keeps its own saves, apart from the projector's. Both AIR checks (this one and the downloads' below) start the app with its real save (in AppData), like a player who starts the game and quits on the title screen; on a PC without one, the game writes a new empty save:

```powershell
.venv\Scripts\python scripts\package_air.py patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\package_air.py --check patched\air\PeacefreeRevival-v10-shortname-1
& "$PWD\patched\air\PeacefreeRevival-v10-shortname-1\Peacefree Revival.exe"
```

Make that app's two downloads next to its folder, an installer (`PeacefreeRevival-v10-shortname-1-Setup.exe`, which shows the app's README.txt before installing) and a zip (`PeacefreeRevival-v10-shortname-1.zip`), and check that the installer installs, its app starts and it uninstalls, and that the zip's app starts, both with the README.txt and THIRD-PARTY-NOTICES.txt (the check installs into a temporary folder, so uninstall the app first if you installed it):

```powershell
.venv\Scripts\python scripts\release_air.py patched\air\PeacefreeRevival-v10-shortname-1
.venv\Scripts\python scripts\release_air.py --check patched\air\PeacefreeRevival-v10-shortname-1
```

## Make a release
1. Raise `REVIVAL_VERSION` in `src/game/peacefree/TitleScreen.as` (the title screen, the app's version and the release's file names come from it), build, and run every check above.
2. Update the version in the README's download file names ("Download and play") and in this file's Status.
3. Make the Windows app, its downloads, and both their checks (above). The app takes `air/README.txt` and `THIRD-PARTY-NOTICES.txt` as they are when it's packaged, so after changing either, package again.
4. Run `release_air.py --release` on that app folder. It runs the downloads' check first and copies nothing if it fails; then it copies the app's .swf and its two downloads under their release names (`Peacefree-Revival-<version>.swf`, `-Windows-Setup.exe`, `-Windows.zip`) into `patched\release\PeacefreeRevival-v10-shortname-1\` (never overwritten) and prints each file's SHA-256:

   ```powershell
   .venv\Scripts\python scripts\release_air.py --release patched\air\PeacefreeRevival-v10-shortname-1
   ```

5. In [CHANGELOG.md](../CHANGELOG.md), Unreleased's entries move under a new `## [<version>] - <date>` heading (the day the release is published), with Unreleased left empty above it, and the link targets at the bottom follow: `[Unreleased]` compares `v<version>...HEAD`, and `[<version>]` links the new release's tag. Commit and push this: the release's tag points at this commit.
6. Write the release notes into a file outside the repo, starting from the previous release's (`gh release view v1.0 --json body --jq .body`): the intro, "Which file?", "What's new" (the version's changelog section as it is), the three SHA-256s from step 4, and the credits, whose THIRD-PARTY-NOTICES.txt link points at the new tag.
7. Make the GitHub release as a draft with `gh` (signed in as an admin of the repo), its tag pointed at the pushed commit of step 5 (for example, version 1.1):

   ```powershell
   $sha = git rev-parse HEAD
   $d = "patched\release\PeacefreeRevival-v10-shortname-1"
   gh release create v1.1 --draft --target $sha --title "Peacefree Revival 1.1" --notes-file ..\release-notes-1.1.md "$d\Peacefree-Revival-1.1.swf" "$d\Peacefree-Revival-1.1-Windows-Setup.exe" "$d\Peacefree-Revival-1.1-Windows.zip"
   ```

   Check that GitHub's SHA-256 of each upload (`digest`) matches step 4's:

   ```powershell
   gh release view v1.1 --json assets --jq '.assets[] | {name, digest}'
   ```

8. Read the draft on GitHub's releases page, then publish it there, with "Set as the latest release" ticked; publishing makes the tag. Then `git fetch --tags`, and check logged out (a private browser window) that the README's "latest release" link leads to the new release and its three downloads give the same SHA-256s.

## Folders and docs
- `original/`: the original .swf (not in the repo). `decompiled/`: ffdec's output. `src/`: our patched classes. `patched/`: built files, Windows apps and release files (not in the repo). `air/`: the Windows app's settings, icons, readme and installer script. `scripts/`: our build, check, packaging and play scripts. `tools/`: downloaded tools (not in the repo).
- [NOTES.md](../NOTES.md): patch, build and test log. [research/](research/): findings by topic. [decisions.md](decisions.md): decisions and their reasons. [todo.md](todo.md): the to-do list. [CHANGELOG.md](../CHANGELOG.md): what changed for players. [THIRD-PARTY-NOTICES.txt](../THIRD-PARTY-NOTICES.txt): the game's parts by others and their licenses. `docs/images/`: the README's screenshot.
