#!/usr/bin/env python3
"""Verify the pinned Radix inputs and generated Fortal icon artifacts."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
import sys
from typing import Any


PACKAGE_ROOT = Path(__file__).resolve().parents[2]
REFERENCE_ROOT = PACKAGE_ROOT / "reference" / "radix_icons_1_3_2"
ICONS_ROOT = REFERENCE_ROOT / "icons"
MANIFEST_PATH = REFERENCE_ROOT / "manifest.json"
GENERATED_ROOT = PACKAGE_ROOT / "lib" / "src" / "radix" / "icons" / "generated"

EXPECTED_UPSTREAM = {
    "name": "Radix Icons",
    "package": "@radix-ui/react-icons",
    "version": "1.3.2",
    "tag": "@radix-ui/react-icons@1.3.2",
    "commit": "bde33b13aa5848555f5512ac12155930fb4beb7d",
    "repository": "https://github.com/radix-ui/icons",
    "sourceDirectory": "packages/radix-icons/icons",
    "sourceTreeSha256": "b12ed033c1bba5dfadf339291f9fb48bd5650cb7269c542cb131c8037ec9445c",
    "license": "MIT",
}
EXPECTED_APPROXIMATIONS = {
    "shadow-inner.svg",
    "shadow-none.svg",
    "shadow-outer.svg",
    "shadow.svg",
    "transparency-grid.svg",
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
    _require(len(paths) == 318, f"Expected 318 Radix SVGs, found {len(paths)}")

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
    license_path = REFERENCE_ROOT / "LICENSE"
    _require(license_path.is_file(), "Missing vendored Radix LICENSE")
    license_contents = license_path.read_bytes()
    return {
        "schemaVersion": 1,
        "upstream": {
            **EXPECTED_UPSTREAM,
            "licenseSha256": _sha256(license_contents),
        },
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
        "Vendored Radix source does not match manifest.json; restore the pinned "
        "snapshot or explicitly regenerate the manifest",
    )

    upstream = committed["upstream"]
    for key, value in EXPECTED_UPSTREAM.items():
        _require(upstream.get(key) == value, f"Unexpected upstream {key}")

    return {
        entry["path"].removeprefix("icons/"): entry["sha256"]
        for entry in committed["integrity"]["files"]
    }


def verify_generated(source_hashes: dict[str, str]) -> None:
    owner = _load_json(GENERATED_ROOT / ".glyphpact.json")
    _require(owner == {"schemaVersion": 1, "owner": "glyphpact"}, "Invalid ownership marker")

    lock = _load_json(GENERATED_ROOT / "iconfont.lock.json")
    _require(lock.get("generatorVersion") == "1.1.0", "Unexpected lock generator")
    _require(lock.get("fontFamily") == "FortalIcons", "Unexpected lock font family")
    _require(lock.get("className") == "FortalIcons", "Unexpected lock class")
    _require(lock.get("fontPackage") == "remix_fortal", "Unexpected lock package")
    _require(lock.get("startCodepoint") == "0xE000", "Unexpected first codepoint")
    lock_glyphs = lock.get("glyphs", [])
    _require(len(lock_glyphs) == 318, f"Expected 318 locked glyphs, found {len(lock_glyphs)}")
    _require(
        {glyph["source"]: glyph["sourceSha256"] for glyph in lock_glyphs}
        == source_hashes,
        "Generated lock does not match vendored source hashes",
    )

    report = _load_json(GENERATED_ROOT / "iconfont.report.json")
    expected_report_values = {
        "schemaVersion": 3,
        "generator": "glyphpact",
        "generatorVersion": "1.1.0",
        "status": "success",
        "quality": "approximated",
        "discoveredIconCount": 318,
        "glyphCount": 318,
        "losslessGlyphCount": 313,
        "approximatedGlyphCount": 5,
        "skippedIconCount": 0,
        "issueCount": 5,
    }
    for key, value in expected_report_values.items():
        _require(report.get(key) == value, f"Unexpected report {key}: {report.get(key)!r}")
    _require(
        report.get("policy") == {"lossy": "convert", "unrepresentable": "error"},
        "Unexpected conversion policy",
    )
    issues = report.get("issues", [])
    _require(
        {issue.get("source") for issue in issues} == EXPECTED_APPROXIMATIONS,
        "The approved approximation set changed",
    )
    _require(
        all(issue.get("code") == "SVG_PARTIAL_ALPHA_APPROXIMATED" for issue in issues),
        "An unapproved conversion issue was reported",
    )

    font = report.get("font", {})
    font_path = GENERATED_ROOT / str(font.get("file"))
    _require(font_path.is_file(), "Missing generated FortalIcons font")
    font_contents = font_path.read_bytes()
    _require(font.get("sha256") == _sha256(font_contents), "Generated font hash drift")
    _require(font.get("bytes") == len(font_contents), "Generated font byte count drift")

    dart_path = GENERATED_ROOT / "fortal_icons.dart"
    _require(dart_path.is_file(), "Missing generated Dart icon provider")
    dart = dart_path.read_text(encoding="utf-8")
    _require("@flutter.staticIconProvider" in dart, "FortalIcons must be a static icon provider")
    _require("abstract final class FortalIcons" in dart, "Missing FortalIcons class")
    _require("static const flutter.IconData switchIcon" in dart, "Missing switchIcon collision rename")
    declaration_count = len(
        re.findall(r"static const flutter\.IconData \w+ = flutter\.IconData\(", dart)
    )
    _require(declaration_count == 318, f"Expected 318 IconData constants, found {declaration_count}")
    _require("Map<String" not in dart, "Runtime icon lookup maps defeat font tree shaking")
    _require("Catalog" not in dart, "Runtime icon catalogs must remain disabled")

    public_export = (PACKAGE_ROOT / "lib" / "src" / "radix" / "icons.dart").read_text(
        encoding="utf-8"
    )
    _require(
        "export 'icons/generated/fortal_icons.dart';" in public_export,
        "Missing generated-provider export",
    )
    _require(
        "icons_index" not in public_export and "fortalIconsByName" not in public_export,
        "Opt-in icons index must not be re-exported from the icons barrel",
    )
    library = (PACKAGE_ROOT / "lib" / "remix_fortal.dart").read_text(encoding="utf-8")
    _require("export 'src/radix/icons.dart';" in library, "FortalIcons is not publicly exported")
    _require(
        "icons_index" not in library and "fortalIconsByName" not in library,
        "Opt-in icons index must not be exported from remix_fortal.dart",
    )
    pubspec = (PACKAGE_ROOT / "pubspec.yaml").read_text(encoding="utf-8")
    _require("family: FortalIcons" in pubspec, "FortalIcons family is not registered")
    _require(
        "lib/src/radix/icons/generated/fonts/FortalIcons.otf" in pubspec,
        "FortalIcons font asset is not registered",
    )
    notice = (PACKAGE_ROOT / "THIRD_PARTY_NOTICES.md").read_text(encoding="utf-8")
    _require("Radix Icons 1.3.2" in notice and "MIT License" in notice, "Missing Radix notice")

    _verify_icons_index(report)


def _verify_icons_index(report: dict[str, Any]) -> None:
    # Import is local so `python verify.py --write-manifest` does not need the
    # generator module on sys.path until generated artifacts are checked.
    tool_dir = Path(__file__).resolve().parent
    if str(tool_dir) not in sys.path:
        sys.path.insert(0, str(tool_dir))
    from generate_icons_index import (  # noqa: PLC0415
        INDEX_PATH,
        check_artifacts,
        load_glyph_names,
    )

    check_artifacts()
    names = load_glyph_names()
    _require(names == [glyph["name"] for glyph in report["glyphs"]], "Index names drifted from the report")
    index = INDEX_PATH.read_text(encoding="utf-8")
    _require("const Map<String, IconData> fortalIconsByName" in index, "Missing fortalIconsByName")
    _require(
        "import 'package:remix_fortal/remix_fortal.dart'" not in index,
        "Index must not import the main library",
    )
    for name in names:
        _require(
            f"'{name}': FortalIcons.{name}" in index,
            f"Index is missing FortalIcons.{name}",
        )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--write-manifest",
        action="store_true",
        help="Replace manifest.json with hashes for the current vendored snapshot",
    )
    args = parser.parse_args()

    try:
        if args.write_manifest:
            write_manifest()
            return 0
        source_hashes = verify_sources()
        verify_generated(source_hashes)
    except (OSError, KeyError, TypeError, ValueError, VerificationError) as error:
        print(f"Fortal icon verification failed: {error}", file=sys.stderr)
        return 1

    print("Fortal icon artifacts verified: 318 glyphs, 313 lossless, 5 approved approximations.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
