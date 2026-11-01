"""Slow check: does a .swf get past the loading screen in Ruffle's web version?

Run from the project folder:
    .venv/Scripts/python scripts/check.py patched/PeacefreeKong-v01-fpsmeter.swf
    .venv/Scripts/python scripts/check.py --premium patched/PeacefreeKong-v02-premium.swf
    .venv/Scripts/python scripts/check.py --shared-save patched/PeacefreeKong-v05-sharedsave.swf
    .venv/Scripts/python scripts/check.py --settings patched/PeacefreeKong-v06-settings.swf
    .venv/Scripts/python scripts/check.py --mission patched/PeacefreeKong-v14-startspeed.swf
    .venv/Scripts/python scripts/check.py --resize patched/PeacefreeKong-v16-scaling.swf

Opens the file in headless Chromium (Playwright, browser in tools/ms-playwright/)
on the local Ruffle page, and takes a screenshot every second until the title
screen's blue PEACEFREE logo shows, or 60 s pass. The last screenshot is saved
in screenshots/. Requests to other sites are blocked and listed, so the check
works offline and shows which network calls the game makes.

With --premium it opens the game with its own show_premium=true flashvar, which
starts on the campaign screen, and passes when the screen's top button is the
Shop (premium unlocked); it fails at once on the gold Premium button (locked).

With --shared-save it first puts in a save under the old name, `game` (Most
Kills 4321), then opens the game the same way (the game saves its settings when
the campaign screen opens). It passes when the game's save is stored under the
root with the new name, where all builds share it, and holds the old save's
4321 (carried over). It fails at once when the save is stored under the file's
own path, so each build has its own save, or when the old save changes (a build
from before the new names saves there; older builds need it as it was).

With --settings it goes on from the title screen: mutes the music with the
title's music icon, clicks Settings, checks that the options panel shows, drags
the music slider from 35% to 75% and checks that the settings save holds 75
(and SFX 100) and the game's save says music is on again (dragging unmutes),
clicks the Start Speed row's 1x and checks that the settings save holds 1,
clicks Controls and checks that the Controls page shows, clicks its Back and
checks that the panel shows again, then clicks the panel's Back and checks that
the panel has gone.

With --mission it does the --settings steps, then goes on into a mission: Play,
Settings on the campaign screen, Unlock All Acts and Yes, Act 2 (Act 1's
tutorial hides the speed buttons), Start, and clicks through Act 2's opening
dialogue until the mission's speed buttons show; it passes when 1x is the lit
one (the game's own start speed is 4x).

With --resize it goes on from the title screen: makes the player 1400x810, wider
than the game's shape like most screens, and passes when the game fits it
(1200x810, centred, black bars left and right): the bars are black, the logo is
at its scaled place, and Settings, clicked at its scaled place, opens the
options panel.
"""

import argparse
import base64
import os
import re
import struct
import sys
import time
from io import BytesIO
from pathlib import Path
from urllib.parse import urlparse

from decompile import ROOT
from PIL import Image
from ruffle_page import RENDERERS, start_server, stop_server

BROWSERS = ROOT / "tools" / "ms-playwright"
SCREENSHOTS = ROOT / "screenshots"
TIMEOUT_SECONDS = 60
# The PEACEFREE logo on the title screen, in the 800x540 player: about 38% of
# this area is logo blue there, and 0% while the file loads (a white screen).
LOGO_AREA = (250, 70, 650, 170)
MIN_LOGO_BLUE = 0.20
# The campaign screen's top button, darkened by the sales popup that
# show_premium also opens: the green Shop ("Weapons") button is 81% green and
# 0% gold here, the gold Premium button 53% gold and 0% green.
BUTTON_AREA = (360, 2, 480, 38)
MIN_BUTTON_SHARE = 0.25
# Ruffle keeps saves in localStorage as <host><path>/<name>, without the port
# (measured): the game's save is 127.0.0.1/game.swf/game under the file's path
# (v04), 127.0.0.1//game under the root (v05), 127.0.0.1//peacefree-game with
# the release's names (v20).
SAVE_NAME = "/peacefree-game"
SETTINGS_SAVE_NAME = "/peacefree-settings"  # the volumes (to-do 6), under the root like the game's save
OLD_SAVE_NAME = "/game"  # --shared-save: the game's save before the names got their prefix
OLD_MOST_KILLS = 4321  # --shared-save: the old save's mark, which a fresh save (0) doesn't have
# --settings: the title screen's Settings button and the options panel's buttons
# (to-do 6). White text shows each: the button's label is 13% white once the
# title's animation has shown it, and 0% before; the panel's "Music Volume"
# label is 17% white with the panel open, and 0% without (measured).
SETTINGS_BUTTON = (67, 18)
MUSIC_ICON = (192, 17)  # the title's music icon, right of the SFX icon (measured)
BACK_BUTTON = (400, 280)
SPEED_1X_BUTTON = (390, 210)  # the panel's Start Speed row (to-do 8)
# The panel's Controls button, left on its bottom row, and the Controls page's
# title and Back button (to-do 9).
CONTROLS_BUTTON = (200, 350)
CONTROLS_TITLE_AREA = (340, 15, 460, 50)
CONTROLS_BACK_BUTTON = (400, 495)
START_SPEED = 1
# The music slider's bar runs from x 360 (0%) to 560 (100%) at y 90; its knob
# starts at the game's own 35%. Dragged to 75%.
MUSIC_KNOB = (430, 90)
MUSIC_DRAG_TO = (510, 90)
DRAGGED_VOLUME = 75
SETTINGS_LABEL_AREA = (25, 5, 110, 30)
PANEL_LABEL_AREA = (200, 75, 335, 105)
MIN_TEXT_WHITE = 0.06
# --mission (to-do 8), measured on v14 screenshots: the title's Play button, the
# panel's Unlock All Acts and its Yes, the campaign screen's Act 2 and Start
# buttons, and the dialogue box ("Click Anywhere to Continue"). The Normal
# difficulty button's label is 21% white once an open act other than Act 1 is
# chosen, and 0% for Act 1, which has no difficulty buttons.
PLAY_BUTTON = (289, 465)
UNLOCK_ACTS_BUTTON = (345, 350)  # inside the button at x 300-500 (v15 and older), 190-390 (v16-v17) and 310-490 (v18 on)
UNLOCK_YES = (339, 364)
ACT_2_BUTTON = (73, 115)
START_BUTTON = (669, 505)
DIALOGUE = (400, 470)
NORMAL_LABEL_AREA = (318, 510, 382, 530)
# The mission's 1x, 4x and 8x buttons, top right: the lit one is 22-28% bright
# green, the dimmed ones 0% (measured, v14 at 1x and v13 at 4x). The pause
# button left of them is left out: pausing lights it without dimming the speed.
HUD_SPEED_AREAS = {1: (678, 52, 700, 72), 4: (712, 52, 744, 72), 8: (755, 52, 792, 72)}
MIN_HUD_GREEN = 0.10
HUD_TIMEOUT_SECONDS = 30
# --resize (to-do 8): the player's new size; the game fits it at 1.5 times its
# 800x540, 100 pixels in, with black bars left and right.
RESIZED_PLAYER = (1400, 810)
RESIZED_SCALE = 1.5
RESIZED_LEFT = 100
MIN_BAR_BLACK = 0.98
# Ruffle opens this notice over the game at the first mouse-over when it draws
# with the CPU, as it does headless; it would catch the clicks.
HIDE_RUFFLE_NOTICE = """() => {
    const shadow = document.querySelector("ruffle-player")?.shadowRoot;
    shadow?.getElementById("hardware-acceleration-modal")?.classList.add("hidden");
}"""


def share(png: bytes, area: tuple[int, int, int, int], matches) -> float:
    """Share of pixels in area (of the player's screenshot) for which matches(r, g, b) is true."""
    pixels = Image.open(BytesIO(png)).convert("RGB").crop(area).get_flattened_data()
    return sum(1 for r, g, b in pixels if matches(r, g, b)) / len(pixels)


def is_logo_blue(r: int, _g: int, b: int) -> bool:
    return b > 180 and r < 120


def is_shop_green(r: int, g: int, _b: int) -> bool:
    return g >= r + 8


def is_premium_gold(r: int, g: int, b: int) -> bool:
    return r >= g + 4 and r >= b + 8


def is_white(r: int, g: int, b: int) -> bool:
    return r > 200 and g > 200 and b > 200


def is_hud_green(r: int, g: int, b: int) -> bool:
    return g > 150 and r < 120 and b < 120


def is_black(r: int, g: int, b: int) -> bool:
    return r < 16 and g < 16 and b < 16


def resized(coords: tuple[int, ...]) -> tuple[int, ...]:
    """A point (x, y) or an area (x1, y1, x2, y2) in the 800x540 player, moved to the resized player."""
    return tuple(round(v * RESIZED_SCALE + (0 if i % 2 else RESIZED_LEFT)) for i, v in enumerate(coords))


def shoot(page, box) -> bytes:
    """A screenshot of the player's box.

    With the options panel open, headless Ruffle takes up to 4 s for one on a
    busy PC (measured), so 5 s left no margin.
    """
    return page.screenshot(clip=box, timeout=15000)


def click(page, box, point: tuple[int, int], wait_ms: int = 1000) -> None:
    """Clicks a point in the player, then waits (the panel fades in or out in 0.5 s)."""
    page.mouse.click(box["x"] + point[0], box["y"] + point[1])
    page.wait_for_timeout(wait_ms)


def amf3_int(value: int) -> bytes:
    """A whole number from 0 to 2^21 - 1 as AMF3 writes it: 7 bits a byte, high bit set while more follow."""
    if not 0 <= value < 0x200000:
        raise ValueError(f"amf3_int can't write {value}")
    groups = [value >> 14 & 0x7F, value >> 7 & 0x7F, value & 0x7F]
    while len(groups) > 1 and groups[0] == 0:
        groups.pop(0)
    return bytes([group | 0x80 for group in groups[:-1]] + groups[-1:])


def amf3_string(text: str) -> bytes:
    data = text.encode()
    return amf3_int(len(data) << 1 | 1) + data


def amf3(value) -> bytes:
    """A value in AMF3, the game's save format: dicts as plain objects, no references."""
    if isinstance(value, bool):
        return b"\x03" if value else b"\x02"
    if isinstance(value, int):
        return b"\x04" + amf3_int(value)
    if isinstance(value, list):
        return b"\x09" + amf3_int(len(value) << 1 | 1) + b"\x01" + b"".join(amf3(item) for item in value)
    if isinstance(value, dict):
        return b"\x0a\x0b\x01" + b"".join(amf3_string(key) + amf3(item) for key, item in value.items()) + b"\x01"
    raise TypeError(f"amf3 can't write {type(value).__name__}")


def sol_file(name: str, entries: dict) -> bytes:
    """A save (.sol file) as Ruffle keeps it in localStorage, before base64 (the layout measured from Ruffle's own)."""
    body = b"TCSO\x00\x04\x00\x00\x00\x00" + struct.pack(">H", len(name)) + name.encode() + b"\x00\x00\x00\x03"
    body += b"".join(amf3_string(key) + amf3(value) + b"\x00" for key, value in entries.items())
    return b"\x00\xbf" + struct.pack(">I", len(body)) + body


def saved_flag(page, key: str, name: bytes) -> bool | None:
    """A true/false setting from a save in Ruffle's localStorage, None if it isn't there.

    Ruffle stores the .sol file in base64; the game's save is AMF3, where a
    setting's name is followed by 0x02 for false or 0x03 for true (measured).
    """
    stored = page.evaluate("key => localStorage.getItem(key)", key)
    data = base64.b64decode(stored) if stored else b""
    at = data.find(name) + len(name)
    return {2: False, 3: True}.get(data[at]) if len(name) <= at < len(data) else None


def saved_number(page, key: str, name: bytes) -> float | None:
    """A number from a save in Ruffle's localStorage, None if it isn't there.

    In AMF3 a number follows its name as 0x04 and an integer of 1 to 4 bytes
    (7 bits each but the 4th's 8, high bit set while more follow), or 0x05 and
    an 8-byte double.
    """
    stored = page.evaluate("key => localStorage.getItem(key)", key)
    data = base64.b64decode(stored) if stored else b""
    at = data.find(name) + len(name)
    if len(name) <= at and at + 9 <= len(data) and data[at] == 0x05:
        return struct.unpack(">d", data[at + 1 : at + 9])[0]
    if len(name) <= at and at + 2 <= len(data) and data[at] == 0x04:  # the save may end soon after
        value = 0
        for i, byte in enumerate(data[at + 1 : at + 5]):
            if i == 3:
                return (value << 8) | byte
            value = (value << 7) | (byte & 0x7F)
            if not byte & 0x80:
                return value
    return None


def try_settings(page, box, host: str) -> tuple[str, bytes]:
    """--settings, on the title screen: what went wrong ("" if nothing) and the last screenshot."""
    game_key = f"{host}/{SAVE_NAME}"
    settings_key = f"{host}/{SETTINGS_SAVE_NAME}"
    page.mouse.move(box["x"] + 400, box["y"] + 500)
    page.wait_for_timeout(300)
    page.evaluate(HIDE_RUFFLE_NOTICE)
    for _ in range(20):  # the button shows when the title's animation ends
        png = shoot(page, box)
        if share(png, SETTINGS_LABEL_AREA, is_white) >= MIN_TEXT_WHITE:
            break
        page.wait_for_timeout(500)
    else:
        return "no Settings button on the title screen", png
    if saved_flag(page, game_key, b"bEnabledBGM") is not True:  # a new browser: no save but the title's
        return "the save doesn't start with music on", png
    click(page, box, MUSIC_ICON)
    if saved_flag(page, game_key, b"bEnabledBGM") is not False:
        return "the title's music icon didn't mute the music", shoot(page, box)
    click(page, box, SETTINGS_BUTTON)
    png = shoot(page, box)
    if share(png, PANEL_LABEL_AREA, is_white) < MIN_TEXT_WHITE:
        return "Settings didn't open the options panel", png
    page.mouse.move(box["x"] + MUSIC_KNOB[0], box["y"] + MUSIC_KNOB[1])
    page.mouse.down()
    page.wait_for_timeout(200)
    page.mouse.move(box["x"] + MUSIC_DRAG_TO[0], box["y"] + MUSIC_DRAG_TO[1], steps=8)
    page.wait_for_timeout(200)
    page.mouse.up()
    page.wait_for_timeout(1000)
    png = shoot(page, box)
    volume = saved_number(page, settings_key, b"music")
    if volume != DRAGGED_VOLUME:
        return f"the music slider dragged to {DRAGGED_VOLUME}% saved {volume}", png
    volume = saved_number(page, settings_key, b"sfx")
    if volume != 100:  # saved with the music's volume, at its start value
        return f"the settings save holds SFX volume {volume}, not 100", png
    if saved_flag(page, game_key, b"bEnabledBGM") is not True:
        return "dragging the muted music slider didn't unmute the music", png
    speed = saved_number(page, settings_key, b"startSpeed")
    if speed != 4:  # saved with the music's volume, at the game's own 4x
        return f"the settings save holds start speed {speed}, not 4", png
    click(page, box, SPEED_1X_BUTTON)
    png = shoot(page, box)
    speed = saved_number(page, settings_key, b"startSpeed")
    if speed != START_SPEED:
        return f"the Start Speed row's {START_SPEED}x saved {speed}", png
    click(page, box, CONTROLS_BUTTON)
    png = shoot(page, box)
    if share(png, CONTROLS_TITLE_AREA, is_white) < MIN_TEXT_WHITE:
        return "Controls didn't open the Controls page", png
    click(page, box, CONTROLS_BACK_BUTTON)
    png = shoot(page, box)
    if share(png, CONTROLS_TITLE_AREA, is_white) >= MIN_TEXT_WHITE or share(png, PANEL_LABEL_AREA, is_white) < MIN_TEXT_WHITE:
        return "the Controls page's Back didn't show the options panel again", png
    click(page, box, BACK_BUTTON)
    png = shoot(page, box)
    if share(png, PANEL_LABEL_AREA, is_white) >= MIN_TEXT_WHITE:
        return "Back didn't close the options panel", png
    return "", png


def try_mission(page, box) -> tuple[str, bytes]:
    """--mission, on the title screen after try_settings: what went wrong ("" if nothing) and the last screenshot."""
    click(page, box, PLAY_BUTTON, 4000)  # the campaign screen fades in
    click(page, box, SETTINGS_BUTTON)
    png = shoot(page, box)
    if share(png, PANEL_LABEL_AREA, is_white) < MIN_TEXT_WHITE:
        return "Settings didn't open the options panel on the campaign screen", png
    click(page, box, UNLOCK_ACTS_BUTTON)
    click(page, box, UNLOCK_YES, 2500)  # the campaign screen is made again, without the panel
    click(page, box, ACT_2_BUTTON, 1500)
    png = shoot(page, box)
    if share(png, NORMAL_LABEL_AREA, is_white) < MIN_TEXT_WHITE:
        return "Act 2 isn't open after Unlock All Acts (no difficulty buttons)", png
    click(page, box, START_BUTTON, 5000)  # the campaign screen fades out and the map loads
    # Act 2 opens with two lines of dialogue that hide the HUD; each click shows the next.
    deadline = time.monotonic() + HUD_TIMEOUT_SECONDS
    while time.monotonic() < deadline:
        png = shoot(page, box)
        lit = [speed for speed, area in HUD_SPEED_AREAS.items() if share(png, area, is_hud_green) >= MIN_HUD_GREEN]
        if lit == [START_SPEED]:
            return "", png
        if lit:
            return f"Act 2 started at {lit[0]}x, not the start speed {START_SPEED}x", png
        click(page, box, DIALOGUE, 1500)
    return f"no speed buttons {HUD_TIMEOUT_SECONDS} s after Start in Act 2", png


def try_resize(page) -> tuple[str, bytes]:
    """--resize, on the title screen: what went wrong ("" if nothing) and the last screenshot."""
    width, height = RESIZED_PLAYER
    page.set_viewport_size({"width": width + 40, "height": height + 40})
    page.evaluate(
        """([width, height]) => {
        for (const element of [document.getElementById("game"), document.querySelector("ruffle-player")]) {
            element.style.width = width + "px";
            element.style.height = height + "px";
        }
    }""",
        [width, height],
    )
    page.wait_for_timeout(1000)
    box = page.locator("ruffle-player").bounding_box(timeout=5000)
    page.mouse.move(box["x"] + width // 2, box["y"] + height - 100)
    page.wait_for_timeout(300)
    page.evaluate(HIDE_RUFFLE_NOTICE)
    for _ in range(20):  # the Settings button shows when the title's animation ends
        png = shoot(page, box)
        if share(png, resized(SETTINGS_LABEL_AREA), is_white) >= MIN_TEXT_WHITE:
            break
        page.wait_for_timeout(500)
    else:
        return f"no Settings button at its place in a {width}x{height} player", png
    for area in ((0, 0, RESIZED_LEFT - 5, height), (width - RESIZED_LEFT + 5, 0, width, height)):
        if share(png, area, is_black) < MIN_BAR_BLACK:
            return f"no black bar at {area} in a {width}x{height} player", png
    if share(png, resized(LOGO_AREA), is_logo_blue) < MIN_LOGO_BLUE:
        return f"the logo isn't at its scaled place in a {width}x{height} player", png
    click(page, box, resized(SETTINGS_BUTTON))
    png = shoot(page, box)
    if share(png, resized(PANEL_LABEL_AREA), is_white) < MIN_TEXT_WHITE:
        return f"Settings, clicked at its scaled place, didn't open the options panel in a {width}x{height} player", png
    return "", png


def main() -> int:
    parser = argparse.ArgumentParser(description="Check that a .swf gets past the loading screen in Ruffle (headless).")
    parser.add_argument("swf", type=Path, help="the .swf file, for example patched/PeacefreeKong-v01-fpsmeter.swf")
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--premium", action="store_true", help="check that premium is unlocked instead")
    mode.add_argument("--shared-save", action="store_true", help="check that the save is shared by all builds instead")
    mode.add_argument("--settings", action="store_true", help="also check the title screen's Settings button and options panel")
    mode.add_argument("--mission", action="store_true", help="also do the --settings steps, then check that Act 2 starts at the start speed")
    mode.add_argument("--resize", action="store_true", help="also check that the game fits a 1400x810 player")
    parser.add_argument("--renderer", choices=RENDERERS, help="the renderer Ruffle tries first (default: Ruffle's own order); Ruffle's log line below names the one it used")
    args = parser.parse_args()
    swf = args.swf.resolve()
    if not swf.is_file():
        print(f"error: file not found: {swf}", file=sys.stderr)
        return 1
    if not BROWSERS.is_dir():
        print(f"error: Playwright's browser is missing; see 'Set up' in docs/building.md to install it into {BROWSERS}", file=sys.stderr)
        return 1

    # Imported only after the browser path is set.
    os.environ["PLAYWRIGHT_BROWSERS_PATH"] = str(BROWSERS)
    from playwright.sync_api import Error as PlaywrightError
    from playwright.sync_api import sync_playwright

    SCREENSHOTS.mkdir(exist_ok=True)
    suffix = "-premium" if args.premium else "-sharedsave" if args.shared_save else "-settings" if args.settings else "-mission" if args.mission else "-resize" if args.resize else ""
    screenshot = SCREENSHOTS / f"check-{swf.stem}{suffix}.png"
    blocked: list[str] = []
    ruffle_log: list[str] = []
    png = b""
    locked = False
    save_key = ""  # --shared-save: the save's localStorage key, once the game has saved
    per_file = False  # --shared-save: the save is under another path, such as the file's own
    old_changed = False  # --shared-save: the old save is gone or no longer the one put in
    previous = ""  # --premium: what the last screenshot showed, "shop", "locked" or ""
    step_error = ""  # --settings, --mission, --resize: what went wrong after the title screen showed

    def block(route):
        blocked.append(route.request.url)
        route.abort()

    def log(message):
        if "Ruffle instance" in message.text or "ERROR" in message.text:
            # Ruffle styles its log with %c and CSS that the text repeats at the end.
            ruffle_log.append(re.sub(r"\s+(color|background):.*", "", message.text.replace("%c", "")))

    try:
        server, url = start_server(swf, args.renderer)
    except FileNotFoundError as error:
        print(f"error: {error}", file=sys.stderr)
        return 1
    host = urlparse(url).hostname
    root_key = f"{host}/{SAVE_NAME}"  # --shared-save: the save's key under the root
    old_key = f"{host}/{OLD_SAVE_NAME}"  # --shared-save: the old save's key, put in before the game starts
    old_data = {"unlockedActs": [], "bEnableFX": True, "bEnabledBGM": True, "longestGame": 1, "mostKills": OLD_MOST_KILLS, "mostRescues": 0}
    old_save = base64.b64encode(sol_file(OLD_SAVE_NAME[1:], {"content": {"data": old_data}})).decode()
    try:
        with sync_playwright() as playwright:
            browser = playwright.chromium.launch()
            page = browser.new_page(viewport={"width": 840, "height": 580})
            page.route(lambda u: not u.startswith(url), block)
            page.on("console", log)
            start = time.monotonic()
            if args.shared_save:  # runs before the page's own scripts, so the old save is there when the game starts
                page.add_init_script(f"localStorage.getItem('{old_key}') || localStorage.setItem('{old_key}', '{old_save}')")
            page.goto(url + ("?show_premium=true" if args.premium or args.shared_save else ""))
            passed = False
            while not passed and not locked and not per_file and not old_changed and time.monotonic() - start < TIMEOUT_SECONDS:
                page.wait_for_timeout(1000)  # unlike time.sleep, Playwright keeps handling requests meanwhile
                if args.shared_save:  # read before the screenshot, so a slow screenshot can't delay it
                    stored = page.evaluate("Object.fromEntries(Object.entries(localStorage))")
                    # Saves under any path, with either name, but not the old save put in.
                    saves = [k for k in stored if k.endswith((SAVE_NAME, OLD_SAVE_NAME)) and k != old_key]
                    old_changed = stored.get(old_key) != old_save
                    # The game's own save, not only the carried-over copy: the old save has no achievement data.
                    passed = not old_changed and b"achievementData" in base64.b64decode(stored.get(root_key, ""))
                    per_file = bool(saves) and root_key not in saves
                    save_key = root_key if root_key in saves else saves[0] if saves else ""
                try:
                    # A page screenshot of the player's box: an element screenshot waits for the
                    # element to be "stable", which never happens on the campaign screen.
                    box = page.locator("ruffle-player").bounding_box(timeout=5000)
                    if box is None:
                        previous = ""
                        continue
                    png = page.screenshot(clip=box, timeout=5000)
                except PlaywrightError:  # no player on the page (yet): try again until the time is up
                    previous = ""  # the next screenshot doesn't follow this one directly
                    continue
                if args.premium:
                    # Decided only when two screenshots in a row agree, so one frame of a fade can't.
                    if share(png, BUTTON_AREA, is_shop_green) >= MIN_BUTTON_SHARE:
                        seen = "shop"
                    elif share(png, BUTTON_AREA, is_premium_gold) >= MIN_BUTTON_SHARE:
                        seen = "locked"
                    else:
                        seen = ""
                    passed = seen == previous == "shop"
                    locked = seen == previous == "locked"
                    previous = seen
                elif not args.shared_save:
                    passed = share(png, LOGO_AREA, is_logo_blue) >= MIN_LOGO_BLUE
            if passed and args.shared_save:
                kills = saved_number(page, root_key, b"mostKills")
                if kills != OLD_MOST_KILLS:
                    step_error = f"its save ({root_key}) didn't carry over the old save {old_key}: Most Kills is {kills}, not {OLD_MOST_KILLS}"
                passed = not step_error
            if passed and (args.settings or args.mission):
                try:
                    step_error, png = try_settings(page, box, host)
                    if not step_error and args.mission:
                        step_error, png = try_mission(page, box)
                except PlaywrightError as error:
                    step_error = f"the browser failed: {str(error).splitlines()[0]}"
                passed = not step_error
            if passed and args.resize:
                try:
                    step_error, png = try_resize(page)
                except PlaywrightError as error:
                    step_error = f"the browser failed: {str(error).splitlines()[0]}"
                passed = not step_error
            seconds = time.monotonic() - start
            browser.close()
    finally:
        stop_server(server)
    if png:
        screenshot.write_bytes(png)

    for line in ruffle_log:
        print(f"Ruffle: {line[:200]}")
    used = next((m.group(1) for line in ruffle_log if (m := re.search(r"Used renderer: ([a-z-]+)", line))), "")
    if args.renderer and used != args.renderer:
        print(f"Note: Ruffle was asked to try {args.renderer} first but used {used or 'none it named'}; the result below is for that one")
    for request in blocked:
        print(f"Blocked request: {request}")
    shown = screenshot.relative_to(ROOT) if png else "none"
    if passed and args.shared_save:
        print(f"PASS: {swf.name} saves under the root ({save_key}), shared by all builds, with the old save's progress carried over and the old save left as it was, after {seconds:.0f} s (screenshot: {shown})")
        return 0
    if passed and args.settings:
        print(f"PASS: {swf.name} opens the options panel from the title screen, saves its music slider at {DRAGGED_VOLUME}% (unmuted) and start speed {START_SPEED}x, opens and leaves the Controls page, and closes it, after {seconds:.0f} s (screenshot: {shown})")
        return 0
    if passed and args.mission:
        print(f"PASS: {swf.name} starts Act 2 at the start speed set in Settings ({START_SPEED}x), after {seconds:.0f} s (screenshot: {shown})")
        return 0
    if passed and args.resize:
        width, height = RESIZED_PLAYER
        print(f"PASS: {swf.name} fits a {width}x{height} player (black bars, logo and Settings at their scaled places), after {seconds:.0f} s (screenshot: {shown})")
        return 0
    if passed and args.premium:
        print(f"PASS: {swf.name} shows the Shop button (premium unlocked) after {seconds:.0f} s (screenshot: {shown})")
        return 0
    if passed:
        print(f"PASS: {swf.name} shows the title screen after {seconds:.0f} s (screenshot: {shown})")
        return 0
    if locked:
        print(f"FAIL: {swf.name} shows the gold Premium button: premium is locked (screenshot: {shown})", file=sys.stderr)
        return 1
    if step_error:
        print(f"FAIL: {swf.name}: {step_error} (screenshot: {shown})", file=sys.stderr)
        return 1
    if old_changed:
        print(f"FAIL: {swf.name} changed or removed the old save ({old_key}), which older builds still use: it saves under the old name, or overwrote it (screenshot: {shown})", file=sys.stderr)
        return 1
    if per_file:
        print(f"FAIL: {swf.name} saves under its own path ({save_key}), not the root: builds don't share it (screenshot: {shown})", file=sys.stderr)
        return 1
    screen = "Shop or Premium button" if args.premium else "save" if args.shared_save else "title screen"
    print(f"FAIL: no {screen} after {TIMEOUT_SECONDS} s (last screenshot: {shown})", file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
