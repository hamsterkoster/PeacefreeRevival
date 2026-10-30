# Notes

Log of findings, patches and test results. Newest entry first; each entry has the date, the to-do number, what was done and the result.

## Original file
`original/PeacefreeKong.swf`, downloaded from the game's Kongregate page (https://www.kongregate.com/en/games/helgravis/peacefree-tactical-warfare).
- 6,526,889 bytes, SHA-256 `3faa86dcb2ae923a149957778535d2a2ebbb5820a9fc4dbfd6ae011b958ad943`.
- `original/` is gitignored; this hash is how we check the file is unchanged.

## Patched files
One line per file in `patched/`: what it contains and its test status.

(none yet)

## Log

### 2026-10-30, To do 1: inspect and decompile
All findings come from reading the decompiled code; nothing was run in a player yet. Numbers marked (measured) were measured, the rest are counts from the code.

**Done**
- ffdec 26.4.0 (release zip, SHA-256 matched GitHub's digest) in `tools/ffdec/`; runs on the installed Java 8. Python venv `.venv` with ruff 0.17.3.
- `scripts/decompile.py` exports everything into `decompiled/PeacefreeKong/`: 3.6 s for a full run (measured), exit code 0, 0 scripts with ffdec's failure markers (measured).
- Tracked: 225 scripts, 16 binaryData files, the symbol list (242 files, 2.3 MB). Gitignored: 6 images, 13 sounds, 2 frames. `.gitignore` now uses an allowlist for `decompiled/*/` (only scripts, texts, binaryData, symbolClass), and `original/` is ignored.
- The script refuses to replace a folder with uncommitted changes (`--force` overrides), exports into `<name>.new/` and swaps it in only on success, and rejects an unreadable file (ffdec itself exits 0 then).
- Test: Claude checked the export, the guard, a broken input and the gitignore rules; the user went through the test checklist (this summary, the hash, an optional script run) and reported it good. The game's Kongregate API key stays in the tracked decompiled code (the suggested answer).

**The file** (measured)
- One .swf: LZMA-compressed (`ZWS`), SWF version 23, 7,463,597 bytes uncompressed. ActionScript 3.
- Not obfuscated (readable names), no embedded .swf, no active sitelock.
- Frame 1 is `StarlingPreloader` (logo and loading bar); frame 2 holds the rest. The preloader starts Starling 1.4.1 with `game.peacefree.PeacefreeGame` as the root class.
- Starling draws on the GPU through Stage3D. `GameConfig` defaults: 2272x1280 game size, 60 fps; the SWF stage is 800x540.
- Game version "Ver.1.08". Build flags in `game/container/GameConfig.as`: KONG_VERSION true, GLOEBIT_VERSION false, DEBUG_MODE, CHEAT_MODE and ENABLE_SITELOCK false.

**Code map** (`decompiled/PeacefreeKong/scripts/`)
- `game/peacefree/` (96 classes): `PeacefreeGame` (root: screens, premium state, save and load), `Map` (2,634 lines: the battle map, commands, game rules), `Tile`, `Building` (1,930 lines), `Mob` (1,501 lines), `Player` (resources and troops), `Mission` with 13 objective types in `missions/`, 5 bosses in `mobs/`, `effects/`, and every UI panel in `interfaces/`.
- `game/acts/`: `Act1` to `Act11` and `DemoMap`, one class per campaign act.
- `game/library/`: `KongregateAPI`, `GloebitAPI`, `FileLibrary` (saves), `MapLibrary` (map parser), `SoundLibrary`, `JSONLibrary` (HTTP).
- `starling/`: the Starling library, third-party code.
- Top level: embedded-asset classes (`Assets`, `SoundAssets`, `Fonts`, `ParticleAssets`, `*_mp3`, `*_png`, `exmission*_txt`).

**How content is defined**
- Levels are data plus code. Each act's tile map is an embedded text file (binaryData `exmissionN_txt`, 25x25 tiles): rows split by newline, tiles by `;`, fields by `:` in this order: tile type, building, decor, danger, food, minerals, recruits, lock ID, secured, scouted, scouted-nearby, secured-nearby, then optional rescued and visible (`Map.loadMap`). The start point, objectives, story dialogue and scripted events are code in the act's class.
- Act to map: Act1 exmission18, Act2 11, Act3 12, Act4 13, Act5 14, Act6 16, Act7 17, Act8 7, Act9 9, Act10 8, DemoMap 4. Act11 (Endless Boss Run) builds a random map with `RandomMapGenerator`.
- Enemies are code only: about 25 numbered types as constants in `Mob.as` (`MOB_BIOSHIP = 1` and so on), with stats and behaviour in switch statements there; the 5 bosses have their own classes. `MobGenerator` spawns a mob type from a tile at an interval.
- Buildings are code only: numbered types with switch statements in `Building.as`.

**Kongregate API and network**
- `KongregateAPI.init` loads Kongregate's API .swf from the `kongregate_api_path` flashvar, or else from `http://www.kongregate.com/flash/API_AS3_Local.swf`. It has no error handler: if the load fails, its callback never runs and later API calls fail quietly inside try/catch. The title screen is built before this, so the game starts either way.
- Calls used: `stats.submit` (LongestGame, Kills, CiviliansRescued, initialized), `mtx.requestUserItemList` (owned items), `mtx.purchaseItems`, `showKredPurchaseDialog`, `showRegistrationBox`, and an HTTP POST to `api.kongregate.com/api/use_item.json` each time a bomb is used.
- Gloebit (a second payment service, through the developer's server peacefree.adventurecat.us): present but switched off (GLOEBIT_VERSION false).
- Present but never called: `MapLibrary.loadMap` and `SoundLibrary.loadLibrary` (both would load from peacefree.adventurecat.us), `GameConfig.isSiteLocked`.
- Other: links to Facebook and Twitter pages (two achievements).
- No network call runs every frame or in a retry loop.
- `KongregateAPI.as` holds the game's Kongregate API key (the developer's, not an account's; it's in the public .swf). Not repeated here.

**Premium**
- One flag: `PeacefreeGame.bPremiumUser`, read through `isPremiumPlayer()`. It becomes true only when Kongregate's item list holds an item `premium` (`updateKongregateItems`), or after a purchase. It is never saved; the game asks Kongregate on every start.
- What it unlocks:
  - Cross Zap: Zap also hits the 4 neighbouring tiles (`CommandInterfacer.as:545`).
  - Shock Bomb and Nox Bomb buttons (`CommandInterfacer.as:235`, `:258`).
  - Extra watchtower upgrades: Blaster, Noxxer and Zap sentry (`SecuredTileOptionList.as:759-779`).
  - Bonus resources at mission start: 200 food, 200 minerals, 4 extra troops, max recruits 4 (`Player.as:89`, `:188`).
  - Act 11, Endless Boss Run (`CampaignActButton.as:66`, `CampaignSelectorScreen.as:306`).
  - The Shop button on the campaign screen, which then hides the premium button (`CampaignSelectorScreen.as:124`).
  - The "Unlocked Premium Features" achievement.
- The bombs are separate consumables. Their counts (`shockLeft`, `noxLeft`) come only from Kongregate items `shock_bomb` and `nox_bomb`, and each use posts to `use_item.json`. With premium alone both counts stay 0, so to-do 3 also has to give the bombs a count and skip that call.
- Smallest patch for to-do 3 (suggestion): make `isPremiumPlayer()` return true, plus the bomb change above.

**Save data**
- Local Flash cookies (`SharedObject.getLocal` in `FileLibrary`): `game` holds unlocked acts, sound settings, best records, achievements and the Facebook/Twitter flags; `save-N` holds saved missions (`Map.as:2231`, slots in `SaveFileInteracer`).
- No server saves. Flash cookies are stored per site, so saves made on kongregate.com don't appear when the file is opened locally, and the other way round.
- Premium isn't in the save, so unlocking it needs no save editing.

**Leads for to-do 2 (performance)**
- Rendering is Starling on Stage3D at a 2272x1280 game size and 60 fps. Ruffle's Stage3D support is newer than its 2D rendering, so the player is the first suspect (estimate, not tested).
- The only network wait is the Kongregate API load at start, which doesn't block the game.
