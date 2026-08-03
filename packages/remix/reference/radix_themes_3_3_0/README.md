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

The tracked parity approximations are the Dialog `modal: false` interaction
boundary and the Menu's flex-based row geometry. The dialog boundary changes
accessibility route scoping while the Navigator route remains pointer-modal.
Menu behavior, semantics, paths, colors, sizes, and interaction states are
covered; Remix uses a normal leading flex slot and item spacing instead of
Radix's CSS-specific absolute indicator and trailing-slot positioning.

Run the contract gate from this package directory:

```sh
fvm dart run tool/fortal_parity/check.dart
```

Chromium reference output is kept under `chromium/` and is never used as a
self-validating oracle for Flutter rendering.
