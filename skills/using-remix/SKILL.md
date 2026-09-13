---
name: using-remix
description: >-
  Use when building Flutter UI with the Remix component library or its
  application-owned Fortal preset: selecting Remix or Fortal, setting up
  `remix_cli`, placing the configured theme scope, composing overlays or routes,
  choosing Remix/Fortal components, or styling `Remix*` widgets with stylers,
  states, variants, recipes, and tokens. Also trigger when building or auditing
  a Remix/Fortal reference showcase or component gallery, for Remix/Fortal
  widget names, or for a UI request in a project that already contains
  `remix`, `remix.yaml`, or the legacy `remix_fortal` package. Do not trigger
  for generic Flutter UI work when none of those are present or requested.
---

# Using Remix

Build accessible Flutter interfaces with Remix behavior and either custom
styles or Fortal's ready-made Radix-inspired theme. For a new standalone
design-system package built on Remix, use `building-remix-design-system`.

## Choose the source layer

Inspect the project's `pubspec.yaml` and `remix.yaml` before assuming how Remix
is configured.

| Need | Source and API |
| --- | --- |
| Accessible component behavior with a custom visual system | `remix`; use `Remix*` widgets and `*Styler`s |
| Ready-made Radix-inspired visuals | `remix_cli` with `preset: fortal`; use the configured scope and prefixed widgets |
| Fortal tokens with a customized composition | installed Fortal source plus `remix`; apply the prefixed recipe to a `Remix*` widget |
| Agent-run surfaces (composer, transcript, permission, plan) | `remix_agent`; use `Agent*` widgets. It depends on `remix` only, has no registry item, and takes its appearance from the application's installed recipes. |
| A visual system unrelated to Fortal | base Remix styling; do not initialize the Fortal preset |

Remix ships no theme. Fortal is optional application-owned source installed by
the CLI. The repository's `remix_fortal` workspace package is its analyzed
authoring and parity surface, not a dependency for new consumer applications.
Preserve an existing legacy `remix_fortal` dependency unless the user asks to
migrate it; do not add that dependency to a new consumer.

## Set up dependencies and imports

For base Remix:

```bash
flutter pub add remix
```

```dart
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
```

For a new Fortal consumer, initialize the preset and add the needed items:

This checkout prepares the first CLI release and requires Remix beta.9.
Until both releases are available, use the checkout setup in
`packages/remix_cli/README.md`. Use the hosted commands below after publication.

```bash
flutter pub add dev:remix_cli
dart run remix_cli:remix init --prefix Fortal --preset fortal
dart run remix_cli:remix add button
```

```dart
import 'package:flutter/widgets.dart';
import 'ui/ui.dart';
```

The examples in this skill use `--prefix Fortal`; honor the prefix already
recorded in `remix.yaml` for an initialized project. Add each recipe before
using it. Also import `package:remix/remix.dart` when the file uses `Remix*`
widgets, `*Styler` types, or Remix data classes that the owned barrel does not
export.

## Place FortalScope correctly

Every subtree that renders a `Fortal*` widget, a `fortal*Style()` recipe, or a
`FortalTokens` value needs `FortalScope`. The outermost scope also establishes
a courtesy `DefaultTextStyle` for bare Flutter `Text`: the Radix theme root run
of `text3` at `gray-12`, regular weight, and no pinned font family. This is a
fallback for ordinary Flutter text, analogous to Material's `bodyMedium`; it
does not supply the text run for Fortal typography, which resolves its own
token defaults. Transparent, non-accent `FortalCode.ghost` deliberately keeps
only the ambient foreground so inline code can blend with surrounding text.

Placement depends on the host, and getting it wrong costs that courtesy
bare-`Text` fallback:

**`WidgetsApp` or a custom host — put the scope above the app.**

```dart
FortalScope(
  accent: FortalAccentColor.indigo,
  gray: FortalGrayColor.slate,
  mode: FortalThemeMode.system,
  child: WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (_, _) => const MyScreen(),
  ),
)
```

**Routed `WidgetsApp` — put the scope in `builder`.**

```dart
WidgetsApp(
  color: const Color(0xFFFFFFFF),
  pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
  ),
  builder: (context, child) => FortalScope(
    accent: FortalAccentColor.indigo,
    child: child!,
  ),
  home: const MyScreen(),
)
```

The builder wraps the Navigator, so pushed routes and overlays inherit the
scope. Use `WidgetsApp` in documentation and runnable examples; do not introduce
Material application hosts. A default WidgetsApp preserves an outer scope’s
text defaults. An explicit WidgetsApp `textStyle` or a nearer `DefaultTextStyle`
can override them; placing the scope in the builder establishes its defaults
below the app’s text style.

A nested `FortalScope` re-scopes tokens only; it does not restate the courtesy
bare-`Text` run. Ordinary `Remix*` widgets with fully custom styles do not need
`FortalScope`.

## Theme selection

Use `theme`, `darkTheme`, and `mode`; do not introduce a `lightTheme` parameter
or a new application wrapper. Keep `WidgetsApp` as the host.

- A root with neither theme supplies preset light/dark defaults and follows the system.
- Supplying only `theme` uses that value in both modes. Supplying only `darkTheme`
  retains the default or inherited base theme. Direct scope design overrides
  such as `accent` apply to both appearances.
- An empty nested scope inherits the configured pair and active selection.
  An explicit nested `mode` can select from the inherited pair.
- The app owns the mode preference and persistence. `mode: .system` reacts to
  platform brightness changes; no application brightness observer is needed.
- Generated default scopes use `<Prefix>ThemeScope`; generated Fortal scopes use
  `<Prefix>Scope`. Both export `<Prefix>ThemeData` and `<Prefix>ThemeMode`.
- No compatibility aliases: scope `data`, scope `brightness`, and config
  `createScope` are removed. Use `theme` for fixed values and `mode` to select
  appearance. Brightness remains a resolved theme-data property.

```dart
FortalScope(
  theme: const FortalThemeData.light(),
  darkTheme: const FortalThemeData.dark(),
  mode: FortalThemeMode.system,
  child: child,
)
```

These APIs are the required standard. Migrate older installed scopes and their
callers together; do not add compatibility aliases. Preserve application-owned
custom tokens while updating generated source.

## Provide only the host capabilities in use

Remix composes inside the caller's host. Do not invent `RemixApp`,
`RemixScaffold`, or `RemixOverlayHost` wrappers.

| UI | Caller must provide |
| --- | --- |
| Ordinary widgets | Normal inherited Flutter services for that subtree |
| Fortal widgets or recipes | `FortalScope` plus normal Flutter services |
| Menu, select, popover, tooltip | An `Overlay`; use `Overlay.wrap` when no navigator is needed |
| `showRemixDialog` or `showRemixAlertDialog` | A caller-owned `Navigator` |

Use `WidgetsApp` for new application scaffolding and examples, including routed
applications. Existing Material or Cupertino applications can host Remix at
runtime; that interoperability does not change the authoring standard. A routed
WidgetsApp provides a navigator and its overlay.

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

`RemixMenuTrigger` is a configuration object, not a widget. The same object
works with `FortalMenu`. For richer visual content, use
`RemixMenuTrigger.builder` and return non-interactive content — never a nested
button:

```dart
FortalMenu<String>(
  trigger: RemixMenuTrigger.builder(
    label: 'Account menu',
    builder: (context, state, defaultTrigger) =>
        const FortalAvatar(label: 'LF'),
  ),
  items: const [RemixMenuItem(value: 'profile', label: 'View profile')],
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
    .padding(.horizontal(16))
    .padding(.vertical(10))
    .borderRadius(.circular(6))
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
      .padding(.horizontal(32))
      .borderRadius(.circular(8)),
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
| Tabs, accordions, and disclosures | [Navigation](references/navigation.md) |
| Fluent styling, state/context variants, animation, callable styles | [Styling](references/styling.md) |
| Fortal setup, presets, variants, sizes, scope, and tokens | [Fortal](references/fortal.md) |
| Text, headings, inline code, keyboard keys, and links | [Fortal](references/fortal.md#typography) |
| Reference apps, product examples, variant matrices, and showcase audits | [Reference showcases](references/reference-showcases.md) |

## Verify the result

- Keep imports aligned with the selected source layer and configured prefix.
- Confirm Fortal content and route/overlay builders are below `FortalScope`.
- Confirm overlays and dialogs have the required caller-owned host capability.
- For showcases, verify product examples and exhaustive coverage use their
  respective rules instead of forcing one abstraction or contrast policy onto
  both.
- Run the project's formatter, analyzer, and relevant Flutter tests.
