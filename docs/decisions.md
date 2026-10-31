# Decisions

One entry per decision, newest first: the date and decision as the heading, then the reason, who decided, and what was rejected and why. CLAUDE.md "Decisions" keeps only the rule that follows from each one.

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
