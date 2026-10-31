# Network and the Kongregate API

What the game loads or sends over the network. Sources: the decompiled code (to-do 1) and the requests the headless check saw (to-do 2).

## Kongregate API
- `KongregateAPI.init` loads Kongregate's API .swf from the `kongregate_api_path` flashvar, or else from `http://www.kongregate.com/flash/API_AS3_Local.swf`. It has no error handler: if the load fails, its callback never runs and later API calls fail quietly inside try/catch. The title screen is built before this, so the game starts either way.
- Seen in to-do 2: this load is the only network call the game makes. In a browser on another site it fails (CORS), and the game carries on.
- Since v02 (to-do 3) the patched game makes no network calls: `src/game/library/KongregateAPI.as` replaces the Kongregate API with an offline stand-in, so neither the API load nor `use_item.json` happens. Measured in the headless check: the original lists one blocked request (`API_AS3_Local.swf`), v02 and v03 none.
- Calls used: `stats.submit` (LongestGame, Kills, CiviliansRescued, initialized), `mtx.requestUserItemList` (owned items), `mtx.purchaseItems`, `showKredPurchaseDialog`, `showRegistrationBox`, and an HTTP POST to `api.kongregate.com/api/use_item.json` each time a bomb is used ([premium.md](premium.md)).
- `KongregateAPI.as` holds the game's Kongregate API key (the developer's, not an account's; it's in the public .swf). Not repeated here.

## Other
- Gloebit (a second payment service, through the developer's server peacefree.adventurecat.us): present but switched off (GLOEBIT_VERSION false).
- Present but never called: `MapLibrary.loadMap` and `SoundLibrary.loadLibrary` (both would load from peacefree.adventurecat.us), `GameConfig.isSiteLocked`.
- Links to Facebook and Twitter pages (two achievements).
- No network call runs every frame or in a retry loop.
