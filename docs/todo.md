# To do

Next number: 15

## To do

The order follows the roadmap in docs/decisions.md (2026-10-31): quality of life in the Flash version (7-9, done), its release (to-do 10's report, [research/release.md](research/release.md), and the six release decisions of 2026-10-31; built in 11-14, 11 and 12 done), then the refactor (4) and modding.

### 13. Browser test with Ruffle's WebGPU renderer (small)
Goal: "any way to have this be playable in the browser, if not download option is fine" (to-do 10's questions).
- Problem: Ruffle in the browser ran the game at 15-20 fps and drew some graphics wrong (to-do 2), most likely on its WebGL renderer: Ruffle's web .wasm tries `wgpu-webgl` before `webgpu`. WebGPU (in Chrome and Edge on Windows) was never tried.
- Read first: "Player comparison" in docs/research/performance.md; docs/research/release.md section 3; `scripts/play.py`; `scripts/ruffle_page.py:29` (the Ruffle config).
- Approach: a `--renderer` option in `play.py` (`webgpu` or `wgpu-webgl`), passed as Ruffle's `preferredRenderer`. The user plays to-do 2's scenes (the title, about 30 s into Act 1) with each renderer and reads the FPS box. Ruffle's log in the browser console shows which renderer it used.
- Ask the user: which browser (suggested: your default, plus Edge if the default isn't based on Chromium).
- Test: lint passes; the user's FPS readings and whether the graphics draw right. Close to 60 fps with correct drawing: a new to-do for a GitHub Pages page with Ruffle. Otherwise browser play waits for the refactor; the result goes into docs/research/performance.md.

### 14. Release package and publishing (medium)
Goal: "a flash version that has quality of life stuff (but not gameplay changes) that we can release" (the roadmap), as the release decisions of 2026-10-31 describe it.
- Problem: everything for the first public release besides game code: the downloads, a README for fans, credits, release notes, the "Before a public release" list below, the GitHub release, then Flashpoint and Kongregate.
- Read first: docs/decisions.md (2026-10-31: form, players, permission and credits, where); docs/research/release.md; "Before a public release" below; README.md; docs/local.md (the projector's Wayback Machine link and SHA-256).
- Approach:
  - Release files: `Peacefree-Revival-1.0.swf`, plus the AIR app (to-do 12) as an installer and a zip, such as `Peacefree-Revival-1.0-Windows-Setup.exe` and `Peacefree-Revival-1.0-Windows.zip`. `scripts/release_air.py` makes both, named after the app folder (to-do 12, step B), so they're renamed or copied for the release.
  - A one-line privacy statement (the game collects nothing and makes no network calls): the AIR license asks for one, linked in the app (docs/research/release.md, "The AIR SDK's current terms").
  - README: a "Play" section at the top for fans (the AIR app, the projector link with its SHA-256, the Ruffle app); the note "unofficial fan patch; taken down if the developer asks"; Credits naming Adventure Cat, LLC and Helgravis, and Audionautix for the music (the game's own Credits screen names them; docs/research/release.md section 4).
  - Release notes from CHANGELOG.md, and a readme in the AIR zip and installer.
  - Then the "Before a public release" list. The user makes the repo public and confirms the GitHub release.
  - Afterwards, Claude drafts and the user posts: the question to Flashpoint's curators and the comment on the game's Kongregate page.
- Likely three steps (A the package and docs, B the checklist, C publishing and announcing), so it gets its own file, docs/todo/14-release.md, when its build starts.
- Ask the user: the version number (suggested: 1.0); the license for our own work (in the list below).
- Test: the user reads the README as a fan would, and runs each download with a fresh save; the list's checks pass; the release page shows both downloads.

### 4. Refactor and modding assessment (medium, report only)
Goal: "Explain how hard it would be to add new levels, new enemy types, and new mechanics in this codebase, and whether making a level/content data format would be worthwhile. Briefly compare continuing to patch the .swf with rebuilding the game in HTML5." Narrowed on 2026-10-31 ("then make a refactored version where we can make all our changes"): its release part moved to to-do 10, and it comes after the Flash release.
- Compare: keep patching (ffdec `-replace`, existing classes only); compile the whole decompiled game as a project with the AIR SDK (maintained by Harman: new classes, and a Windows app without Flash Player, with window sizes through `NativeWindow`); rebuild it in HTML5 or another engine. For each: effort, risk, and how hard new levels, enemies and mechanics get; and whether a level/content data format is worthwhile.
- Read first: "How content is defined" in docs/research/game-code.md; the player comparison in docs/research/performance.md (projector about 60 fps, Ruffle app 40, Ruffle in the browser 15-20 with drawing errors); the release report ([research/release.md](research/release.md), to-do 10).
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
