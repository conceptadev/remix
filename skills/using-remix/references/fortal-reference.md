# Fortal Theme Reference

Complete reference for Fortal — Remix's built-in, Radix-inspired design
system: preset widgets, variants, sizes, and tokens.

## How Fortal presets work

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
| Button | `FortalButton` | `solid`, `soft`, `surface`, `outline`, `ghost` | `size1`–`size4` |
| IconButton | `FortalIconButton` | `solid`, `soft`, `surface`, `outline`, `ghost` | `size1`–`size4` |
| Toggle | `FortalToggle` | `ghost`, `outline` | `size1`–`size3` |
| Checkbox | `FortalCheckbox` | `surface`, `soft` | `size1`–`size3` (16/24/32 px) |
| Radio | `FortalRadio<T>` | `surface`, `soft` | `size1`–`size3` |
| Switch | `FortalSwitch` | `surface`, `soft` | `size1`–`size3` |
| Slider | `FortalSlider` | `surface`, `soft` | `size1`–`size3` (13/16/19 px thumb) |
| TextField | `FortalTextField` | `surface`, `soft` | `size1`–`size3` |
| Select | `FortalSelect<T>` | `surface`, `soft`, `ghost` | `size1`–`size3` |
| Menu | `FortalMenu<T>` | `solid`, `soft` | `size1`–`size2` |
| Avatar | `FortalAvatar` | `soft`, `solid` | `size1`–`size4` (24/32/40/64 px) |
| Badge | `FortalBadge` | `solid`, `soft`, `surface`, `outline` | `size1`–`size3` |
| Card | `FortalCard` | `surface`, `classic`, `ghost` | `size1`–`size3` |
| Callout | `FortalCallout` | `outline`, `surface`, `soft` | `size1`–`size3` |
| Progress | `FortalProgress` | `surface`, `soft` | `size1`–`size3` (4/8/12 px) |
| Accordion | `FortalAccordion<T>` | `surface`, `soft` | `size1`–`size3` |
| Spinner | `FortalSpinner` | — | `size1`–`size3` |
| Divider | `FortalDivider` | — | `size1`–`size3` (1/2/3 px) |
| Dialog | `FortalDialog` | — | — |
| Tooltip | `FortalTooltip` | — | — |
| Tabs | `FortalTabBar` / `FortalTab` / `FortalTabView` | — | — |

Variant meanings (consistent across components):

| Variant | Description |
|---------|-------------|
| `solid` | Filled accent background, high-contrast foreground |
| `soft` | Subtle accent surface, accent foreground |
| `surface` | Neutral surface with border |
| `outline` | Transparent with border |
| `ghost` | Transparent, no persistent border |
| `classic` (Card) | Traditional card with shadow |

Notes:

- Enum names are per component: `FortalButtonVariant`, `FortalButtonSize`,
  `FortalCheckboxVariant`, etc.
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

## FortalScope & Theme Config

```dart
FortalScope(
  accent: FortalAccentColor.indigo,   // default .indigo
  gray: FortalGrayColor.slate,        // default .slate
  brightness: Brightness.light,       // default .light
  orderOfModifiers: null,             // optional List<Type>
  child: MyApp(),
)
```

**Accent colors** (31): amber, blue, bronze, brown, crimson, cyan, gold,
grass, green, indigo, iris, jade, lime, mint, orange, pink, plum, purple,
red, ruby, sky, teal, tomato, violet, yellow — plus the neutrals gray,
mauve, slate, sage, olive, sand.

**Gray scales** (6): gray, mauve, slate, sage, olive, sand.

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
