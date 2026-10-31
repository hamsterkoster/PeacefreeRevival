# 12. AIR app: a Windows app that needs no Flash Player (medium)
Goal: "if the AIR app test works that should be an option as well" (release decisions, choice 2); "We should have both installer and zip" (the user, after step A).
- Problem: fans should be able to double-click and play without installing a player. The AIR SDK (now Wipro's) packages the finished .swf as a Windows app with its own runtime, with no recompiling.
- Read first: docs/research/release.md, "The AIR SDK's current terms" and "The AIR app, measured"; docs/decisions.md (2026-10-31: the AIR app); `air/application.xml`; `scripts/package_air.py`.
- Approach, in steps: A, the app itself and a check that it starts (done); B, the two release downloads of it, an installer and a zip.
- Test: `package_air.py --check` passes; the user installs, plays and uninstalls (B).

## Progress
- Step A (done, tested by the user on 2026-10-31: "Tests look good"):
  - The AIR SDK 51.5.1.1, installed by the user with Wipro's AIR SDK Manager into `tools/air/`.
  - `air/application.xml`: "Peacefree Revival", the ID `io.github.hamsterkoster.PeacefreeRevival` (it decides the save folder), `renderMode` direct, `allowLowQuality`, the dark splash. It has no window size: with one, AIR counted the title bar in and the game got 784x500.
  - `scripts/package_air.py` makes `patched/air/PeacefreeRevival-<label>-N/` (64-bit, about 5 s, 27.1 MB) from a patched build of the current `src/`. `--check` starts the app and reads its window with `PrintWindow` until the title screen's logo shows.
  - The user played v21 as the AIR app (`-4`): the FPS box, Settings, a mission, saving and loading, resizing, Fullscreen and Esc all work as in the projector.
- Step B (next): the release downloads of the app.
  - An installer made with Inno Setup (on winget: `JRSoftware.InnoSetup`, version 6 or 7), which follows the AIR license's "runs without installation" clause.
  - A zip of the same folder, the user's choice too: simpler for fans who don't want to install anything, though against that clause's literal wording.
  - Both made by `package_air.py` (or a sibling script) next to the app folder, each with its SHA-256.
  - Ask the user:
    - Inno Setup 6 or 7 (suggested: 6, the long-used one; check 7's changes first).
    - Install for the current user, with no admin prompt (suggested: yes).
    - A Start menu entry, and a desktop shortcut as an option on a checkbox (suggested: yes).
    - The uninstaller keeps the saves in AppData (suggested: yes, the usual way).
    - An app icon from the game's art instead of AIR's default (suggested: yes, if the game has a suitable picture).
  - Test: Claude checks that the installer installs silently into a temp folder and the installed app passes `--check`. The user runs the installer as a fan would, plays, uninstalls, then unzips the zip and plays.
