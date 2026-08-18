#!/usr/bin/env python3
"""Generate the opt-in FortalIcons name → IconData index from the locked report.

The always-imported GlyphPact provider stays map-free so Flutter can subset the
font. Catalogs, galleries, and drift tests import this extra library instead.
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path


PACKAGE_ROOT = Path(__file__).resolve().parents[2]
REPORT_PATH = (
    PACKAGE_ROOT / "lib" / "src" / "radix" / "icons" / "generated" / "iconfont.report.json"
)
INDEX_PATH = PACKAGE_ROOT / "lib" / "icons_index.dart"
EXPECTED_PATH = PACKAGE_ROOT / "test" / "radix" / "fortal_icons_by_name_expected.dart"


def _glyph_names(report: dict) -> list[str]:
    glyphs = report.get("glyphs")
    if not isinstance(glyphs, list) or len(glyphs) != 318:
        raise ValueError(f"Expected 318 report glyphs, found {len(glyphs or [])}")
    names: list[str] = []
    for glyph in glyphs:
        name = glyph.get("name")
        if not isinstance(name, str) or not name.isidentifier():
            raise ValueError(f"Invalid glyph Dart name: {name!r}")
        names.append(name)
    if len(set(names)) != len(names):
        raise ValueError("Report glyph names are not unique")
    return names


def _map_entries(names: list[str]) -> str:
    return ",\n".join(f"  '{name}': FortalIcons.{name}" for name in names)


def render_icons_index(names: list[str]) -> str:
    return (
        "// GENERATED CODE - DO NOT MODIFY BY HAND.\n"
        "// Generated from lib/src/radix/icons/generated/iconfont.report.json.\n"
        "// Do not export this library from remix_fortal.dart -- importing it\n"
        "// keeps every FortalIcons glyph reachable and defeats font subsetting.\n"
        "\n"
        "import 'package:flutter/widgets.dart';\n"
        "\n"
        "import 'src/radix/icons.dart';\n"
        "\n"
        "/// Opt-in Dart member name → [IconData] index of every [FortalIcons] constant.\n"
        "///\n"
        "/// Import `package:remix_fortal/icons_index.dart` from catalogs, galleries,\n"
        "/// and drift tests. Applications that only need individual glyphs should\n"
        "/// import `package:remix_fortal/remix_fortal.dart` and reference\n"
        "/// [FortalIcons] statics so Flutter can subset the font.\n"
        "const Map<String, IconData> fortalIconsByName = {\n"
        f"{_map_entries(names)},\n"
        "};\n"
    )


def render_expected_index(names: list[str]) -> str:
    return (
        "// GENERATED CODE - DO NOT MODIFY BY HAND.\n"
        "// Generated from lib/src/radix/icons/generated/iconfont.report.json.\n"
        "\n"
        "import 'package:flutter/widgets.dart';\n"
        "import 'package:remix_fortal/remix_fortal.dart';\n"
        "\n"
        "/// [FortalIcons] statics keyed by Dart member name, for index identity tests.\n"
        "const Map<String, IconData> expectedFortalIconsByName = {\n"
        f"{_map_entries(names)},\n"
        "};\n"
    )


def load_glyph_names() -> list[str]:
    report = json.loads(REPORT_PATH.read_text(encoding="utf-8"))
    if not isinstance(report, dict):
        raise ValueError("iconfont.report.json must be an object")
    return _glyph_names(report)


def expected_artifacts() -> dict[Path, str]:
    names = load_glyph_names()
    return {
        INDEX_PATH: render_icons_index(names),
        EXPECTED_PATH: render_expected_index(names),
    }


def write_artifacts() -> None:
    for path, source in expected_artifacts().items():
        path.write_text(source, encoding="utf-8")
        print(f"Wrote {path.relative_to(PACKAGE_ROOT)}")


def check_artifacts() -> None:
    for path, source in expected_artifacts().items():
        if not path.is_file():
            raise FileNotFoundError(f"Missing {path.relative_to(PACKAGE_ROOT)}")
        actual = path.read_text(encoding="utf-8")
        if actual != source:
            raise ValueError(
                f"{path.relative_to(PACKAGE_ROOT)} is stale; run "
                "`melos run fortal:icons:generate`"
            )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--check",
        action="store_true",
        help="Fail unless the committed index matches the locked report",
    )
    args = parser.parse_args()

    try:
        if args.check:
            check_artifacts()
            print("Fortal icons index matches the locked 318-glyph report.")
        else:
            write_artifacts()
    except (OSError, KeyError, TypeError, ValueError) as error:
        print(f"Fortal icons index generation failed: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
