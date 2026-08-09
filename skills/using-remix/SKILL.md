---
name: using-remix
description: >-
  Use when building Flutter UI with the Remix component library or its
  companion Fortal theme package (`remix_fortal`): selecting Remix or Fortal,
  adding dependencies, placing `FortalScope`, composing overlays or routes,
  choosing Remix/Fortal components, or styling `Remix*` widgets with stylers,
  states, variants, recipes, and tokens. Also trigger for Remix/Fortal widget
  names or a UI request in a project that already depends on `remix` or
  `remix_fortal`. Do not trigger for generic Flutter UI work when neither
  package is present or requested.
---

# Using Remix

Build accessible Flutter interfaces with Remix behavior and either custom
styles or Fortal's ready-made Radix-inspired theme. For a new standalone
design-system package built on Remix, use `building-remix-design-system`.

## Choose the package layer

Inspect the project's `pubspec.yaml` before assuming Remix is in use.

| Need | Package and API |
| --- | --- |
| Accessible component behavior with a custom visual system | `remix`; use `Remix*` widgets and `*Styler`s |
| Ready-made Radix-inspired visuals | `remix_fortal`; use `FortalScope` and `Fortal*` widgets |
| Fortal tokens with a customized composition | both packages; apply `fortal*Style()` to a `Remix*` widget |
| A visual system unrelated to Fortal | base Remix styling; do not add `remix_fortal` |

Remix ships no theme. Fortal is optional, lives in a separate package, depends
on Remix, and does not re-export Remix APIs.

## Set up dependencies and imports

For base Remix:

```bash
flutter pub add remix
```

```dart
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
```

For Fortal, add its separate dependency:

```bash
flutter pub add remix_fortal
```

```dart
import 'package:flutter/widgets.dart';
import 'package:remix_fortal/remix_fortal.dart';
```

Also import `package:remix/remix.dart` when the file uses `Remix*` widgets,
`*Styler` types, or Remix data classes alongside Fortal.

## Place FortalScope correctly

Every subtree that renders a `Fortal*` widget, a `fortal*Style()` recipe, or a
`FortalTokens` value needs `FortalScope`. Place the scope above the application
or router when overlay entries and pushed routes must inherit its tokens:

```dart
FortalScope(
  accent: FortalAccentColor.indigo,
  gray: FortalGrayColor.slate,
  brightness: Brightness.light,
  child: WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (_, _) => const MyScreen(),
  ),
)
```

Ordinary `Remix*` widgets with fully custom styles do not need `FortalScope`.

## Provide only the host capabilities in use

Remix composes inside the caller's host. Do not invent `RemixApp`,
`RemixScaffold`, or `RemixOverlayHost` wrappers.

| UI | Caller must provide |
| --- | --- |
| Ordinary widgets | Normal inherited Flutter services for that subtree |
| Fortal widgets or recipes | `FortalScope` plus normal Flutter services |
| Menu, select, popover, tooltip | An `Overlay`; use `Overlay.wrap` when no navigator is needed |
| `showRemixDialog` or `showRemixAlertDialog` | A caller-owned `Navigator` |

`MaterialApp`, `CupertinoApp`, `WidgetsApp`, and router-based hosts are all
valid. A host with routing commonly provides both a navigator and its overlay.

For a portal-only subtree:

```dart
FortalScope(
  child: WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (_, _) => Overlay.wrap(
      child: FortalMenu<String>.soft(
        trigger: const RemixMenuTrigger(label: 'Actions'),
        items: const [RemixMenuItem(value: 'share', label: 'Share')],
      ),
    ),
  ),
)
```

## Choose a styling path

1. Prefer a `Fortal*` preset for standard Fortal UI. Use a named constructor
   such as `FortalButton.soft(...)` when the variant is fixed.
2. Use the unnamed Fortal constructor with `variant:` only when the variant is
   selected at runtime.
3. Start from `fortal*Style()` and pass the result to a `Remix*` widget when
   Fortal is the baseline but the composition or styling needs overrides.
4. Build a `*Styler` from scratch when the design should not use Fortal.

Base Remix example:

```dart
final submitStyle = ButtonStyler()
    .color(const Color(0xFF3E63DD))
    .paddingX(16)
    .paddingY(10)
    .borderRounded(6)
    .labelColor(const Color(0xFFFFFFFF))
    .onHovered(ButtonStyler().color(const Color(0xFF3358D4)));

RemixButton(label: 'Submit', style: submitStyle, onPressed: submit)
```

Fortal recipe with an override:

```dart
RemixButton(
  label: 'Save',
  onPressed: save,
  style: fortalButtonStyle(variant: .solid)
      .paddingX(32)
      .borderRounded(8),
)
```

Do not infer that every component has the same variants or sizes. Check the
Fortal reference for the exact family.

## Preserve behavioral roots

Some coordination APIs remain base Remix even when their children use Fortal:

- Use `RemixTabs` as the behavioral root with `FortalTabBar`, `FortalTab`, and
  `FortalTabView`; there is no `FortalTabs`.
- Keep `RemixRadioGroup`, `RemixCheckboxGroup`, and `RemixAccordionGroup` as
  roots around their Fortal-styled children.
- Provide the required `RemixAccordionGroup.controller`; tabs and menus can
  manage optional controllers.

## Route to references

Read only the references needed for the task:

| Task | Reference |
| --- | --- |
| Pick a component category | [Component index](references/components.md) |
| Buttons, icon buttons, toggles, and toggle groups | [Actions](references/actions.md) |
| Form controls, text areas, and selection | [Forms](references/forms.md) |
| Cards, data lists/tables, loading, and display widgets | [Data display](references/data-display.md) |
| Popovers, dialogs, tooltips, menus, and host requirements | [Overlays](references/overlays.md) |
| Tabs and accordions | [Navigation](references/navigation.md) |
| Fluent styling, state/context variants, animation, callable styles | [Styling](references/styling.md) |
| Fortal setup, presets, variants, sizes, scope, and tokens | [Fortal](references/fortal.md) |

## Verify the result

- Keep imports aligned with the selected package layer.
- Confirm Fortal content and route/overlay builders are below `FortalScope`.
- Confirm overlays and dialogs have the required caller-owned host capability.
- Run the project's formatter, analyzer, and relevant Flutter tests.
