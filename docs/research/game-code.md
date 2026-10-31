# Game code

What the original .swf holds, how its code is laid out, how content is defined, and how it saves. Source: the decompiled code in `decompiled/PeacefreeKong/scripts/` (to-do 1) unless an entry says otherwise. Numbers marked (measured) were measured; the rest are counts from the code.

## The file (measured)
- One .swf: LZMA-compressed (`ZWS`), SWF version 23, 7,463,597 bytes uncompressed. ActionScript 3.
- Not obfuscated (readable names), no embedded .swf, no active sitelock.

## Startup and rendering
- Frame 1 is `StarlingPreloader` (logo and loading bar); frame 2 holds the rest. The preloader starts Starling 1.4.1 with `game.peacefree.PeacefreeGame` as the root class.
- Starling draws on the GPU through Stage3D, at 60 fps (`GameConfig` default).
- Game size 800x540, the same as the SWF stage: `StarlingPreloader` calls `GameConfig.setScreenResolution(800,540,...)` at startup (`StarlingPreloader.as:38`). Corrected in to-do 2: to-do 1 said 2272x1280, which is only the default in `GameConfig`.
- Game version "Ver.1.08". Build flags in `game/container/GameConfig.as`: KONG_VERSION true, GLOEBIT_VERSION false, DEBUG_MODE, CHEAT_MODE and ENABLE_SITELOCK false.

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
