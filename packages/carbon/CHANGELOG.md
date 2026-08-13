# Changelog

## Unreleased

### Changed

- `CarbonButton` is now generated from its `ButtonStyler` recipe with a direct
  `RemixButton` target, matching the `remix_fortal` reuse model and removing the
  hand-maintained behavior facade.
- Renamed the public recipe to `carbonButtonStyle()` and the trailing-icon
  parameter to `trailingIcon`, matching the generated Remix anatomy.
- Button focus treatment now uses focus-visible modality, so pointer focus does
  not show a keyboard ring.
- Carbon participates in workspace generation, dependency, documentation, and
  Material-independence checks; its separate token generator is also part of
  the root CI sequence.
- `CarbonLayer` resolves directly from the generated indexed role-family table
  instead of maintaining a duplicate hand-written map.
- Aligned Remix/Mix dependencies with the workspace, removed unused direct
  Naked UI and Material-font declarations, and switched Remix from a path to a
  hosted constraint.

## 0.0.2

Full-package review round: correctness fixes, consolidation, and performance.

### Fixed

- **CarbonButton loading state** no longer renders the disabled gray treatment;
  it keeps the kind's colors with a `textOnColor` spinner (Remix folds loading
  into the disabled widget-state, which the recipe now accounts for).
- **CarbonButton default size** is Carbon's `lg` (48px) when no
  `CarbonLayoutScope` is present, matching the docs and
  `carbonButtonStyler()`.
- **CarbonLayer off-by-one**: a single `CarbonLayer` now steps the page (level 1)
  up to level 2 instead of being a no-op; also added the four missing contextual
  aliases (`layerAccentHover`, `layerAccentActive`, `layerBackground`,
  `borderSubtleSelected`), with a test asserting full coverage of the generated
  indexed role families.
- **dangerGhost pressed state** uses `buttonDangerActive` + `textOnColor`
  instead of an illegible white-on-gray combination.
- **Focus ring** paints as a foreground decoration: no layout shift on focus and
  the tertiary outline is no longer replaced.
- **Button label** consumes `CarbonTokens.bodyCompact01` via
  `TextStyler().style(token.mix())` instead of hand-copied measurements, so the
  scope's `fontFamily` override now reaches button labels.
- **`CarbonThemeOverrides.fontFamily` reaches fluid type**:
  `CarbonType.fluidTextStyle` reads the enclosing scope's override.
- **`CarbonFontFamilies`** now exposes usable family names (e.g. `'IBM Plex
  Sans'`) plus separate `*Fallback` lists instead of raw CSS stacks.
- **`CarbonType.resolveFluid`** throws `ArgumentError` on unknown names in all
  build modes instead of silently falling back in release.
- **`verify_generated.mjs`** is fully read-only (scripts gained `--out` flags;
  the committed snapshot can no longer be clobbered by a verify run) and reports
  per-stage results accurately.
- Token pipeline hardening: pinned versions derive from `upstream/package.json`
  (single source of truth), shared theme tuple and color-formatting helpers,
  NaN guards in unit parsers.

### Changed

- Aligned with Remix `1.0.0-beta.1`, Mix `2.1`, and Naked UI `1.0.0-beta.3`.
- Renamed `carbonButtonStyle()` to `carbonButtonStyler()` to match Remix 1.0
  and Mix 2 styler terminology.
- `CarbonButton` now forwards Remix 1.0's long-press, focus, semantics, and
  mouse-cursor behavior surface; `onPressed` is optional and null disables it.
- Carbon now runs under the workspace's fatal DCM gate.
- Generated token maps are top-level `final`s (built once per isolate) and the
  per-theme scope token map is cached, making repeated `CarbonScope` rebuilds
  allocation-free; button stylers are memoized per (kind, size, loading).
- Determinism is now actually CI-enforced via `.github/workflows/carbon_tokens.yml`.
- `packages/carbon/example` added to the melos package globs; `publish_to: none`
  while remix is a path dependency.

## 0.0.1

Initial pre-1.0 foundation release.

### Added

- **Deterministic token pipeline** (`tool/`) that extracts, normalizes, generates
  and verifies Carbon design tokens from the pinned official `@carbon/*` npm
  packages. Regeneration from the source lock is byte-identical (CI-enforced).
  - `@carbon/themes` 11.76.0, `@carbon/colors` 11.53.0, `@carbon/layout` 11.54.0,
    `@carbon/type` 11.62.0, `@carbon/motion` 11.47.0.
  - Carbon repo commit `b288a66af010622bedc6de4d6d0b81ee3c9f5520`.
- **Generated tokens** (`lib/src/tokens/generated/`): 246-color primitive palette,
  234 color roles × 4 themes, 78 component tokens (fallbacks and partial-theme
  omissions preserved), 13-step spacing, control/container/icon sizes, fixed and
  fluid typography, motion durations and easing curves, and a provenance manifest.
- **Foundation runtime**: `CarbonScope` / `CarbonTheme` (White, Gray 10, Gray 90,
  Gray 100), `CarbonLayer` contextual layer model, `CarbonLayoutScope`
  (`CarbonSize`, `CarbonDensity`), `CarbonType` fluid resolver, `CarbonMotion`
  reduced-motion helpers, and typed theme overrides.
- **Carbon Button** vertical slice: seven kinds (primary, secondary, tertiary,
  ghost, danger, danger-tertiary, danger-ghost), the Carbon size scale, and
  hover/pressed/focus/disabled/loading states, implemented as a hand-written
  facade over Remix's button machinery.
- Package scaffolding, example gallery, tests, and the token-pipeline ADR.
