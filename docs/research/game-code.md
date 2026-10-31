# Game code

What the original .swf holds, how its code is laid out, how content is defined, and how it saves. Source: the decompiled code in `decompiled/PeacefreeKong/scripts/` (to-do 1) unless an entry says otherwise. Numbers marked (measured) were measured; the rest are counts from the code.

## The file (measured)
- One .swf: LZMA-compressed (`ZWS`), SWF version 23, 7,463,597 bytes uncompressed. ActionScript 3.
- Not obfuscated (readable names), no embedded .swf, no active sitelock.

## Startup and rendering
- Frame 1 is `StarlingPreloader` (logo and loading bar); frame 2 holds the rest. The preloader starts Starling 1.4.1 with `game.peacefree.PeacefreeGame` as the root class.
- Starling draws on the GPU through Stage3D, at 60 fps (`GameConfig` default).
- Game size 800x540, the same as the SWF stage: `StarlingPreloader` calls `GameConfig.setScreenResolution(800,540,...)` at startup (`StarlingPreloader.as:38`). Corrected in to-do 2: to-do 1 said 2272x1280, which is only the default in `GameConfig`.
- Game version "Ver.1.08". Build flags in `game/container/GameConfig.as`: KONG_VERSION true, GLOEBIT_VERSION false, DEBUG_MODE, CHEAT_MODE and ENABLE_SITELOCK false. DEBUG_MODE and CHEAT_MODE are read nowhere in the decompiled code (to-do 3), so there is no hidden cheat or unlock to switch on.
- Window resize (to-do 3, measured in the projector): resizing the projector window makes Windows reset the graphics device. Starling's `handleLostContext` is off in the original, so Starling stops and shows "Fatal error: The application lost the device context!" on a white screen; the projector keeps running. The original does the same: same Starling setup, and its window showed the same red bar (only seen in a small capture). Fixed in v04 by turning `handleLostContext` on in `src/StarlingPreloader.as`: the game keeps drawing after resizing (measured). Its costs, from Starling 1.4.1's code: textures keep a copy of their image for restoring (more memory, not measured), and the minimap's RenderTexture comes back blank until it is redrawn.
- The game doesn't scale with the window: `StarlingPreloader` sets `scaleMode` to `noScale` and `align` to top-left, so the 800x540 game stays in the top-left corner and a smaller window crops it.

## Code map (`decompiled/PeacefreeKong/scripts/`)
- `game/peacefree/` (96 classes): `PeacefreeGame` (root: screens, premium state, save and load), `Map` (2,634 lines: the battle map, commands, game rules), `Tile`, `Building` (1,930 lines), `Mob` (1,501 lines), `Player` (resources and troops), `Mission` with 13 objective types in `missions/`, 5 bosses in `mobs/`, `effects/`, and every UI panel in `interfaces/`.
- `game/acts/`: `Act1` to `Act11` and `DemoMap`, one class per campaign act.
- `game/library/`: `KongregateAPI`, `GloebitAPI`, `FileLibrary` (saves), `MapLibrary` (map parser), `SoundLibrary`, `JSONLibrary` (HTTP).
- `starling/`: the Starling library, third-party code.
- Top level: embedded-asset classes (`Assets`, `SoundAssets`, `Fonts`, `ParticleAssets`, `*_mp3`, `*_png`, `exmission*_txt`).

## How content is defined
- Levels are data plus code. Each act's tile map is an embedded text file (binaryData `exmissionN_txt`, 25x25 tiles): rows split by newline, tiles by `;`, fields by `:` in this order: tile type, building, decor, danger, food, minerals, recruits, lock ID, secured, scouted, scouted-nearby, secured-nearby, then optional rescued and visible (`Map.loadMap`). The start point, objectives, story dialogue and scripted events are code in the act's class.
- Act to map: Act1 exmission18, Act2 11, Act3 12, Act4 13, Act5 14, Act6 16, Act7 17, Act8 7, Act9 9, Act10 8, DemoMap 4. Act11 (Endless Boss Run) builds a random map with `RandomMapGenerator`.
- Enemies are code only: about 25 numbered types as constants in `Mob.as` (`MOB_BIOSHIP = 1` and so on), with stats and behaviour in switch statements there; the 5 bosses have their own classes. `MobGenerator` spawns a mob type from a tile at an interval.
- Buildings are code only: numbered types with switch statements in `Building.as`.

## Save data
- Local Flash cookies (`SharedObject.getLocal` in `FileLibrary`): `game` holds unlocked acts, sound settings, best records, achievements and the Facebook/Twitter flags; `save-N` holds saved missions (`Map.as:2231`, slots in `SaveFileInteracer`).
- No server saves. Flash cookies are stored per site, so saves made on kongregate.com don't appear when the file is opened locally, and the other way round.
- Premium isn't in the save: [premium.md](premium.md).
- Flash keys a local file's save on the file's full path, file name included, because `getLocal` gets no `localPath` (`FileLibrary.as:15`). So in the original and v01-v04, every build has its own save, and each new build starts at the tutorial again. Measured in to-do 3: the projector's save folder has separate `game.sol` files under `.../patched/PeacefreeKong-v01-fpsmeter.swf/` and `.../PeacefreeKong-v03-premium.swf/` (in `%APPDATA%\Macromedia\Flash Player\#SharedObjects\<random>\#localWithNet\`; the drive letter isn't in the path).
- From v05, all builds share one save: `src/game/library/FileLibrary.as` passes `"/"` as `localPath`, so the projector keeps `game.sol` (and `save-N.sol`) straight in `#localWithNet\`, wherever the build is and whatever its name. The original isn't patched and keeps its own save. Measured after the user's test: the projector wrote only `#localWithNet\game.sol`, with no per-file folder for v05 or a renamed copy of it in another folder. Every save and load goes through `FileLibrary.loadSharedData`; nothing else calls `getLocal` (to-do 5). The drawback: another local Flash game that also uses `getLocal("game", "/")` would share the file.
- Ruffle's web version keeps saves in `localStorage` as `<host><path>/<name>` without the port (measured, to-do 5): `127.0.0.1/game.swf/game` for v04 (under the file's path), `127.0.0.1//game` for v05. `check.py --shared-save` checks for the second.
- The game writes `game` whenever the campaign screen opens (`PeacefreeGame.as:649`), so `show_premium=true`, which starts there, makes it save within about a second (measured).
- A `.sol` file holds its own name in the header (`TCSO`, then the name's length and the name, here `game`), not its path; so copying one to another folder moves the save. To-do 5 copied v04's `game.sol` into `#localWithNet\` once. The saves before that (decoded, to-do 5): original none unlocked; v01 act 2, best 37 rescues and longest game 11; v03 act 2; v04 acts 2-11 (from "Unlock All Acts"), 5 kills, 4 rescues. No `save-N` files existed.
- Progress is the `unlockedActs` list: winning act N adds N+1 (`Act1.as:1722-1734` and the other acts); the campaign screen shows an act's button only if it's in the list (`CampaignActButton.as:46-61`). Medals for the Tech screen come from achievements (`SkillsInterfacer.as:183`).
- The only settings panel is the options menu inside a mission (`OptionsInterfacer`, opened from the mission's HUD): music, SFX, difficulty, Exit Game, Back to Game. v04 adds "Unlock All Acts" there.
