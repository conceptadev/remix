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

from prepare import (
    EXPECTED_ICON_COUNT,
    FALLBACK_WRAPPER_FILES,
    FALLBACK_WRAPPER_TRANSFORM,
    PREPARED_ROOT,
    PreparationError,
    expected_prepared_sources,
)


PACKAGE_ROOT = Path(__file__).resolve().parents[2]
REFERENCE_ROOT = PACKAGE_ROOT / "reference" / "carbon_icons_11_86_0"
ICONS_ROOT = REFERENCE_ROOT / "icons"
MANIFEST_PATH = REFERENCE_ROOT / "manifest.json"
GENERATED_ROOT = PACKAGE_ROOT / "lib" / "src" / "icons" / "generated"
UPSTREAM_ROOT = Path(__file__).resolve().parent / "upstream"
UPSTREAM_PACKAGE_ROOT = UPSTREAM_ROOT / "node_modules" / "@carbon" / "icons"
EXPECTED_UPSTREAM = {
    "name": "Carbon Icons",
    "package": "@carbon/icons",
    "version": "11.86.0",
    "integrity": "sha512-EWrCD+58w3BSzwB2wFG3sk5Dzm09oZHNX0N0CKgnmMx/rPHY5jO1/Zdue04h6oL53y3iSYPtv31BtHNYpatsgw==",
    "tarball": "https://registry.npmjs.org/@carbon/icons/-/icons-11.86.0.tgz",
    "repository": "https://github.com/carbon-design-system/carbon",
    "commit": "188d23202ec1092322dee92cf0df9d9958224ae4",
    "sourceDirectory": "svg/32",
    "license": "Apache-2.0",
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


def _verify_upstream_lock() -> None:
    package_json = _load_json(UPSTREAM_ROOT / "package.json")
    _require(
        package_json.get("name") == "remix-carbon-icons-upstream",
        "Unexpected upstream npm workspace name",
    )
    dependencies = package_json.get("dependencies")
    _require(isinstance(dependencies, dict), "Missing upstream dependencies")
    _require(
        dependencies.get("@carbon/icons") == EXPECTED_UPSTREAM["version"],
        "@carbon/icons must be pinned to the exact verified version",
    )

    package_lock = _load_json(UPSTREAM_ROOT / "package-lock.json")
    packages = package_lock.get("packages")
    _require(isinstance(packages, dict), "Missing npm lock packages")
    root_lock = packages.get("")
    _require(isinstance(root_lock, dict), "Missing npm root lock entry")
    locked_dependencies = root_lock.get("dependencies")
    _require(isinstance(locked_dependencies, dict), "Missing locked dependencies")
    _require(
        locked_dependencies.get("@carbon/icons") == EXPECTED_UPSTREAM["version"],
        "npm root lock does not pin @carbon/icons",
    )

    icon_lock = packages.get("node_modules/@carbon/icons")
    _require(isinstance(icon_lock, dict), "Missing locked @carbon/icons package")
    expected_lock = {
        "version": EXPECTED_UPSTREAM["version"],
        "resolved": EXPECTED_UPSTREAM["tarball"],
        "integrity": EXPECTED_UPSTREAM["integrity"],
        "license": EXPECTED_UPSTREAM["license"],
    }
    for key, value in expected_lock.items():
        _require(icon_lock.get(key) == value, f"Unexpected @carbon/icons lock {key}")


def _source_inventory() -> tuple[list[dict[str, Any]], str, dict[str, bytes]]:
    prepared_sources = expected_prepared_sources()
    _require(
        len(prepared_sources) == EXPECTED_ICON_COUNT,
        f"Expected {EXPECTED_ICON_COUNT} prepared SVGs",
    )

    tree = hashlib.sha256()
    entries: list[dict[str, Any]] = []
    for relative_path in sorted(prepared_sources):
        path = ICONS_ROOT / relative_path
        _require(path.is_file(), f"Missing vendored icon {relative_path}")
        contents = path.read_bytes()
        manifest_path = f"icons/{relative_path}"
        tree.update(manifest_path.encode("utf-8"))
        tree.update(b"\0")
        tree.update(contents)
        tree.update(b"\0")
        entries.append(
            {
                "path": manifest_path,
                "sha256": _sha256(contents),
                "bytes": len(contents),
            }
        )
    return entries, tree.hexdigest(), prepared_sources


def _manifest() -> dict[str, Any]:
    entries, tree_sha256, prepared_sources = _source_inventory()
    license_path = REFERENCE_ROOT / "LICENSE"
    _require(license_path.is_file(), "Missing vendored Carbon Icons LICENSE")
    license_contents = license_path.read_bytes()
    transforms = []
    for relative_path in sorted(FALLBACK_WRAPPER_FILES):
        source_contents = (ICONS_ROOT / relative_path).read_bytes()
        prepared_contents = prepared_sources[relative_path]
        transforms.append(
            {
                "path": f"icons/{relative_path}",
                "transformation": FALLBACK_WRAPPER_TRANSFORM,
                "sourceSha256": _sha256(source_contents),
                "preparedSha256": _sha256(prepared_contents),
            }
        )

    return {
        "schemaVersion": 2,
        "upstream": {
            **EXPECTED_UPSTREAM,
            "licenseSha256": _sha256(license_contents),
        },
        "scope": "Complete official 32 px Carbon Icons catalog",
        "fontPreparation": {
            "fileCount": len(transforms),
            "files": transforms,
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


def _verify_prepared_sources(expected: dict[str, bytes]) -> None:
    _require(
        PREPARED_ROOT.is_dir(),
        "Missing prepared icon tree; run prepare.py before verification",
    )
    actual_paths = sorted(
        path.relative_to(PREPARED_ROOT).as_posix()
        for path in PREPARED_ROOT.rglob("*")
        if path.is_file()
    )
    _require(
        actual_paths == sorted(expected),
        "Prepared Carbon icon inventory is stale or incomplete",
    )
    for relative_path, expected_contents in expected.items():
        _require(
            (PREPARED_ROOT / relative_path).read_bytes() == expected_contents,
            f"Prepared Carbon icon drift: {relative_path}",
        )


def verify_sources() -> dict[str, str]:
    _verify_upstream_lock()
    actual = _manifest()
    committed = _load_json(MANIFEST_PATH)
    _require(
        committed == actual,
        "Vendored Carbon icon source does not match manifest.json",
    )
    _require(
        (REFERENCE_ROOT / "README.md").is_file(),
        "Missing Carbon icon snapshot README",
    )

    prepared_sources = expected_prepared_sources()
    _verify_prepared_sources(prepared_sources)
    return {
        relative_path: _sha256(contents)
        for relative_path, contents in prepared_sources.items()
    }


def verify_upstream_install() -> None:
    _require(
        UPSTREAM_PACKAGE_ROOT.is_dir(),
        "Missing installed @carbon/icons; run npm ci in tool/carbon_icons/upstream",
    )
    package_json = _load_json(UPSTREAM_PACKAGE_ROOT / "package.json")
    _require(
        package_json.get("name") == "@carbon/icons",
        "Unexpected installed icon package",
    )
    _require(
        package_json.get("version") == EXPECTED_UPSTREAM["version"],
        "Unexpected installed icon version",
    )
    _require(
        package_json.get("license") == EXPECTED_UPSTREAM["license"],
        "Unexpected installed icon license",
    )
    _require(
        package_json.get("gitHead") == EXPECTED_UPSTREAM["commit"],
        "Unexpected installed icon commit",
    )

    installed_root = UPSTREAM_PACKAGE_ROOT / EXPECTED_UPSTREAM["sourceDirectory"]
    installed_paths = sorted(
        path.relative_to(installed_root).as_posix()
        for path in installed_root.rglob("*.svg")
    )
    vendored_paths = sorted(
        path.relative_to(ICONS_ROOT).as_posix() for path in ICONS_ROOT.rglob("*.svg")
    )
    _require(installed_paths == vendored_paths, "Vendored icon inventory differs from npm")
    for relative_path in installed_paths:
        _require(
            (installed_root / relative_path).read_bytes()
            == (ICONS_ROOT / relative_path).read_bytes(),
            f"Vendored icon differs from npm: {relative_path}",
        )
    _require(
        (UPSTREAM_PACKAGE_ROOT / "LICENSE").read_bytes()
        == (REFERENCE_ROOT / "LICENSE").read_bytes(),
        "Vendored Carbon Icons LICENSE differs from npm",
    )


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
        "fontPackage": "remix_carbon",
        "startCodepoint": "0xE000",
    }
    for key, value in expected_lock.items():
        _require(lock.get(key) == value, f"Unexpected lock {key}")
    lock_glyphs = lock.get("glyphs", [])
    _require(isinstance(lock_glyphs, list), "Invalid locked glyph list")
    _require(
        len(lock_glyphs) == EXPECTED_ICON_COUNT,
        f"Expected {EXPECTED_ICON_COUNT} locked glyphs, found {len(lock_glyphs)}",
    )
    _require(
        {glyph["source"]: glyph["sourceSha256"] for glyph in lock_glyphs}
        == source_hashes,
        "Generated lock does not match prepared source hashes",
    )
    _require(
        len({glyph["name"] for glyph in lock_glyphs}) == EXPECTED_ICON_COUNT,
        "Generated Dart icon names are not unique",
    )
    _require(
        len({glyph["codepoint"] for glyph in lock_glyphs}) == EXPECTED_ICON_COUNT,
        "Generated icon codepoints are not unique",
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
    _require(isinstance(font, dict), "Missing generated font report")
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
        re.findall(
            r"static const flutter\.IconData \w+\s*=\s*flutter\.IconData\(",
            dart,
        )
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
    library = (PACKAGE_ROOT / "lib" / "remix_carbon.dart").read_text(
        encoding="utf-8"
    )
    _require("export 'src/icons/icons.dart';" in library, "CarbonIcons is not exported")
    pubspec = (PACKAGE_ROOT / "pubspec.yaml").read_text(encoding="utf-8")
    _require("name: remix_carbon" in pubspec, "Unexpected Dart package name")
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
    parser.add_argument(
        "--verify-upstream",
        action="store_true",
        help="Also compare the vendored snapshot with installed @carbon/icons",
    )
    args = parser.parse_args()

    try:
        if args.write_manifest:
            write_manifest()
            return 0
        source_hashes = verify_sources()
        if args.verify_upstream:
            verify_upstream_install()
        verify_generated(source_hashes)
    except (
        OSError,
        KeyError,
        TypeError,
        ValueError,
        PreparationError,
        VerificationError,
    ) as error:
        print(f"Carbon icon verification failed: {error}", file=sys.stderr)
        return 1

    upstream_note = ", npm snapshot matched" if args.verify_upstream else ""
    print(
        f"Carbon icon artifacts verified: {EXPECTED_ICON_COUNT} official glyphs, "
        f"all lossless{upstream_note}."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
