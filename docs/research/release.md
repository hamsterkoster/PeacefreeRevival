# Release of the Flash version

To-do 10's report: what goes into a public release of the patched Flash version, in what form, for which player, with what permission, where, and under which save names. One recommendation per choice; the user decides, and the build work becomes new to-dos. Written 2026-10-31.

Sources: the repo (marked measured, or "from the code"), web pages (listed at the end; secondhand ones are marked), and the user's answers on 2026-10-31: they asked Helgravis on the game's Kongregate page years ago and got no answer; browser play is wanted if possible, otherwise a download is fine; copies of the original .swf are free to download on many sites, so publishing is fine, and the user takes it down if Helgravis asks.

## Summary

| Choice | Recommendation |
|---|---|
| What goes in | Everything in v19. Keep the free bombs and "Unlock All Acts". Change the shop's "10 Kreds" texts to say the bombs are free. |
| Form | The full patched .swf. A patch file only if Helgravis allows patches but not hosting. |
| Player | Link to the Flash Player projector, don't bundle it; the Ruffle app as the second choice. Browser: test Ruffle's WebGPU renderer first. |
| Permission | One email to the address on the developer's own site before the release. No answer in about 4 weeks: release as an unofficial fan patch, taken down on request. A "no": no release. |
| Where | A GitHub release in this repo (plus a GitHub Pages page if the browser test passes). Ask Flashpoint's curators afterwards. Not itch.io, Newgrounds or Kongregate. |
| Save names | Prefix them (`peacefree-game` and so on), with a one-time read of the old names so existing progress carries over. |

## 1. What goes in
v19 holds: the offline Kongregate stand-in (premium owned, bombs counted locally, no network calls), the P key's FPS box, one shared save, the Settings button with volume sliders and Start Speed, music pause and Next, the window fit and Fullscreen button, the Controls page, and "Unlock All Acts". Each is listed in NOTES.md "Patched files".

- **Premium unlocked:** needed, since it can no longer be bought. It unlocks what a paying player had ([premium.md](premium.md)).
- **Free bombs** (10 Shock and 10 Nox at each game start, counted down, 10 more free in the shop): not a gameplay change, in my view. In the original, any player could buy as many as they wanted (10 Kreds for 10); the release removes the price, not a rule. The cooldown and the counter stay. The other options are worse: 0 at start sends every player to the shop each game; unlimited was already rejected (docs/decisions.md, bombs entry).
- **The shop's "Kreds" texts** (from the code): 4 texts in `ShopInterfacer.as` ("Buy 10 for 10 Kreds" on both bombs, and both confirm popups, "...for 10 Kreds?"). They promise a price that isn't charged. Suggested: "Get 10 free" and "Get 10 Nox Bombs for free?". That's one more patched class and 4 lines. The 2 texts in `PremiumInterfacer.as` don't need changing: with premium owned, that screen only opens through the `show_premium` flashvar, which the projector doesn't pass (`CampaignSelectorScreen.as:128-137`, `PeacefreeGame.as:654`).
- **"Unlock All Acts":** it skips progress but changes no rule, and the player has to choose it and confirm it. It helps returning fans most: no one's old progress can carry over (saves made on kongregate.com stay there, and local saves are tied to the file's path; [game-code.md](game-code.md) "Save data"), so without it, everyone starts at the long tutorial again. Recommended: keep it as it is; the README says it can't be undone. Removing it is a one-class change if the user prefers a pure release.
- **Optional, small:** a release version on the title screen next to the game's "Ver.1.08" (for example "Revival 1.0"), so bug reports name the build. `TitleScreen.as` is already patched.
- **Kept as they are:** the title's Facebook and Twitter buttons (the developer's pages; they give two achievements).

## 2. Form
Measured on the original and v19: only the two code tags differ (166 KB and 414 KB of the 7.46 MB uncompressed file). All 47 other tags, the art and sound included, are byte-identical. A binary delta of the two code tags is about 105 KB (git's delta format), against 6.5 MB for the whole .swf.

- **A. The full patched .swf** (6.5 MB): one file, nothing to install but a player. It holds all of Helgravis's game: art, sound and code.
- **B. A patch file plus a patcher:** about 105 KB, with none of the art or sound, and only our changed classes. Its drawbacks:
  - Fans need the exact original (SHA-256 in NOTES.md). Ours came from the game's Kongregate page; other sites may have other builds. Flashpoint's copy is a different build (`peacefreegbit.swf`, the developer's own Gloebit version), so the patch wouldn't apply to it.
  - Fans don't have Python, so the patcher would be new work: an .exe or a web page in JavaScript.
  - If Kongregate stops serving the file, nobody can patch any more.
- Recommended: A, given the user's position on hosting. B is the fallback if Helgravis allows patches but not hosting.

## 3. Player, and the browser
Measured in to-do 2 (FPS from the stats box, [performance.md](performance.md)): projector about 60 fps; Ruffle app about 40; Ruffle in the browser 15-20. Ruffle also drew some graphics wrong.

- **Flash Player projector 32:** the best player, and the one the project tests in. Bundling it isn't allowed. Adobe's terms let a projector be copied only for internal use, and redistributing Flash Player needs a distribution license. Adobe stopped offering it; forum replies from Adobe staff say new licenses are unlikely (secondhand), and Harman sells licensed versions. Linking is the usual way: the README links to the Wayback Machine's copy of Adobe's own download (the file in docs/local.md, signed by Adobe), with its SHA-256. Flashpoint does ship projectors (its FAQ); how it's licensed wasn't found.
- **Ruffle app:** we may bundle it or link to it (MIT or Apache-2.0), and it runs on Windows, macOS and Linux. It's slower, with some drawing errors. It's the second choice in the README.
- **Browser (Ruffle's web version):** too slow as measured. Ruffle's own blog says Stage3D games run well only in its desktop app (2023). One untested chance: the renderer order in Ruffle's code is `wgpu-webgl`, then `webgpu` (from the strings in `tools/ruffle/web/`'s .wasm). So our browser test most likely ran on WebGL, and WebGPU (in Chrome and Edge on Windows) was never tried. It can be forced with the `preferredRenderer: "webgpu"` setting.
  - Suggested: a small to-do that adds a renderer option to `scripts/play.py`, then you read the FPS box in your browser. If it's close to 60 fps and draws right, a GitHub Pages page with Ruffle is a small to-do. If not, the release is a download only, and browser play waits for the refactor (to-do 4 compares an HTML5 rebuild).
- **An AIR build** (a Windows app without Flash Player) is part of to-do 4, not this release.

## 4. Permission
- **The rights holder:** the developer's site names Adventure Cat, LLC ("'Peacefree' is a game created by Adventure Cat, LLC. All rights reserved.", © 2014). Helgravis is the Kongregate account. README's Credits should name both.
- **Ways to reach them** (checked 2026-10-31):
  - Kongregate: the account's latest activity is from September 2017, so a message there is unlikely to be read. That fits the user's unanswered question.
  - The developer's site (peacefree.adventurecat.us) is still up. Its contact page lists an email address, the only direct way found.
  - The game's title screen links to Adventure Cat's Twitter and Facebook pages; I didn't check whether they're still active.
- Recommended: one short email before the release, saying what the project is (free, unofficial, quality-of-life only, no money involved), what changed, and that it comes down on request. Ask for permission, or at least no objection. Claude can draft it.
  - **No answer in about 4 weeks:** release as an unofficial fan patch, with a takedown-on-request note in the README (the user's position).
  - **"Yes":** credit them and say so in the README.
  - **"No":** no release, and the repo stays private; drop `decompiled/` and `src/` before ever making it public.
- **The repo going public** publishes the game's decompiled code (225 scripts and 16 map files are tracked, about 1.9 MB measured). The user is fine with that, so this is only the cost if a complaint comes:
  - GitHub forwards a takedown notice and gives about 1 business day to remove what it names, or it disables the repository.
  - If the notice says the whole repository infringes, GitHub disables it straight away.
  - Notices are published.
  - The local clone keeps our work either way.

## 5. Where
- **GitHub release in this repo** (when it's public): free, versioned, and next to the code and docs that explain it. A takedown works as in section 4. Recommended as the home.
- **GitHub Pages:** only for the browser version, if the WebGPU test passes.
- **Flashpoint Archive:** it already has the game: "Peacefree Tactical Warfare" by Adventure Cat, status Playable, added 2018. That entry is the Gloebit build from the developer's site, so premium is presumably locked there (not tested). Its rules have no category for fan patches:
  - "Hacked" means changed so the game works in Flashpoint, and it needs the original file too.
  - Alternate versions go under "Additional Applications".
  - Its not-accepted list says nothing about Peacefree or fan patches.

  Recommended: after the GitHub release, ask in Flashpoint's curator channel whether they'd add it as an alternate version. Flashpoint ships the player, and it's where Flash fans look.
- **Internet Archive:** it plays a .swf in the browser with Ruffle (an item's `emulator` field set to `ruffle-swf`). It has the same speed problem as the browser version, so it's only a mirror, and only if the WebGPU test passes.
- **Not recommended:**
  - itch.io: its terms say uploaders must hold the rights, though that's enforced only when someone complains (secondhand).
  - Newgrounds: the uploader must be the game's creator (secondhand; the rules page refused the request).
  - Kongregate: only the developer can update the game's page. Kongregate now plays many Flash games with Ruffle; whether Peacefree runs there wasn't tested.
- **Announcing:** the game's Kongregate page still gets comments (one from 2025, about playing offline in Ruffle), so a comment there with the link reaches fans.

## 6. Save names
- From the code: the game and our patches use three names, all under `"/"`: `game`, `save-N`, and our `settings` (`FileLibrary.saveData("settings", ...)` in `src/game/library/SoundLibrary.as`). Every save passes through `FileLibrary.loadSharedData`.
- **Where they collide:**
  - In the projector, every local .swf with the same name under `"/"` shares the file ([game-code.md](game-code.md) "Save data").
  - In a browser, every .swf on the same site shares it. On a shared host such as archive.org, that means other Flash games. On GitHub Pages, it means only this organization's pages.
  - `settings` and `game` are generic names. How many Flash games use them under `"/"` is unknown; probably few, an estimate.
- **Cost of renaming:** fans start fresh anyway, since their old saves can't be read (section 1), so new names cost them nothing. Only existing progress (the user's, and any testers') has to carry over.
- Recommended: before the release, `FileLibrary` adds a `peacefree-` prefix to every name. When a prefixed save is still empty, it reads the old name once and saves it under the new one. That's about 10 lines in a class that's already patched, and `check.py --shared-save` needs the new name. It revisits the shared-save decision of 2026-10-31, which expected this ("unique names can come later").

## Suggested to-dos and order
1. **The email to the developer** (the user sends it; Claude drafts it). It goes first, so the 4 weeks run while the rest is built.
2. **Release patches** (small): the shop's free-bomb texts; the save-name prefix with the one-time read of the old names; optionally the release version on the title. One build, all checks.
3. **Browser test** (small): a renderer option in `play.py`; you measure WebGPU in your browser. If it passes, a GitHub Pages page with Ruffle becomes a to-do.
4. **Release package** (small): a release file name, such as `Peacefree-Revival-1.0.swf`; a README "Play" section for fans (download, get the projector, open the file); release notes. Then the "Before a public release" list in docs/todo.md.
5. **Later:** ask Flashpoint's curators.

## Sources
- Flashpoint database entry 2ff5159c-747f-08e0-b404-2c03ac68064d: https://db-api.unstable.life/search?id=2ff5159c-747f-08e0-b404-2c03ac68064d&filter=false
- Flashpoint curation format, "Hacked" and Additional Applications: https://flashpointarchive.org/datahub/Curation_Format/meta
- Flashpoint not-accepted list: https://flashpointarchive.org/datahub/Not_Accepted_Games
- Flashpoint FAQ (bundled projectors; secondhand, from a search summary): https://flashpointarchive.org/faq
- Adobe, Flash Player usage terms: https://www.adobe.com/products/eula/tools/flashplayer_usage.html
- Adobe, Flash Player distribution: https://www.adobe.com/products/flashplayer/distribution.html
- Ruffle progress report, 2023-05-29 (Stage3D only well in the desktop app): https://ruffle.rs/blog/2023/05/29/progress-report
- Kongregate, Helgravis's profile (latest activity Sep 29, 2017): https://www.kongregate.com/en/accounts/Helgravis
- Kongregate, the game's page (released July 14, 2014; last updated August 14, 2014; comments): https://www.kongregate.com/en/games/helgravis/peacefree-tactical-warfare
- Kongregate on Ruffle: https://kongregatesupport.zendesk.com/hc/en-us/articles/26730357791501-Ruffle-Flash-Player-What-is-it-why-we-support-it-and-how-you-can-help-too
- The developer's site and contact page: http://www.peacefree.adventurecat.us/ and http://www.peacefree.adventurecat.us/contact
- GitHub DMCA takedown policy: https://docs.github.com/en/site-policy/content-removal-policies/dmca-takedown-policy
- Internet Archive, Flash with Ruffle: https://blog.archive.org/2020/11/19/flash-animations-live-forever-at-the-internet-archive/
- itch.io's rights rule (secondhand, from a search summary of its terms and forum): https://itch.io/docs/legal/terms
- Newgrounds' "creator and owner" rule (secondhand, quoted in a devlog): https://poizonstudios.itch.io/toaster-launchers-2d/devlog/945738/hehefunihax
