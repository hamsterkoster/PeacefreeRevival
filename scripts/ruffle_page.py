"""A local web page that plays one .swf in Ruffle's web version (tools/ruffle/web/).

Used by play.py (opens it in your browser) and check.py (headless screenshot).
The server listens on 127.0.0.1 only and serves three things: the page at /,
the .swf at /game.swf, and the Ruffle files from tools/ruffle/web/.
"""

import threading
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from typing import ClassVar

from decompile import ROOT

RUFFLE_WEB = ROOT / "tools" / "ruffle" / "web"

# 800x540 is the game's stage size; Kongregate shows it at that size too.
PAGE = """<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>{title}</title>
<style>
html, body {{ margin: 0; background: #222; }}
#game {{ width: 800px; height: 540px; margin: 20px auto; }}
</style>
<script>
window.RufflePlayer = {{ config: {{ autoplay: "on", unmuteOverlay: "hidden", splashScreen: false }} }};
</script>
<script src="/ruffle.js"></script>
</head>
<body>
<div id="game"></div>
<script>
const player = window.RufflePlayer.newest().createPlayer();
player.style.width = "800px";
player.style.height = "540px";
document.getElementById("game").appendChild(player);
// The page's query string becomes the game's flashvars, for example ?show_premium=true.
player.ruffle().load({{ url: "/game.swf", parameters: location.search }});
</script>
</body>
</html>
"""


class Handler(SimpleHTTPRequestHandler):
    extensions_map: ClassVar = {**SimpleHTTPRequestHandler.extensions_map, ".wasm": "application/wasm"}

    def __init__(self, *args, swf: Path, **kwargs):
        self.swf = swf
        super().__init__(*args, directory=str(RUFFLE_WEB), **kwargs)

    def do_GET(self):
        path = self.path.split("?")[0]
        if path == "/":
            self.send_bytes(PAGE.format(title=self.swf.name).encode("utf-8"), "text/html; charset=utf-8")
        elif path == "/game.swf":
            self.send_bytes(self.swf.read_bytes(), "application/x-shockwave-flash")
        else:
            super().do_GET()

    def send_bytes(self, body: bytes, content_type: str):
        self.send_response(200)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):  # keep the console quiet
        pass


def start_server(swf: Path) -> tuple[ThreadingHTTPServer, str]:
    """Serve the page for swf on a free port in a background thread; returns the server and its URL."""
    if not (RUFFLE_WEB / "ruffle.js").is_file():
        raise FileNotFoundError(f"Ruffle's web version is missing: unzip it into {RUFFLE_WEB}")
    server = ThreadingHTTPServer(("127.0.0.1", 0), partial(Handler, swf=swf.resolve()))
    threading.Thread(target=server.serve_forever, daemon=True).start()
    return server, f"http://127.0.0.1:{server.server_address[1]}/"


def stop_server(server: ThreadingHTTPServer):
    server.shutdown()
    server.server_close()
