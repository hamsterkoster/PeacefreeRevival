# Premium

How the game decides whether premium is owned, and what it unlocks. Source: the decompiled code (to-do 1). For to-do 3.

## The flag
- One flag: `PeacefreeGame.bPremiumUser`, read through `isPremiumPlayer()`. It becomes true only when Kongregate's item list holds an item `premium` (`updateKongregateItems`), or after a purchase.
- It is never saved; the game asks Kongregate on every start. So unlocking it needs no save editing.
- The Kongregate calls involved (`mtx.requestUserItemList`, `mtx.purchaseItems`, `use_item.json`): [network.md](network.md).

## What it unlocks
- Cross Zap: Zap also hits the 4 neighbouring tiles (`CommandInterfacer.as:545`).
- Shock Bomb and Nox Bomb buttons (`CommandInterfacer.as:235`, `:258`).
- Extra watchtower upgrades: Blaster, Noxxer and Zap sentry (`SecuredTileOptionList.as:759-779`).
- Bonus resources at mission start: 200 food, 200 minerals, 4 extra troops, max recruits 4 (`Player.as:89`, `:188`).
- Act 11, Endless Boss Run (`CampaignActButton.as:66`, `CampaignSelectorScreen.as:306`).
- The Shop button on the campaign screen, which then hides the premium button (`CampaignSelectorScreen.as:124`).
- The "Unlocked Premium Features" achievement.

## Bombs
- The bombs are separate consumables. Their counts (`shockLeft`, `noxLeft`) come only from Kongregate items `shock_bomb` and `nox_bomb`, and each use posts to `use_item.json`.
- With premium alone both counts stay 0, so to-do 3 also has to give the bombs a count and skip that call.

## Smallest patch (suggestion from to-do 1, not tried yet)
Make `isPremiumPlayer()` return true, plus the bomb change above.
