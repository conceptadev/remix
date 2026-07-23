# Fortal Theme Reference

Fortal is Remix's built-in theme. Its 20 mapped component families follow the
tracked `@radix-ui/themes@3.3.0` contract; Accordion, Toggle, and ToggleGroup are
Fortal extensions and are excluded from the Radix parity score.

## Presets and stylers

Fortal widgets with variants expose named constructors. Prefer those
constructors when the variant is known statically; use the unnamed constructor
with `variant:` when the variant is selected dynamically at runtime.

```dart
FortalButton.soft(
  size: .size3,
  onPressed: save,
  child: const Text('Save'),
)

RemixButton(
  onPressed: save,
  style: fortalButtonStyler(variant: .soft, size: .size3)
      .onHovered(ButtonStyler().scale(1.02)),
  child: const Text('Save'),
)
```

Use the Fortal widget for the canonical recipe. Use the matching
`fortal<Name>Styler(...)` with a `Remix*` widget when a visual override is
required. Fortal widgets and stylers resolve `FortalTokens`, so they require a
`FortalScope` ancestor.

## Component matrix

| Family | Variants | Sizes | Default |
|---|---|---|---|
| Avatar | `soft`, `solid` | `size1`–`size9` | `soft`, `size3` |
| Badge | `solid`, `soft`, `surface`, `outline` | `size1`–`size3` | `soft`, `size1` |
| Button | `classic`, `solid`, `soft`, `surface`, `outline`, `ghost` | `size1`–`size4` | `solid`, `size2` |
| Callout | `soft`, `surface`, `outline` | `size1`–`size3` | `soft`, `size2` |
| Card | `surface`, `classic`, `ghost` | `size1`–`size5` | `surface`, `size1` |
| Checkbox | `classic`, `surface`, `soft` | `size1`–`size3` | `surface`, `size2` |
| Dialog | alignment `start`, `center` | `size1`–`size4` | `center`, `size3` |
| Divider | horizontal or vertical | `size1`–`size4` | horizontal, `size1` |
| IconButton | `classic`, `solid`, `soft`, `surface`, `outline`, `ghost` | `size1`–`size4` | `solid`, `size2` |
| Menu content | `solid`, `soft` | `size1`–`size2` | `solid`, `size2` |
| Popover | — | `size1`–`size4` | `size2` |
| Progress | `classic`, `surface`, `soft` | `size1`–`size3` | `surface`, `size2` |
| Radio | `classic`, `surface`, `soft` | `size1`–`size3` | `surface`, `size2` |
| Select trigger | `classic`, `surface`, `soft`, `ghost` | `size1`–`size3` | `surface`, `size2` |
| Select content | `solid`, `soft` | follows Select size | `solid` |
| Slider | `classic`, `surface`, `soft` | `size1`–`size3` | `surface`, `size2` |
| Spinner | — | `size1`–`size3` | `size2`, loading |
| Switch | `classic`, `surface`, `soft` | `size1`–`size3` | `surface`, `size2` |
| Tabs | — | `size1`–`size2` | `size2` |
| TextField | `classic`, `surface`, `soft` | `size1`–`size3` | `surface`, `size2` |
| Tooltip | — | — | 200 ms delay, arrow, 360 px max |
| Accordion extension | `surface`, `soft` | `size1`–`size3` | `surface`, `size2` |
| Toggle extension | `ghost`, `outline` | `size1`–`size3` | `ghost`, `size2` |
| ToggleGroup extension | `soft`, `surface` | `size1`–`size3` | `soft`, `size2` |

`classic` is the raised Radix treatment, including its ordered gradient and
shadow layers. `solid` is an accent fill, `soft` is a subtle accent treatment,
`surface` is a translucent or neutral control surface, `outline` has no fill,
and `ghost` removes persistent chrome.

Component-specific overrides mirror Radix style props. Where supported, use
`color: FortalAccentColor?`, `radius: FortalRadius?`, and `highContrast:` on the
Fortal widget. Select exposes separate trigger/content color overrides and
`contentHighContrast`; Tabs applies color and contrast at `FortalTabBar`.

## Theme scope

Put the root scope above `WidgetsApp`, `MaterialApp`, or `CupertinoApp`. This
lets platform appearance and Navigator overlays resolve the same theme.

```dart
FortalScope(
  appearance: .inherit,
  accentColor: .indigo,
  grayColor: .auto,
  panelBackground: .translucent,
  radius: .medium,
  scaling: .percent100,
  child: MaterialApp(home: MyScreen()),
)
```

Theme enums and root defaults:

- `FortalAppearance`: `inherit`, `light`, `dark`; root `inherit` observes
  platform brightness.
- `FortalAccentColor`: 26 Radix accent names from `gray` through `sky`; default
  `indigo`.
- `FortalGrayColor`: `auto`, `gray`, `mauve`, `slate`, `sage`, `olive`, `sand`;
  `auto` selects the accent's matching neutral (Indigo resolves to Slate).
- `FortalPanelBackground`: `solid`, `translucent`; default `translucent`.
- `FortalRadius`: `none`, `small`, `medium`, `large`, `full`; default `medium`.
- `FortalScaling`: `percent90`, `percent95`, `percent100`, `percent105`,
  `percent110`; default `percent100`.
- Root `hasBackground` defaults to true and translucent panels resolve a
  64-logical-pixel backdrop blur.

Nested scopes inherit omitted values. Passing `.auto` recomputes the gray for
the nested accent; it does not simply preserve the parent's resolved gray.
`FortalTheme.of(context)` returns the fully resolved `FortalThemeData`.
`FortalThemeConfig.createScope(...)` is the immutable configuration form.

## Current composition APIs

Button, IconButton, Badge, and other content-bearing components accept widgets,
so text and icon styling is inherited by arbitrary descendants:

```dart
FortalButton(
  onPressed: save,
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [Icon(Icons.save), Text('Save')],
  ),
)

FortalIconButton(
  semanticLabel: 'Settings',
  onPressed: openSettings,
  icon: const Icon(Icons.settings),
)
```

Slider retains scalar `value`/`snapDivisions` and adds list-valued mode for any
positive number of ordered thumbs. Multi-thumb mode uses `step`, `minSpacing`,
and `onValuesChanged`.

```dart
FortalSlider(
  values: range,
  min: 0,
  max: 100,
  step: 5,
  minSpacing: 10,
  onValuesChanged: (values) => setState(() => range = values),
)
```

Select uses a declarative trigger and sealed items:

```dart
FortalSelect<String>(
  trigger: const RemixSelectTrigger(placeholder: 'Choose a fruit'),
  items: const [
    RemixSelectLabel(label: 'Fruit'),
    RemixSelectItem(value: 'apple', label: 'Apple'),
    RemixSelectItem(value: 'banana', label: 'Banana'),
    RemixSelectSeparator(),
  ],
  selectedValue: fruit,
  onChanged: (value) => setState(() => fruit = value),
)
```

Menu is widget-compositional. Its `items` may contain actions, labels,
groups, separators, controlled checkbox items, radio groups/items, and
recursive submenus:

```dart
FortalMenu<String>(
  trigger: const Text('Actions'),
  items: const [
    RemixMenuLabel(child: Text('Edit')),
    RemixMenuAction(value: 'copy', child: Text('Copy')),
    RemixMenuSeparator(),
    RemixMenuSubmenu<String>(
      child: Text('Share'),
      items: [
        RemixMenuAction(value: 'link', child: Text('Copy link')),
      ],
    ),
  ],
  onSelected: handleAction,
)
```

Use `FortalRadioGroup<T>(value:, onChanged:, child:)` around
`FortalRadio<T>` items. Use `RemixTabs` as the behavioral root around
`FortalTabBar`, `FortalTab`, and `FortalTabView`; there is no `FortalTabs`.
Dialog defaults to `maxWidth: 600`, Popover to `maxWidth: 480` without an
arrow, and Tooltip to `maxWidth: 360` with a styled arrow.

## Tokens and box effects

Token families include 12-step accent and gray scales plus alpha scales,
spacing (`space1`–`space9` = 4, 8, 12, 16, 24, 32, 40, 48, 64), typography
(`text1`–`text9` = 12, 14, 16, 18, 20, 24, 28, 35, 60), radii
(`radius1`–`radius6` = 3, 4, 6, 8, 12, 16), derived theme radii, border/focus
widths, motion durations, ordinary Mix box-shadow lists, and specialized
inset-capable Remix shadow lists.

Use callable tokens inside Mix stylers and resolve concrete values through the
active `MixScope` in ordinary widget code:

```dart
final style = ButtonStyler()
    .color(FortalTokens.accent9())
    .paddingAll(FortalTokens.space4())
    .borderRadiusAll(FortalTokens.radius3());

final accent = MixScope.tokenOf(FortalTokens.accent9, context);
```

Mix `BoxSpec` and `FlexBoxSpec` own container geometry and standard decoration:
color, ordinary gradient and `BoxShadowMix` elevation, border, radius,
clipping, margin, constraints, and transforms. `FortalTokens.shadow2` through
`shadow6` are Mix `BoxShadowToken` values; `shadow1` and mixed/inset recipes
remain `RemixBoxShadowListToken` values.

`RemixBoxEffectsMix` augments the box only when Fortal needs advanced paint.
Its `behindContent` and `overContent` `RemixBoxEffectLayerMix` values support
multiple token-aware gradients with independent clip insets, true inset
shadows, `shapeInset`, and explicitly positioned overlays. The aggregate also
owns backdrop blur and offset outlines. Component APIs expose one
`containerEffects` field, or role-specific names such as `trackEffects`,
`thumbEffects`, and `thumbFocusEffects`. Shadow stroke colors use
standards-aligned premultiplied-alpha OKLab mixing.
