# Decisions

One entry per decision, newest first: the date and decision as the heading, then the reason, who decided, and what was rejected and why. CLAUDE.md "Decisions" keeps only the rule that follows from each one.

## 2026-10-31: Settings on the title and campaign screens; volume sliders saved in their own save
- What: a "Settings" text button, first in the top left with the two sound icons moved to its right, on the title and campaign screens opens the mission's options panel (`OptionsInterfacer`), without Difficulty and Exit Game; Back closes it; "Unlock All Acts" stays and, on the campaign screen, makes the screen again so the new acts show. The panel knows it's outside a mission because the screen passes it a callback (Map passes none), not from `pgame.map`, which holds the title's demo map. Built in step A: v08 had the button after the icons; the user asked for it first while testing v08, so v09 has Settings first and the icons to its right. Step B: music and SFX sliders, 0-100% in 5% steps, 100% = full volume, music starting at 35% (the game's own level) and SFX at 100%; the old icons stay as quick mute, the panel shows "Off" beside a muted slider and dragging it unmutes; volumes in their own `settings` save (through `FileLibrary`, so shared by all builds), read at start by the sound code; the slider is built inside `OptionsInterfacer`.
- Reason: the user's request (to-do 6): settings reachable from the title and act screens, volume as a slider. One panel for all three screens, so the sliders are built once. A separate save keeps `PeacefreeGame` (1,149 lines) unpatched; the mute flags stay in the game's save, where the game reads them. Inside `OptionsInterfacer` because `build.py` can only replace existing classes ([research/game-code.md](research/game-code.md)).
- Decided by: the user, taking all suggested answers, to-do 6.
- Rejected: the campaign button next to Tech/Load/Back (the to-do's first suggestion): that side is full (Weapons, Tech, Load, Back), and the left keeps it in the same spot on both screens. 10% steps: 35% isn't one. ON/OFF buttons beside each slider: crowded rows. Volumes in the game's own save: needs `PeacefreeGame` patched. One panel owned by `PeacefreeGame` instead of one per screen (the review's note): the same patch; the two screens' 15 shared lines don't change in step B. Extending `build.py` to add new classes: not needed for one slider.

## 2026-10-31: All builds share one save, under the root path; v04's save carried over
- What: from v05, `src/game/library/FileLibrary.as` calls `SharedObject.getLocal(name, "/")`, so every build reads and writes the same `game` and `save-N` saves, wherever the file is and whatever it's called. The save names stay `game` and `save-N`. The original .swf isn't patched and keeps its own save. Claude copied v04's `game.sol` once to the shared spot (only because none was there); the older saves stay untouched.
- Reason: the user's request: progress should carry over to each new build instead of starting at the tutorial again ([research/game-code.md](research/game-code.md)). One line in the one class every save goes through. `"/"` rather than the builds' folder, so a save also follows a build that's moved or downloaded elsewhere.
- Decided by: the user, taking the suggested answers, to-do 5: v04's save (newest, all acts), a one-time copy without a script, the original kept separate, the names unchanged.
- Rejected: unique names such as `peacefree-game` (they would avoid sharing a file with another local Flash game that uses `getLocal("game", "/")`, which is rare, but the copy would have had to rewrite the name inside the file). Merging v01's better records into the save: not worth the work. A copy script: one copy doesn't need one, and fans won't have our old per-build saves. Reading the old per-file save when the shared one is empty: a new build's own path never had a save, so it wouldn't help.
- Follows: if the public release needs it, unique names can come later with one more one-time copy.

## 2026-10-31: An "Unlock All Acts" button in the mission's options menu, in every build for now
- What: `src/game/peacefree/interfaces/OptionsInterfacer.as` adds the button under "Back to Game". After a confirm popup it adds acts 2-11 to the save's unlocked acts, as if each earlier act was won, and saves. It can't be undone. It unlocks acts only; medals for the Tech screen still come from achievements.
- Reason: the user wants to skip the long tutorial when testing; every build has its own save, so each new build starts at the tutorial ([research/game-code.md](research/game-code.md)). The options menu is the game's only settings panel, and it exists only inside a mission.
- Decided by: the user ("a button in settings that unlocks everything", in every build "for now"), to-do 3. Acts only, not medals: Claude's reading of "everything" (the request was about missions); medals change the game's balance.
- Rejected: always showing every act button (Claude's suggestion): the user preferred a button they choose to press.
- Follows: decide before the public release whether the button stays, becomes optional or goes.

## 2026-10-31: Starling's `handleLostContext` is on (fixes the crash when resizing the window)
- What: `src/StarlingPreloader.as` sets `Starling.handleLostContext = true` before creating Starling.
- Reason: resizing the projector window resets the graphics device; with the setting off (the original), Starling stops with a fatal error. Reproduced and fixed, measured ([research/game-code.md](research/game-code.md)).
- Decided by: the user, taking the suggested answer, to-do 3.
- Rejected: nothing else fixes it from inside the game. Accepted costs: more memory (texture copies) and a blank minimap after a resize until it redraws.

## 2026-10-31: Saves shared between builds: a to-do of its own
- What: making all builds share one save (to-do 5) waits; for now each build has its own save. Done in to-do 5: see "All builds share one save" above.
- Reason: it changes where the user's saves live, so it gets its own decision.
- Decided by: the user, taking the suggested answer, to-do 3.

## 2026-10-31: Kongregate is replaced by an offline stand-in in `KongregateAPI.as`
- What: `src/game/library/KongregateAPI.as` never loads Kongregate's API. It answers the game's item-list request with "owns premium and these bombs", lets every purchase succeed for free, counts used bombs itself, and reports the player as signed in, which hides the dead "Sign in" link. The game makes no network calls at all.
- Reason: every ownership answer the game gets passes through this one 244-line class, so one small class unlocks everything and leaves the game's own code untouched. Off kongregate.com, Kongregate's sign-in, stats and purchases can't work anyway.
- Decided by: the user, taking the suggested answer ("remove kongregate stuff for now"), to-do 3.
- Rejected: making `isPremiumPlayer()` return true (to-do 1's suggestion): the bombs stay at 0 and buying in the shop hangs on "Processing payment..." ([research/premium.md](research/premium.md)). Setting the flag in `PeacefreeGame.as`: a 1149-line class, and the bomb and shop fixes would still need `KongregateAPI.as`, so two classes instead of one.

## 2026-10-31: Bombs: 10 of each at every game start, counted down, free in the shop
- What: each game start gives 10 Shock and 10 Nox bombs; each use counts one down; the shop's Buy adds 10 for free. The shop still says "10 Kreds".
- Reason: keeps the game's balance as designed (cooldown plus a limited supply) without ever blocking the player. The counts aren't saved because the original never saved them (Kongregate held them).
- Decided by: the user, taking the suggested answers, to-do 3.
- Rejected: unlimited bombs (the counter would never go down). Changing the shop's "Kreds" text now: it needs a second class (`ShopInterfacer`); worth doing before the public release.

## 2026-10-30: Play in the Flash Player projector; no fixes for Ruffle
- Reason: in the user's test (to-do 2), the projector ran the game at about 60 fps, the Ruffle app at about 40 and Ruffle in the browser at 15-20, and Ruffle drew some graphics wrong. Details: [research/performance.md](research/performance.md).
- Decided by: the user, to-do 2.
- Rejected: Ruffle as the player (slower, drawing errors); to-do 2's planned step B, cutting the game's per-frame work, because the projector doesn't need it.
- Follows: the headless check still uses Ruffle's web version, only as a smoke test that a build loads.

## 2026-10-30: Patches are edited copies of whole classes in `src/`, compiled in with ffdec's `-replace`
- Reason: `decompiled/` stays exactly the original, and `git diff --no-index` shows each patch.
- Decided in: to-do 2, when `scripts/build.py` was written. Who decided and what was rejected weren't recorded.

## 2026-10-30: `patched/*.swf` is gitignored
- Reason: each build contains the whole original, so this follows from the `original/` decision below. `src/` and `scripts/build.py` make it again, byte for byte; its SHA-256 goes in NOTES.md.
- Decided by: follows from the user's `original/` decision.

## 2026-10-30: `original/` is gitignored
- Reason: Helgravis's .swf stays out of the public history, the hardest thing to take back later. Its SHA-256 in NOTES.md proves which file we worked from.
- Decided by: the user.

## 2026-10-30: The game's Kongregate API key stays in the tracked decompiled code
- Reason: it's the developer's key for the game, not an account's, and it's in the public .swf ([research/network.md](research/network.md)). It isn't an account token as meant by "Never in tracked files".
- Decided by: the user, taking the suggested answer (to-do 1). The other option, removing it from the tracked `KongregateAPI.as`, wasn't needed for the reason above.

## 2026-10-30: Decompiled scripts are tracked; exported media is not
- Reason: patches show as readable diffs; the media is bulky and can be exported again.
- Decided at: project setup. Who decided and what was rejected weren't recorded.

## 2026-10-30: `tools/` is gitignored
- Reason: it holds downloads only; our own scripts live in `scripts/`.
- Decided at: project setup. Who decided and what was rejected weren't recorded.

## 2026-10-30: Private now, public later
- Reason: premium can no longer be bought, and Helgravis didn't answer requests about a re-release.
- Decided by: the user.
- Follows: git history goes public with the repo, so "Never in tracked files" in CLAUDE.md applies from the first commit.
