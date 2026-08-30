# Remix icon generation

This tool compiles the vendored Radix Icons 1.3.2 SVG snapshot into the
tree-shakable `RemixIcons` Flutter font provider and the opt-in
`package:remix_icons/icons_index.dart` name map. The toolchain is locked to
Python 3.13, uv 0.11.24, and GlyphPact 1.1.0.

`RemixIcons` stays an `@staticIconProvider` of static const fields (`catalog:
false`). The enumerable map is generated *outside* GlyphPact's `generated/`
directory from `iconfont.report.json` so an app that never imports the index
keeps full font subsetting.

From the repository root:

```sh
fvm dart run melos run icons:generate
fvm dart run melos run icons:check
```

Generation preserves the committed codepoint lock. Five Radix sources use
partial opacity that an ordinary monochrome icon font cannot represent:
`shadow.svg`, `shadow-inner.svg`, `shadow-none.svg`, `shadow-outer.svg`, and
`transparency-grid.svg`. GlyphPact intentionally flattens their positive alpha
to opaque coverage; every other glyph must convert losslessly.
