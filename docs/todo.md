# To do

Next number: 5

## To do

### 2. Performance (large)
Goal: "Make it run smoothly (it currently lags badly)."
- Seen so far: it lags badly, played in Ruffle (the user believes).
- First, the cheapest test: run the unchanged original in the Flash Player projector, the Ruffle desktop app and the latest Ruffle in the browser. If the projector is smooth, the lag is the player, not the game.
- Then look in the code for: Kongregate/other server calls that now fail or time out, retry loops, expensive work every frame. Patch dead network/API calls to return at once with sensible fake results.
- Rebuild into `patched/` (versioned name) and confirm it recompiles cleanly. Launch commands for the projector and Ruffle go in docs/local.md.
- Headless Playwright + Ruffle screenshot past the loading screen; this becomes the slow check in CLAUDE.md.
- Ask the user: where do you play it now (kongregate.com, a Ruffle browser extension, the Ruffle app)? Suggested: kongregate.com in the browser.
- Test: the user plays the patched file in each player and compares the lag with the original.

### 3. Premium unlock (medium)
Goal: "Find where the game decides whether premium features/items are owned, and make it always report them as owned. Make the change as small and targeted as possible."
- Read first: the premium/purchase findings from to-do 1 in NOTES.md.
- Rebuild into `patched/` as a new versioned file; log it in NOTES.md.
- Test: a checklist of what to look for in the game to confirm each premium feature works.

### 4. Modding assessment (medium, report only)
Goal: "Explain how hard it would be to add new levels, new enemy types, and new mechanics in this codebase, and whether making a level/content data format would be worthwhile. Briefly compare continuing to patch the .swf with rebuilding the game in HTML5."
- Also: what a public release for fans needs: what goes in it, where fans would get it (for example a GitHub release or Flashpoint Archive), and which player they'd use.
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
