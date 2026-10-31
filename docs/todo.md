# To do

Next number: 7

## To do

### 6. Settings on the title and act screens, volume sliders (medium)
Goal: "Settings should be accessible from the main page / act selection page. The volumes should also be a slider not just on/off."
- Problem: the only settings panel is the options menu inside a mission (`OptionsInterfacer`; it needs `pgame.map` for Difficulty, Exit Game and closing). Music and SFX are on/off only (`SoundLibrary.ENABLE_SFX`, `bEnabledBGM`; music plays at a fixed 0.35 through `SoundLibrary.BGM_VOLUME`); the title screen has just two on/off icons.
- Read first: `OptionsInterfacer.as` (our copy in `src/`, with "Unlock All Acts"), `SoundLibrary.as` (`playSFX`, `playBGM`, `BGM_VOLUME`), `TitleScreen.as` (`sfxButton`, `bgmButton`), the top bar in `CampaignSelectorScreen.as:139-160`, `PeacefreeGame.saveGameData` (what the save holds).
- Approach: a Settings button on both screens opening the same panel, with mission-only rows hidden outside a mission; a small slider class (bar plus draggable knob, Starling touch events; neither Starling 1.4.1 nor the game has one) for music and SFX volume; volumes saved with the other settings, through `FileLibrary` so all builds share them (to-do 5).
- Ask the user: slider steps (suggested: 0-100% in 10% steps, 0 = off); where the button goes (suggested: title screen next to the two sound icons, campaign screen in the top bar next to Tech/Load/Back); keep the old on/off icons (suggested: yes, they mute/unmute); save the volumes in the game's own save or a separate one (suggested: separate key, so `PeacefreeGame` needn't be patched).
- Test: both headless checks pass; in the projector, the panel opens from the title, act and mission screens, the sliders change the volume while you listen, and the volumes are still set after a restart.

### 4. Modding assessment (medium, report only)
Goal: "Explain how hard it would be to add new levels, new enemy types, and new mechanics in this codebase, and whether making a level/content data format would be worthwhile. Briefly compare continuing to patch the .swf with rebuilding the game in HTML5."
- Also: what a public release for fans needs: what goes in it, where fans would get it (for example a GitHub release or Flashpoint Archive), and which player they'd use. Read first: "How content is defined" in docs/research/game-code.md, and the player comparison in docs/research/performance.md (projector about 60 fps, Ruffle app 40, Ruffle in the browser 15-20 with drawing errors).
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
