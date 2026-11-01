"""Play a .swf in Ruffle's web version (tools/ruffle/web/) in your default browser.

Run from the project folder:
    .venv/Scripts/python scripts/play.py patched/PeacefreeKong-v01-fpsmeter.swf
    .venv/Scripts/python scripts/play.py --renderer webgpu patched/PeacefreeKong-v01-fpsmeter.swf

Starts a small web server on this PC only (127.0.0.1) and opens the page.
The page shows the renderer Ruffle used under the game. Stop it with Ctrl+C in the terminal.
"""

import argparse
import sys
import time
import webbrowser
from pathlib import Path

from ruffle_page import RENDERERS, start_server, stop_server


def main() -> int:
    parser = argparse.ArgumentParser(description="Play a .swf in Ruffle's web version in your browser.")
    parser.add_argument("swf", type=Path, help="the .swf file, for example patched/PeacefreeKong-v01-fpsmeter.swf")
    parser.add_argument("--renderer", choices=RENDERERS, help="the renderer Ruffle tries first (default: Ruffle's own order, wgpu-webgl first)")
    args = parser.parse_args()
    if not args.swf.is_file():
        print(f"error: file not found: {args.swf}", file=sys.stderr)
        return 1

    try:
        server, url = start_server(args.swf, args.renderer)
    except FileNotFoundError as error:
        print(f"error: {error}", file=sys.stderr)
        return 1
    print(f"Playing {args.swf.name} at {url}")
    print("Press Ctrl+C here to stop.")
    webbrowser.open(url)
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        pass
    finally:
        stop_server(server)
    return 0


if __name__ == "__main__":
    sys.exit(main())
