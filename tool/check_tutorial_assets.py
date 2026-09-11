"""Check the tutorial's recorded assets and downloadable source without extraction.

Run from any directory with Python 3; no third-party packages are required.
This verifies recorded evidence, not a fresh Flutter replay or visual review.
"""

import hashlib
import json
from pathlib import Path
import re
import zipfile

from prepare_docs_site import SOURCE_TAG


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
    recorded = json.loads((root / "docs/assets/remix-cli-tutorial/code-evidence.json").read_text())
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
        expected = recorded.get(block_id, {})
        if expected.get("language") != language or expected.get("sha256") != hashlib.sha256(code.encode()).hexdigest():
            failures.append(f"Native tutorial code block {block_id} differs from recorded evidence")
    if {block[0] for block in blocks} != set(recorded):
        failures.append("Native tutorial is missing a recorded code block")
    expected_sources = {(preset, file) for preset in ["default", "fortal"]
                        for file in ["lib/main.dart", "test/workflow_test.dart"]}
    if set(SOURCE_TAG.findall(source)) != expected_sources:
        failures.append("Tutorial must include both complete applications and both test files")
    if "<TutorialSource" in SOURCE_TAG.sub("", source):
        failures.append("Unsupported tutorial source include")

    # The capture pin describes the evidence, not the latest branch head.
    evidence = json.loads((root / "docs/assets/remix-cli-tutorial/evidence.json").read_text())
    # The checkout command remains pinned to the original capture.
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
    return failures


def main():
    root = Path(__file__).resolve().parents[1]
    failures = check_assets(root) + check_content(root)

    if failures:
        raise SystemExit("Tutorial asset drift:\n" + "\n".join(failures))
    print("Tutorial assets, sample sources, native code excerpts, checkout pin, and content links passed.")


if __name__ == "__main__":
    main()
