# Peacefree: Tactical Warfare - Revival

A fan project to revive [Peacefree: Tactical Warfare](https://www.kongregate.com/en/games/helgravis/peacefree-tactical-warfare), a tactical strategy Flash game by Helgravis, first released on Kongregate. Flash is gone, and so is Kongregate's purchase service, so the game's premium features can no longer be bought. The goals:

1. Make it run smoothly.
2. Unlock the premium features.
3. Later: make it moddable (new levels, enemies, mechanics).

This is an unofficial fan project, not affiliated with Helgravis or Kongregate. The repo doesn't contain the game's .swf: you need your own copy.

## Status
- Done: the game is decompiled and mapped ([docs/research/](docs/research/)). The lag came from the player, not the game: the Flash Player projector runs it at about 60 fps.
- Done: premium is unlocked. Kongregate is replaced by an offline stand-in, so the game makes no network calls; bombs are free in the shop. Resizing the window no longer stops the game.
- Done: all builds share one save, so progress carries over to each new build.
- Done: a Settings button on the title and campaign screens opens the options panel there too, with volume sliders for music and sound effects (saved, and shared by all builds).
- Next: a report on how moddable the game is.
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
3. In PowerShell, from the project folder:

   ```powershell
   python -m venv .venv
   .venv\Scripts\python -m pip install -r requirements-dev.txt
   $env:PLAYWRIGHT_BROWSERS_PATH = "$PWD\tools\ms-playwright"
   .venv\Scripts\python -m playwright install --only-shell chromium
   ```

## Build and play
Build a patched file (pick the next free version number and a short name), check in headless Ruffle that it reaches the title screen, that premium is unlocked, that the save is shared by all builds and that Settings opens the options panel, then play it in the projector:

```powershell
.venv\Scripts\python scripts\build.py v10-shortname
.venv\Scripts\python scripts\check.py patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\check.py --premium patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\check.py --shared-save patched\PeacefreeKong-v10-shortname.swf
.venv\Scripts\python scripts\check.py --settings patched\PeacefreeKong-v10-shortname.swf
& "$PWD\tools\flashplayer\flashplayer_32_sa.exe" "$PWD\patched\PeacefreeKong-v10-shortname.swf"
```

In patched builds, the P key shows or hides the FPS box, and the options menu has an "Unlock All Acts" button (it can't be undone). From v09, the options menu also opens from the Settings button at the top left of the title and campaign screens. From v05, all builds share one save, so progress carries over to each new build; the original keeps its own.

## Folders and docs
- `original/`: the original .swf (not in the repo). `decompiled/`: ffdec's output. `src/`: our patched classes. `patched/`: built files (not in the repo). `scripts/`: our build, check and play scripts. `tools/`: downloaded tools (not in the repo).
- [NOTES.md](NOTES.md): patch, build and test log. [docs/research/](docs/research/): findings by topic. [docs/decisions.md](docs/decisions.md): decisions and their reasons. [docs/todo.md](docs/todo.md): the to-do list.

## Credits
- **Peacefree: Tactical Warfare** by Helgravis: the original game, its code, art and sound. All rights remain with its author.
- **[Starling Framework](https://github.com/Gamua/Starling-Framework)** 1.4.1 by Gamua GmbH, Simplified BSD License: the game's GPU rendering library, part of the original .swf.
- **[JPEXS Free Flash Decompiler (ffdec)](https://github.com/jindrapetrik/jpexs-decompiler)** 26.4.0 by Jindra Petřík and contributors, GPL-3.0: decompiles and rebuilds the .swf.
- **[Ruffle](https://ruffle.rs)** by Ruffle LLC and contributors, MIT or Apache-2.0: the Flash emulator behind the headless check.
- **Adobe Flash Player projector** 32 by Adobe: the player the game runs best in. Proprietary; not included.
- **[Playwright](https://github.com/microsoft/playwright-python)** 1.64.1 by Microsoft, Apache-2.0, with Chrome Headless Shell by the Chromium Authors (BSD-style license): runs the headless check.
- **[Pillow](https://python-pillow.org)** 13.0.0 by Jeffrey A. Clark and contributors, MIT-CMU: the check's pixel test.
- **[Ruff](https://docs.astral.sh/ruff)** 0.17.3 by Astral, MIT: lints our scripts.
