# To do

Next number: 11

## To do

The order follows the roadmap in docs/decisions.md (2026-10-31): quality of life in the Flash version (7-9), its release (10), then the refactor (4) and modding.

### 7. Music: mute pauses and resumes, a Next track button (medium)
Goal: "For the music mute, it seems to stop the music and then restart it, rather than muting/unmuting." and "If we want to allow skipping tracks that should be a separate button in my opinion."
- Problem: muting stops the song. Unmuting starts `main_menu` from the beginning on the title and campaign screens (`PeacefreeGame.playBGM`/`stopBGM`, `PeacefreeGame.as:681-692`) and skips to the next song in a mission (`Map.setEnableBGM` moves `bgIndex` on, `Map.as:1891`). Wanted: mute pauses, unmute continues the same song from where it was, on every screen; skipping is its own button.
- Decided (the user, 2026-10-31): resume everywhere, missions included. Rejected: keeping the original behaviour; resuming only on the title and campaign screens with "unmute = next song" kept in missions (Claude's first suggestion), because skipping should be a separate button.
- Read first: `src/game/library/SoundLibrary.as` (`playBGM`, `stopBGM`, `currentBGMChannel`); `toggleBGM` in `src/game/peacefree/TitleScreen.as` and `CampaignSelectorScreen.as`; `Map.as:1891-1937` (`setEnableBGM`, `playBGM`, and `pauseBGM`, which also stops); `MapHUD.toggleBGM` (`MapHUD.as:913`); the music slider's unmute in `src/game/peacefree/interfaces/OptionsInterfacer.as`.
- Approach: `SoundLibrary` gets a pause that remembers the song and its position (`SoundChannel.position`) and continues a paused song from there when it's played again; screen changes still stop it for good. Missions: patch `Map.setEnableBGM` (first build `Map.as`, 2,634 lines, unchanged and run the checks, to see that it recompiles cleanly), or else change its two callers (`MapHUD.toggleBGM`, the panel). A "Next track" button in the panel beside the music slider, missions only.
- Ask the user: the button's place (suggested: a small "Next" button right of the music readout, missions only); Next while muted (suggested: dimmed, does nothing).
- Test: the headless checks pass (they can't hear the music; the build session decides whether a check can see the paused song); in the projector, mute and unmute continue the same song on the title, campaign and mission screens, and Next starts the next song in a mission.

### 8. Game options: start speed, fullscreen, window sizes (medium)
Goal: Claude's suggestions "starting game speed" and "fullscreen button" ("Your suggestions sound good. Lets add 1-3 to the to do."), and "For 2, maybe we can have different window sizes?"
- Problem: every new mission starts at 4x speed (`Map.as:232`, `mapHUD.changeSpeed(4)`; a loaded save keeps its own, `Map.as:405`); the game has 1x, 4x and 8x. The game has a working fullscreen toggle (`PeacefreeGame.toggleFullScreen`, `PeacefreeGame.as:1037`; Esc leaves it, 503-512), but the developer switched its title button off (`TitleScreen.as:162`, `if(false && ...)`). Flash Player can't resize its own window from ActionScript (only Adobe AIR can), so window sizes need something outside the game; dragging the window edge already works.
- Read first: those lines; `MapHUD.changeSpeed` (`MapHUD.as:585`); `resizeStage`/`resizeBack` in `src/StarlingPreloader.as` and the `handleLostContext` decision (CLAUDE.md Decisions: resizing once killed the game); `SoundLibrary.saveVolumes` (the `settings` save to extend); docs/local.md (the projector's path and run command).
- Approach: in the panel, a "Start speed" row (1x / 4x / 8x, saved in `settings`, applied where a new mission starts; needs `Map.as` or its caller patched, which to-do 7 may already have done) and a "Fullscreen" button calling the game's own toggle. A Python launcher in `scripts/` that starts the projector with a build and sets its window size through the Windows API.
- Steps (suggested): A start speed and the Fullscreen button (in the game), B the launcher (outside it).
- Ask the user: the start speed default (suggested: 4x, the game's own); the window sizes (suggested: 800x540, 1200x810 and 1600x1080, the game's own shape); the launcher's form (suggested: `.venv/Scripts/python scripts/projector.py patched/<file> --size 1200x810`).
- Test: the headless checks pass, plus a `--settings` step for the speed row if a screenshot can show it; in the projector, a new mission starts at the chosen speed, Fullscreen and Esc work and the game keeps running, and the launcher opens the chosen size.

### 9. Controls: a list of the mission keys, then rebindable keys (large)
Goal: "Controls list might even have customizable hotkeys instead, if possible."
- Problem: missions have about 10 keyboard shortcuts in a fixed `switch` (`Map.onKeyDown`, `Map.as:2254`, and `onKeyUp`, 2458; key codes 192 for the backtick, 81 Q, 70 F, 69 E, 82 R, 84 T, 71 G, 88 X, 67 C and more), plus our P for the FPS box (`src/StarlingPreloader.as`) and Esc to leave fullscreen (`PeacefreeGame.as:503-512`). Claude found nowhere the game shows them (from the code, not checked in play).
- Read first: those functions and what each key does (follow each `case`); `PeacefreeGame.onKeyDown`/`onKeyUp` (`PeacefreeGame.as:491-499`); `OptionsInterfacer` (the panel a Controls page opens from); the `settings` save (`SoundLibrary.saveVolumes`).
- Approach, in steps: A, a "Controls" button in the panel opening a page that lists each key and what it does (read-only). B, rebindable keys: each row's key is a button that waits for the next key press; the bindings go in the `settings` save; `Map.onKeyDown`/`onKeyUp` look keys up in the bindings instead of fixed codes (needs `Map.as` patched); a "Reset to defaults" button.
- Ask the user: build A first and decide B after seeing the list (suggested: yes); a key already in use (suggested: the two actions swap keys); P and Esc (suggested: not rebindable, only the mission keys).
- Test: the headless checks pass, plus a `--settings` step that opens the Controls page; in the projector, the list matches what the keys do, and (B) a rebound key works in a mission and after a restart.

### 10. Release prep for the Flash version (medium, report first)
Goal: "I want to make a flash version that has quality of life stuff (but not gameplay changes) that we can release, then make a refactored version where we can make all our changes."
- Problem: a public release needs choices the code doesn't make: what goes in, in what form, for which player, where. Split out of to-do 4 (2026-10-31).
- Read first: docs/decisions.md ("Private now, public later": Helgravis didn't answer requests about a re-release; the "Unlock All Acts", bombs and shared-save entries, each with something to decide before the public release); README.md (the repo has no .swf: "you need your own copy"); the player comparison in docs/research/performance.md; NOTES.md "Patched files" (each patched .swf holds the whole original).
- The report covers: what goes in (premium unlocked is needed, since it can't be bought; whether free bombs, "Unlock All Acts" and the shop's "Kreds" text count as gameplay changes, and what to do with each); the form (a full patched .swf, or a patcher fans run on their own copy of the original, and where they'd get that copy); the player (the Flash Player projector and whether we may link or bundle it, Ruffle, or an AIR build from to-do 4 later); permission (asking Helgravis again, and what changes if they say no); where (a GitHub release, Flashpoint Archive, others, and what each requires); the save names `game` and `save-N` under the root, which other local Flash games may share.
- No changes to the game: a report with a recommendation per choice; the user decides; the build work becomes new to-dos.
- Test: the user reads the report.

### 4. Refactor and modding assessment (medium, report only)
Goal: "Explain how hard it would be to add new levels, new enemy types, and new mechanics in this codebase, and whether making a level/content data format would be worthwhile. Briefly compare continuing to patch the .swf with rebuilding the game in HTML5." Narrowed on 2026-10-31 ("then make a refactored version where we can make all our changes"): its release part moved to to-do 10, and it comes after the Flash release.
- Compare: keep patching (ffdec `-replace`, existing classes only); compile the whole decompiled game as a project with the AIR SDK (maintained by Harman: new classes, and a Windows app without Flash Player, with window sizes through `NativeWindow`); rebuild it in HTML5 or another engine. For each: effort, risk, and how hard new levels, enemies and mechanics get; and whether a level/content data format is worthwhile.
- Read first: "How content is defined" in docs/research/game-code.md; the player comparison in docs/research/performance.md (projector about 60 fps, Ruffle app 40, Ruffle in the browser 15-20 with drawing errors); the release report (to-do 10).
- No changes to the game; a report only.
- Test: the user reads the report.

## Writing a to-do
- Title with size (small / medium / large) and the goal in the user's words.
- Problem / Goal: what is wrong or wanted, with an example. For a bug or research to-do, also what the user has seen (it exists, where, what works) and what is already ruled out.
- Read first: files and functions to look at, outside references.
- Approach: the suggested design, what to reuse.
- Ask the user: open questions, each with a suggested answer.
- Test: what Claude checks, and what the user tests by hand.

Each to-do starts as an entry in the list. When one grows past ~10 lines, move it into its own file, docs/todo/NN-name.md.
