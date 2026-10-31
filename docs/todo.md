# To do

Next number: 11

## To do

The order follows the roadmap in docs/decisions.md (2026-10-31): quality of life in the Flash version (7-9, done), its release (10), then the refactor (4) and modding.

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
