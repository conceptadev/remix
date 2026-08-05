
<p align="center">
  <img alt="Remix banner" src="https://jtmo7uveygl6pnag.public.blob.vercel-storage.com/remix_banner.png" width="100%" />
</p>

A comprehensive Flutter component library that combines headless UI behavior with Mix's powerful styling system, giving you complete freedom to build and customize components that match your design system perfectly.

Remix brings together the best of both worlds: the robust interaction behavior and accessibility of Naked UI with the flexible, composable styling capabilities of Mix. This combination enables you to create components that are fully customizable, reusable, and maintainable.

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
  .paddingX(16)
  .paddingY(10)
  .color(Colors.blue)
  .borderRadiusAll(const Radius.circular(8))
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
  .paddingX(16)
  .paddingY(10)
  .color(Colors.blue)
  .borderRadiusAll(const Radius.circular(8))
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
    .paddingX(16)
    .paddingY(10)
    .color(Colors.blue)
    .borderRadiusAll(const Radius.circular(8))
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
  .paddingX(16)
  .paddingY(10)
  .color(Colors.blue)
  .borderRadiusAll(const Radius.circular(8))
  .label(TextStyler().color(Colors.white))
  .onHovered(.color(Colors.blue.shade700))
  .onPressed(.scale(0.95));
```

### Adding Animation

Make your button style smoothly animate when its state changes by chaining `.animate()` with your state-specific styles. You can use `AnimationConfig.spring` to get natural, spring-based motion.

```dart
final style = ButtonStyler()
  .paddingX(16)
  .paddingY(10)
  .color(Colors.blue)
  .borderRadiusAll(const Radius.circular(8))
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
    .paddingX(16)
    .paddingY(10)
    .borderRadiusAll(const Radius.circular(8));

final primaryButton = baseButtonStyle
    .color(Colors.blue)
    .label(TextStyler().color(Colors.white));

final destructiveButton = baseButtonStyle
    .color(Colors.red)
    .label(TextStyler().color(Colors.white));
```

## The Fortal Widgets

While Remix gives you complete freedom to build any design system, it also includes **Fortal Design System** - a comprehensive set of prebuilt styles based on Radix. These styles provide a polished, modern UI out of the box while maintaining full customizability.

### Quick Start with Fortal

To use Fortal widgets, wrap your app with `FortalScope` to provide the design tokens, then use the generated `Fortal*` widgets. Named constructors select a fixed variant; use the unnamed constructor with `variant:` when the choice is dynamic:

```dart
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FortalScope(
      child: WidgetsApp(
        color: Colors.white,
        builder: (_, _) => Center(
          child: FortalButton.solid(
            onPressed: () {},
            label: 'Fortal Button',
          ),
        ),
      ),
    );
  }
}
```

### Host Capabilities

Remix composes inside your existing Flutter host. It does not require a
`MaterialApp`, `Scaffold`, or Remix-owned application wrapper.

| UI | Caller provides | Compatible hosts |
|----|-----------------|------------------|
| Ordinary `Remix*` widgets | The inherited Flutter services used by the widget subtree | Material, Cupertino, Widgets, and router-based hosts |
| `Fortal*` widgets and recipes | `FortalScope`, in addition to the widget's normal Flutter services | Any Flutter host |
| Menu, select, popover, and tooltip | An `Overlay` | Any host exposing an overlay; use `Overlay.wrap` when no `Navigator` is needed |
| `showRemixDialog` and `showRemixAlertDialog` | A `Navigator` | Any host with a caller-owned navigator |

For a portal-based interface without routing, provide only an overlay:

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

A `MaterialApp`, `CupertinoApp`, `WidgetsApp`, or router with routing configured
commonly provides a `Navigator` and its overlay already. Dialog helpers push
routes, so their calling context must be below that caller-owned `Navigator`.

### Customizing Fortal Styles

Generated Fortal widgets call the matching `fortal*Style` recipe internally.
Use those recipes directly when you need a custom Remix widget composition:

```dart
final style = fortalButtonStyle(variant: FortalButtonVariant.solid)
  .borderRadiusAll(const Radius.circular(8))
  .paddingX(32)
  .onHovered(.scale(1.05));
```

### Fortal Design Tokens

Fortal styles are built on a robust token system that includes:

- **Colors**: 12-step accent and gray scales (powered by Radix Colors)
- **Spacing**: 9-step spacing scale
- **Border Radius**: 6-step radius scale
- **Shadows**: 6-level shadow system
- **Typography**: 9-size type scale
- **Border Widths**: Consistent stroke weights

You can use these tokens directly in your custom styles:

```dart
final style = ButtonStyler()
  .color(FortalTokens.accent9())
  .paddingAll(FortalTokens.space4())
  .borderRadiusAll(FortalTokens.radius3())
  .label(TextStyler().color(FortalTokens.accentContrast()));
```

## Components

Remix provides a comprehensive set of production-ready components:

### Interactive Elements
- **Button** - Clickable actions with full styling control
- **IconButton** - Icon-based actions
- **Switch** - Toggle controls
- **Toggle** - Two-state on/off buttons
- **Checkbox** - Multiple selection
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
- **Divider** - Visual separators
- **Progress** - Progress indicators
- **Spinner** - Loading states

### Layout & Navigation
- **Tabs** - Tabbed navigation
- **Accordion** - Collapsible content sections
- **Menu** - Context menus and dropdowns

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

Check out the `demo` and `example` directories for complete working examples demonstrating:
- Component usage patterns
- Style composition techniques
- Design system implementation
- Advanced customization

---

Built with ❤️ using [Mix](https://github.com/btwld/mix) and [Naked UI](https://github.com/btwld/naked_ui)
