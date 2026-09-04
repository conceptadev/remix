# Fortal Scripts

Development utilities for regenerating Fortal's Radix color data. Both scripts
are run from this package root (`packages/remix_fortal/`) and write paths
relative to it.

These are **not** part of `melos run ci`. The Radix color table is pinned to
`@radix-ui/themes@3.3.0` and only regenerates when that pin moves — which is a
deliberate, reviewed change, because the parity contract in
`reference/radix_themes_3_3_0/` asserts against it.

## The pipeline

```
@radix-ui/themes@3.3.0 npm tarball
        │
        │  extract_radix_tokens.dart <extracted-package-dir>
        ▼
radix_colors.generated.json          # checked in; excluded from the published archive
        │
        │  generate_radix_colors.dart
        ▼
lib/src/theme/radix_colors.dart   # checked in; shipped
```

### `extract_radix_tokens.dart`

Reads `tokens/colors/<name>.css` and `tokens/base.css` out of an extracted
`@radix-ui/themes` package directory and writes the sRGB fallback scales to
`radix_colors.generated.json`.

It refuses to run against any version other than the pinned
`3.3.0`, and verifies the package's own `package.json` identity first.

```sh
# Obtain and extract the pinned artifact, then:
fvm dart run scripts/extract_radix_tokens.dart <extracted-@radix-ui/themes-package>
```

The tarball URL and its integrity hash are recorded in
`reference/radix_themes_3_3_0/manifest.json` and enforced by
`tool/fortal_parity/check.dart`.

### `generate_radix_colors.dart`

Renders `radix_colors.generated.json` into the Dart swatch table at
`lib/src/theme/radix_colors.dart`.

```sh
fvm dart run scripts/generate_radix_colors.dart
```

## After regenerating

```sh
fvm dart run ../../tool/check_generated.dart   # build_runner artifacts
fvm dart run tool/fortal_parity/check.dart     # Radix parity contract
fvm flutter test
```
