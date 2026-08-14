#!/usr/bin/env python3
"""Verify pinned Carbon icon sources and generated Flutter artifacts."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
import sys
from typing import Any


PACKAGE_ROOT = Path(__file__).resolve().parents[2]
REFERENCE_ROOT = PACKAGE_ROOT / "reference" / "carbon_icons_11_86_0"
ICONS_ROOT = REFERENCE_ROOT / "icons"
MANIFEST_PATH = REFERENCE_ROOT / "manifest.json"
GENERATED_ROOT = PACKAGE_ROOT / "lib" / "src" / "icons" / "generated"
EXPECTED_ICON_COUNT = 34
EXPECTED_UPSTREAM = {
    "name": "Carbon Icons",
    "package": "@carbon/icons",
    "version": "11.86.0",
    "integrity": "sha512-EWrCD+58w3BSzwB2wFG3sk5Dzm09oZHNX0N0CKgnmMx/rPHY5jO1/Zdue04h6oL53y3iSYPtv31BtHNYpatsgw==",
    "tarball": "https://registry.npmjs.org/@carbon/icons/-/icons-11.86.0.tgz",
    "repository": "https://github.com/carbon-design-system/carbon",
    "sourceDirectory": "svg/32",
    "license": "Apache-2.0",
    "licenseSha256": "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30",
}


class VerificationError(Exception):
    pass


def _require(condition: bool, message: str) -> None:
    if not condition:
        raise VerificationError(message)


def _sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def _load_json(path: Path) -> dict[str, Any]:
    _require(path.is_file(), f"Missing {path.relative_to(PACKAGE_ROOT)}")
    value = json.loads(path.read_text(encoding="utf-8"))
    _require(isinstance(value, dict), f"Expected an object in {path}")
    return value


def _source_inventory() -> tuple[list[dict[str, Any]], str]:
    paths = sorted(ICONS_ROOT.glob("*.svg"), key=lambda path: path.name)
    _require(
        len(paths) == EXPECTED_ICON_COUNT,
        f"Expected {EXPECTED_ICON_COUNT} Carbon SVGs, found {len(paths)}",
    )

    tree = hashlib.sha256()
    entries: list[dict[str, Any]] = []
    for path in paths:
        relative_path = f"icons/{path.name}"
        contents = path.read_bytes()
        tree.update(relative_path.encode("utf-8"))
        tree.update(b"\0")
        tree.update(contents)
        tree.update(b"\0")
        entries.append(
            {
                "path": relative_path,
                "sha256": _sha256(contents),
                "bytes": len(contents),
            }
        )
    return entries, tree.hexdigest()


def _manifest() -> dict[str, Any]:
    entries, tree_sha256 = _source_inventory()
    return {
        "schemaVersion": 1,
        "upstream": EXPECTED_UPSTREAM,
        "scope": "Official 32 px glyphs used internally by Carbon components",
        "integrity": {
            "algorithm": "SHA-256 over sorted path + NUL + bytes + NUL",
            "fileCount": len(entries),
            "treeSha256": tree_sha256,
            "files": entries,
        },
    }


def write_manifest() -> None:
    MANIFEST_PATH.write_text(
        json.dumps(_manifest(), indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    print(f"Wrote {MANIFEST_PATH.relative_to(PACKAGE_ROOT)}")


def verify_sources() -> dict[str, str]:
    actual = _manifest()
    committed = _load_json(MANIFEST_PATH)
    _require(
        committed == actual,
        "Vendored Carbon icon source does not match manifest.json",
    )
    return {
        entry["path"].removeprefix("icons/"): entry["sha256"]
        for entry in committed["integrity"]["files"]
    }


def verify_generated(source_hashes: dict[str, str]) -> None:
    owner = _load_json(GENERATED_ROOT / ".glyphpact.json")
    _require(
        owner == {"schemaVersion": 1, "owner": "glyphpact"},
        "Invalid ownership marker",
    )

    lock = _load_json(GENERATED_ROOT / "iconfont.lock.json")
    expected_lock = {
        "generatorVersion": "1.1.0",
        "fontFamily": "CarbonIcons",
        "className": "CarbonIcons",
        "fontPackage": "carbon",
        "startCodepoint": "0xE000",
    }
    for key, value in expected_lock.items():
        _require(lock.get(key) == value, f"Unexpected lock {key}")
    lock_glyphs = lock.get("glyphs", [])
    _require(
        len(lock_glyphs) == EXPECTED_ICON_COUNT,
        f"Expected {EXPECTED_ICON_COUNT} locked glyphs, found {len(lock_glyphs)}",
    )
    _require(
        {glyph["source"]: glyph["sourceSha256"] for glyph in lock_glyphs}
        == source_hashes,
        "Generated lock does not match vendored source hashes",
    )

    report = _load_json(GENERATED_ROOT / "iconfont.report.json")
    expected_report = {
        "schemaVersion": 3,
        "generator": "glyphpact",
        "generatorVersion": "1.1.0",
        "status": "success",
        "quality": "lossless",
        "discoveredIconCount": EXPECTED_ICON_COUNT,
        "glyphCount": EXPECTED_ICON_COUNT,
        "losslessGlyphCount": EXPECTED_ICON_COUNT,
        "approximatedGlyphCount": 0,
        "skippedIconCount": 0,
        "issueCount": 0,
    }
    for key, value in expected_report.items():
        _require(report.get(key) == value, f"Unexpected report {key}")
    _require(
        report.get("policy") == {"lossy": "error", "unrepresentable": "error"},
        "Unexpected conversion policy",
    )
    _require(report.get("issues") == [], "Carbon icon conversion reported issues")

    font = report.get("font", {})
    font_path = GENERATED_ROOT / str(font.get("file"))
    _require(font_path.is_file(), "Missing generated CarbonIcons font")
    font_contents = font_path.read_bytes()
    _require(font.get("sha256") == _sha256(font_contents), "Generated font hash drift")
    _require(font.get("bytes") == len(font_contents), "Generated font size drift")

    dart_path = GENERATED_ROOT / "carbon_icons.dart"
    _require(dart_path.is_file(), "Missing generated Dart icon provider")
    dart = dart_path.read_text(encoding="utf-8")
    _require("@flutter.staticIconProvider" in dart, "Provider must be tree-shakable")
    _require("abstract final class CarbonIcons" in dart, "Missing CarbonIcons class")
    declarations = len(
        re.findall(r"static const flutter\.IconData \w+ = flutter\.IconData\(", dart)
    )
    _require(
        declarations == EXPECTED_ICON_COUNT,
        f"Expected {EXPECTED_ICON_COUNT} IconData constants, found {declarations}",
    )
    _require("Map<String" not in dart, "Runtime icon maps defeat font tree shaking")

    public_export = (PACKAGE_ROOT / "lib" / "src" / "icons" / "icons.dart").read_text(
        encoding="utf-8"
    )
    _require(
        "export 'generated/carbon_icons.dart';" in public_export,
        "Missing generated-provider export",
    )
    library = (PACKAGE_ROOT / "lib" / "carbon.dart").read_text(encoding="utf-8")
    _require("export 'src/icons/icons.dart';" in library, "CarbonIcons is not exported")
    pubspec = (PACKAGE_ROOT / "pubspec.yaml").read_text(encoding="utf-8")
    _require("family: CarbonIcons" in pubspec, "CarbonIcons font is not registered")
    _require(
        "lib/src/icons/generated/fonts/CarbonIcons.otf" in pubspec,
        "CarbonIcons font asset is not registered",
    )
    notice = (PACKAGE_ROOT / "NOTICE").read_text(encoding="utf-8")
    _require(
        "Carbon Icons 11.86.0" in notice and "Apache License" in notice,
        "Missing Carbon Icons notice",
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--write-manifest",
        action="store_true",
        help="Replace manifest.json with hashes for the vendored snapshot",
    )
    args = parser.parse_args()

    try:
        if args.write_manifest:
            write_manifest()
            return 0
        source_hashes = verify_sources()
        verify_generated(source_hashes)
    except (OSError, KeyError, TypeError, ValueError, VerificationError) as error:
        print(f"Carbon icon verification failed: {error}", file=sys.stderr)
        return 1

    print("Carbon icon artifacts verified: 34 official glyphs, all lossless.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
