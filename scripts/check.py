"""Slow check: does a .swf get past the loading screen in Ruffle's web version?

Run from the project folder:
    .venv/Scripts/python scripts/check.py patched/PeacefreeKong-v01-fpsmeter.swf
    .venv/Scripts/python scripts/check.py --premium patched/PeacefreeKong-v02-premium.swf

Opens the file in headless Chromium (Playwright, browser in tools/ms-playwright/)
on the local Ruffle page, and takes a screenshot every second until the title
screen's blue PEACEFREE logo shows, or 60 s pass. The last screenshot is saved
in screenshots/. Requests to other sites are blocked and listed, so the check
works offline and shows which network calls the game makes.

With --premium it opens the game with its own show_premium=true flashvar, which
starts on the campaign screen, and passes when the screen's top button is the
Shop (premium unlocked); it fails at once on the gold Premium button (locked).
"""

import argparse
import os
import re
import sys
import time
from io import BytesIO
from pathlib import Path

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


def main() -> int:
    parser = argparse.ArgumentParser(description="Check that a .swf gets past the loading screen in Ruffle (headless).")
    parser.add_argument("swf", type=Path, help="the .swf file, for example patched/PeacefreeKong-v01-fpsmeter.swf")
    parser.add_argument("--premium", action="store_true", help="check that premium is unlocked instead")
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
    screenshot = SCREENSHOTS / f"check-{swf.stem}{'-premium' if args.premium else ''}.png"
    blocked: list[str] = []
    ruffle_log: list[str] = []
    png = b""
    locked = False
    previous = ""  # --premium: what the last screenshot showed, "shop", "locked" or ""

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
    try:
        with sync_playwright() as playwright:
            browser = playwright.chromium.launch()
            page = browser.new_page(viewport={"width": 840, "height": 580})
            page.route(lambda u: not u.startswith(url), block)
            page.on("console", log)
            start = time.monotonic()
            page.goto(url + ("?show_premium=true" if args.premium else ""))
            passed = False
            while not passed and not locked and time.monotonic() - start < TIMEOUT_SECONDS:
                page.wait_for_timeout(1000)  # unlike time.sleep, Playwright keeps handling requests meanwhile
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
                else:
                    passed = share(png, LOGO_AREA, is_logo_blue) >= MIN_LOGO_BLUE
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
    if passed and args.premium:
        print(f"PASS: {swf.name} shows the Shop button (premium unlocked) after {seconds:.0f} s (screenshot: {shown})")
        return 0
    if passed:
        print(f"PASS: {swf.name} shows the title screen after {seconds:.0f} s (screenshot: {shown})")
        return 0
    if locked:
        print(f"FAIL: {swf.name} shows the gold Premium button: premium is locked (screenshot: {shown})", file=sys.stderr)
        return 1
    screen = "Shop or Premium button" if args.premium else "title screen"
    print(f"FAIL: no {screen} after {TIMEOUT_SECONDS} s (last screenshot: {shown})", file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
