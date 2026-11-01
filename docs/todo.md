# To do

Next number: 15

## To do

The order follows the roadmap in docs/decisions.md (2026-10-31): quality of life in the Flash version (7-9, done), its release (to-do 10's report, [research/release.md](research/release.md), and the six release decisions of 2026-10-31; built in 11-14, all done: release 1.0 was published on 2026-11-01), then the refactor (to-do 4 assessed it, done) and modding. The refactor is a clean HTML5 rewrite in a new repo (docs/decisions.md and [research/refactor.md](research/refactor.md), 2026-11-01); the "Later" items below live there.

(No open to-dos in this repo: the Flash revival and its v1.0 release are done. The next work is the HTML5 rewrite, which starts in its own new repo.)

## Later, only if the user asks
These belong to the HTML5 rewrite (a new repo; docs/decisions.md 2026-11-01), not the Flash version:
- Gameplay changes, new levels, enemies and mechanics, and modding. A content data format is worthwhile here: extend the level text format (or move it to JSON) and give enemy/building numbers a data format with behaviour hooks in code ([research/refactor.md](research/refactor.md)).
- Rebindable keys (to-do 9's dropped step B), with the key names in on-screen texts taken from the bindings. Each row of the Controls page's key a button that waits for the next key press; bindings in the `settings` save; a key already in use swaps with the other action; P, Esc and 1-9 stay fixed; "Reset to defaults". Why not in the Flash version: docs/decisions.md (2026-10-31); the texts that name keys: "Keys" in docs/research/game-code.md.

## Writing a to-do
- Title with size (small / medium / large) and the goal in the user's words.
- Problem / Goal: what is wrong or wanted, with an example. For a bug or research to-do, also what the user has seen (it exists, where, what works) and what is already ruled out.
- Read first: files and functions to look at, outside references.
- Approach: the suggested design, what to reuse.
- Ask the user: open questions, each with a suggested answer.
- Test: what Claude checks, and what the user tests by hand.

Each to-do starts as an entry in the list. When one grows past ~10 lines, offer to move it into its own file, docs/todo/NN-name.md.
