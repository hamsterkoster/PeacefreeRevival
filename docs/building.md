# Building Peacefree Revival

For developers: how the patches are made, and how to set up, build, check and release them. For players: [README.md](../README.md).

## Status
Revival 1.0 is being prepared for release (to-do 14). What changed for players: [CHANGELOG.md](../CHANGELOG.md). Every patch, build and test: [NOTES.md](../NOTES.md). What's next: [todo.md](todo.md).

## How it works
The patches are edited copies of the game's classes in `src/`. `scripts/build.py` compiles them into a copy of the original .swf with ffdec and writes `patched/PeacefreeKong-vNN-name.swf`. The original file is never changed. The Windows app is that .swf packaged as it is with the AIR SDK, with its own runtime (`scripts/package_air.py`), and its installer and zip are made by `scripts/release_air.py`.

## Set up (Windows)
Needs Java 8 or newer and Python 3.13.

1. Put the original `PeacefreeKong.swf` in `original/`. Its SHA-256 is in [NOTES.md](../NOTES.md).
2. Put the tools in `tools/`:
   - [ffdec](https://github.com/jindrapetrik/jpexs-decompiler/releases) 26.4.0: unzip into `tools/ffdec/`.
   - [Ruffle](https://github.com/ruffle-rs/ruffle/releases): the Windows app into `tools/ruffle/desktop/`, the web version into `tools/ruffle/web/`.
   - Flash Player projector 32 (`flashplayer_32_sa.exe`, Adobe's standalone player) into `tools/flashplayer/`: the Wayback Machine's copy of Adobe's download, linked with its SHA-256 in the README's "Download and play".
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

Make the Windows app from a build of the current `src/` (it writes `patched\air\PeacefreeRevival-v10-shortname-1\`, the next free number, with `air\README.txt` in it), check that it reaches its title screen, and play it. It keeps its own saves, apart from the projector's:

```powershell
.venv\Scripts\python scripts\package_air.py patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\package_air.py --check patched\air\PeacefreeRevival-v10-shortname-1
& "$PWD\patched\air\PeacefreeRevival-v10-shortname-1\Peacefree Revival.exe"
```

Make that app's two downloads next to its folder, an installer (`PeacefreeRevival-v10-shortname-1-Setup.exe`, which shows the app's README.txt before installing) and a zip (`PeacefreeRevival-v10-shortname-1.zip`), and check that the installer installs, its app starts and it uninstalls, and that the zip's app starts, both with the README.txt (the check installs into a temporary folder, so uninstall the app first if you installed it):

```powershell
.venv\Scripts\python scripts\release_air.py patched\air\PeacefreeRevival-v10-shortname-1
.venv\Scripts\python scripts\release_air.py --check patched\air\PeacefreeRevival-v10-shortname-1
```

## Make a release
1. Raise `REVIVAL_VERSION` in `src/game/peacefree/TitleScreen.as` (the title screen, the app's version and the release's file names come from it), build, and run every check above.
2. Make the Windows app, its downloads, and both their checks (above).
3. Copy the app's .swf and its two downloads under their release names (`Peacefree-Revival-<version>.swf`, `-Windows-Setup.exe`, `-Windows.zip`) into `patched\release\PeacefreeRevival-v10-shortname-1\` (never overwritten). It runs the downloads' check first and copies nothing if it fails, then prints each file's SHA-256:

   ```powershell
   .venv\Scripts\python scripts\release_air.py --release patched\air\PeacefreeRevival-v10-shortname-1
   ```

4. In [CHANGELOG.md](../CHANGELOG.md), Unreleased becomes the version with its date.
5. A GitHub release, tag `v<version>`, with the three files and the notes from CHANGELOG.md. To-do 14, step C, writes down the exact steps when it makes the first one.

## Folders and docs
- `original/`: the original .swf (not in the repo). `decompiled/`: ffdec's output. `src/`: our patched classes. `patched/`: built files, Windows apps and release files (not in the repo). `air/`: the Windows app's settings, icons, readme and installer script. `scripts/`: our build, check, packaging and play scripts. `tools/`: downloaded tools (not in the repo).
- [NOTES.md](../NOTES.md): patch, build and test log. [research/](research/): findings by topic. [decisions.md](decisions.md): decisions and their reasons. [todo.md](todo.md): the to-do list. [CHANGELOG.md](../CHANGELOG.md): what changed for players.
