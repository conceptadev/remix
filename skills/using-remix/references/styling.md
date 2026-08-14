# Styling Remix

Use this reference when a task needs a custom `*Styler`, interaction or context variants, animation, callable styles, Fortal-token overrides, or reusable app styles.

## Table of Contents

- [Fluent stylers](#fluent-stylers)
- [Interaction states](#interaction-states)
- [Context variants](#context-variants)
- [Animation](#animation)
- [Callable styles](#callable-styles)
- [Fortal tokens](#styling-with-fortal-tokens)
- [Reusable styles](#common-patterns)

## Fluent stylers

Every component's style is a chainable, immutable `*Styler`:

```dart
ButtonStyler()
    .color(Colors.blue)              // container fill (universal primitive)
    .borderRadius(.circular(12))     // circular radius shortcut
    .padding(.horizontal(24))
    .padding(.vertical(12))
    .labelColor(Colors.white)
    .labelFontSize(16)
    .labelFontWeight(FontWeight.w600)
    .iconColor(Colors.white)
    .iconSize(20)
    .spacing(8)                  // icon↔label gap (flex-based components)
```

Fluent surface shared by container-based stylers: `.color()`, `.gradient()`,
`.border()` / `.borderRadius()`, `.shadow()` /
`.shadows()` / `.elevation()`, `.padding()` / `.margin()` (compound forms,
e.g. `.padding(.horizontal(x))`), `.width()` / `.height()` / `.size()`, `.scale()` /
`.rotate()` / `.translate()`. Flex-based ones add `.spacing()`,
`.direction()`, `.mainAxisAlignment()`, `.crossAxisAlignment()`, `.row()`,
`.column()`. Component-part mixins add `.label*()` (color, fontSize,
fontWeight, letterSpacing, …), `.icon*()` (color, size, opacity, …), and
`.spinner*()` (indicatorColor, size, strokeWidth, …) where the component has
those parts. Use the canonical `.color()` method for component surfaces and
check the per-component reference for exact surface area. Keep slot-specific
color methods such as `.labelColor()`, `.iconColor()`, and `.textColor()` for
the corresponding component parts.

### Interaction States

State variants take a styler of the same type and merge it over the base:

```dart
ButtonStyler()
    .color(Colors.blue)
    .labelColor(Colors.white)
    .onHovered(ButtonStyler().color(Colors.blue.shade700))
    .onPressed(ButtonStyler().scale(0.97))
    .onFocused(ButtonStyler().border(.all(.color(Colors.white).width(2))))
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
    .padding(.horizontal(24))
    .onMobile(ButtonStyler().padding(.horizontal(16)).labelFontSize(14))
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
    .padding(.horizontal(24))
    .borderRadius(.circular(8));

primaryButton(label: 'Save', onPressed: save)   // → RemixButton
```

Generic surfaces use `call<T>()`: Accordion, Menu, Radio, SegmentedControl,
Select, and ToggleGroup. Dart can usually infer `T` from the required values or
item lists. All other leaf component stylers use a non-generic `call()` method.
Behavioral group/root widgets such as `RemixAccordionGroup`, `RemixRadioGroup`,
and `RemixTabs` are constructed directly because they do not have stylers.

### Styling with Fortal Tokens

Reference Fortal tokens in custom styles so they respect the active theme.
Call the token inside styler chains; `.mix()` for text-style tokens;
`.resolve(context)` for direct values in widget code:

```dart
ButtonStyler()
    .color(FortalTokens.accent9())
    .padding(.all(FortalTokens.space4()))
    .borderRadius(.all(FortalTokens.radius3()))
    .label(TextStyler().style(FortalTokens.text2.mix())
        .color(FortalTokens.accentContrast()))

Container(color: FortalTokens.colorBackground.resolve(context))
```

Token families: `accent1–12`, `gray1–12` (+ `accentA*`/`grayA*` alpha),
functional colors (`accentContrast`, `colorSurface`, …), `space1–9`,
`radius1–6` + `radiusFull`, `text1–9`, `shadow1–6`, font weights, and
transition durations. Full catalog: `fortal.md`.

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
