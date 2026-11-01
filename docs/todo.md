# To do

Next number: 15

## To do

The order follows the roadmap in docs/decisions.md (2026-10-31): quality of life in the Flash version (7-9, done), its release (to-do 10's report, [research/release.md](research/release.md), and the six release decisions of 2026-10-31; built in 11-14, 11-13 done), then the refactor (4) and modding.

### 14. Release package and publishing (medium)
In its own file with its Progress list: [todo/14-release.md](todo/14-release.md) (three steps: A the package and docs, B the "Before a public release" list below, C publishing and announcing).

### 4. Refactor and modding assessment (medium, report only)
Goal: "Explain how hard it would be to add new levels, new enemy types, and new mechanics in this codebase, and whether making a level/content data format would be worthwhile. Briefly compare continuing to patch the .swf with rebuilding the game in HTML5." Narrowed on 2026-10-31 ("then make a refactored version where we can make all our changes"): its release part moved to to-do 10, and it comes after the Flash release.
- Compare: keep patching (ffdec `-replace`, existing classes only); compile the whole decompiled game as a project with the AIR SDK (maintained by Harman: new classes, and a Windows app without Flash Player, with window sizes through `NativeWindow`); rebuild it in HTML5 or another engine. For each: effort, risk, and how hard new levels, enemies and mechanics get; and whether a level/content data format is worthwhile. Also where the refactor lives (asked by the user in to-do 14): a rebuild fits a new repo, with this one staying the Flash version's home and its releases; a project compiled from the decompiled code could grow here.
- Read first: "How content is defined" in docs/research/game-code.md; the player comparison in docs/research/performance.md (projector about 60 fps, Ruffle app 40, Ruffle in the browser 15-20 with drawing errors, and its WebGPU renderer freezes the tab, to-do 13); the release report ([research/release.md](research/release.md), to-do 10).
- No changes to the game; a report only.
- Test: the user reads the report.

## Later, only if the user asks
- Gameplay changes, new levels, enemies and mechanics, and modding: in the refactored version (to-do 4), not the Flash version.
- Rebindable keys (to-do 9's dropped step B): in the refactored version, with the key names in on-screen texts taken from the bindings. Each row of the Controls page's key a button that waits for the next key press; bindings in the `settings` save; a key already in use swaps with the other action; P, Esc and 1-9 stay fixed; "Reset to defaults". Why not in the Flash version: docs/decisions.md (2026-10-31); the texts that name keys: "Keys" in docs/research/game-code.md.

## Before a public release
- Pick a license (LICENSE file; ask the user, with a suggestion). It can only cover our own work (`scripts/`, the docs); the game's code in `decompiled/` and `src/` stays Helgravis's.
- Search all tracked files for the "Never in tracked files" list in CLAUDE.md. If old commits hold any of it, publish a new repo with one clean commit instead of rewriting history.
- Before switching the repo to public, the user removes the commit email from the personal push account (github.com, Settings → Emails). Until then GitHub shows every commit as made by that account (measured 2026-10-31). Check: `gh api repos/hamsterkoster/PeacefreeRevival/commits/main --jq .author.login` no longer prints the login from docs/local.md. The organization's member list is already private (measured 2026-10-31).
- A fresh subagent that hasn't seen the project checks README.md and the docs it links against the code, and only reports; the user decides the fixes.
- A screenshot of the game in the README.
- Start CHANGELOG.md (Keep a Changelog: Unreleased first, then versions newest first) with the first version.

## Writing a to-do
- Title with size (small / medium / large) and the goal in the user's words.
- Problem / Goal: what is wrong or wanted, with an example. For a bug or research to-do, also what the user has seen (it exists, where, what works) and what is already ruled out.
- Read first: files and functions to look at, outside references.
- Approach: the suggested design, what to reuse.
- Ask the user: open questions, each with a suggested answer.
- Test: what Claude checks, and what the user tests by hand.

Each to-do starts as an entry in the list. When one grows past ~10 lines, offer to move it into its own file, docs/todo/NN-name.md.
