---
name: using-remix
description: This skill should be used when the user wants to build Flutter UI with the Remix component library (Mix + Naked UI + Fortal theme) — create screens or widgets with Remix components, style or customize Remix widgets, set up Fortal theming, handle interaction states, or use any Remix/Fortal widget (RemixButton, FortalButton, RemixSelect, FortalTextField, RemixTabs, etc.). Also trigger on mentions of Remix styling, stylers, Fortal tokens/variants, or generic UI requests like "make a button" or "style this form" in a project that depends on the remix package.
---

# Using Remix — Building Flutter Interfaces

Remix is a Flutter design-system library. It combines **Naked UI** (headless
accessible behavior) with **Mix** (styling engine) to deliver fully styled,
interaction-aware components. The built-in **Fortal** theme provides
Radix-inspired design tokens and ready-made preset widgets.

This skill is for consuming Remix and its built-in Fortal theme. For a
standalone branded design-system package built on Remix, use the
`building-remix-design-system` skill instead.

## Quick Start

```dart
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
```

Wrap the app (or a subtree) in `FortalScope` to provide the Fortal tokens:

```dart
FortalScope(
  accent: FortalAccentColor.indigo,  // 31 options (default .indigo)
  gray: FortalGrayColor.slate,       // 6 neutral scales (default .slate)
  brightness: Brightness.light,      // or .dark
  child: WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (_, _) => const MyScreen(),
  ),
)
```

Then use the Fortal preset widgets:

```dart
FortalButton(label: 'Submit', onPressed: handleSubmit)
FortalButton.ghost(label: 'Cancel', onPressed: cancel)
FortalTextField(hintText: 'you@example.com', label: 'Email')
FortalCheckbox(selected: agreed, onChanged: (v) => setState(() => agreed = v))
```

Variant presets have named constructors such as `FortalButton.solid(...)` and
`FortalSelect.ghost(...)`. Prefer them when the variant is fixed; use the
unnamed constructor with `variant:` when the value is selected dynamically.
For generic presets, Dart infers `T` from values, items, and callbacks, so
calls such as `FortalRadio.soft(value: 'option')` do not need `<String>`.

Plain `Remix*` widgets work without `FortalScope`, but anything Fortal
(`Fortal*` widgets, `fortal*Style()` functions, `FortalTokens`) requires it
to resolve tokens.

## Host Capabilities

Remix composes inside the caller's Flutter host. Do not add a `RemixApp`,
`RemixOverlayHost`, or `RemixScaffold`.

| UI | Caller provides | Compatible hosts |
|----|-----------------|------------------|
| Ordinary `Remix*` widgets | The inherited Flutter services used by the widget subtree | Material, Cupertino, Widgets, and router-based hosts |
| `Fortal*` widgets and recipes | `FortalScope`, in addition to the widget's normal Flutter services | Any Flutter host |
| Menu, select, popover, and tooltip | An `Overlay` | Any host exposing an overlay; use `Overlay.wrap` when no `Navigator` is needed |
| `showRemixDialog` and `showRemixAlertDialog` | A `Navigator` | Any host with a caller-owned navigator |

Use the smallest host capability required by the screen. A portal-only screen
can use a caller-owned overlay without routing:

```dart
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

Widget buildPortalHost() {
  return FortalScope(
    child: WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => Overlay.wrap(
        child: Center(
          child: FortalMenu<String>.soft(
            trigger: const RemixMenuTrigger(label: 'Actions'),
            items: const [
              RemixMenuItem(value: 'share', label: 'Share'),
            ],
          ),
        ),
      ),
    ),
  );
}
```

Material, Cupertino, Widgets, and router hosts with routing configured commonly
provide a `Navigator` and its overlay already. Dialog helpers push routes, so
their calling context must be below that caller-owned `Navigator`.

## Three levels of styling

1. **Fortal preset widgets** — `FortalButton.soft(size: .size2)`.
   Fastest path; consistent by construction. Use for standard UI.
2. **Fortal style recipe + overrides** — `fortal*Style()` returns the component's
   `*Styler`; chain custom modifications and pass it to the `Remix*`
   widget's `style:`:

   ```dart
   RemixButton(
     label: 'Save',
     onPressed: save,
     style: fortalButtonStyle(variant: .solid)
         .borderRadiusAll(const Radius.circular(8))
         .paddingX(32)
         .onHovered(ButtonStyler().wrap(.scale(x: 1.05, y: 1.05))),
   )
   ```

3. **Fully custom styler** — build a `*Styler` from scratch with the
   fluent API (below). Use for bespoke designs that don't start from Fortal.

## Component Catalog

Remix ships 21 components. Each styled leaf widget accepts `style` (a
`*Styler`) and has a `Fortal*` preset counterpart. Behavioral roots and
groups (`RemixTabs`, `RemixRadioGroup`, and `RemixAccordionGroup`) intentionally
have neither a styler nor a Fortal wrapper.

| Category | Remix widgets | Fortal presets |
|----------|---------------|----------------|
| **Actions** | `RemixButton`, `RemixIconButton`, `RemixToggle` | `FortalButton`, `FortalIconButton`, `FortalToggle` |
| **Forms** | `RemixCheckbox`, `RemixRadio` + `RemixRadioGroup`, `RemixSwitch`, `RemixSlider`, `RemixTextField`, `RemixSelect` | `FortalCheckbox`, `FortalRadio`, `FortalSwitch`, `FortalSlider`, `FortalTextField`, `FortalSelect` |
| **Data display** | `RemixAvatar`, `RemixBadge`, `RemixCard`, `RemixCallout`, `RemixProgress`, `RemixSpinner`, `RemixDivider` | `FortalAvatar`, `FortalBadge`, `FortalCard`, `FortalCallout`, `FortalProgress`, `FortalSpinner`, `FortalDivider` |
| **Overlays** | `RemixDialog` (+ `showRemixDialog`), `RemixTooltip`, `RemixMenu` | `FortalDialog`, `FortalTooltip`, `FortalMenu` |
| **Navigation** | `RemixTabs` + `RemixTabBar`/`RemixTab`/`RemixTabView`, `RemixAccordion` + `RemixAccordionGroup` | `FortalTabBar`/`FortalTab`/`FortalTabView` (no `FortalTabs` — use `RemixTabs`), `FortalAccordion` |

Full constructor parameters for every component: `references/components.md`.
All Fortal variants, sizes, and tokens: `references/fortal-reference.md`.

## Using Components

### Buttons

```dart
FortalButton.outline(
  label: 'Delete',
  leadingIcon: Icons.delete,
  loading: isDeleting,
  enabled: canDelete,
  size: .size2,
  onPressed: handleDelete,
)

FortalIconButton.ghost(icon: Icons.settings, onPressed: openSettings)

// Toggle: a pressable button that stays active while selected
FortalToggle(selected: isBold, label: 'Bold', onChanged: (v) => setBold(v))
```

A button is interactive only when `enabled && !loading && onPressed != null`
— `loading: true` disables it (and the `.onDisabled` variant styles the
loading state).

### Form Controls

```dart
FortalCheckbox(
  selected: isChecked,
  onChanged: (val) => setState(() => isChecked = val),
)

// Radio: FortalRadio still needs a RemixRadioGroup ancestor
RemixRadioGroup<String>(
  groupValue: selectedOption,
  onChanged: (val) => setState(() => selectedOption = val),
  child: Column(children: [
    for (final option in ['a', 'b', 'c'])
      Row(children: [FortalRadio.surface(value: option), Text(option)]),
  ]),
)

FortalSwitch(
  selected: isDarkMode,
  onChanged: (val) => toggleDarkMode(val),
)

FortalSlider(
  value: volume,
  min: 0,
  max: 100,
  onChanged: (val) => setState(() => volume = val),
)

FortalTextField(
  controller: emailController,
  label: 'Email',
  hintText: 'you@example.com',
  helperText: 'Never shared',
  error: hasError,          // enables error-state styling
  leading: const Icon(Icons.mail),
)
```

### Select & Menu

`RemixSelectTrigger`, `RemixSelectItem`, `RemixMenuTrigger`, and
`RemixMenuItem` are data classes, not widgets.

```dart
FortalSelect.surface(
  trigger: const RemixSelectTrigger(placeholder: 'Choose a fruit'),
  items: const [
    RemixSelectItem(value: 'apple', label: 'Apple'),
    RemixSelectItem(value: 'banana', label: 'Banana'),
  ],
  selectedValue: selectedFruit,
  onChanged: (val) => setState(() => selectedFruit = val),
)

// Menu — item styling is also baked into the preset:
FortalMenu.solid(
  trigger: const RemixMenuTrigger(label: 'Actions', icon: Icons.more_vert),
  items: const [
    RemixMenuItem(value: 'edit', label: 'Edit', leadingIcon: Icons.edit),
    RemixMenuItem(value: 'copy', label: 'Copy', leadingIcon: Icons.copy),
    RemixMenuDivider(),
    RemixMenuItem(value: 'delete', label: 'Delete', leadingIcon: Icons.delete),
  ],
  onSelected: (action) => handleAction(action),
)
```

### Tabs

```dart
RemixTabs(
  selectedTabId: currentTab,
  onChanged: (id) => setState(() => currentTab = id),
  child: Column(children: [
    FortalTabBar(
      child: Row(children: [
        FortalTab(tabId: 'overview', label: 'Overview'),
        FortalTab(tabId: 'details', label: 'Details', icon: Icons.info),
      ]),
    ),
    Expanded(child: Column(children: [
      FortalTabView(tabId: 'overview', child: OverviewPanel()),
      FortalTabView(tabId: 'details', child: DetailsPanel()),
    ])),
  ]),
)
```

### Accordion

`RemixAccordionGroup` requires an explicit controller:

```dart
RemixAccordionGroup<String>(
  controller: RemixAccordionController<String>(min: 0, max: 1),
  child: Column(children: [
    FortalAccordion.surface(value: 'faq1', title: 'What is Remix?', child: Text('...')),
    const FortalDivider(),
    FortalAccordion.surface(value: 'faq2', title: 'How does theming work?', child: Text('...')),
  ]),
)
```

### Dialog & Tooltip

```dart
showRemixDialog(
  context: context,
  builder: (_) => Center(
    child: FortalDialog(
      title: 'Confirm',
      description: 'Are you sure you want to proceed?',
      actions: [
        FortalButton.ghost(label: 'Cancel',
            onPressed: () => Navigator.pop(context)),
        FortalButton(label: 'Confirm',
            onPressed: () { confirm(); Navigator.pop(context); }),
      ],
    ),
  ),
)

FortalTooltip(
  tooltipChild: const Text('Saves your work'),
  child: FortalIconButton(icon: Icons.save, onPressed: save),
)
```

### Data Display

```dart
FortalAvatar(label: 'JD', backgroundImage: NetworkImage('https://...'), size: .size3)
FortalBadge(label: 'New')
FortalCard(size: .size2, child: Column(children: [...]))
FortalCallout(icon: Icons.info, text: 'Informational callout.')
FortalProgress(value: 0.65)
FortalSpinner(size: .size2)
FortalDivider()
```

## Custom Styling with Stylers

Every component's style is a chainable, immutable `*Styler`:

```dart
ButtonStyler()
    .color(Colors.blue)          // container fill (universal primitive)
    .borderRounded(12)           // circular radius shortcut
    .paddingX(24)
    .paddingY(12)
    .labelColor(Colors.white)
    .labelFontSize(16)
    .labelFontWeight(FontWeight.w600)
    .iconColor(Colors.white)
    .iconSize(20)
    .spacing(8)                  // icon↔label gap (flex-based components)
```

Fluent surface shared by container-based stylers: `.color()`, `.gradient()`,
`.border*()`, `.borderRadius*()` / `.borderRounded()`, `.shadow()` /
`.shadows()` / `.elevation()`, `.padding*()` / `.margin*()` (incl.
`.paddingX/.paddingY`), `.width()` / `.height()` / `.size()`, `.scale()` /
`.rotate()` / `.translate()`. Flex-based ones add `.spacing()`,
`.direction()`, `.mainAxisAlignment()`, `.crossAxisAlignment()`, `.row()`,
`.column()`. Component-part mixins add `.label*()` (color, fontSize,
fontWeight, letterSpacing, …), `.icon*()` (color, size, opacity, …), and
`.spinner*()` (indicatorColor, size, strokeWidth, …) where the component has
those parts. `.backgroundColor()` is an alias on Accordion, Avatar, Badge,
Button, Callout, Card, Dialog, IconButton, TextField, Toggle, and Tooltip
stylers. It is not universal; use the component's `.color()` method where
available and check the per-component reference for exact surface area.

### Interaction States

State variants take a styler of the same type and merge it over the base:

```dart
ButtonStyler()
    .color(Colors.blue)
    .labelColor(Colors.white)
    .onHovered(ButtonStyler().color(Colors.blue.shade700))
    .onPressed(ButtonStyler().scale(0.97))
    .onFocused(ButtonStyler().borderAll(color: Colors.white, width: 2))
    .onDisabled(ButtonStyler().color(Colors.grey))
```

`.onSelected()` exists on the selection components only — Checkbox, Radio,
Switch, Toggle, Tab, and TabView stylers:

```dart
CheckboxStyler()
    .color(Colors.grey.shade200)
    .onSelected(CheckboxStyler().color(Colors.blue))
```

### Context Variants

Respond to platform, brightness, and form factor:

```dart
ButtonStyler()
    .paddingX(24)
    .onMobile(ButtonStyler().paddingX(16).labelFontSize(14))
    .onDark(ButtonStyler().color(Colors.blue.shade800))
```

Available: `.onDark()`, `.onLight()`, `.onMobile()`, `.onTablet()`,
`.onDesktop()`, `.onPortrait()`, `.onLandscape()`, `.onLtr()`, `.onRtl()`,
`.onIos()`, `.onAndroid()`, `.onMacos()`, `.onWindows()`, `.onLinux()`,
`.onWeb()`, `.onBreakpoint(...)`, `.onNot(...)`, `.onBuilder(...)`.

### Animation

Add transitions between states with `.animate(AnimationConfig)`:

```dart
ButtonStyler()
    .color(Colors.blue)
    .onHovered(ButtonStyler().color(Colors.blue.shade800))
    .animate(AnimationConfig.spring(300.ms))
```

`AnimationConfig` factories: `.spring(duration, {bounce})`,
`.curve({duration, curve})`, and shortcuts like `.easeOut(200.ms)`,
`.easeIn(...)`, `.linear(...)`, `.decelerate(...)`. The `.ms` / `.s`
duration extensions come from Mix.

### Callable Styles

Every leaf component styler has a `call()` method that builds the widget
directly:

```dart
final primaryButton = ButtonStyler()
    .color(Colors.blue)
    .labelColor(Colors.white)
    .paddingX(24)
    .borderRounded(8);

primaryButton(label: 'Save', onPressed: save)   // → RemixButton
```

Generic surfaces use `call<T>()`: Accordion, Menu, Radio, and Select. Dart can
usually infer `T` from the required values or item lists. All other leaf
component stylers use a non-generic `call()` method. Behavioral group/root
widgets such as `RemixAccordionGroup`, `RemixRadioGroup`, and `RemixTabs` are
constructed directly because they do not have stylers.

### Styling with Fortal Tokens

Reference Fortal tokens in custom styles so they respect the active theme.
Call the token inside styler chains; `.mix()` for text-style tokens;
`.resolve(context)` for direct values in widget code:

```dart
ButtonStyler()
    .color(FortalTokens.accent9())
    .paddingAll(FortalTokens.space4())
    .borderRadiusAll(FortalTokens.radius3())
    .label(TextStyler().style(FortalTokens.text2.mix())
        .color(FortalTokens.accentContrast()))

Container(color: FortalTokens.colorBackground.resolve(context))
```

Token families: `accent1–12`, `gray1–12` (+ `accentA*`/`grayA*` alpha),
functional colors (`accentContrast`, `colorSurface`, …), `space1–9`,
`radius1–6` + `radiusFull`, `text1–9`, `shadow1–6`, font weights, and
transition durations. Full catalog: `references/fortal-reference.md`.

## Common Patterns

### Reusable App Styles

```dart
class AppStyles {
  static ButtonStyler get primaryButton => fortalButtonStyle(variant: .solid)
      .animate(AnimationConfig.spring(200.ms));

  static ButtonStyler get dangerButton => fortalButtonStyle(variant: .solid)
      .color(Colors.red)
      .onHovered(ButtonStyler().color(Colors.red.shade700))
      .animate(AnimationConfig.spring(200.ms));
}

RemixButton(label: 'Save', onPressed: save, style: AppStyles.primaryButton)
```

### Material Dark Mode Interoperability

When the caller uses `MaterialApp`, keep its theme brightness aligned with
`FortalScope`. `MaterialApp` and `Scaffold` are not Remix requirements.

```dart
class _MyAppState extends State<MyApp> {
  var _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return FortalScope(
      accent: FortalAccentColor.indigo,
      brightness: _brightness,
      child: MaterialApp(
        theme: ThemeData(brightness: _brightness),
        home: Scaffold(
          body: FortalSwitch(
            selected: _brightness == Brightness.dark,
            onChanged: (dark) => setState(() =>
                _brightness = dark ? Brightness.dark : Brightness.light),
          ),
        ),
      ),
    );
  }
}
```

`FortalThemeConfig` is the value-object form for dynamic theming:
`config.createScope(child: …)`, `config.copyWith(brightness: …)`.

## Pitfalls

- **No `FortalTabs`** — the behavioral root is always `RemixTabs`.
- **`RemixAccordionGroup.controller` is required** (Tabs/Menu controllers are
  optional).
- **`loading` implies disabled** on buttons — style the loading appearance
  through `.onDisabled()`.
- **`.backgroundColor()` is not universal** — use it only on the stylers
  listed above; otherwise use the component's `.color()` method where
  available.
- **`.onSelected()` is not on Button** — only Checkbox, Radio, Switch,
  Toggle, Tab, TabView.

For deeper Mix-level styling (specs, `StyleSpec`, `BoxStyler`, `TextStyler`,
`build_runner` codegen), consult the **Mix** skill.

## Additional Resources

- **`references/components.md`** — full constructor parameters for all 21
  components and their Fortal presets.
- **`references/fortal-reference.md`** — every Fortal variant/size per
  component, `FortalScope`/`FortalThemeConfig`, and the complete token
  catalog with values.
