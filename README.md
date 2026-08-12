
<p align="center">
  <img alt="Remix banner" src="https://jtmo7uveygl6pnag.public.blob.vercel-storage.com/remix_banner.png" width="100%" />
</p>

A comprehensive Flutter component library that combines headless UI behavior with Mix's powerful styling system, giving you complete freedom to build and customize components that match your design system perfectly.

Remix brings together the best of both worlds: the robust interaction behavior and accessibility of Naked UI with the flexible, composable styling capabilities of Mix. This combination enables you to create components that are fully customizable, reusable, and maintainable.

## Agent skills

[![skills.sh](https://skills.sh/b/conceptadev/remix)](https://skills.sh/conceptadev/remix)

This repository publishes two skills from its [`skills/`](skills) catalog:

- [`using-remix`](https://skills.sh/conceptadev/remix/using-remix) helps agents build Flutter interfaces with base Remix or the optional Fortal theme.
- [`building-remix-design-system`](https://skills.sh/conceptadev/remix/building-remix-design-system) helps agents create standalone design-system packages on Remix.

List the available skills without installing them:

```bash
npx skills add conceptadev/remix --list
```

Install both skills, or select one:

```bash
npx skills add conceptadev/remix
npx skills add conceptadev/remix --skill using-remix -y
```

Project installs create a local agent-skills directory such as `.agents/`.
Contributors who do not want that directory in their checkout can install
globally or use a skill ephemerally:

```bash
npx skills add conceptadev/remix --skill using-remix -g -y
npx skills use conceptadev/remix@using-remix
```

List installed skills and update them later:

```bash
npx skills ls
npx skills update
```

### Vendored Mix skill

This repository commits the project-scoped Mix skill and its lockfile so Codex
and Claude Code use the same reviewed instructions. Install or refresh the
canonical copy and Claude symlink with:

```bash
npx skills add conceptadev/mix --skill mix --agent codex --agent claude-code -y
```

Update the committed installation from its locked project source with:

```bash
npx skills update mix --project -y
```

## Why Remix?

### The Problem

Flutter developers commonly face these challenges when building custom UIs:

- **Verbose styling** - Deep widget nesting makes code difficult to read and maintain
- **Complex state management** - Handling hover, focus, and press states requires extensive boilerplate
- **Style reusability** - Creating consistent, reusable component styles often leads to copied code
- **Animation overhead** - Adding smooth transitions requires significant setup

### The Solution

```dart
final style = ButtonStyler()
  .padding(.horizontal(16))
  .padding(.vertical(10))
  .color(Colors.blue)
  .borderRadius(.all(const Radius.circular(8)))
  .animate(AnimationConfig.spring(300.ms))
  .onHovered(.color(Colors.blue.shade700));

RemixButton(
  onPressed: () {},
  label: 'Click me',
  style: style,
);
```

Or using callable styles:
```dart
final button = ButtonStyler()
  .padding(.horizontal(16))
  .padding(.vertical(10))
  .color(Colors.blue)
  .borderRadius(.all(const Radius.circular(8)))
  .onHovered(.color(Colors.blue.shade700))
  .animate(AnimationConfig.spring(300.ms));

button(
  label: 'Click me',
  onPressed: () {},
); // return RemixButton Widget.
```

With Remix, you get:
- **Ready-to-use components** with all the behavior, accessibility, and keyboard navigation built-in
- **Complete styling freedom** using Mix's powerful, chainable styling API
- **State-aware styling** with built-in support for hover, focus, press, and custom states
- **Smooth animations** that work seamlessly with your style definitions

## Quick Start

### Installation

Add Remix to your project:

```bash
flutter pub add remix
```

Or add it to your `pubspec.yaml`:

```yaml
dependencies:
  remix: ^1.0.0
```

### Your First Component

Let's build your first button with Remix. This simple example demonstrates how easy it is to create a fully customizable component using Remix's styling API.

```dart
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

class MyApp extends StatelessWidget {

  final button = ButtonStyler()
    .padding(.horizontal(16))
    .padding(.vertical(10))
    .color(Colors.blue)
    .borderRadius(.all(const Radius.circular(8)))
    .label(TextStyler().color(Colors.white));

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.blue,
      builder: (_, _) => Center(
        child: button(
          label: 'Click Me',
          onPressed: () => debugPrint('Button pressed!'),
        ),
      ),
    );
  }
}
```

### Adding Interaction States

Easily define how components should look in different interaction states.

```dart
final button = ButtonStyler()
  .padding(.horizontal(16))
  .padding(.vertical(10))
  .color(Colors.blue)
  .borderRadius(.all(const Radius.circular(8)))
  .label(TextStyler().color(Colors.white))
  .onHovered(.color(Colors.blue.shade700))
  .onPressed(.scale(0.95));
```

### Adding Animation

Make your button style smoothly animate when its state changes by chaining `.animate()` with your state-specific styles. You can use `AnimationConfig.spring` to get natural, spring-based motion.

```dart
final style = ButtonStyler()
  .padding(.horizontal(16))
  .padding(.vertical(10))
  .color(Colors.blue)
  .borderRadius(.all(const Radius.circular(8)))
  .animate(AnimationConfig.spring(300.ms))
  .onHovered(.color(Colors.blue.shade700))
  .onPressed(.scale(0.95));
```

This example animates both the color on hover and the scale on press, creating a smooth interactive experience for your users. 

> **Note:** Animation support is built using the powerful Mix API. To dive deeper into animated styles, visit the [Mix Repository](https://github.com/btwld/mix) for more capabilities and advanced examples with keyframes and Phase Animations.

### Style Composition and Reuse

Create base styles and extend them to build variants:

```dart
final baseButtonStyle = ButtonStyler()
    .padding(.horizontal(16))
    .padding(.vertical(10))
    .borderRadius(.all(const Radius.circular(8)));

final primaryButton = baseButtonStyle
    .color(Colors.blue)
    .label(TextStyler().color(Colors.white));

final destructiveButton = baseButtonStyle
    .color(Colors.red)
    .label(TextStyler().color(Colors.white));
```

## Theming with Fortal

Remix ships no theme of its own. If you want a polished, Radix Themes-inspired
starting point instead of authoring every style yourself, add the companion
[`remix_fortal`](https://pub.dev/packages/remix_fortal) package — it provides
`FortalScope`, a token system, the `fortal*Style()` recipes, and a matching
catalog of ready-made `Fortal*` widgets.

See the [Fortal documentation](https://docs.page/btwld/remix/fortal) to get
started.

## Host Capabilities

Remix composes inside your existing Flutter host. It does not require a
`MaterialApp`, `Scaffold`, or Remix-owned application wrapper.

| UI | Caller provides | Compatible hosts |
|----|-----------------|------------------|
| Ordinary `Remix*` widgets | The inherited Flutter services used by the widget subtree | Material, Cupertino, Widgets, and router-based hosts |
| Widgets styled by a theme package such as Fortal | That package's token scope, in addition to the widget's normal Flutter services | Any Flutter host |
| Menu, select, popover, and tooltip | An `Overlay` | Any host exposing an overlay; use `Overlay.wrap` when no `Navigator` is needed |
| `showRemixDialog` and `showRemixAlertDialog` | A `Navigator` | Any host with a caller-owned navigator |

For a portal-based interface without routing, provide only an overlay:

```dart
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

Widget buildPortalHost() {
  return WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (_, _) => Overlay.wrap(
      child: Center(
        child: RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Actions'),
          items: const [
            RemixMenuItem(value: 'share', label: 'Share'),
          ],
        ),
      ),
    ),
  );
}
```

A `MaterialApp`, `CupertinoApp`, `WidgetsApp`, or router with routing configured
commonly provides a `Navigator` and its overlay already. Dialog helpers push
routes, so their calling context must be below that caller-owned `Navigator`.

## Components

Remix provides a comprehensive set of production-ready components:

### Interactive Elements
- **Button** - Clickable actions with full styling control
- **IconButton** - Icon-based actions
- **Switch** - Toggle controls
- **Toggle** - Two-state on/off buttons
- **Checkbox** - Multiple selection
- **CheckboxGroup** - Coordinated multiple selection with composable checkbox visuals
- **Radio** - Single selection from a group
- **Slider** - Continuous value selection

### Input Components
- **TextField** - Text input with validation support
- **TextArea** - Multiline text input with safe auto-growing defaults
- **Select** - Dropdown selection with keyboard navigation

### Display Components
- **Avatar** - User avatars and images
- **Badge** - Status indicators and labels
- **Card** - Content containers
- **DataList** - Label/value metadata lists with a shared label column
- **DataTable** - Controlled tables with shared column headers, sorting, selection, and pagination
- **Divider** - Visual separators
- **Progress** - Progress indicators
- **Skeleton** - Loading placeholders that mirror their content
- **Spinner** - Loading states

### Layout & Navigation
- **Tabs** - Tabbed navigation
- **Accordion** - Collapsible content sections
- **Menu** - Context menus and dropdowns
- **SegmentedControl** - Equal-segment controlled single selection

### Overlays
- **Dialog** - Modal dialogs
- **Tooltip** - Contextual help
- **Callout** - Highlighted information blocks

## Who is Remix for?

Remix is ideal for:
- **Teams building custom design systems** who need full control over component appearance
- **Developers requiring complex state management** with multiple variants and interaction states
- **Applications needing consistent styling** across dozens of components

## Examples

Check out `apps/dashboard`, `apps/demo`, and the per-package examples in
`packages/remix/example` and `packages/remix_fortal/example` for complete working examples demonstrating:
- Component usage patterns
- Style composition techniques
- Design system implementation
- Advanced customization

---

Built with ❤️ using [Mix](https://github.com/btwld/mix) and [Naked UI](https://github.com/btwld/naked_ui)
