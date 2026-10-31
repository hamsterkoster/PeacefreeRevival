# Premium

How the game decides whether premium is owned, and what it unlocks. Sources: the decompiled code (to-do 1, to-do 3) and the headless premium check (to-do 3).

## The flag
- One flag: `PeacefreeGame.bPremiumUser`, read through `isPremiumPlayer()`. It becomes true only when Kongregate's item list holds an item `premium` (`updateKongregateItems`), or after a purchase.
- It is never saved; the game asks Kongregate on every start. So unlocking it needs no save editing.
- The Kongregate calls involved (`mtx.requestUserItemList`, `mtx.purchaseItems`, `use_item.json`): [network.md](network.md).

## What it unlocks
- Cross Zap: Zap also hits the 4 neighbouring tiles (`CommandInterfacer.as:545`).
- Shock Bomb and Nox Bomb buttons (`CommandInterfacer.as:235`, `:258`).
- Extra watchtower upgrades: Blaster, Noxxer and Zap sentry (`SecuredTileOptionList.as:759-779`).
- Bonus resources at mission start: 200 food, 200 minerals, 4 extra troops, max recruits 4 (`Player.as:89`, `:188`).
- Act 11, Endless Boss Run (`CampaignActButton.as:66`, `CampaignSelectorScreen.as:306`). With premium its button ("Boss Run") shows even before act 10 is finished: the premium check overrides the unlocked-acts check (`CampaignActButton.as:64-74`; seen in the headless screenshot, to-do 3).
- The Shop button on the campaign screen, labelled "Weapons" (green), in place of the gold "Premium" button (`CampaignSelectorScreen.as:124`).
- The "Unlocked Premium Features" achievement.

## Bombs
- The bombs are separate consumables. Their counts (`shockLeft`, `noxLeft`) come only from Kongregate items `shock_bomb` and `nox_bomb`, and each use posts to `use_item.json`.
- With premium alone both counts stay 0, so to-do 3 also has to give the bombs a count and skip that call.
- Since v02 (to-do 3): the stand-in starts each game with 10 of each, counts uses down, and the shop adds 10 for free; no `use_item.json` call.

## The shop needs Kongregate too (to-do 3, from the code, not run)
Buying bombs in the shop shows "Processing payment..." over a black film that covers the whole shop, and only Kongregate's purchase callback hides them again (`PeacefreeGame.buyShockBombsViaKongregate`, `ShopInterfacer.as:72-110`). Without Kongregate, `KongregateAPI.purchase` fails quietly inside try/catch, so the callback never runs and the shop would stay stuck.

## The `show_premium` flashvar
With `show_premium=true` the game opens the campaign screen at start and shows the "Premium Features" sales popup over it, even for a premium player (`PeacefreeGame.as:220`, `:654`). `scripts/check.py --premium` uses it: the top button is green "Weapons" (premium) or gold "Premium" (locked). Measured in headless Ruffle, button area darkened by the popup: v02 81% green, 0% gold; the original 0% green, 53% gold.

## Smallest patch (suggestion from to-do 1): wrong, replaced
To-do 1 suggested making `isPremiumPlayer()` return true plus a bomb change. Not enough: the bombs and the shop (above) still depend on Kongregate. Replaced in to-do 3 by an offline stand-in for Kongregate in `src/game/library/KongregateAPI.as` (v02, cleaned up in v03): it reports premium and the bombs as owned, purchases succeed for free, and bomb use is counted locally. Decision and reasons: [decisions.md](../decisions.md).
