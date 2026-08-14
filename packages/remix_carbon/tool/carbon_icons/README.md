# Carbon icon generation

This tool compiles the complete pinned Carbon Icons 11.86.0 32 px catalog into
the tree-shakable `CarbonIcons` Flutter font provider. The 2,725 source SVGs
are vendored byte-for-byte from `@carbon/icons@11.86.0`. The toolchain mirrors
`remix_fortal`: Python 3.13, uv 0.11.24, and GlyphPact 1.1.0.

From the repository root:

```sh
fvm dart run melos run remix_carbon:icons:generate
fvm dart run melos run remix_carbon:icons:check
```

Generation preserves the committed codepoint lock. The manifest verifier pins
the npm package version, integrity, original license, every source file, and
the generated output. Install the exact upstream npm workspace with
`npm ci --ignore-scripts --prefix packages/remix_carbon/tool/carbon_icons/upstream`
before refreshing the
vendored snapshot.

Five upstream files contain an Adobe Illustrator `<switch>` with a
`<foreignObject>` capability probe followed by ordinary SVG fallback geometry.
`prepare.py` deterministically removes only that non-rendering wrapper in an
ignored staging directory; the vendored originals remain byte-identical to the
npm package. The verifier pins both the original and prepared hashes.
