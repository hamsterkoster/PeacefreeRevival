"""Slow check: does a .swf get past the loading screen in Ruffle's web version?

Run from the project folder:
    .venv/Scripts/python scripts/check.py patched/PeacefreeKong-v01-fpsmeter.swf
    .venv/Scripts/python scripts/check.py --premium patched/PeacefreeKong-v02-premium.swf
    .venv/Scripts/python scripts/check.py --shared-save patched/PeacefreeKong-v05-sharedsave.swf
    .venv/Scripts/python scripts/check.py --settings patched/PeacefreeKong-v06-settings.swf

Opens the file in headless Chromium (Playwright, browser in tools/ms-playwright/)
on the local Ruffle page, and takes a screenshot every second until the title
screen's blue PEACEFREE logo shows, or 60 s pass. The last screenshot is saved
in screenshots/. Requests to other sites are blocked and listed, so the check
works offline and shows which network calls the game makes.

With --premium it opens the game with its own show_premium=true flashvar, which
starts on the campaign screen, and passes when the screen's top button is the
Shop (premium unlocked); it fails at once on the gold Premium button (locked).

With --shared-save it opens the game the same way (the game saves its settings
when the campaign screen opens) and passes when the save is stored under the
root, where all builds share it; it fails at once when the save is stored under
the file's own path, so each build has its own save.

With --settings it goes on from the title screen: clicks Settings, checks that
the options panel shows, clicks the panel's SFX OFF and checks that the save
says so, then clicks Back and checks that the panel has gone.
"""

import argparse
import base64
import os
import re
import sys
import time
from io import BytesIO
from pathlib import Path
from urllib.parse import urlparse

from decompile import ROOT
from PIL import Image
from ruffle_page import start_server, stop_server

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
# (v04), 127.0.0.1//game under the root (v05).
SAVE_NAME = "/game"
# --settings: the title screen's Settings button and the options panel's buttons
# (to-do 6). White text shows each: the button's label is 13% white once the
# title's animation has shown it, and 0% before; the panel's "Music Volume"
# label is 17% white with the panel open, and 0% without (measured).
SETTINGS_BUTTON = (67, 18)
SFX_OFF_BUTTON = (500, 150)
BACK_BUTTON = (400, 260)
SETTINGS_LABEL_AREA = (25, 5, 110, 30)
PANEL_LABEL_AREA = (200, 75, 335, 105)
MIN_TEXT_WHITE = 0.06
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


def saved_flag(page, key: str, name: bytes) -> bool | None:
    """A true/false setting from a save in Ruffle's localStorage, None if it isn't there.

    Ruffle stores the .sol file in base64; the game's save is AMF3, where a
    setting's name is followed by 0x02 for false or 0x03 for true (measured).
    """
    stored = page.evaluate("key => localStorage.getItem(key)", key)
    data = base64.b64decode(stored) if stored else b""
    at = data.find(name) + len(name)
    return {2: False, 3: True}.get(data[at]) if len(name) <= at < len(data) else None


def try_settings(page, box, save_key: str) -> tuple[str, bytes]:
    """--settings, on the title screen: what went wrong ("" if nothing) and the last screenshot."""

    def shoot() -> bytes:
        return page.screenshot(clip=box, timeout=5000)

    def click(point: tuple[int, int]) -> None:
        page.mouse.click(box["x"] + point[0], box["y"] + point[1])
        page.wait_for_timeout(1000)  # the panel fades in or out in 0.5 s

    page.mouse.move(box["x"] + 400, box["y"] + 500)
    page.wait_for_timeout(300)
    page.evaluate(HIDE_RUFFLE_NOTICE)
    for _ in range(20):  # the button shows when the title's animation ends
        png = shoot()
        if share(png, SETTINGS_LABEL_AREA, is_white) >= MIN_TEXT_WHITE:
            break
        page.wait_for_timeout(500)
    else:
        return "no Settings button on the title screen", png
    click(SETTINGS_BUTTON)
    png = shoot()
    if share(png, PANEL_LABEL_AREA, is_white) < MIN_TEXT_WHITE:
        return "Settings didn't open the options panel", png
    if saved_flag(page, save_key, b"bEnableFX") is not True:  # a new browser: no save but the title's
        return "the save doesn't start with SFX on", png
    click(SFX_OFF_BUTTON)
    png = shoot()
    if saved_flag(page, save_key, b"bEnableFX") is not False:
        return "the panel's SFX OFF wasn't saved", png
    click(BACK_BUTTON)
    png = shoot()
    if share(png, PANEL_LABEL_AREA, is_white) >= MIN_TEXT_WHITE:
        return "Back didn't close the options panel", png
    return "", png


def main() -> int:
    parser = argparse.ArgumentParser(description="Check that a .swf gets past the loading screen in Ruffle (headless).")
    parser.add_argument("swf", type=Path, help="the .swf file, for example patched/PeacefreeKong-v01-fpsmeter.swf")
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--premium", action="store_true", help="check that premium is unlocked instead")
    mode.add_argument("--shared-save", action="store_true", help="check that the save is shared by all builds instead")
    mode.add_argument("--settings", action="store_true", help="also check the title screen's Settings button and options panel")
    args = parser.parse_args()
    swf = args.swf.resolve()
    if not swf.is_file():
        print(f"error: file not found: {swf}", file=sys.stderr)
        return 1
    if not BROWSERS.is_dir():
        print(f"error: Playwright's browser is missing; see docs/local.md to install it into {BROWSERS}", file=sys.stderr)
        return 1

    # Imported only after the browser path is set.
    os.environ["PLAYWRIGHT_BROWSERS_PATH"] = str(BROWSERS)
    from playwright.sync_api import Error as PlaywrightError
    from playwright.sync_api import sync_playwright

    SCREENSHOTS.mkdir(exist_ok=True)
    suffix = "-premium" if args.premium else "-sharedsave" if args.shared_save else "-settings" if args.settings else ""
    screenshot = SCREENSHOTS / f"check-{swf.stem}{suffix}.png"
    blocked: list[str] = []
    ruffle_log: list[str] = []
    png = b""
    locked = False
    save_key = ""  # --shared-save: the save's localStorage key, once the game has saved
    per_file = False  # --shared-save: the save is under another path, such as the file's own
    previous = ""  # --premium: what the last screenshot showed, "shop", "locked" or ""
    settings_error = ""  # --settings: what went wrong after the title screen showed

    def block(route):
        blocked.append(route.request.url)
        route.abort()

    def log(message):
        if "Ruffle instance" in message.text or "ERROR" in message.text:
            # Ruffle styles its log with %c and CSS that the text repeats at the end.
            ruffle_log.append(re.sub(r"\s+(color|background):.*", "", message.text.replace("%c", "")))

    try:
        server, url = start_server(swf)
    except FileNotFoundError as error:
        print(f"error: {error}", file=sys.stderr)
        return 1
    root_key = f"{urlparse(url).hostname}/{SAVE_NAME}"  # --shared-save, --settings: the save's key under the root
    try:
        with sync_playwright() as playwright:
            browser = playwright.chromium.launch()
            page = browser.new_page(viewport={"width": 840, "height": 580})
            page.route(lambda u: not u.startswith(url), block)
            page.on("console", log)
            start = time.monotonic()
            page.goto(url + ("?show_premium=true" if args.premium or args.shared_save else ""))
            passed = False
            while not passed and not locked and not per_file and time.monotonic() - start < TIMEOUT_SECONDS:
                page.wait_for_timeout(1000)  # unlike time.sleep, Playwright keeps handling requests meanwhile
                if args.shared_save:  # read before the screenshot, so a slow screenshot can't delay it
                    saves = [k for k in page.evaluate("Object.keys(localStorage)") if k.endswith(SAVE_NAME)]
                    passed = root_key in saves
                    per_file = bool(saves) and not passed
                    save_key = root_key if passed else saves[0] if saves else ""
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
            if passed and args.settings:
                try:
                    settings_error, png = try_settings(page, box, root_key)
                except PlaywrightError as error:
                    settings_error = f"the browser failed: {str(error).splitlines()[0]}"
                passed = not settings_error
            seconds = time.monotonic() - start
            browser.close()
    finally:
        stop_server(server)
    if png:
        screenshot.write_bytes(png)

    for line in ruffle_log:
        print(f"Ruffle: {line[:200]}")
    for request in blocked:
        print(f"Blocked request: {request}")
    shown = screenshot.relative_to(ROOT) if png else "none"
    if passed and args.shared_save:
        print(f"PASS: {swf.name} saves under the root ({save_key}), shared by all builds, after {seconds:.0f} s (screenshot: {shown})")
        return 0
    if passed and args.settings:
        print(f"PASS: {swf.name} opens the options panel from the title screen, saves its SFX OFF and closes it, after {seconds:.0f} s (screenshot: {shown})")
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
    if settings_error:
        print(f"FAIL: {swf.name}: {settings_error} (screenshot: {shown})", file=sys.stderr)
        return 1
    if per_file:
        print(f"FAIL: {swf.name} saves under its own path ({save_key}), not the root: builds don't share it (screenshot: {shown})", file=sys.stderr)
        return 1
    screen = "Shop or Premium button" if args.premium else "save" if args.shared_save else "title screen"
    print(f"FAIL: no {screen} after {TIMEOUT_SECONDS} s (last screenshot: {shown})", file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
