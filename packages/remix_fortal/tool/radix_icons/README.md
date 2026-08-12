# Fortal icon generation

This tool compiles the vendored Radix Icons 1.3.2 SVG snapshot into the
tree-shakable `FortalIcons` Flutter font provider. The toolchain is locked to
Python 3.13, uv 0.11.24, and GlyphPact 1.1.0.

From the repository root:

```sh
fvm dart run melos run fortal:icons:generate
fvm dart run melos run fortal:icons:check
```

Generation preserves the committed codepoint lock. Five Radix sources use
partial opacity that an ordinary monochrome icon font cannot represent:
`shadow.svg`, `shadow-inner.svg`, `shadow-none.svg`, `shadow-outer.svg`, and
`transparency-grid.svg`. GlyphPact intentionally flattens their positive alpha
to opaque coverage; every other glyph must convert losslessly.
