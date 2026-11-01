# Release of the Flash version

To-do 10's report: what goes into a public release of the patched Flash version, in what form, for which player, with what permission, where, and under which save names. One recommendation per choice; the user decides, and the build work becomes new to-dos. Written 2026-10-31.

Sources: the repo (marked measured, or "from the code"), web pages (listed at the end; secondhand ones are marked), and the user's answers on 2026-10-31: they asked Helgravis on the game's Kongregate page years ago and got no answer; browser play is wanted if possible, otherwise a download is fine; copies of the original .swf are free to download on many sites, so publishing is fine, and the user takes it down if Helgravis asks.

## Summary

| Choice | Recommendation |
|---|---|
| What goes in | Everything in v19. Keep the free bombs and "Unlock All Acts". Change the shop's "10 Kreds" texts to say the bombs are free. **Decided 2026-10-31:** as recommended, with the release version on the title. Built in to-do 11 (v21). |
| Form | The full patched .swf. A patch file only if Helgravis allows patches but not hosting. **Decided 2026-10-31:** the patched .swf for any player, plus a Windows AIR app with the game packaged in, if a test build runs well (section 2). |
| Player | Link to the Flash Player projector, don't bundle it; the Ruffle app as the second choice. Browser: test Ruffle's WebGPU renderer first. **Decided 2026-10-31:** the README lists the AIR app (if its test works), then the projector (linked to the Wayback Machine's copy of Adobe's download, with its SHA-256), then the Ruffle app; the WebGPU test comes before any browser version. **Tested 2026-10-31 (to-do 13):** WebGPU freezes the tab and WebGL is as slow as before, so there is no browser version. |
| Permission | One email to the address on the developer's own site before the release. No answer in about 4 weeks: release as an unofficial fan patch, taken down on request. A "no": no release. **Decided 2026-10-31:** no email; an unofficial release, taken down if the developer asks, with full credits to Adventure Cat, LLC and Helgravis. |
| Where | A GitHub release in this repo (plus a GitHub Pages page if the browser test passes). Ask Flashpoint's curators afterwards. Not itch.io, Newgrounds or Kongregate. **Decided 2026-10-31:** as recommended, plus a comment with the link on the game's Kongregate page; the Internet Archive skipped for now. The browser test failed (to-do 13), so no GitHub Pages page. |
| Save names | Prefix them (`peacefree-game` and so on), with a one-time read of the old names so existing progress carries over. **Decided 2026-10-31:** as recommended; the old saves are never deleted. Built in to-do 11 (v21). |

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
- **C. An app fans just double-click** (added 2026-10-31, after the user asked for a file fans can just run). A .swf always needs a player, so this means shipping a player with it:
  - A projector .exe with the game inside (the projector's File > Create Projector): one file at about 60 fps, but it ships Adobe's Flash Player, which Adobe's terms don't allow (section 3). Rejected.
  - An AIR app: Harman's AIR SDK packages the finished .swf as it is, with no recompiling, into a Windows folder with its own runtime ("captive runtime"); fans unzip it and run `Peacefree.exe` (in to-do 12 it's `Peacefree Revival.exe`, and the license asks for an installer rather than a zip: see below). Distributing apps is what the SDK is for. Its free tier covers developers under $50k a year and shows a Harman splash screen at startup (Harman's pricing document of 2020; the current license wasn't read; read in to-do 12, it's Wipro's now: see "The AIR SDK's current terms" below). It should run about as fast as the projector, being the same runtime family (an estimate, not tested). From the code: nothing the patched game runs is blocked in AIR. `Security.allowDomain` is only in the original `KongregateAPI.as`, which our stand-in replaces, and the one `ExternalInterface` call (`GameConfig.isSiteLocked`) is never called. Its costs: AIR keeps saves in the app's own folder, so they aren't shared with the projector builds (fans start fresh anyway; existing progress needs a one-time copy). The .exe isn't code-signed, so Windows warns the first time it runs ("Windows protected your PC", then More info, Run anyway); signing costs a yearly fee. Fullscreen and window resizing in AIR are untested.
  - Ruffle bundled with the .swf and a start file: allowed, but slower (section 3).
- **Decided 2026-10-31:** the patched .swf, so fans can use the player they choose, and an AIR app as a second download if a test build runs well. Decided by the user; the AIR test is a new to-do.

### The AIR SDK's current terms (read 2026-10-31, to-do 12)
- **Harman is gone; it's Wipro now.** airsdk.harman.com redirects to airsdk.wxlift.com ("Adobe AIR SDK from Wipro"). The latest SDK is 51.5.1.1 (released 2026-10-27). Its release notes say 51.5 comes only through the **AIR SDK Manager**, a Windows .msi from https://github.com/airsdk/airsdkmanager-releases (v1.5.1, 10.2 MB, 2026-10-27). The site's download API marks 51.5.1.1 `"downloadable": false`, and a direct request for its zip returns HTTP 500. Not on winget.
- **Free tier** (the site's pricing page): free, "Revenue cap of less than $50k/year", "Splash screen will be injected"; "The SDK is free for personal use and for low-income companies". License section 4: free-tier apps show "a splash screen showing Wipro/Adobe branding during the application start-up". Release notes section 9: on Windows it's a separate window for about 2 seconds, and the game's code starts only after it closes. From 51.5 the descriptor's `<splash>` picks `light`, `dark` or `auto`.
- **Distribution** (license section 3.3): the runtime may be shipped only "as incorporated automatically ... as a byproduct of your use of the Build Tools", which is what `-target bundle` makes. The site: "distribution of the runtime when bundled into an application is already covered by the terms of the AIR SDK license agreement."
- **"Runs without installation"** (license section 6.1): "You shall not create or distribute any Developer Application that runs without installation." A zipped bundle folder that fans unzip and run is, read literally, such an app. Adobe's license had the same sentence while Adobe's docs described the bundle as a folder you can run directly. Wipro's release notes (section 6) say the bundle "needs to be packaged up using a third party installer mechanism, in order to provide something that can be easily distributed to and installed by end users". An installer such as Inno Setup (free, on winget as `JRSoftware.InnoSetup`) follows the clause's letter; a zip doesn't. Not asked of Wipro.
- **Privacy** (license section 6.4): the developer must post a privacy policy and put its URL "conspicuously in the Developer Application". The patched game collects nothing and makes no network calls ([network.md](network.md)), so a one-line statement would do; where it goes is for to-do 14.
- **Name** (license, trademarks): "Adobe AIR" may not be in the app's title. "Peacefree Revival" is fine.
- **ADT phones home** (license section 6.4): packaging sends Wipro the OS, the app ID, packaging settings, the SDK version, the locale and an anonymised machine ID. The app itself sends nothing: "The Runtime embedded within such Developer Applications will not send your end user information back to Wipro."
- **Signing:** `-target bundle` takes an AIR signing certificate before `-target` (a self-signed one from `adt -certificate` is fine) and optional Windows code-signing options after it. 64-bit needs `-arch x64` after `-target bundle` (Adobe's bundle page; release notes section 6).

### The AIR app, measured (to-do 12, step A, v21)
- **The SDK:** 51.5.1.1, installed by the user with the AIR SDK Manager into `tools/air/AIRSDK_51.5.1` (1.7 GB: every platform's runtimes and tools). ADT runs on our Java 8. `adt -license` finds no license file, so it's the free tier.
- **Signing is needed after all:** ADT's help writes the bundle's signing options as optional, but packaging from a descriptor stops with "Signing options required to package from descriptor and fileset". `scripts/package_air.py` makes a self-signed certificate once, in `tools/air/`.
- **The app folder:** 16 files, 27.1 MB: `Adobe AIR.dll` 20.2 MB, the game 6.5 MB, `Peacefree Revival.exe` 95 KB. Packaging takes 4-5 s. The .exe is AIR's launcher, byte-identical in every package, so its SHA-256 says nothing about the game inside.
- **Window size:** with `<width>800</width><height>540</height>` in the descriptor, AIR counts the title bar and borders in, and the game got 784x500 with thin black bars. Without them, AIR makes the game's part 800x540, like the projector.
- **Display scaling:** at Windows' 150% (this PC), the AIR app and the projector both ignore the scaling, so Windows stretches both to 1200x810 real pixels: they should look equally sharp. AIR's `requestedDisplayResolution` (`high`) might draw sharper; not tried.
- **Saves:** `%APPDATA%\io.github.hamsterkoster.PeacefreeRevival\Local Store\#SharedObjects\peacefree-game.sol`, separate from the projector's. The game writes it as it starts (a new empty save, 237 bytes, on the first start).
- **Start-up:** the title screen shows 6-13 s after the .exe starts, splash included (five check runs).
- **The check:** a screenshot from the screen failed twice, with another window over the game's. Windows didn't bring the new window to the front, and making it topmost (`SetWindowPos`) didn't work either. `PrintWindow` with `PW_RENDERFULLCONTENT` gets the game's Stage3D drawing even with the window behind others (logo blue 37% against 0% on screen), so the check uses it.

### The AIR app's downloads, measured (to-do 12, step B, v21)
- **Inno Setup 6.7.3**, installed with winget for the current user into `tools/innosetup/` (`--scope user --location`). Inno Setup 7.1.1 is on winget too (`JRSoftware.InnoSetup.7`): its changes (64-bit installers, two editions, breaking script changes; [what's new](https://jrsoftware.org/files/is7-whatsnew.htm)) don't help a per-user installer, and it was 3 days old. License ([license.txt](https://jrsoftware.org/files/is/license.txt), read 2026-10-31): free for any use, commercial included; the commercial licenses added in 6.5.0 are a request.
- **The icon:** with `<icon>` in the descriptor, ADT puts it into the .exe (95 KB without, 449 KB with; Windows shows the chevron). The .exe is still the same in every package with the same icons. The installer's shortcuts and Windows' installed-apps list take the icon from the .exe; the installer's own icon is an .ico that `release_air.py` makes from `air/icons/icon-256.png`.
- **Sizes and times:** the app folder 27.5 MB (21 files); the installer 13,986,571 bytes (LZMA2, solid) in 5.5 s; the zip 15,144,361 bytes (deflate) in 2.2 s. Both are reproducible: the same app folder gave the same SHA-256 again (installer twice, zip three times).
- **Per-user install** (`PrivilegesRequired=lowest`): no admin prompt; the default folder is `%LOCALAPPDATA%\Programs\Peacefree Revival`, the uninstall entry `HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\io.github.hamsterkoster.PeacefreeRevival_is1`, the Start menu entry `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Peacefree Revival.lnk`.
- **Silent install and uninstall** (`release_air.py --check`, 18 s with the zip's check): `/VERYSILENT /MERGETASKS=!desktopicon /DIR=...` installs; the installed app reaches its title screen in 6-7 s; `unins000.exe /VERYSILENT` removes the folder, the Start menu entry and the uninstall entry. The uninstaller starts a copy of itself and ends at once, so the check waits until all three are gone. The saves in AppData stay: the uninstaller removes only what it installed.
- **The zip:** the app's files in a "Peacefree Revival" folder; the unzipped app reaches its title screen in 6-7 s. Not tested: a zip or installer downloaded from the web, which Windows marks; most likely Windows warns on the first start, as for any unsigned .exe (an estimate).

## 3. Player, and the browser
Measured in to-do 2 (FPS from the stats box, [performance.md](performance.md)): projector about 60 fps; Ruffle app about 40; Ruffle in the browser 15-20. Ruffle also drew some graphics wrong.

- **Flash Player projector 32:** the best player, and the one the project tests in. Bundling it isn't allowed. Adobe's terms let a projector be copied only for internal use, and redistributing Flash Player needs a distribution license. Adobe stopped offering it; forum replies from Adobe staff say new licenses are unlikely (secondhand), and Harman sells licensed versions. Linking is the usual way: the README links to the Wayback Machine's copy of Adobe's own download (the file in docs/local.md, signed by Adobe), with its SHA-256. Flashpoint does ship projectors (its FAQ); how it's licensed wasn't found.
- **Ruffle app:** we may bundle it or link to it (MIT or Apache-2.0), and it runs on Windows, macOS and Linux. It's slower, with some drawing errors. It's the second choice in the README.
- **Browser (Ruffle's web version):** too slow as measured. Ruffle's own blog says Stage3D games run well only in its desktop app (2023). One untested chance: the renderer order in Ruffle's code is `wgpu-webgl`, then `webgpu` (from the strings in `tools/ruffle/web/`'s .wasm). So our browser test most likely ran on WebGL, and WebGPU (in Chrome and Edge on Windows) was never tried. It can be forced with the `preferredRenderer: "webgpu"` setting.
  - Suggested: a small to-do that adds a renderer option to `scripts/play.py`, then you read the FPS box in your browser. If it's close to 60 fps and draws right, a GitHub Pages page with Ruffle is a small to-do. If not, the release is a download only, and browser play waits for the refactor (to-do 4 compares an HTML5 rebuild).
  - **Tested 2026-10-31 (to-do 13):** in Edge, `wgpu-webgl` ran about 15 fps in Act 1 with the white background, and `webgpu` started but froze the tab (the game never showed). So the release is a download only, and browser play waits for the refactor ([performance.md](performance.md)).
- **An AIR build** (a Windows app without Flash Player) is part of to-do 4, not this release. Replaced 2026-10-31: packaging the finished .swf as an AIR app needs no recompiling, so it can be part of this release (section 2, C). To-do 4 is about compiling the whole game with the AIR SDK.

## 4. Permission
- **The game's own credits** (from the code, found in to-do 11): its Credits screen shows "A Game By" with the Adventure Cat logo, "Program & Art By: Daniel John Pua" with www.adventurecat.us, "Music By: Audionautix" with audionautix.com, and "Copyright © 2014 Adventure Cat, LLC. All Rights Reserved." (`CreditsScreen.as:44-106`). So the game already credits its makers in the game; the release's title line only says it's an unofficial fan patch. The release's credits should name Audionautix for the music too.
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
- **GitHub Pages:** only for the browser version, if the WebGPU test passes. It didn't (to-do 13), so none.
- **Flashpoint Archive:** it already has the game: "Peacefree Tactical Warfare" by Adventure Cat, status Playable, added 2018. That entry is the Gloebit build from the developer's site, so premium is presumably locked there (not tested). Its rules have no category for fan patches:
  - "Hacked" means changed so the game works in Flashpoint, and it needs the original file too.
  - Alternate versions go under "Additional Applications".
  - Its not-accepted list says nothing about Peacefree or fan patches.

  Recommended: after the GitHub release, ask in Flashpoint's curator channel whether they'd add it as an alternate version. Flashpoint ships the player, and it's where Flash fans look.
- **Internet Archive:** it plays a .swf in the browser with Ruffle (an item's `emulator` field set to `ruffle-swf`). It has the same speed problem as the browser version, so it's only a mirror, and only if the WebGPU test passes. It didn't (to-do 13).
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
- Built in to-do 11 (v21): a copy of the old save is carried over in memory and written by the game's next save; details in [game-code.md](game-code.md) "Save data".

## Suggested to-dos and order
1. **The email to the developer** (the user sends it; Claude drafts it). It goes first, so the 4 weeks run while the rest is built. Dropped 2026-10-31: no email (the user's decision, docs/decisions.md).
2. **Release patches** (small): the shop's free-bomb texts; the save-name prefix with the one-time read of the old names; optionally the release version on the title. One build, all checks. Built 2026-10-31 (to-do 11, v21).
3. **Browser test** (small): a renderer option in `play.py`; you measure WebGPU in your browser. If it passes, a GitHub Pages page with Ruffle becomes a to-do. Built 2026-10-31 (to-do 13): it didn't pass, so no browser version.
4. **AIR app test** (small to medium; added 2026-10-31): the AIR SDK in `tools/`, an app descriptor, v19 packaged as a Windows app with its own runtime, and you play it. If it runs well, the release offers it next to the .swf. Built 2026-10-31 (to-do 12, step A, v21: it runs well); next an installer and a zip (step B).
5. **Release package** (small): a release file name, such as `Peacefree-Revival-1.0.swf`; a README "Play" section for fans (download, get the projector, open the file); release notes. Then the "Before a public release" list in docs/todo.md.
6. **Later:** ask Flashpoint's curators.

## Sources
- Flashpoint database entry 2ff5159c-747f-08e0-b404-2c03ac68064d: https://db-api.unstable.life/search?id=2ff5159c-747f-08e0-b404-2c03ac68064d&filter=false
- Flashpoint curation format, "Hacked" and Additional Applications: https://flashpointarchive.org/datahub/Curation_Format/meta
- Flashpoint not-accepted list: https://flashpointarchive.org/datahub/Not_Accepted_Games
- Flashpoint FAQ (bundled projectors; secondhand, from a search summary): https://flashpointarchive.org/faq
- Adobe, Flash Player usage terms: https://www.adobe.com/products/eula/tools/flashplayer_usage.html
- Adobe, Flash Player distribution: https://www.adobe.com/products/flashplayer/distribution.html
- Harman, AIR pricing (January 2020; free tier with a splash screen, under $50k a year; secondhand, from a search summary): https://airsdk.harman.com/assets/pdfs/Adobe%20AIR%20-%20Updated%20Pricing.pdf. Replaced by the Wipro sources below (read 2026-10-31).
- Wipro, AIR SDK site and pricing (the site's own script, read 2026-10-31): https://airsdk.wxlift.com/download
- Wipro, AIR SDK License Agreement (AdobeAIR_SDK License-en_US-20261008): https://airsdk.wxlift.com/assets/pdfs/Wipro%20AIR%20SDK%20License%20Agreement.pdf
- Wipro, AIR SDK 51.5.1.1 release notes: https://airsdk.wxlift.com/api/versions/51.5.1.1/release-notes/Release_Notes_AIR_SDK_51.5.1.pdf
- AIR SDK Manager releases: https://github.com/airsdk/airsdkmanager-releases/releases
- Adobe, packaging a captive runtime bundle for desktop computers: https://help.adobe.com/en_US/air/build/WSfffb011ac560372f709e16db131e43659b9-8000.html
- Ruffle progress report, 2023-05-29 (Stage3D only well in the desktop app): https://ruffle.rs/blog/2023/05/29/progress-report
- Kongregate, Helgravis's profile (latest activity Sep 29, 2017): https://www.kongregate.com/en/accounts/Helgravis
- Kongregate, the game's page (released July 14, 2014; last updated August 14, 2014; comments): https://www.kongregate.com/en/games/helgravis/peacefree-tactical-warfare
- Kongregate on Ruffle: https://kongregatesupport.zendesk.com/hc/en-us/articles/26730357791501-Ruffle-Flash-Player-What-is-it-why-we-support-it-and-how-you-can-help-too
- The developer's site and contact page: http://www.peacefree.adventurecat.us/ and http://www.peacefree.adventurecat.us/contact
- GitHub DMCA takedown policy: https://docs.github.com/en/site-policy/content-removal-policies/dmca-takedown-policy
- Internet Archive, Flash with Ruffle: https://blog.archive.org/2020/11/19/flash-animations-live-forever-at-the-internet-archive/
- itch.io's rights rule (secondhand, from a search summary of its terms and forum): https://itch.io/docs/legal/terms
- Newgrounds' "creator and owner" rule (secondhand, quoted in a devlog): https://poizonstudios.itch.io/toaster-launchers-2d/devlog/945738/hehefunihax
