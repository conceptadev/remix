# Fortal Theme Reference

Complete reference for Fortal — the Radix-inspired design system that ships as a
separate package on top of Remix: preset widgets, variants, sizes, and tokens.

## Table of Contents

- [Choose Fortal or base Remix](#choose-fortal-or-base-remix)
- [Install and import](#install-and-import)
- [Presets and recipes](#presets-and-recipes)
- [Component variants and sizes](#component-variants--sizes)
- [Typography](#typography)
- [Scope and theme configuration](#fortalscope--theme-config)
- [Tokens](#using-tokens)

## Choose Fortal or base Remix

Use Fortal when the UI should follow its ready-made Radix-inspired visual system. Use base Remix when the user wants a distinct visual language, does not want Fortal's token scales, or needs a fully custom `*Styler`. Fortal is optional and never required for ordinary `Remix*` widgets.

Place `FortalScope` above every subtree that renders Fortal styles. Put it above the application or router when overlay entries and pushed routes must inherit Fortal tokens — **except** under `MaterialApp` or `CupertinoApp`, where it belongs in `builder:`. See [Scope placement](#fortalscope--theme-config).

## Install and import

Everything on this page lives in `remix_fortal`, not `remix`:

```bash
flutter pub add remix_fortal
```

```dart
import 'package:remix_fortal/remix_fortal.dart';
```

`remix_fortal` does not re-export `remix`. Import both when a file also uses base
`Remix*` widgets or `*Styler` types.

Charts also use `mix_chart` data models. Add and import `mix_chart` directly;
Fortal provides the themed recipes and generated wrappers without re-exporting
the chart package.

## Presets and recipes

Each component ships a `fortal<Name>Style(...)` function that returns the
component's `*Styler`, plus a `Fortal<Name>` preset widget that applies
it. Two equivalent ways to use a preset:

```dart
// 1. Preset widget — Remix widget params + fixed variant/size
FortalButton.soft(label: 'Save', onPressed: save, size: .size3)

// 2. Styler function — returns a ButtonStyler to extend
RemixButton(
  label: 'Save',
  onPressed: save,
  style: fortalButtonStyle(variant: .soft, size: .size3)
      .onHovered(ButtonStyler().scale(1.02)),
)
```

Fortal preset styles resolve `FortalTokens`, so a `FortalScope` ancestor is
required.

Every variant has a matching named constructor. Prefer a named constructor
when the variant is fixed and reserve the unnamed constructor's `variant:`
parameter for runtime-selected values. Generic presets infer their type from
required values and item lists, so `FortalRadio.soft(value: 'option')`,
`FortalMenu.solid(items: items, ...)`, and similar calls do not need an
explicit `<String>`.

## Component Variants & Sizes

| Component | Preset widget | Variants | Sizes |
|-----------|--------------|----------|-------|
| Button | `FortalButton` | `classic`, `solid`, `soft`, `surface`, `outline`, `ghost` | `size1`–`size4` |
| IconButton | `FortalIconButton` | `classic`, `solid`, `soft`, `surface`, `outline`, `ghost` | `size1`–`size4` |
| Toggle | `FortalToggle` | `ghost`, `outline` | `size1`–`size3` |
| ToggleGroup | `FortalToggleGroup<T>` | `soft`, `surface` | `size1`–`size3` |
| Checkbox | `FortalCheckbox` | `classic`, `surface`, `soft` | `size1`–`size3` (14/16/20 px) |
| Radio | `FortalRadio<T>` | `classic`, `surface`, `soft` | `size1`–`size3` |
| Switch | `FortalSwitch` | `classic`, `surface`, `soft` | `size1`–`size3` |
| Slider | `FortalSlider` | `classic`, `surface`, `soft` | `size1`–`size3` (13/16/19 px thumb) |
| TextField | `FortalTextField` | `classic`, `surface`, `soft` | `size1`–`size3` |
| TextArea | `FortalTextArea` | `classic`, `surface`, `soft` | `size1`–`size3` |
| Select | `FortalSelect<T>` | `surface`, `soft`, `ghost` | `size1`–`size3` |
| SegmentedControl | `FortalSegmentedControl<T>` | `surface`, `classic` | `size1`–`size3` |
| Menu | `FortalMenu<T>` | `solid`, `soft` | `size1`–`size2` |
| Popover | `FortalPopover` | — | `size1`–`size4` |
| Avatar | `FortalAvatar` | `soft`, `solid` | `size1`–`size9` |
| Badge | `FortalBadge` | `solid`, `soft`, `surface`, `outline` | `size1`–`size3` |
| Card | `FortalCard` | `surface`, `classic`, `ghost` | `size1`–`size5` |
| Callout | `FortalCallout` | `outline`, `surface`, `soft` | `size1`–`size3` |
| DataList | `FortalDataList` | — | `size1`–`size3` |
| DataTable | `FortalDataTable<T>` | `surface`, `ghost` | `size1`–`size3` |
| LineChart | `FortalLineChart` | — | — |
| BarChart | `FortalBarChart` | — | — |
| PieChart | `FortalPieChart` | — | — |
| Progress | `FortalProgress` | `classic`, `surface`, `soft` | `size1`–`size3` (4/8/12 px) |
| Accordion | `FortalAccordion<T>` | `surface`, `soft` | `size1`–`size3` |
| Spinner | `FortalSpinner` | — | `size1`–`size3` |
| Skeleton | `FortalSkeleton` | — | — |
| Divider | `FortalDivider` | — | `size1`–`size4` |
| Dialog | `FortalDialog` | — | `size1`–`size4` |
| Tooltip | `FortalTooltip` | — | — |
| Tabs | `FortalTabBar` / `FortalTab` / `FortalTabView` | — | `FortalTab`: `size1`–`size2` |
| Text | `FortalText` | — | `FortalTextSize.size1`–`size9` |
| Heading | `FortalHeading` | — | `FortalTextSize.size1`–`size9` (default `size6`) |
| Code | `FortalCode` | `solid`, `soft`, `outline`, `ghost` | `FortalTextSize.size1`–`size9` |
| Kbd | `FortalKbd` | `classic`, `soft` | `FortalTextSize.size1`–`size9` |
| Link | `FortalLink` | — | `FortalTextSize.size1`–`size9` |

Variant meanings (consistent across components):

| Variant | Description |
|---------|-------------|
| `solid` | Filled accent background, high-contrast foreground |
| `soft` | Subtle accent surface, accent foreground |
| `surface` | Neutral surface with border |
| `outline` | Transparent with border |
| `ghost` | Transparent, no persistent border |
| `classic` | Raised treatment with component-specific gradients or shadows |

Notes:

- Enum names are per component: `FortalButtonVariant`, `FortalButtonSize`,
  `FortalCheckboxVariant`, etc.
- Components that expose `highContrast` use it to strengthen their active or
  foreground treatment; do not assume the option exists on every family.
- There is no `FortalTabs` — use `RemixTabs` as the behavioral root.
- `FortalIconButton` forwards the complete `RemixIconButton` behavior surface,
  including builders, long press, focus, semantics, and cursor options.
- Generated `FortalButton` does not accept a style override. For Fortal visuals
  with custom one-icon placement, use
  `RemixButton(style: fortalButtonStyle(...).iconAlignment(.end), ...)`.
  With two icons, leading → label → trailing order remains stable.
- `FortalSelect` and `FortalMenu` both include matching default item styles.
  Set an individual item's `style` only when that row needs an override.

---

## Typography

`FortalText`, `FortalHeading`, `FortalCode`, `FortalKbd`, and `FortalLink` exist
only in Fortal — base Remix ships no `RemixText`. All five share one
`FortalTextSize` (`size1`–`size9`) and one `FortalTextWeight` (`light`,
`regular`, `medium`, `bold`) instead of five parallel enums.

```dart
FortalHeading('Overview', size: .size6)                    // level 1 by default
FortalHeading('Recent activity', headingLevel: 2, size: .size4, weight: .medium)
FortalText('Body copy', size: .size3)
FortalCode.soft('FortalScope', size: .size2)
FortalKbd.classic('⌘K', semanticLabel: 'Command K')
FortalLink('Read the docs', onPressed: openDocs)
```

Rules that matter when writing code:

- Omitting `size` on `FortalText`, `FortalCode`, `FortalKbd`, or `FortalLink`
  inherits the ambient `DefaultTextStyle`, matching an unsized Radix `Text` at
  `1em`. `FortalHeading` defaults to `size6` and `bold`.
- `headingLevel` drives accessibility only; it never changes the visual `size`.
  Page titles are level 1, sections and cards below them level 2.
- Colour is opt-in: `accent: true` gives `accent-a11` and adding
  `highContrast: true` promotes it to `accent-12`. `highContrast` alone does
  nothing. `FortalKbd` pins `gray-12` and its own regular weight.
- `truncate: true` wins over `softWrap` and forces one ellipsized line.
- A `FortalLink` **without** `onPressed` is inert styled text: no focus stop, no
  link role, no activation. Only an actionable link underlines.
- `linkUrl` is assistive metadata and is never launched; navigation belongs in
  `onPressed`. Passing `linkUrl` without `onPressed` asserts.
- No leading trim, `pretty`/`balance` wrapping, responsive prop objects, or
  per-instance colour prop. Re-scope `FortalScope.accent` for a coloured
  subtree.

---

## FortalScope & Theme Config

```dart
FortalScope(
  accent: FortalAccentColor.indigo,   // default .indigo
  gray: FortalGrayColor.slate,        // default .slate
  brightness: Brightness.light,       // default .light
  panelBackground: FortalPanelBackground.translucent,
  radius: FortalRadius.medium,
  scaling: FortalScaling.percent100,
  hasBackground: true,
  orderOfModifiers: null,             // optional List<Type>
  child: MyApp(),
)
```

**Accent colors** (31): amber, blue, bronze, brown, crimson, cyan, gold,
grass, green, indigo, iris, jade, lime, mint, orange, pink, plum, purple,
red, ruby, sky, teal, tomato, violet, yellow — plus the neutrals gray,
mauve, slate, sage, olive, sand.

**Gray scales** (6): gray, mauve, slate, sage, olive, sand.

`panelBackground` selects solid or translucent floating surfaces; `radius`
selects `none|small|medium|large|full`; `scaling` selects 90%, 95%, 100%, 105%,
or 110%; and `hasBackground` controls whether the scope paints the resolved
page background behind its child.

### Scope placement

The **outermost** `FortalScope` also establishes the Radix theme root's default
text run — `text3` (16px, 1.5 line height, 0 letter spacing) at `gray-12`,
regular weight, with no pinned font family. That is what an unsized
`FortalText`, `FortalCode`, `FortalKbd`, or `FortalLink` measures `1em` against
when there is no closer `DefaultTextStyle`, so placement matters:

| Host | Put the scope |
| --- | --- |
| `WidgetsApp`, router, or a custom host | Above the app |
| `MaterialApp`, `CupertinoApp` | In `builder:` |

A **nested** scope re-scopes tokens only. It inherits the closest text style
instead of restating the root run, so wrapping a subtree in
`FortalScope(accent: .red, hasBackground: false, ...)` re-themes its tokens
without resizing or recoloring the text already running through it.

```dart
// MaterialApp / CupertinoApp
MaterialApp(
  builder: (context, child) => FortalScope(child: child!),
  home: const MyScreen(),
)
```

Those apps pass `WidgetsApp` their own root `DefaultTextStyle`, which lands
below anything wrapping the app. A scope placed above `MaterialApp` still
supplies tokens, but its root text run is overridden. `builder:` sits below that
style and above the `Navigator`, so pushed routes and raw `Overlay` entries
receive the Fortal fallback.

Normal Flutter inheritance still applies below the scope. A nearer
`DefaultTextStyle`, including one from `Material` or `Scaffold`, wins. Unsized
Fortal typography deliberately inherits it; use `size: FortalTextSize.size3`
when a component needs the exact 16px Radix root size inside such a surface.

If text inside a hand-rolled `OverlayEntry` renders red and monospace with a
yellow double underline, the scope is in the wrong place: that is Flutter's
"put your text in a Material" fallback style.

`FortalThemeConfig` is the immutable config object form:

```dart
const theme = FortalThemeConfig(accent: .green, gray: .sage, brightness: .dark);
final light = theme.copyWith(brightness: .light);
theme.createScope(child: MyApp())
```

---

## Using Tokens

Inside styler chains, call the token to get a resolvable value; in plain
widgets, resolve against context:

```dart
// In a styler chain:
ButtonStyler()
    .backgroundColor(FortalTokens.accent9())
    .borderRadiusAll(FortalTokens.radius3())

// In a widget build:
Container(color: FortalTokens.colorBackground.resolve(context))

// Text style token into a TextStyler:
TextStyler().style(FortalTokens.text2.mix())
```

## Color Tokens

### Accent Scale (12 steps)

| Token | Semantic Role |
|-------|---------------|
| `FortalTokens.accent1` | App background (subtle) |
| `FortalTokens.accent2` | Subtle component background |
| `FortalTokens.accent3` | Component background (rest) |
| `FortalTokens.accent4` | Component background (hover) |
| `FortalTokens.accent5` | Component background (active) |
| `FortalTokens.accent6` | Subtle border |
| `FortalTokens.accent7` | Component border |
| `FortalTokens.accent8` | Border (hover/focus) |
| `FortalTokens.accent9` | Solid background (default) |
| `FortalTokens.accent10` | Solid background (hover) |
| `FortalTokens.accent11` | Low-contrast text |
| `FortalTokens.accent12` | High-contrast text |

### Gray Scale (12 steps)

Same semantic structure: `FortalTokens.gray1` through `FortalTokens.gray12`.

### Alpha Variants

- Accent alpha: `FortalTokens.accentA1` – `accentA12`
- Gray alpha: `FortalTokens.grayA1` – `grayA12`
- Black alpha (shadows): `blackA3`, `blackA4`, `blackA5`, `blackA6`,
  `blackA7`, `blackA11`

### Functional Colors

| Token | Role |
|-------|------|
| `FortalTokens.colorBackground` | Page background (gray1) |
| `FortalTokens.colorSurface` | Input/control surface |
| `FortalTokens.colorPanelSolid` | Solid panel (gray2) |
| `FortalTokens.colorPanelTranslucent` | Translucent panel with alpha |
| `FortalTokens.colorOverlay` | Dark overlay for modals |
| `FortalTokens.accentSurface` | Subtle accent (soft variants) |
| `FortalTokens.accentIndicator` | Active indicator (sliders, progress) |
| `FortalTokens.accentTrack` | Track background |
| `FortalTokens.accentContrast` | High-contrast text on accent solid |
| `FortalTokens.graySurface` | Neutral surface |
| `FortalTokens.grayIndicator` | Neutral indicator |
| `FortalTokens.grayTrack` | Neutral track |
| `FortalTokens.grayContrast` | Text on neutral solid |
| `FortalTokens.focus8` | Solid focus ring (accent step 8) |
| `FortalTokens.focusA8` | Translucent focus ring |
| `FortalTokens.shadowStroke` | OKLab-mixed shadow stroke blend |

---

## Space Tokens

4px-increment scale (`SpaceToken`):

| Token | Value |
|-------|-------|
| `FortalTokens.space1` | 4px |
| `FortalTokens.space2` | 8px |
| `FortalTokens.space3` | 12px |
| `FortalTokens.space4` | 16px |
| `FortalTokens.space5` | 24px |
| `FortalTokens.space6` | 32px |
| `FortalTokens.space7` | 40px |
| `FortalTokens.space8` | 48px |
| `FortalTokens.space9` | 64px |

---

## Radius Tokens

| Token | Value |
|-------|-------|
| `FortalTokens.radius1` | 3px |
| `FortalTokens.radius2` | 4px |
| `FortalTokens.radius3` | 6px |
| `FortalTokens.radius4` | 8px |
| `FortalTokens.radius5` | 12px |
| `FortalTokens.radius6` | 16px |
| `FortalTokens.radiusFull` | 9999px (pill/circle) |

---

## Typography Tokens

`TextStyleToken`s with tuned line height and letter spacing:

| Token | Size | Typical use |
|-------|------|-------------|
| `FortalTokens.text1` | 12px | Small labels, metadata |
| `FortalTokens.text2` | 14px | Standard UI text, buttons |
| `FortalTokens.text3` | 16px | Body text |
| `FortalTokens.text4` | 18px | Prominent body |
| `FortalTokens.text5` | 20px | Small headings |
| `FortalTokens.text6` | 24px | Medium headings |
| `FortalTokens.text7` | 28px | Large headings |
| `FortalTokens.text8` | 35px | Extra-large headings |
| `FortalTokens.text9` | 60px | Display/hero text |

---

## Shadow Tokens

`BoxShadowToken`s, six elevation levels: `FortalTokens.shadow1` (subtle,
resting cards) through `FortalTokens.shadow6` (maximum elevation, critical
dialogs). `shadow3` suits dropdowns/tooltips; `shadow4`–`shadow5` suit
modals.

---

## Border & Focus Tokens

| Token | Value |
|-------|-------|
| `FortalTokens.borderWidth1` | 1px |
| `FortalTokens.borderWidth2` | 2px |
| `FortalTokens.focusRingWidth` | 2px |
| `FortalTokens.focusRingOffset` | 2px |

---

## Animation Tokens

| Token | Value |
|-------|-------|
| `FortalTokens.transitionFast` | 100ms (hover, press micro-interactions) |
| `FortalTokens.transitionSlow` | 300ms (modals, larger transitions) |

---

## Font Weight Tokens

| Token | Value |
|-------|-------|
| `FortalTokens.fontWeightLight` | 300 |
| `FortalTokens.fontWeightRegular` | 400 |
| `FortalTokens.fontWeightMedium` | 500 |
| `FortalTokens.fontWeightBold` | 700 |
