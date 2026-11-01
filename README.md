# Peacefree: Tactical Warfare - Revival

A fan project to revive [Peacefree: Tactical Warfare](https://www.kongregate.com/en/games/helgravis/peacefree-tactical-warfare), a tactical strategy Flash game by Helgravis, first released on Kongregate. Flash is gone, and so is Kongregate's purchase service, so the game's premium features can no longer be bought. The goals:

1. Make it run smoothly.
2. Unlock the premium features.
3. Quality-of-life changes (no gameplay changes), then a release of this Flash version.
4. Later: a refactored version that's moddable (new levels, enemies, mechanics).

This is an unofficial fan project, not affiliated with Helgravis or Kongregate. The repo doesn't contain the game's .swf: you need your own copy.

## Status
- Done: the game is decompiled and mapped ([docs/research/](docs/research/)). The lag came from the player, not the game: the Flash Player projector runs it at about 60 fps.
- Done: premium is unlocked. Kongregate is replaced by an offline stand-in, so the game makes no network calls; bombs are free in the shop. Resizing the window no longer stops the game.
- Done: all builds share one save, so progress carries over to each new build.
- Done: a Settings button on the title and campaign screens opens the options panel there too, with volume sliders for music and sound effects (saved, and shared by all builds).
- Done: muting the music pauses the song and unmuting continues it, on every screen; in a mission, the options panel has a Next button to skip to the next song.
- Done: a Start Speed setting (1x, 4x or 8x) in the options panel chooses the speed a new act starts at (the tutorial, Act 1, keeps 4x).
- Done: the game grows and shrinks with its window (drag the edge or maximize), keeping its shape with black bars; the options panel has a Fullscreen button (Esc leaves fullscreen).
- Done: a Controls button in the options panel opens a page listing the keys and what they do; in a mission, the keys do nothing while the options panel is open.
- Done: a report on releasing the Flash version ([docs/research/release.md](docs/research/release.md)): what goes in, in what form, which player, permission, where, and the save names.
- Done: the release patches: the shop says the bombs are free, the saves have names of their own (`peacefree-game` and so on; progress from older builds carries over, and their saves stay as they were), and the title shows "Revival 1.0, unofficial fan patch".
- Done: a Windows app that runs the game without Flash Player (built with the AIR SDK, its own runtime included); it plays like the projector. It comes as an installer (for your user only, no admin prompt; a Start menu entry and a desktop shortcut; uninstalling keeps your saves) and as a zip, with the title screen's red chevron as its icon.
- Done: a test of browser play with Ruffle: its WebGL renderer is still slow (about 15 fps) and draws the background white, and its WebGPU renderer freezes the page. So the release is downloads only; browser play waits for a rebuilt version of the game.
- Next: the release itself.
- Not yet: a ready-to-play release.

## How it works
The patches are edited copies of the game's classes in `src/`. `scripts/build.py` compiles them into a copy of the original .swf with ffdec and writes `patched/PeacefreeKong-vNN-name.swf`. The original file is never changed.

## Set up (Windows)
Needs Java 8 or newer and Python 3.13.

1. Put the original `PeacefreeKong.swf` in `original/`. Its SHA-256 is in [NOTES.md](NOTES.md).
2. Put the tools in `tools/`:
   - [ffdec](https://github.com/jindrapetrik/jpexs-decompiler/releases) 26.4.0: unzip into `tools/ffdec/`.
   - [Ruffle](https://github.com/ruffle-rs/ruffle/releases): the Windows app into `tools/ruffle/desktop/`, the web version into `tools/ruffle/web/`.
   - Flash Player projector 32 (`flashplayer_32_sa.exe`, Adobe's standalone player) into `tools/flashplayer/`. Adobe no longer offers it; NOTES.md says where ours came from.
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

Make the Windows app from a build of the current `src/` (it writes `patched\air\PeacefreeRevival-v10-shortname-1\`, the next free number), check that it reaches its title screen, and play it. It keeps its own saves, apart from the projector's:

```powershell
.venv\Scripts\python scripts\package_air.py patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\package_air.py --check patched\air\PeacefreeRevival-v10-shortname-1
& "$PWD\patched\air\PeacefreeRevival-v10-shortname-1\Peacefree Revival.exe"
```

Make that app's two downloads next to its folder, an installer (`PeacefreeRevival-v10-shortname-1-Setup.exe`) and a zip (`PeacefreeRevival-v10-shortname-1.zip`), and check that the installer installs, its app starts and it uninstalls, and that the zip's app starts (the check installs into a temporary folder, so uninstall the app first if you installed it):

```powershell
.venv\Scripts\python scripts\release_air.py patched\air\PeacefreeRevival-v10-shortname-1
.venv\Scripts\python scripts\release_air.py --check patched\air\PeacefreeRevival-v10-shortname-1
```

## Folders and docs
- `original/`: the original .swf (not in the repo). `decompiled/`: ffdec's output. `src/`: our patched classes. `patched/`: built files and Windows apps (not in the repo). `air/`: the Windows app's settings, icons and installer script. `scripts/`: our build, check, packaging and play scripts. `tools/`: downloaded tools (not in the repo).
- [NOTES.md](NOTES.md): patch, build and test log. [docs/research/](docs/research/): findings by topic. [docs/decisions.md](docs/decisions.md): decisions and their reasons. [docs/todo.md](docs/todo.md): the to-do list.

## Credits
- **Peacefree: Tactical Warfare** by Helgravis: the original game, its code, art and sound (the Windows app's icon is the game's own title-screen chevron). All rights remain with its author.
- **[Starling Framework](https://github.com/Gamua/Starling-Framework)** 1.4.1 by Gamua GmbH, Simplified BSD License: the game's GPU rendering library, part of the original .swf.
- **[JPEXS Free Flash Decompiler (ffdec)](https://github.com/jindrapetrik/jpexs-decompiler)** 26.4.0 by Jindra Petřík and contributors, GPL-3.0: decompiles and rebuilds the .swf.
- **[Ruffle](https://ruffle.rs)** by Ruffle LLC and contributors, MIT or Apache-2.0: the Flash emulator behind the headless check.
- **Adobe Flash Player projector** 32 by Adobe: the player the game runs best in. Proprietary; not included.
- **[AIR SDK](https://airsdk.wxlift.com/download)** 51.5.1 by Wipro Connected Services (formerly HARMAN), with the Adobe AIR runtime: packages the game as a Windows app with its own runtime. Proprietary ([AIR SDK License Agreement](https://airsdk.wxlift.com/assets/pdfs/Wipro%20AIR%20SDK%20License%20Agreement.pdf), free tier); not in the repo.
- **[Inno Setup](https://jrsoftware.org/isinfo.php)** 6.7.3 by Jordan Russell and Martijn Laan, the Inno Setup License (free, also for commercial use): builds the Windows app's installer. Not in the repo.
- **[Playwright](https://github.com/microsoft/playwright-python)** 1.64.1 by Microsoft, Apache-2.0, with Chrome Headless Shell by the Chromium Authors (BSD-style license): runs the headless check.
- **[Pillow](https://python-pillow.org)** 13.0.0 by Jeffrey A. Clark and contributors, MIT-CMU: the check's pixel test.
- **[Ruff](https://docs.astral.sh/ruff)** 0.17.3 by Astral, MIT: lints our scripts.
