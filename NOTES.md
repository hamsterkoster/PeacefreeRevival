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
- `PeacefreeKong-v05-sharedsave.swf`: v04 plus one save shared by all builds (`"/"` as the save path in `src/game/library/FileLibrary.as`). SHA-256 `de7c9cbce0b8f8d815dea9416ab5d062cf5dff1a6e9f9b57a419cbe831be0688`. Headless checks pass. Tested by the user in the projector (to-do 5).
- `PeacefreeKong-v06-settings.swf`: the first build of to-do 6 step A, replaced by v07 after the review, before any test in a player. SHA-256 `f8c071ce165061c141405819804491945e67765d82628f5156c6cf8b13f9155d`. Headless checks passed. Not for playing (to-do 6).
- `PeacefreeKong-v07-settings.swf`: v06 with the review's fixes; replaced by v08 for an unused import, before any test in a player. SHA-256 `446cf04384881c9a9f7de9dffd346a70490298007c415d198cc6cc981c475206`. Headless checks passed. Not for playing (to-do 6).
- `PeacefreeKong-v08-settings.swf`: v05 plus a Settings button after the two sound icons on the title and campaign screens, opening the options panel without its mission-only rows (`src/game/peacefree/TitleScreen.as`, `CampaignSelectorScreen.as`, `interfaces/OptionsInterfacer.as`). SHA-256 `0e0bf00f59eea9feb593a7122817167e63b0d1813807a459f5236dc6d696f624`. Headless checks pass. Tested by the user in the projector; replaced by v09 for the button's place (to-do 6).
- `PeacefreeKong-v09-settings.swf`: v08 with Settings first in the top left and the two sound icons to its right. SHA-256 `c055f2986786b038996b9d13835c066ca33d465282323b48e8fbb7b72e36acc9`. Headless checks pass. Tested by the user in the projector (to-do 6, step A).
- `PeacefreeKong-v10-sliders.swf`: v09 with volume sliders for music and SFX in the options panel and the volumes in their own `settings` save (`src/game/library/SoundLibrary.as`, `interfaces/OptionsInterfacer.as`). SHA-256 `47fa7312907cb91a699a44464164b548ef0b0a87a717d8154d9fb85a71e39775`. Headless checks passed. Replaced by v11 after the review, before any test in a player (to-do 6, step B).
- `PeacefreeKong-v11-sliders.swf`: v10 with the review's fixes (volumes also saved when the panel closes; no sound effects played at 0%). SHA-256 `b6a2f982f645e6d11f55619cdf2b02743b6abca1b6818b126a506c0588ee5f92`. Headless checks pass. Tested by the user in the projector (to-do 6, step B).
- `PeacefreeKong-v12-music.swf`: v11 with mute pausing and unmute continuing the song everywhere, and a Next button in the mission's options panel (`src/game/library/SoundLibrary.as`, `game/peacefree/Map.as`, `TitleScreen.as`, `CampaignSelectorScreen.as`, `interfaces/OptionsInterfacer.as`). SHA-256 `e53119d92ab423be3418e0cc59032063cd457eb611d8b6b745dc9998cb6f0ace`. Headless checks passed. Replaced by v13 after the review, before any test in a player (to-do 7).
- `PeacefreeKong-v13-music.swf`: v12 with the review's fixes (a song paused at its very end goes on to the next one; no crash when Flash has no free sound channel). SHA-256 `81e47e59d0d53275c546bcb1a1b4d5fe57229328b13a5e759e20c72cc9982d3f`. Headless checks pass. Tested by the user in the projector (to-do 7).
- `PeacefreeKong-v14-startspeed.swf`: v13 with a Start Speed row (1x / 4x / 8x) in the options panel, saved in the `settings` save and applied when an act starts (`src/game/library/SoundLibrary.as`, `game/peacefree/CampaignSelectorScreen.as`, `interfaces/OptionsInterfacer.as`). SHA-256 `027b0002475aa1d85b6b5332a02f721e40bc0674b99800127c145c59899d1b2b`. Headless checks passed. Replaced by v15 after the review, before any test in a player (to-do 8, step A).
- `PeacefreeKong-v15-startspeed.swf`: v14 with the review's fix: Act 1 (the tutorial) keeps 4x. SHA-256 `9eeba6c56ab36164dbf7733d6379ac6707b07237ba60a7e2818324e39a213a23`. Headless checks pass. Tested by the user in the projector (to-do 8, step A).

## Log

### 2026-10-31, To do 8, step A: start speed
A "Start Speed" row in the options panel (title, campaign and mission screens) chooses the speed a new act starts at; a new headless check enters a mission. Findings: "Game speed and the mission check" in docs/research/game-code.md; decisions (window sizes by scaling, no launcher; the start speed's rules): docs/decisions.md. The to-do moved to docs/todo/08-game-options.md with its Progress list.

**Done**
- `src/game/library/SoundLibrary.as`: `startSpeed` (1, 4 or 8; 4 when missing or invalid) read from the `settings` save at start, `getStartSpeed`/`setStartSpeed`; `saveVolumes` renamed `saveSettings` and also writes `startSpeed`.
- `src/game/peacefree/interfaces/OptionsInterfacer.as`: the Start Speed row below SFX Volume, three 60x40 buttons (`makeSpeedButton`), the chosen one at full alpha and the others at 0.35 like the HUD's speed buttons, saved on each press; Difficulty moved down to y 250 and Exit Game to 305; outside a mission Back moved to 250.
- `src/game/peacefree/CampaignSelectorScreen.as`: `startAct` calls `mapHUD.changeSpeed` with the start speed after making the map, except for Act 1. Loaded saves and the title's demo map keep their own speed.
- `scripts/check.py`: `--settings` also checks the save starts with start speed 4, clicks 1x and checks it holds 1 (Back moved to (400, 280)); new `--mission` does the `--settings` steps, then Play, Settings on the campaign screen, Unlock All Acts, Act 2, Start, clicks through Act 2's opening dialogue and passes when the HUD's 1x button is the lit one. The step screenshots' time limit went from 5 to 15 s (see Test results). `shoot` and `click` moved out of `try_settings` for both.
- Built v14, then v15 after the review (6,531,644 bytes; 15-25 s; measured).
- Review (built-in code-review, medium), 7 findings. Fixed: Act 1 keeps 4x (its tutorial hides the speed buttons, so a 1x or 8x start would have left the player stuck at that speed); `--mission` leaves out the pause button, which pausing lights without dimming the speed button. Not taken: hiding the row in missions (the user chose all three screens; it changes the next act); saving only when the panel closes (one save per click); moving the settings save out of `SoundLibrary` (no new classes; noted for to-do 9); applying the speed in `Map`'s constructor (`startAct` is the only place a new act starts, and the demo map uses the same constructor). The docs finding is covered by this entry.

**Test results**
- Claude, v14: title (4 s), premium (11 s), shared-save (7 s), settings and mission checks PASS (measured). Run at the same time, so their times are high.
- Claude, negative test: v13 in the same Act 2 path (scratch script) lights 4x (28% green) and not 1x, so `--mission` can tell them apart (measured).
- Claude, v15: title (4 s), premium (17 s), shared-save (8 s), settings (41 s) and mission (81 s) checks PASS, no Ruffle errors from the game (measured). Other programs used about 39% of the CPU meanwhile (measured), so the slow checks took about twice as long as in to-do 7. The first `--mission` run on v15 failed with a screenshot timeout (5 s) with the panel open on the title, unchanged code from to-do 6; a timed run had measured such screenshots at up to 4.1 s, so the limit went to 15 s, and the next run passed.
- The user tested v15 in the projector: "Tests look good." (the checklist: the row and its saved choice after a restart; an act other than Act 1 starts at 1x, another at 8x; the mission's panel rows don't overlap and Exit Game works; a loaded save keeps its own speed).
- Finish (Claude): lint and the settings check (41 s) on v15 pass, after the title, premium, shared-save and mission checks above; `src/` unchanged since the v15 build; the original's SHA-256 matches.

### 2026-10-31, To do 7: music mute pauses and resumes, a Next track button
Mute now pauses the song and unmute continues it, on the title, campaign and mission screens; a Next button in the mission's options panel skips to the next song. Findings: "Music" in docs/research/game-code.md; decision: docs/decisions.md.

**Done**
- `src/game/library/SoundLibrary.as`: `pauseBGM` (remembers the song, its position and its end function), `resumeBGM` (plays it from there at the current volume), `stopBGM` and a new song forget it; a paused song counts as playing in `isBGMPlaying`. Playing a song moved into `startBGM`, shared by both.
- `src/game/peacefree/Map.as` (new copy, 21 lines differ from the original): `setEnableBGM` pauses and continues instead of stopping and skipping to the next song; new `nextBGM` stops the song and starts the list's next one. `MapHUD` and the panel keep calling `setEnableBGM`.
- `src/game/peacefree/TitleScreen.as`, `CampaignSelectorScreen.as`: `toggleBGM` pauses on mute and continues on unmute (with nothing paused, starts the menu music as before).
- `src/game/peacefree/interfaces/OptionsInterfacer.as`: a 70x40 "Next" button right of the music readout, only in missions, dimmed and doing nothing while the music is muted.
- Built v12, then v13 after the review (6,531,291 bytes; builds about 23 s; measured). Before that, `Map.as` unchanged in a scratch build: compiled in 15 s, title check PASS (measured).
- No new headless check: the check can't hear the music. A mission check is noted in to-do 8.
- A wrong first theory: "the title's demo map starts `act_1` when the title is muted"; the game has no `act_1` song (`SoundAssets.as`). Marked in docs/research/game-code.md.
- Review (built-in code-review, medium), 8 findings. Fixed: a song paused at its very end now goes on to what its end does (the next song) instead of maybe never ending; no crash when `Sound.play` gives no channel. Can't happen in this game (all four songs are embedded and cached at start, nothing loads while playing): muting or Next while a song loads, and the leftover song on the title that follows from it. Can't happen: Next during the story's music pause (set and cleared in one call). Not taken: splitting `isBGMPlaying` into playing and paused (the demo map would make it forget the paused song); one helper for the two-line mute blocks in three classes (the original screens already repeat each other).

**Test results**
- Claude, v12 and v13: title check PASS (5-7 s), premium check PASS (13 s), shared-save check PASS (6-7 s), settings check PASS (23-24 s), no Ruffle errors from the game (all measured).
- The user tested v13 in the projector: "tested" (the checklist: mute and unmute continue the same song on the title, campaign and mission screens; Next in the mission's panel; Next dimmed while muted; no Next outside missions; menu music from the start after leaving a mission).
- Finish (Claude): lint, title check (4 s), premium check (13 s), shared-save check (7 s) and settings check (21 s) on v13 pass; `src/` unchanged since the v13 build; the original's SHA-256 matches. To-do 7 is done and removed from docs/todo.md.

### 2026-10-31, To do 6, step B: volume sliders
Step B replaces the panel's ON/OFF buttons for music and SFX with sliders and keeps the volumes in their own save. Findings: "Sound and the settings panel" in docs/research/game-code.md; decision (made before step A): docs/decisions.md.

**Done**
- `src/game/library/SoundLibrary.as` (new copy): music and SFX volume in % (0-100), read from the `settings` save when the class starts (defaults: music 35, the game's own level; SFX 100); `playSFX` plays at the SFX volume and plays nothing at 0%; `setMusicVolume` also changes the playing track; `saveVolumes()` writes `{music, sfx}` through `FileLibrary`, so all builds share it.
- `src/game/peacefree/interfaces/OptionsInterfacer.as`: each row's ON/OFF pair is a slider made by `makeSlider` (bar, orange fill, white knob, readout; 200 px wide, 5% steps; press or drag anywhere on the bar). A muted sound shows a dimmed slider and "Off"; dragging unmutes it the way the ON button did. Letting go saves the volumes (closing the panel saves them too); letting go of the SFX slider plays the button click at the new volume. The mute icons on the title, campaign and mission screens are unchanged.
- `scripts/check.py --settings`: now mutes the music with the title's music icon, opens Settings, drags the music slider from 35% to 75%, reads `music` 75 and `sfx` 100 from the `settings` save and `bEnabledBGM` true from `game`, then clicks Back. New `saved_number` reads AMF3 numbers.
- Built v10, then v11 after the review (6,529,806 bytes for v10; builds about 23 s; measured).
- A dead end in the check: its first number reader wanted 4 bytes after the type byte, but `music` comes 2 bytes before the end of the save, so it read nothing while the slider worked (the screenshot showed 75%). The dumped save showed `music` then `04 4B`; fixed by checking only the bytes needed.
- Review (built-in code-review, medium), 9 findings. Fixed: volumes are also saved when the panel closes (a drag might never end on the slider); no sound effects play at 0% (they took slots in the game's limit of 16); the check also reads `sfx`; the check gets the host name once. Left as notes: the panel can't mute and 0% isn't "Off" (decided: the icons mute); `refresh` returns before the sliders when a mission has no map (the panel only opens from the map); every mouse move re-applies the volume (cheap); the two unmute blocks are alike but differ.

**Test results**
- Claude, v10 and v11: title check PASS (4-5 s), premium check PASS (15 s), shared-save check PASS (6-7 s), settings check PASS (25-26 s); the first settings run on v10 failed on the check's own reader, see above (all measured).
- The user tested v11 in the projector: "This looks good". They noticed that muting the music stops it and unmuting starts it again (in a mission: the next song); that's the original game's behaviour (`PeacefreeGame.playBGM`/`stopBGM`, `Map.setEnableBGM`), left for a later to-do: mute will pause and resume everywhere, with a separate button to skip a song.
- Finish (Claude): lint, title check (5 s), premium check (15 s), shared-save check (7 s) and settings check (22 s) on v11 pass; `src/` unchanged since the v11 build; the original's SHA-256 matches. To-do 6 is done; `docs/todo/06-settings.md` removed (its answers are in docs/decisions.md, its log here).

### 2026-10-31, To do 6, step A: Settings on the title and campaign screens
The only settings panel was the options menu inside a mission. Step A opens the same panel from a Settings button on the title and campaign screens; step B adds volume sliders. Findings: "Sound and the settings panel" in docs/research/game-code.md, the Ruffle notice in docs/research/performance.md; decision: docs/decisions.md.

**Done**
- `src/game/peacefree/TitleScreen.as` and `CampaignSelectorScreen.as` (new copies): a Settings button, first in the top left, with the two sound icons moved to its right; it opens one `OptionsInterfacer` per screen, made on first use and disposed with the screen. A sound change in the panel calls the screen's own `toggleBGM(false)` and `toggleSFX(false)`, which update the icons, start or stop the menu music and save.
- `src/game/peacefree/interfaces/OptionsInterfacer.as`: an optional callback; without one (Map's call) the panel works as before. With one (`inMission()` false) Difficulty and Exit Game are hidden, "Back to Game" is "Back" and moves up, and X and Back fade the panel out (`showOn`, `close`). "Unlock All Acts" on the campaign screen makes the screen again (`pgame.goToCampaignScreen()`) so the new acts show. The mode can't come from `pgame.map`: the title screen keeps its demo map there.
- `scripts/check.py --settings`: from the title screen, hides Ruffle's hardware-acceleration notice, waits for the Settings label, clicks it, checks the panel's white "Music Volume" label, clicks SFX OFF and reads `bEnableFX` false from the save in `localStorage` (AMF3: `0x02` false, `0x03` true), clicks Back and checks the panel has gone.
- Built v06, then v07 after the review, v08 after dropping an unused import, v09 after the user moved the button (sizes 6,528,719 / 6,528,573 / 6,528,889 / 6,528,664 bytes; builds 14-16 s; measured).
- Review (built-in code-review, medium), 10 findings. Fixed: an original line lost a space, three files had LF endings in the working copy (now CRLF like the rest), the check crashed instead of failing if Ruffle's page changes or the browser errors, the SFX OFF failure screenshot was taken before the click, the panel's mode test is now named (`inMission()`). Left as notes: the panel stays clickable during the 0.5 s door animation after an unlock (harmless: Back then only closes it early, and the screen's dispose still frees it); each ON/OFF click saves twice; the two screens repeat about 15 lines (one panel owned by `PeacefreeGame` would mean patching it; step B doesn't touch the screens); the check covers the title screen only; it relies on the title screen's own save at start.

**Test results**
- Claude, v06-v09: title check PASS (3-6 s), premium check PASS (9-11 s), shared-save check PASS (4-6 s), settings check PASS (13-20 s). Settings check on v05: FAIL, "no Settings button on the title screen", as it should (all measured).
- The user tested v08 in the projector (the panel from the title, campaign and mission screens): "Looks good", and asked for Settings first with the icons to its right. Tested v09: "tested".
- Finish (Claude): lint, title check (4 s), premium check (10 s), shared-save check (6 s) and settings check (20 s) on v09 pass; `src/` unchanged since the v09 build; the original's SHA-256 matches.

### 2026-10-31, To do 5: shared saves between builds
Every save and load goes through `FileLibrary.loadSharedData`, which called `getLocal(name)` without a path, so Flash kept a separate save for each file path. Findings: "Save data" in docs/research/game-code.md; decision: docs/decisions.md.

**Done**
- `src/game/library/FileLibrary.as`: `getLocal(name, "/")`, for `game` and the saved missions (`save-N`) alike.
- Built `PeacefreeKong-v05-sharedsave.swf` (6,527,759 bytes; measured).
- `scripts/check.py --shared-save`: opens the game with `show_premium=true` (the game saves when the campaign screen opens) and reads Ruffle's `localStorage`: passes on the root key `127.0.0.1//game`, fails at once on any other key for `game`, such as v04's `127.0.0.1/game.swf/game`. Review (built-in code-review, medium): the first version passed on any key ending in `/game` without `game.swf`, picked the first matching key, and waited on the screenshot; now it needs the exact root key, built from the page's host, and reads before the screenshot. Left as notes: another local Flash game with `getLocal("game", "/")` would share the save (decided, docs/decisions.md); the check tests where the save is written, not that a second build reads it (the user's projector test does); three stop flags in the check's loop.
- Copied v04's `game.sol` once to the shared spot in the projector's save folder (none was there; SHA-256 of the copy matches). The older saves are untouched.

**Test results**
- Claude, v05: title check PASS (4 s), premium check PASS (12 s), shared-save check PASS (5 s; 7 s after the review fix). Shared-save check on v04: FAIL at once with `127.0.0.1/game.swf/game`, as it should (all measured).
- The user tested v05 in the projector: v04's progress shows, a setting survives a restart, a renamed copy of v05 in another folder shows the same save, and the P key, premium and resizing still work. Result: "Tested, looks good." Afterwards the projector's save folder had a newly written `#localWithNet\game.sol` and no per-file folder for v05 or the copy (measured), so the projector stores the save under the root as intended.
- Finish (Claude): lint, title check (5 s), premium check (10 s) and shared-save check (5 s) on v05 pass; `src/` unchanged since the v05 build; the original's SHA-256 matches.

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
