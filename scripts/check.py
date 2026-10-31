"""Slow check: does a .swf get past the loading screen in Ruffle's web version?

Run from the project folder:
    .venv/Scripts/python scripts/check.py patched/PeacefreeKong-v01-fpsmeter.swf

Opens the file in headless Chromium (Playwright, browser in tools/ms-playwright/)
on the local Ruffle page, and takes a screenshot every second until the title
screen's blue PEACEFREE logo shows, or 60 s pass. The last screenshot is saved
in screenshots/. Requests to other sites are blocked and listed, so the check
works offline and shows which network calls the game makes.
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


def logo_blue_share(png: bytes) -> float:
    """Share of pixels in LOGO_AREA that are the logo's blue."""
    pixels = Image.open(BytesIO(png)).convert("RGB").crop(LOGO_AREA).get_flattened_data()
    blue = sum(1 for r, _g, b in pixels if b > 180 and r < 120)
    return blue / len(pixels)


def main() -> int:
    parser = argparse.ArgumentParser(description="Check that a .swf gets past the loading screen in Ruffle (headless).")
    parser.add_argument("swf", type=Path, help="the .swf file, for example patched/PeacefreeKong-v01-fpsmeter.swf")
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
    screenshot = SCREENSHOTS / f"check-{swf.stem}.png"
    blocked: list[str] = []
    ruffle_log: list[str] = []
    png = b""

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
            page.goto(url)
            passed = False
            while not passed and time.monotonic() - start < TIMEOUT_SECONDS:
                page.wait_for_timeout(1000)  # unlike time.sleep, Playwright keeps handling requests meanwhile
                try:
                    png = page.locator("ruffle-player").screenshot(timeout=5000)
                except PlaywrightError:  # no player on the page (yet): try again until the time is up
                    continue
                passed = logo_blue_share(png) >= MIN_LOGO_BLUE
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
    if passed:
        print(f"PASS: {swf.name} shows the title screen after {seconds:.0f} s (screenshot: {shown})")
        return 0
    print(f"FAIL: no title screen after {TIMEOUT_SECONDS} s (last screenshot: {shown})", file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
