# Notes

Log of patches, builds and test results. Newest entry first; each entry has the date, the to-do number, what was done and the result. Findings are in docs/research/ (one file per topic), decisions in docs/decisions.md.

## Original file
`original/PeacefreeKong.swf`, downloaded from the game's Kongregate page (https://www.kongregate.com/en/games/helgravis/peacefree-tactical-warfare).
- 6,526,889 bytes, SHA-256 `3faa86dcb2ae923a149957778535d2a2ebbb5820a9fc4dbfd6ae011b958ad943`.
- `original/` is gitignored; this hash is how we check the file is unchanged.

## Patched files
One line per file in `patched/`: what it contains and its test status. The files are gitignored (each contains the whole original); `scripts/build.py` makes them again from `src/`, byte for byte.

- `PeacefreeKong-v01-fpsmeter.swf`: the original plus the P key for Starling's stats box (FPS, memory, draw calls), in `src/StarlingPreloader.as`. SHA-256 `4b6e2df90472e64097ba61147486b1c4ff27608a8c5d3de68dc681f81f723112`. Tested by the user in all three players (to-do 2).
- `PeacefreeKong-v02-premium.swf`: the first version of the Kongregate stand-in, replaced by v03 after the review, before any test in a player. SHA-256 `a349e92a113e757c3309c85b899a5c0906c81a2526e45d9e6841791135253a88`. Headless checks passed. Not for playing (to-do 3).
- `PeacefreeKong-v03-premium.swf`: v01 plus premium unlocked through an offline stand-in for Kongregate, in `src/game/library/KongregateAPI.as`. SHA-256 `c2e00acf3c94372073896befa331a406f6f40628b51ddae99a267ae1a13976f2`. Headless checks pass. The user started testing it in the projector, found the long tutorial and the resize crash; replaced by v04 (to-do 3).
- `PeacefreeKong-v04-premium.swf`: v03 plus the options menu's "Unlock All Acts" button (`src/game/peacefree/interfaces/OptionsInterfacer.as`) and the resize-crash fix (`handleLostContext` in `src/StarlingPreloader.as`). SHA-256 `446fac3e2c72c421726c1bf5b520d3fb7dbd57e225b56dff715efe9e3a3fa245`. Headless checks pass. Tested by the user in the projector (to-do 3).

## Log

### 2026-10-31, To do 3: premium unlock
Premium, the bombs and the shop all depend on Kongregate's answers, which all pass through `KongregateAPI.as`; v03 replaces that class with an offline stand-in. The to-do 1 suggestion (`isPremiumPlayer()` returns true) was not enough: bombs at 0 and a stuck shop. Findings: docs/research/premium.md; decisions: docs/decisions.md.

**Done**
- `src/game/library/KongregateAPI.as`: never loads Kongregate's API; the item list says premium plus the bombs left (10 of each at every game start); purchases succeed for free (+10 bombs); a used bomb is counted down locally instead of posting to `use_item.json`; `isGuest()` is false, which hides the title screen's dead "Sign in" link.
- Built `PeacefreeKong-v02-premium.swf` (15.8 s), then, after the review, `PeacefreeKong-v03-premium.swf` (14.8 s, 6,527,103 bytes; measured), both with v01's FPS key. v02 changed only the Kongregate calls inside the original class; the review (built-in code-review, medium) found leftovers: the unused API key copied into `src/`, dead fields and functions, stats calls that threw and were caught, and a needless dependency on `GameConfig.KONG_VERSION`. v03 keeps only the members the game uses (`init`, `getItems`, `purchase`, `consumeItem`, `isGuest`, `addStats`, `showSignUpLogin`, and the fields `onLoadComplete` and `onLogin`, which the game sets but which are never called).
- `scripts/check.py --premium`: opens the game with its own `show_premium=true` flashvar (campaign screen at start) and checks the top button: green Shop passes, gold Premium fails, each only when two screenshots in a row agree (a review finding: one frame of a fade shouldn't decide). `scripts/ruffle_page.py` passes the page's query string to Ruffle as flashvars. The check now screenshots the page clipped to the player: an element screenshot waits for the element to be "stable", which never happens on the campaign screen (tested: it works with `?foo=bar`, so flashvars aren't the cause).
- During the user's test of v03: two requests. (1) The tutorial is too long, and each build has its own save, so every new build starts there again: v04 adds "Unlock All Acts" to the mission's options menu (the user's choice over always showing all acts). (2) The game crashed when the projector window was resized: Starling lost the graphics device and had `handleLostContext` off, as in the original; v04 turns it on. Built in 16.1 s, 6,527,528 bytes (measured). Review (built-in code-review, medium): the premium check no longer counts two screenshots with a failed one between them as "in a row", and its timeout message names the missing buttons. Left as notes: the memory and minimap costs of `handleLostContext`. Shared saves between builds: to-do 5.

**Test results**
- Claude, v04: title check PASS (4 s), premium check PASS (12 s). Resize test in the projector (a scratch script resizes the window and captures only that window): v03 shows Starling's "lost the device context" fatal error after a resize, and v04 keeps drawing the title screen (both measured); the original showed the same red bar, but only in a small capture, and it has the same Starling setup. The unlock button has no automated test: it would mean driving a mission and two popups by clicks in headless Ruffle.
- Claude: title check PASS on v02 (7 s) and v03 (6 s); premium check PASS on v02 (6 s) and v03 (11 s, with the two-screenshot rule); premium check on the original FAIL on the gold button, as it should. The original lists one blocked request (Kongregate's `API_AS3_Local.swf`), v02 and v03 none (all measured).
- The user tested v04 in the projector: the premium features, the bombs and the free shop, "Unlock All Acts", and resizing the window. Result: "Tests look good."
- Finish (Claude): lint, title check (4 s) and premium check (11 s) on v04 pass; `src/` unchanged since the v04 build; the original's SHA-256 matches.

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
