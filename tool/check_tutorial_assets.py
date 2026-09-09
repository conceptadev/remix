"""Check the tutorial's recorded assets and downloadable source without extraction.

Run from any directory with Python 3; no third-party packages are required.
This verifies recorded evidence, not a fresh Flutter replay or visual review.
"""

import hashlib
from html.parser import HTMLParser
import json
from pathlib import Path
import re
import zipfile


class TutorialCode(HTMLParser):
    """Read literal pre/code blocks, decoding HTML entities once."""

    def __init__(self):
        super().__init__()
        self.in_pre = False
        self.language = None
        self.text = []
        self.figure = None
        self.blocks = {}

    def handle_starttag(self, tag, attrs):
        if tag == "figure":
            self.figure = dict(attrs).get("id")
        if tag == "pre":
            self.in_pre = True
        if tag == "code" and self.in_pre:
            classes = dict(attrs).get("class", "").split()
            self.language = next(
                (name.removeprefix("language-") for name in classes
                 if name.startswith("language-")), "text")
            self.text = []

    def handle_data(self, data):
        if self.language is not None:
            self.text.append(data)

    def handle_endtag(self, tag):
        if tag == "code" and self.language is not None:
            language = "text" if self.language == "none" else self.language
            if self.figure:
                self.blocks[self.figure] = (language, "".join(self.text))
            self.language = None
        if tag == "pre":
            self.in_pre = False
        if tag == "figure":
            self.figure = None


def check_assets(root):
    assets = root / "docs/assets/remix-cli-tutorial"
    evidence = json.loads((assets / "evidence.json").read_text())
    failures = []

    def check(label, data, expected):
        if hashlib.sha256(data).hexdigest() != expected:
            failures.append(f"{label}: SHA-256 differs from evidence.json")

    for screenshot in evidence["screenshots"]:
        data = (assets / screenshot["file"]).read_bytes()
        check(screenshot["file"], data, screenshot["sha256"])
        if len(data) != screenshot["bytes"]:
            failures.append(f"{screenshot['file']}: recorded size differs")

    archive = assets / "sample-projects.zip"
    check(archive.name, archive.read_bytes(), evidence["archive_sha256"])
    with zipfile.ZipFile(archive) as samples:
        for source in evidence["source"]:
            prefix = source["preset"] + "_demo/"
            for path, key in (("lib/main.dart", "main_sha256"),
                              ("test/workflow_test.dart", "test_sha256")):
                check(prefix + path, samples.read(prefix + path), source[key])

    return failures


def check_content(root):
    failures = []
    offline = TutorialCode()
    offline.feed((root / "docs/remix-cli-tutorial.html").read_text())
    native = root / "docs/tutorials/settings-screen.mdx"
    source = native.read_text()
    blocks = re.findall(
        r"\{/\* tutorial-source: ([\w-]+) \*/\}\n\n```(\w+)\n([\s\S]*?)\n```",
        source,
    )
    if not blocks:
        failures.append("Native tutorial has no checked code blocks")
    if len(blocks) != len(re.findall(r"^```\w+", source, re.MULTILINE)):
        failures.append("Every native tutorial code block needs a tutorial-source marker")
    for block_id, language, code in blocks:
        if offline.blocks.get(block_id) != (language, code):
            failures.append(f"Native tutorial code block {block_id} differs from the offline tutorial")

    # The capture pin describes the evidence, not the latest branch head.
    evidence = json.loads((root / "docs/assets/remix-cli-tutorial/evidence.json").read_text())
    # The first checkout command in the reviewed HTML is the reproducibility pin.
    pin = re.search(r"git -C remix-review checkout ([a-f0-9]{40})", source)
    if not pin or pin.group(1) != evidence["source_checkout"]:
        failures.append("Native tutorial checkout pin differs from recorded evidence")

    for page in [native, root / "docs/index.mdx", root / "docs/getting-started.mdx",
                 root / "docs/guides/styling-components.mdx"]:
        for href in re.findall(r"\]\((/[^)]+)\)", page.read_text()):
            path = href.split("#", 1)[0].split("?", 1)[0]
            target = root / "docs" / path.lstrip("/")
            if path == "/":
                target = target / "index.mdx"
            elif not target.suffix:
                target = target.with_suffix(".mdx")
            if not target.is_file():
                failures.append(f"{page.relative_to(root)}: missing link target {href}")
            elif target.suffix == ".html" and "#" in href:
                anchor = href.split("#", 1)[1]
                if anchor not in re.findall(r'\bid="([^"]+)"', target.read_text()):
                    failures.append(f"{page.relative_to(root)}: missing HTML anchor {href}")
    return failures


def main():
    root = Path(__file__).resolve().parents[1]
    failures = check_assets(root) + check_content(root)

    if failures:
        raise SystemExit("Tutorial asset drift:\n" + "\n".join(failures))
    print("Tutorial assets, sample sources, native code excerpts, checkout pin, and content links passed.")


if __name__ == "__main__":
    main()
