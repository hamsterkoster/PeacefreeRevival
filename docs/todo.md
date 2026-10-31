# To do

Next number: 7

## To do

### 6. Settings on the title and act screens, volume sliders (medium)
Goal: "Settings should be accessible from the main page / act selection page. The volumes should also be a slider not just on/off."
- In two steps; the to-do, the user's answers and its Progress list: [todo/06-settings.md](todo/06-settings.md).

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
