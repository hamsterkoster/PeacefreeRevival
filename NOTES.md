# Notes

Log of patches, builds and test results. Newest entry first; each entry has the date, the to-do number, what was done and the result. Findings are in docs/research/ (one file per topic), decisions in docs/decisions.md.

## Original file
`original/PeacefreeKong.swf`, downloaded from the game's Kongregate page (https://www.kongregate.com/en/games/helgravis/peacefree-tactical-warfare).
- 6,526,889 bytes, SHA-256 `3faa86dcb2ae923a149957778535d2a2ebbb5820a9fc4dbfd6ae011b958ad943`.
- `original/` is gitignored; this hash is how we check the file is unchanged.

## Patched files
One line per file in `patched/`: what it contains and its test status. The files are gitignored (each contains the whole original); `scripts/build.py` makes them again from `src/`, byte for byte.

- `PeacefreeKong-v01-fpsmeter.swf`: the original plus the P key for Starling's stats box (FPS, memory, draw calls), in `src/StarlingPreloader.as`. SHA-256 `4b6e2df90472e64097ba61147486b1c4ff27608a8c5d3de68dc681f81f723112`. Tested by the user in all three players (to-do 2).

## Log

### 2026-10-30, To do 2: performance
The lag is the player, not the game: the Flash Player projector runs the game at about 60 fps. The user's decision: play in the projector, no fixes for Ruffle, so the planned step B (less per-frame work) was dropped. Findings and the player comparison: docs/research/performance.md.

**Done**
- Players in `tools/`: Flash Player projector 32.0.0.465 (`flashplayer_32_sa.exe` from the Wayback Machine copy of Adobe's download URL; valid Adobe Inc. signature), Ruffle nightly 2026-10-29 app and web version (SHA-256 matched GitHub's). Playwright 1.64.1 with Chrome Headless Shell 156 in `tools/ms-playwright/` (282 MB, measured). Pillow 13.0.0 for the check's pixel test.
- `scripts/build.py vNN-name`: checks the original's SHA-256, compiles every class in `src/` into a copy with ffdec's `-replace`, writes `patched/PeacefreeKong-vNN-name.swf`. 16-17 s (measured); the same input gives the same file (same SHA-256 twice, measured). A compile error, an unknown class, a reused version number and a bad name each stop it with nothing written (tested). ffdec prints "This feature is EXPERIMENTAL" for its AS3 compiler, and adds a second `[SWF(...)]` metadata line to the preloader class (harmless; the file header is unchanged).
- `scripts/check.py <file>`: the slow check. Headless Chromium plays the file in Ruffle's web version and passes once the title screen's blue logo shows (logo area 38% logo blue on the title screen, 0% while loading; measured). 7-12 s for a pass, 60 s for a fail (measured). Blocks and lists requests to other sites.
- `scripts/play.py <file>`: plays a file in Ruffle in the user's browser, through the same local page (`scripts/ruffle_page.py`).
- `patched/*.swf` is gitignored (docs/decisions.md).

**Test results**
- The user played v01 in the projector, the Ruffle app and Ruffle in the browser, and read the FPS from the stats box: about 60, 40 and 15-20 (docs/research/performance.md).

### 2026-10-30, To do 1: inspect and decompile
All findings come from reading the decompiled code; nothing was run in a player yet. They are in docs/research/: game-code.md (the file, code map, content format, saves), premium.md, network.md, and the performance leads in performance.md.

**Done**
- ffdec 26.4.0 (release zip, SHA-256 matched GitHub's digest) in `tools/ffdec/`; runs on the installed Java 8. Python venv `.venv` with ruff 0.17.3.
- `scripts/decompile.py` exports everything into `decompiled/PeacefreeKong/`: 3.6 s for a full run (measured), exit code 0, 0 scripts with ffdec's failure markers (measured).
- Tracked: 225 scripts, 16 binaryData files, the symbol list (242 files, 2.3 MB). Gitignored: 6 images, 13 sounds, 2 frames. `.gitignore` now uses an allowlist for `decompiled/*/` (only scripts, texts, binaryData, symbolClass), and `original/` is ignored.
- The script refuses to replace a folder with uncommitted changes (`--force` overrides), exports into `<name>.new/` and swaps it in only on success, and rejects an unreadable file (ffdec itself exits 0 then).
- Test: Claude checked the export, the guard, a broken input and the gitignore rules; the user went through the test checklist (this summary, the hash, an optional script run) and reported it good. The game's Kongregate API key stays in the tracked decompiled code (the suggested answer).
