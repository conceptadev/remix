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
import 'package:remix/remix.dart';
```

Wrap the app (or a subtree) in `FortalScope` to provide the Fortal tokens:

```dart
FortalScope(
  appearance: FortalAppearance.inherit,
  accentColor: FortalAccentColor.indigo,
  grayColor: FortalGrayColor.auto,
  child: MaterialApp(home: MyScreen()),
)
```

Then use the Fortal preset widgets:

```dart
FortalButton(child: const Text('Submit'), onPressed: handleSubmit)
FortalButton.ghost(
  child: const Text('Cancel'),
  onPressed: cancel,
)
FortalTextField(hintText: 'you@example.com', label: 'Email')
FortalCheckbox(selected: agreed, onChanged: (v) => setState(() => agreed = v))
```

Fortal widgets with variants expose named constructors such as
`FortalButton.ghost`. Use the unnamed constructor with `variant:` only when the
variant is selected dynamically at runtime. Pass `size:` when it differs from
the component default.

Plain `Remix*` widgets work without `FortalScope`, but anything Fortal
(`Fortal*` widgets, `fortal*Styler()` functions, `FortalTokens`) requires it
to resolve tokens.

## Three levels of styling

1. **Fortal preset widgets** — `FortalButton.soft(size: .size2, child: ...)`.
   Fastest path; consistent by construction. Use for standard UI.
2. **Fortal styler + overrides** — `fortal*Styler()` returns the component's
   `Remix*Styler`; chain custom modifications and pass it to the `Remix*`
   widget's `style:`:

   ```dart
   RemixButton(
     child: const Text('Save'),
     onPressed: save,
     style: fortalButtonStyler(variant: .solid)
         .borderRadiusAll(const Radius.circular(8))
         .paddingX(32)
         .onHovered(ButtonStyler().wrap(.scale(x: 1.05, y: 1.05))),
   )
   ```

3. **Fully custom styler** — build a `Remix*Styler` from scratch with the
   fluent API (below). Use for bespoke designs that don't start from Fortal.

## Component Catalog

Each styled leaf widget accepts `style` (a
`Remix*Styler`) and has a `Fortal*` preset counterpart. Behavioral roots and
groups such as `RemixTabs` and `RemixAccordionGroup` intentionally have no
styler; `FortalRadioGroup` is a typed convenience around `RemixRadioGroup`.

| Category | Remix widgets | Fortal presets |
|----------|---------------|----------------|
| **Actions** | `RemixButton`, `RemixIconButton`, `RemixToggle` | `FortalButton`, `FortalIconButton`, `FortalToggle` |
| **Forms** | `RemixCheckbox`, `RemixRadio` + `RemixRadioGroup`, `RemixSwitch`, `RemixSlider`, `RemixTextField`, `RemixSelect` | `FortalCheckbox`, `FortalRadio` + `FortalRadioGroup`, `FortalSwitch`, `FortalSlider`, `FortalTextField`, `FortalSelect` |
| **Data display** | `RemixAvatar`, `RemixBadge`, `RemixCard`, `RemixCallout`, `RemixProgress`, `RemixSpinner`, `RemixDivider` | `FortalAvatar`, `FortalBadge`, `FortalCard`, `FortalCallout`, `FortalProgress`, `FortalSpinner`, `FortalDivider` |
| **Overlays** | `RemixDialog` (+ `showRemixDialog`), `RemixPopover`, `RemixTooltip`, `RemixMenu` | `FortalDialog`, `FortalPopover`, `FortalTooltip`, `FortalMenu` |
| **Navigation** | `RemixTabs` + `RemixTabBar`/`RemixTab`/`RemixTabView`, `RemixAccordion` + `RemixAccordionGroup`, `RemixToggleGroup` | `FortalTabBar`/`FortalTab`/`FortalTabView` (no `FortalTabs`), `FortalAccordion`, `FortalToggleGroup` |

Full constructor parameters for every component: `references/components.md`.
All Fortal variants, sizes, and tokens: `references/fortal-reference.md`.

## Using Components

### Buttons

```dart
FortalButton.outline(
  loading: isDeleting,
  enabled: canDelete,
  size: .size2,
  onPressed: handleDelete,
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [Icon(Icons.delete), Text('Delete')],
  ),
)

FortalIconButton.ghost(
  semanticLabel: 'Settings',
  onPressed: openSettings,
  icon: const Icon(Icons.settings),
)

// Toggle: a pressable button that stays active while selected
FortalToggle(selected: isBold, label: 'Bold', onChanged: (v) => setBold(v))
```

A button is interactive only when
`enabled && !loading && (onPressed != null || onLongPress != null)`.
`loading: true` disables it (and the `.onDisabled` variant styles the loading
state).

### Form Controls

```dart
FortalCheckbox(
  selected: isChecked,
  onChanged: (val) => setState(() => isChecked = val),
)

FortalRadioGroup<String>(
  value: selectedOption,
  onChanged: (val) => setState(() => selectedOption = val),
  child: Column(children: [
    for (final option in ['a', 'b', 'c'])
      Row(children: [FortalRadio(value: option), Text(option)]),
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
  snapDivisions: 100,
  onChanged: (value) => setState(() => volume = value),
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

Select uses a declarative trigger plus sealed items. Menu items are real
widgets so actions, labels, groups, checks, radio choices, and recursive
submenus compose in source order. Set `open` and handle `onOpenChanged` when
the Select owner must accept or reject overlay-state requests.

```dart
FortalSelect<String>(
  trigger: const RemixSelectTrigger(placeholder: 'Choose a fruit'),
  items: const [
    RemixSelectItem(value: 'apple', label: 'Apple'),
    RemixSelectItem(value: 'banana', label: 'Banana'),
  ],
  selectedValue: selectedFruit,
  onChanged: (val) => setState(() => selectedFruit = val),
)

FortalMenu<String>(
  trigger: const Text('Actions'),
  items: const [
    RemixMenuAction(
      value: 'edit',
      leading: Icon(Icons.edit),
      child: Text('Edit'),
    ),
    RemixMenuSeparator(),
    RemixMenuSubmenu<String>(
      child: Text('Share'),
      items: [
        RemixMenuAction(value: 'link', child: Text('Copy link')),
      ],
    ),
  ],
  onSelected: (action) => handleAction(action),
)
```

### Tabs

```dart
RemixTabs(
  selectedTabId: currentTab,
  activationMode: .manual,
  onChanged: (id) => setState(() => currentTab = id),
  child: Column(children: [
    FortalTabBar(
      children: [
        FortalTab(tabId: 'overview', label: 'Overview'),
        FortalTab(tabId: 'details', label: 'Details', icon: Icons.info),
      ],
    ),
    Expanded(child: Column(children: [
      FortalTabView(tabId: 'overview', child: OverviewPanel()),
      FortalTabView(tabId: 'details', child: DetailsPanel()),
    ])),
  ]),
)
```

Automatic activation selects as arrow-key focus moves; manual activation waits
for Space or Enter.

### Accordion

`RemixAccordionGroup` requires an explicit controller:

```dart
RemixAccordionGroup<String>(
  controller: RemixAccordionController<String>(min: 0, max: 1),
  child: Column(children: [
    FortalAccordion(value: 'faq1', title: 'What is Remix?', child: Text('...')),
    const FortalDivider(),
    FortalAccordion(value: 'faq2', title: 'How does theming work?', child: Text('...')),
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
        FortalButton.ghost(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FortalButton(
          onPressed: () { confirm(); Navigator.pop(context); },
          child: const Text('Confirm'),
        ),
      ],
    ),
  ),
)

FortalTooltip(
  tooltipChild: const Text('Saves your work'),
  child: FortalIconButton(
    semanticLabel: 'Save',
    onPressed: save,
    icon: const Icon(Icons.save),
  ),
)
```

`RemixDialog.modal` controls accessibility route scoping; a dialog opened with
`showRemixDialog` remains a pointer-modal Navigator route for either value.
Tooltip arrows follow the resolved trigger position after collision flips and
cross-axis shifts.

### Data Display

```dart
FortalAvatar(label: 'JD', backgroundImage: NetworkImage('https://...'), size: .size3)
FortalBadge(child: const Text('New'))
FortalCard(size: .size2, child: Column(children: [...]))
FortalCallout(icon: const Icon(Icons.info), child: const Text('Informational callout.'))
FortalProgress(value: 65)
FortalSpinner(size: .size2)
FortalDivider()
```

Indeterminate progress renders a stable completed-growth frame when
`MediaQuery.disableAnimations` is enabled.

## Custom Styling with Stylers

Every component's style is a chainable, immutable `Remix*Styler`:

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

Remix exports `.onSelected()` for generated Remix stylers. Selection controls
use it for checked/selected recipes, and overlay compositions use it for open
trigger recipes such as a Card inside `RemixPopover`:

```dart
RemixCheckboxStyler()
    .color(Colors.grey.shade200)
    .onSelected(RemixCheckboxStyler().color(Colors.blue))

RemixCardStyler()
    .onSelected(RemixCardStyler().backgroundColor(Colors.blue.shade50))
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

primaryButton(child: const Text('Save'), onPressed: save) // → RemixButton
```

Generic surfaces use `call<T>()`: Accordion, Menu, Radio, and Select. Dart can
usually infer `T` from required values, items, or callbacks. All other leaf
component stylers use a non-generic `call()` method. Behavioral group/root
widgets such as `RemixAccordionGroup`, `RemixRadioGroup`, and `RemixTabs` are
constructed directly because they do not have stylers.

### Styling with Fortal Tokens

Reference Fortal tokens in custom styles so they respect the active theme.
Call the token inside styler chains; use `.mix()` for text-style tokens and
`MixScope.tokenOf(...)` for direct values in widget code:

```dart
ButtonStyler()
    .color(FortalTokens.accent9())
    .paddingAll(FortalTokens.space4())
    .borderRadiusAll(FortalTokens.radius3())
    .label(TextStyler().style(FortalTokens.text2.mix())
        .color(FortalTokens.accentContrast()))

Container(color: MixScope.tokenOf(FortalTokens.colorBackground, context))
```

Token families: `accent1–12`, `gray1–12` (+ `accentA*`/`grayA*` alpha),
functional colors (`accentContrast`, `colorSurface`, …), `space1–9`,
`radius1–6` + `radiusFull`, `text1–9`, `shadow1–6`, font weights, and
transition durations. Full catalog: `references/fortal-reference.md`.

## Common Patterns

### Reusable App Styles

```dart
class AppStyles {
  static ButtonStyler get primaryButton => fortalButtonStyler(variant: .solid)
      .animate(AnimationConfig.spring(200.ms));

  static ButtonStyler get dangerButton => fortalButtonStyler(variant: .solid)
      .color(Colors.red)
      .onHovered(ButtonStyler().color(Colors.red.shade700))
      .animate(AnimationConfig.spring(200.ms));
}

RemixButton(
  child: const Text('Save'),
  onPressed: save,
  style: AppStyles.primaryButton,
)
```

### Dark Mode Toggle

```dart
class _MyAppState extends State<MyApp> {
  var _appearance = FortalAppearance.light;

  @override
  Widget build(BuildContext context) {
    return FortalScope(
      accentColor: FortalAccentColor.indigo,
      appearance: _appearance,
      child: MaterialApp(
        theme: ThemeData(
          brightness: _appearance == .dark ? .dark : .light,
        ),
        home: Scaffold(
          body: FortalSwitch(
            selected: _appearance == .dark,
            onChanged: (dark) => setState(() =>
                _appearance = dark ? .dark : .light),
          ),
        ),
      ),
    );
  }
}
```

`FortalThemeConfig` is the value-object form for dynamic theming:
`config.createScope(child: …)`, `config.copyWith(appearance: …)`.

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

- **`references/components.md`** — constructor contracts for Remix components
  and their Fortal presets.
- **`references/fortal-reference.md`** — every Fortal variant/size per
  component, `FortalScope`/`FortalThemeConfig`, and the complete token
  catalog with values.
