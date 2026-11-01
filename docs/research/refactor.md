# Refactor and modding assessment (to-do 4)

A report, not a change. It answers: how hard is it to add new levels, enemy types
and mechanics in this codebase; is a level/content data format worthwhile; and
should we keep patching the .swf, compile the decompiled game with the AIR SDK, or
rebuild it in HTML5. It also answers the user's question of where the refactor lives
(a new repo for an HTML rebuild?).

Sources: the decompiled code (`decompiled/PeacefreeKong/scripts/`, to-do 1), the code
map and content format in [game-code.md](game-code.md), the player comparison in
[performance.md](performance.md), and light web research (2026-11-01). Numbers marked
(measured) were counted from the code; effort in weeks is an **estimate** (the project
has no comparable past work to measure against), so treat it as a rough order of size,
not a quote.

## The goal this has to serve

From CLAUDE.md: the refactored version is where gameplay changes and **modding** live
(new levels, enemies, mechanics), and it's what **browser play** waits for (to-do 13
deferred the browser to the refactor: Ruffle in a page runs the Flash build at ~15 fps
with drawing errors). So the refactor has two hard requirements the Flash release
doesn't: (1) you can add new code, not just swap existing classes, and (2) it runs well
in a browser. Keep those in view — they rule out two of the three paths.

## How big the job is (measured)

- Our game code: **121 classes, ~32,000 lines of ActionScript 3** (`game/`, excluding
  Starling). The code is **not obfuscated** (readable names, to-do 1) — a large help
  for any port.
- Starling: **62 classes, ~12,900 lines** (`starling/`, third-party). In a rebuild this
  layer is *replaced* by a JS/Haxe rendering library, not ported line-for-line.
- The biggest classes carry most of the logic: `Map.as` 2,634, `Building.as` 1,930,
  `Act1.as` 1,908, `Mob.as` 1,501, `PeacefreeGame.as` 1,149, `MapHUD.as` 1,142,
  `Tile.as` 1,005 (measured).

## The three paths

| Path | Add new classes? | Runs in browser? | Effort (estimate) | Verdict |
|------|------------------|------------------|-------------------|---------|
| 1. Keep patching (ffdec `-replace`) | No — swap whole existing classes only | No (Flash/Ruffle only) | ~0 (current tooling) | Dead end for modding |
| 2. Compile decompiled code as an AIR SDK project | Yes | No (AIR is desktop/mobile) | ~1–3 weeks to a clean build | Unblocks modding, wrong platform |
| 3. Rebuild in HTML5 | Yes | Yes | see below | The only path meeting both goals |

**Path 1 — keep patching.** We already hit its wall: ffdec `-replace` can only
recompile classes that already exist, so new UI like the volume slider had to be
squeezed inside `OptionsInterfacer` ([game-code.md](game-code.md)), and new mechanics or
enemy classes are impossible. It also stays on Flash, so browser play stays at ~15 fps.
Fine for tiny further tweaks to the Flash release; useless as a base for modding.

**Path 2 — AIR SDK project.** Compile the whole decompiled tree as a Harman AIR project.
This *does* lift the "existing classes only" limit — you can add classes and mechanics —
and the decompilation is clean (`decompile.py` ends with "All scripts decompiled without
errors"), so it should build with modest fixing. But:
- It's still the **AIR runtime**: desktop and mobile, **not the web**. It fails
  requirement (2) outright — no browser play, which was a stated reason for the refactor.
- It keeps the game in **AS3**, a sunset language: Harman maintains AIR commercially (we
  use the free tier), tooling and community are shrinking, and modders would have to
  learn AS3.
- So it gets you a maintainable project but on a platform you'd want to leave anyway.
  It's a half-step that costs real work and doesn't reach the destination.

**Path 3 — rebuild in HTML5.** This is the only path that gives both new code and the
browser. Research turned up two genuinely different flavours:

- **3a. Transpile route (OpenFL + Haxe + Starling-Haxe).** The maintained Starling now
  targets HTML5 through OpenFL/Haxe (and TypeScript/JS), and `as3hx` auto-converts AS3 to
  Haxe. So the path is: AS3 → Haxe (automated, then cleanup) running on the Haxe port of
  **the same Starling API the game already uses**. This reuses the ~32k lines of logic
  and the scene-graph structure rather than reinventing them. Haxe is a real, current
  language, so modding is open. **Estimate: ~4–8 weeks** — dominated by cleanup of the
  auto-converted code and filling Starling/OpenFL API gaps, not by rewriting. Risk:
  as3hx leaves manual fixes; the Starling-Haxe port may lag the 1.4.1 behaviour we rely
  on (e.g. `handleLostContext`, viewport/`nativeOverlay` handling — see
  [game-code.md](game-code.md)); the particle extension and the bitmap font need Haxe
  equivalents.
- **3b. Full rewrite (Phaser or Pixi, TypeScript).** Reimplement the game from scratch in
  a modern JS engine. The cleanest, most moddable, most future-proof base — and the one
  most migration guides recommend over line-by-line porting — but you reimplement all
  ~32k lines of logic. **Estimate: ~3–6 months.** The decompiled AS3 stays as a precise
  spec to copy behaviour from, which de-risks it, but it's a large project.

## Is a level/content data format worthwhile?

Depends on the path, and it's exactly where modding is won or lost (see
[game-code.md](game-code.md) "How content is defined"):

- **Levels are already data** — each act's 25×25 tile map is an embedded text file
  (`exmissionN_txt`). Extending that format (more fields, or moving to JSON) is cheap and
  clearly worth it: new levels are the easiest mod to support.
- **Enemies and buildings are code-only** — ~25 mob types and the building types are
  `switch` statements in `Mob.as` / `Building.as`, and each act's start point,
  objectives, story and scripted events are hand-written code in the act class. A data
  format for the **numbers** (stats, cost, spawn interval, which tile) is worthwhile and
  not hard; the **behaviour/AI** stays code with named hooks a mod can point at. Fully
  data-driven behaviour (scripting language, event system) is a much larger design job —
  worth it only if modding is the headline feature.

Verdict: a content data format is **worthwhile, but only inside Path 3** — it's the point
of the refactor. In Paths 1 and 2 it's wasted effort (hard to load external data, and
you'd throw it away on the move to HTML anyway).

## Where the refactor lives (the repo question)

**An HTML rebuild (Path 3, either flavour) should be a new repo.** It's a different
language (Haxe or TypeScript vs AS3), a different toolchain (no ffdec, no AIR SDK, no
`build.py`/`package_air.py`), and a different build output. This repo's identity is "the
Flash revival and its releases" — it stays the home of the Flash version, the v1.0
release, and any small Flash patches. The decompiled AS3 stays valuable as the behaviour
spec, but it's *referenced or copied*, not cohabited; mixing a Flash tree (with its
gitignore rules for `original/`, `patched/`, `tools/`) and a web project in one repo
helps no one.

The one path that could grow *in this repo* is Path 2 (AIR project), since it's the same
AS3 codebase — but Path 2 isn't recommended, so in practice: **new repo.** This matches
the parked decision of 2026-10-31 ("where the refactor lives depends on how to-do 4
refactors").

## Decision (2026-11-01)

The user chose **Path 3, flavour 3b — a clean rewrite in a modern JS engine
(Phaser/Pixi, TypeScript), in a new repo** — over the transpile route this report first
recommended. Reason: willing to spend more effort now for a better, more moddable base
later. The assessment below is kept as written; the transpile route (3a) stays recorded
as the cheaper fallback if the rewrite stalls.

## Recommendation (as assessed; superseded by the decision above)

**Rebuild in HTML5 (Path 3), in a new repo, starting with the transpile route (3a:
OpenFL + Haxe + Starling-Haxe).** Reasons:

1. Only Path 3 meets both stated goals — adding new code *and* browser play. Paths 1 and
   2 each fail one.
2. Within Path 3, the transpile route reuses the ~32k lines of readable AS3 and the
   Starling scene graph the game is built on, so it's the cheapest way to a working
   browser build (~4–8 weeks estimate vs ~3–6 months for a from-scratch rewrite), while
   still landing on a current language that's open to modders.
3. Then build modding on top: extend the level text format (or move it to JSON), and add
   a data format for enemy/building **numbers** with behaviour hooks in code.

Honest caveats:
- The transpile route is a bet on the Starling-Haxe port matching the 1.4.1 behaviour we
  depend on. If that fights back hard, the fallback is the Phaser/Pixi rewrite (3b) —
  cleaner but months more work. It's worth a short **spike first**: run `as3hx` on a few
  classes and try to get `Map`/`Tile` rendering under Starling-Haxe before committing.
  (That spike would be the first step of the refactor to-do, not part of this report.)
- All the week/month figures are estimates, not measured. The spike is what turns them
  into real numbers.
- If modding turns out to matter more than reaching the browser quickly, 3b (the clean
  rewrite) becomes the better long-term base despite the cost — a judgement call for when
  the refactor to-do is written.

## Dead ends and rejected options (for a later chat)

- **Path 1 (keep patching)** rejected as a refactor base: can't add classes (already hit),
  no browser.
- **Path 2 (AIR project)** rejected: unblocks modding but stays off the web and on AS3, a
  sunset platform — a half-step.
- **Line-by-line manual port**: not recommended by migration guides; `as3hx` automates the
  first pass, so a manual port buys nothing.
- **Starling.js** (a 2013 JS port of Starling): found no release activity since 2013; the
  maintained HTML5 path is Starling via OpenFL/Haxe, not Starling.js.

Sources (web, 2026-11-01): the OpenFL forum's "Flash game to HTML5" procedure and the
as3hx→Haxe→OpenFL route; the AS32JS converter (built to move a Starling/AIR game to
Phaser); a Flash→HTML5 migration guide (advises rewrite over line-by-line, points to
Phaser); Starling's OpenFL README (HTML5 via TypeScript/Haxe/JS).
