# Performance

Why the game lagged and what runs it smoothly. Sources: the user's FPS readings from Starling's stats box (P key, build v01), the headless check, and the decompiled code (to-dos 1 and 2).

## Result
The lag is the player, not the game: the Flash Player projector runs it at about 60 fps. Decision: play in the projector, no fixes for Ruffle ([decisions.md](../decisions.md)).

## Player comparison (to-do 2)
FPS read by the user from the stats box, rounded: title screen / about 30 s into Act 1.
- Flash Player projector 32.0.0.465: about 60 / 60. Played best.
- Ruffle app (nightly 2026-10-29): about 40 / 40. Okay but slow.
- Ruffle in the browser (`scripts/play.py`, the default browser): about 20 / 15. Worst.
- Ruffle also drew some graphics wrong, for example a white background where it should be black.
- Not measured: a busy moment late in a mission (the user's original complaint). If that lags in the projector, it needs a new to-do.

## Rendering
- Starling 1.4.1 on Stage3D, 800x540, 60 fps target ([game-code.md](game-code.md)).
- Ruffle's web version uses its `wgpu-webgl` renderer here (needed for Stage3D). The graphics driver logged "GPU stall due to ReadPixels" warnings in headless Chromium; whether they cost FPS is unknown.
- Headless Chromium showed 5.4 FPS on the title screen (measured, but headless and while taking screenshots, so only a hint).
- Headless Chromium has no GPU, so Ruffle reports a CPU adapter and opens its "hardware acceleration is disabled" notice over the game at the first mouse-over; the notice catches the clicks meant for the game (measured, to-do 6: the first click on Settings only darkened the page). No Ruffle setting turns it off (`ruffle.js` opens it whenever the adapter type is `Cpu`); `check.py --settings` hovers once and then hides the notice (`#hardware-acceleration-modal` in the player's shadow DOM).

## Per-frame work in the game
Every frame the game updates all 625 tiles and every enemy, re-sorts the enemy list and rebuilds 7 HUD texts (`Map.progress`, `MapHUD.update`). Not a problem in the projector at the measured scenes; it is the first place to look if a late mission lags.

## Leads, dead ends and dropped plans
- To-do 1's lead "Ruffle's Stage3D support is newer than its 2D rendering, so the player is the first suspect" (an estimate then): confirmed by the comparison above.
- To-do 1's 2272x1280 game size: wrong, it's 800x540 ([game-code.md](game-code.md)).
- To-do 2's planned step B, cutting the per-frame work above: dropped, because the projector doesn't need it.
