# Carbon icon generation

This tool compiles the pinned Carbon Icons 11.86.0 component subset into the
tree-shakable `CarbonIcons` Flutter font provider. The source SVGs are the
official 32 px assets from `@carbon/icons@11.86.0`; the subset contains every
glyph used internally by the Carbon component catalog. The toolchain mirrors
`remix_fortal`: Python 3.13, uv 0.11.24, and GlyphPact 1.1.0.

From the repository root:

```sh
fvm dart run melos run carbon:icons:generate
fvm dart run melos run carbon:icons:check
```

Generation preserves the committed codepoint lock. The manifest verifier pins
the npm package version, integrity, license, source files, and generated output.
