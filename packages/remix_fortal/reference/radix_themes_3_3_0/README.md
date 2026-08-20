# Fortal / Radix Themes 3.3.0 reference

This directory pins the upstream `@radix-ui/themes@3.3.0` contract used by
Fortal. The package version, integrity hash, mapped families, public enum
domains and defaults, supported style props, interaction states, Flutter
boundaries, and reference-fixture paths live in `manifest.json`.

`coverage_evidence.json` maps every manifest enum value and state to an exact
executable test case in the corresponding `coverage.tests` allowlist. The
parity checker rejects unknown keys, missing keys, stale test descriptions,
uncited test files, source drift, an inexact Naked beta.8 dependency, or an
undocumented approximation. Parameterized cases use their literal Dart test
description, such as
`${size.name} matches the pinned dimension and radius`.

The contract tracks 30 mapped Radix families and three Fortal extensions.
Text, Heading, Code, Kbd, and Link publish one shared nine-step
`FortalTextSize`, so their `size` enum resolves against
`lib/src/recipes/typography_shared.dart` rather than five parallel per-family
enums. `upstreamInventory.families` must name exactly the tracked family set,
so a new family fails the gate until both the Fortal mapping and the
family-independent upstream record are written.

CheckboxGroup is separately audited in `unmappedUpstreamFamilies`: Remix's
nonvisual coordinator leaves root direction and spacing caller-owned, while
`FortalCheckboxGroupItem` maps the checkbox visuals plus Radix's size-linked
item typography and scaled 6/7/8 label gaps.

Every intentional difference is listed in `approximations`. In addition to the
Dialog `modal: false` interaction boundary and Menu's flex-based row geometry,
the ledger records SegmentedControl's static selected surface, single-label
typography transition, omitted separators, constrained overflow, and possible
small intrinsic-width shift when a changing label is tied to selection;
Skeleton's `grayA3` starting/resting phase versus Radix's `grayA4`
`alternate-reverse` start; TextArea's Flutter-native growth and platform
scrolling instead of Radix's themed 12px browser scrollbar and resize handle;
DataList's data-driven anatomy, global label styling, caller-owned
responsive rebuilds, and untrimmed text bounds; Kbd's omitted `-0.03em`
vertical nudge and `text-top` inline alignment; and Link's font-relative
decoration thickness, absent underline offset, and sRGB approximation of
Radix's OKLab decoration-colour mix. Segmented Control orientation
and per-item disabling are Remix extensions, not entries in the pinned upstream
inventory. TextArea keeps native invalid semantics in coverage, while Remix's
red `error` treatment is documented as an extension rather than a Radix visual
state.

Run the contract gate from this package directory:

```sh
fvm dart run tool/fortal_parity/check.dart
```

Chromium reference output is kept under `chromium/` and is never used as a
self-validating oracle for Flutter rendering.

The `data_table` family is named for the Flutter component but cites Radix
`Table`. Only the passive visuals are parity claims: cell padding, minimum
cell height, typography, radius, the `gray-a5` row divider, bold column
headers, and the surface panel, border, `gray-a2` header background, and
suppressed last-row divider. Radix's Table has no data engine, so controlled
sorting, page-scoped selection, pagination, row hover, arbitrary row actions,
and horizontal scrolling are recorded as Flutter/Fortal extensions in
`flutterExceptions` rather than parity claims.
