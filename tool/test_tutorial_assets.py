"""Regression tests for the recorded-evidence and documentation drift gate."""

import json
from pathlib import Path
import shutil
import tempfile
import unittest

from check_tutorial_assets import check_assets, check_content, TutorialCode


class TutorialAssetTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        source = Path(__file__).resolve().parents[1]
        # Isolate mutations from the user's checkout and preserve real fixtures.
        shutil.copytree(source / "docs", self.root / "docs")

    def test_reviewed_content_and_assets_pass(self):
        self.assertEqual(check_assets(self.root) + check_content(self.root), [])

    def test_screenshot_corruption_fails(self):
        assets = self.root / "docs/assets/remix-cli-tutorial"
        evidence = json.loads((assets / "evidence.json").read_text())
        (assets / evidence["screenshots"][0]["file"]).write_bytes(b"changed")
        self.assertTrue(any("SHA-256 differs" in error for error in check_assets(self.root)))

    def test_archived_source_hash_drift_fails(self):
        path = self.root / "docs/assets/remix-cli-tutorial/evidence.json"
        evidence = json.loads(path.read_text())
        evidence["source"][0]["main_sha256"] = "0" * 64
        path.write_text(json.dumps(evidence))
        self.assertTrue(any("main.dart" in error for error in check_assets(self.root)))

    def test_native_command_drift_fails(self):
        path = self.root / "docs/tutorials/settings-screen.mdx"
        path.write_text(path.read_text().replace("--dry-run", "--overwrite"))
        self.assertTrue(any("code block" in error for error in check_content(self.root)))

    def test_missing_download_fails(self):
        (self.root / "docs/assets/remix-cli-tutorial/sample-projects.zip").unlink()
        self.assertTrue(any("sample-projects.zip" in error for error in check_content(self.root)))

    def test_no_excerpts_cannot_pass(self):
        path = self.root / "docs/tutorials/settings-screen.mdx"
        path.write_text("---\ntitle: Empty\n---\n")
        self.assertTrue(any("no checked code blocks" in error for error in check_content(self.root)))

    def test_unmarked_excerpt_fails(self):
        path = self.root / "docs/tutorials/settings-screen.mdx"
        path.write_text(path.read_text().replace("{/* tutorial-source: preview-button */}", ""))
        self.assertTrue(any("needs a tutorial-source marker" in error for error in check_content(self.root)))

    def test_capture_pin_drift_fails(self):
        path = self.root / "docs/assets/remix-cli-tutorial/evidence.json"
        evidence = json.loads(path.read_text())
        evidence["source_checkout"] = "0" * 40
        path.write_text(json.dumps(evidence))
        self.assertTrue(any("checkout pin" in error for error in check_content(self.root)))

    def test_broken_offline_section_fails(self):
        path = self.root / "docs/tutorials/settings-screen.mdx"
        path.write_text(path.read_text().replace(".html#compose", ".html#missing-section"))
        self.assertTrue(any("missing HTML anchor" in error for error in check_content(self.root)))

    def test_parser_decodes_entities_and_keeps_literal_code(self):
        parser = TutorialCode()
        parser.feed('<code>ignore</code><figure id="example"><pre><code class="language-dart">a &lt; b &amp;&amp; c</code></pre></figure>')
        self.assertEqual(parser.blocks, {"example": ("dart", "a < b && c")})


if __name__ == "__main__":
    unittest.main()
