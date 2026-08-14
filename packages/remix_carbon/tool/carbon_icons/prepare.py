#!/usr/bin/env python3
"""Prepare exact Carbon SVG sources for deterministic icon-font conversion."""

from __future__ import annotations

from pathlib import Path
import re
import shutil
import tempfile


PACKAGE_ROOT = Path(__file__).resolve().parents[2]
TOOL_ROOT = Path(__file__).resolve().parent
SOURCE_ROOT = PACKAGE_ROOT / "reference" / "carbon_icons_11_86_0" / "icons"
PREPARED_ROOT = TOOL_ROOT / ".prepared"
EXPECTED_ICON_COUNT = 2725
FALLBACK_WRAPPER_FILES = frozenset(
    {
        "calendar--add--alt.svg",
        "calendar--add.svg",
        "data-quality-definition.svg",
        "rule--data-quality.svg",
        "workflow-automation.svg",
    }
)
FALLBACK_WRAPPER_TRANSFORM = (
    "Remove the Adobe Illustrator switch/foreignObject capability probe and "
    "retain its bundled static SVG fallback geometry"
)

_FALLBACK_WRAPPER = re.compile(
    rb"(<svg\b[^>]*>)<switch><foreignObject\b[^>]*/><g>(.*)</g></switch>(</svg>)",
    re.DOTALL,
)


class PreparationError(Exception):
    pass


def _source_paths() -> list[Path]:
    paths = sorted(
        SOURCE_ROOT.rglob("*.svg"),
        key=lambda path: path.relative_to(SOURCE_ROOT).as_posix(),
    )
    if len(paths) != EXPECTED_ICON_COUNT:
        raise PreparationError(
            f"Expected {EXPECTED_ICON_COUNT} Carbon SVGs, found {len(paths)}"
        )

    wrapper_files = {
        path.relative_to(SOURCE_ROOT).as_posix()
        for path in paths
        if b"<foreignObject" in path.read_bytes()
    }
    if wrapper_files != FALLBACK_WRAPPER_FILES:
        raise PreparationError(
            "The approved Illustrator fallback-wrapper set changed: "
            f"{sorted(wrapper_files)}"
        )
    return paths


def prepare_contents(relative_path: str, contents: bytes) -> bytes:
    """Return the exact bytes GlyphPact should consume for one vendored SVG."""

    if relative_path not in FALLBACK_WRAPPER_FILES:
        if b"<foreignObject" in contents:
            raise PreparationError(
                f"Unapproved foreignObject in {relative_path}"
            )
        return contents

    match = _FALLBACK_WRAPPER.fullmatch(contents)
    if match is None:
        raise PreparationError(
            f"Unexpected Illustrator fallback wrapper in {relative_path}"
        )
    prepared = match.group(1) + match.group(2) + match.group(3)
    if b"<foreignObject" in prepared or b"<switch" in prepared:
        raise PreparationError(f"Failed to normalize {relative_path}")
    return prepared


def expected_prepared_sources() -> dict[str, bytes]:
    return {
        path.relative_to(SOURCE_ROOT).as_posix(): prepare_contents(
            path.relative_to(SOURCE_ROOT).as_posix(),
            path.read_bytes(),
        )
        for path in _source_paths()
    }


def materialize() -> None:
    prepared_sources = expected_prepared_sources()
    temporary_root = Path(
        tempfile.mkdtemp(prefix=".prepared-", dir=TOOL_ROOT)
    )
    try:
        for relative_path, contents in prepared_sources.items():
            destination = temporary_root / relative_path
            destination.parent.mkdir(parents=True, exist_ok=True)
            destination.write_bytes(contents)

        if PREPARED_ROOT.exists():
            shutil.rmtree(PREPARED_ROOT)
        temporary_root.rename(PREPARED_ROOT)
    except BaseException:
        if temporary_root.exists():
            shutil.rmtree(temporary_root)
        raise

    print(
        f"Prepared {len(prepared_sources)} Carbon SVGs "
        f"({len(FALLBACK_WRAPPER_FILES)} fallback wrappers normalized)."
    )


if __name__ == "__main__":
    try:
        materialize()
    except (OSError, PreparationError) as error:
        raise SystemExit(f"Carbon icon preparation failed: {error}") from error
