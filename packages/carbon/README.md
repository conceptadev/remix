# Carbon for Flutter

A Flutter-native implementation of the [IBM Carbon Design System](https://carbondesignsystem.com),
built on the same interaction and styling foundations as Remix 1.0 — [Naked UI](https://pub.dev/packages/naked_ui)
for behavior and [Mix](https://pub.dev/packages/mix) for styling — but with Carbon's
own generated palette, role tokens, themes, layered surfaces, contextual sizes,
density, typography, motion and component tokens.

> **Status: pre-1.0.** This release delivers the token/foundation layer and the
> Button vertical slice. It is **not** the full Carbon React catalog — see the
> roadmap below. Token values are reproducibly generated from pinned official
> Carbon sources; see [Provenance](#provenance).

## Install

```yaml
dependencies:
  carbon:
    git:
      url: https://github.com/btwld/remix.git
      path: packages/carbon
```

## Quick start

Wrap your app (or any subtree) in a `CarbonScope` and use Carbon widgets and
tokens inside it.

```dart
import 'package:carbon/carbon.dart';

CarbonScope(
  theme: CarbonTheme.g100, // white | g10 | g90 | g100
  child: CarbonButton(
    label: 'Save',
    kind: CarbonButtonKind.primary,
    onPressed: () {},
  ),
);
```

## Foundation

| API | Purpose |
| --- | --- |
| `CarbonScope` | Resolves Carbon tokens into a `MixScope`; selects one of the four themes; accepts typed overrides (colors, font family). |
| `CarbonTheme` | `white`, `g10`, `g90`, `g100` — with matching `brightness`. |
| `CarbonLayer` | Contextual layer model (levels 1–3). Resolves aliases like `layer`, `field`, `borderSubtle` to the correct indexed role token. |
| `CarbonLayoutScope` | Contextual `CarbonSize` (`xs`–`x2l`) and `CarbonDensity` (`condensed`/`normal`); components clamp into their supported range. |
| `CarbonType` | Fixed styles as Mix tokens; a viewport-aware resolver for Carbon's fluid type. |
| `CarbonMotion` | Carbon easing curves by intent/mode, plus reduced-motion-aware `duration`/`curve` helpers. |

### Tokens

- **Role tokens** — `CarbonTokens.*` (234 semantic color roles identical across all
  four themes, plus spacing, control sizes, fixed type styles, motion durations,
  font weights). Prefer these in component code.
- **Component tokens** — `CarbonComponentTokens.*` (Button, Tag, Notification,
  Status, Content Switcher), namespaced separately.
- **Primitive palette** — `CarbonPalette.*` (the raw IBM Design Language colors);
  use only where a primitive is genuinely required.

```dart
Box(
  style: BoxStyler()
      .color(CarbonTokens.layer01())
      .padding(EdgeInsetsMix.all(CarbonTokens.spacing05())),
);
```

### Contextual layers

```dart
CarbonLayer( // steps up to level 2 inside a level-1 subtree
  child: Builder(builder: (context) {
    final layer = CarbonLayer.of(context).color(CarbonContextualColor.layer);
    // -> CarbonTokens.layer02
    return const SizedBox();
  }),
);
```

### Fluid typography

```dart
Text(
  'Responsive heading',
  style: CarbonType.fluidTextStyle(context, 'fluidHeading05'),
);
```

## Provenance

Every token value is generated from the pinned official Carbon npm packages —
never hand-copied. See `lib/src/tokens/generated/carbon_source_manifest.g.dart`
and `tool/upstream/carbon-source-lock.json`.

| Package | Version |
| --- | --- |
| `@carbon/themes` | 11.76.0 |
| `@carbon/colors` | 11.53.0 |
| `@carbon/layout` | 11.54.0 |
| `@carbon/type` | 11.62.0 |
| `@carbon/motion` | 11.47.0 |

Carbon repo commit: `b288a66af010622bedc6de4d6d0b81ee3c9f5520` (2026-07-09).

The pipeline (extract → normalize → generate → verify) lives under `tool/`; see
[`tool/README.md`](tool/README.md). Consumers never run it — the normalized
snapshot and generated Dart are committed. It is deterministic: regenerating from
the same source lock is byte-identical, enforced by `tool/verify_generated.mjs`
in the `Carbon tokens` GitHub workflow (`.github/workflows/carbon_tokens.yml`).

## Fonts

Carbon typography uses IBM Plex. This package does **not** bundle the fonts; pass
a bundled family through `CarbonScope` — it applies to every fixed text-style
token *and* to `CarbonType.fluidTextStyle`:

```dart
CarbonScope(
  theme: CarbonTheme.white,
  overrides: const CarbonThemeOverrides(fontFamily: CarbonFontFamilies.sans),
  child: app,
);
```

`CarbonFontFamilies` exposes each official Plex stack as a usable family name
(e.g. `CarbonFontFamilies.sans == 'IBM Plex Sans'`) plus a separate
`*Fallback` list for `TextStyle.fontFamilyFallback`. IBM Plex is licensed under
the SIL Open Font License; see `NOTICE`.

## Roadmap

- **Now:** tokens + foundation, Carbon Button.
- **Next:** Text Input and Modal vertical slices, then an architecture checkpoint.
- **Then:** the initial overlap set (Checkbox, Radio, Toggle, Slider, Select,
  Dropdown, Tabs, Accordion, Tooltip, Overflow Menu, Tag, Tile, Inline
  Notification, …) followed by Carbon-native breadth (Data Table, Pagination, …).

See `docs/adr/0001-carbon-token-pipeline.md` for the architecture decision record.

## Licensing

Licensed under Apache-2.0. Carbon token values are derived from the Apache-2.0
IBM Carbon Design System. "IBM", "Carbon" and "IBM Plex" are IBM trademarks; this
is an independent community implementation. See `LICENSE` and `NOTICE`.
