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

The contract tracks 25 mapped Radix families and three Fortal extensions.
CheckboxGroup is separately audited in `unmappedUpstreamFamilies`: Remix's
nonvisual coordinator composes the mapped checkbox recipe on each item, but it
does not claim Radix's root/item spacing and inherited visual-prop anatomy.

Every intentional difference is listed in `approximations`. In addition to the
Dialog `modal: false` interaction boundary and Menu's flex-based row geometry,
the ledger records SegmentedControl's static selected surface, single-label
typography transition, and omitted separators; TextArea's Flutter-native
growth and absent browser resize handle; and DataList's data-driven anatomy,
global label styling, caller-owned responsive rebuilds, and untrimmed text
bounds.

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
