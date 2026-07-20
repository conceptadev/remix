
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
final style = RemixButtonStyler()
  .paddingX(16)
  .paddingY(10)
  .color(Colors.blue)
  .borderRadiusAll(const Radius.circular(8))
  .animate(AnimationConfig.spring(300.ms))
  .onHovered(.color(Colors.blue.shade700));

RemixButton(
  onPressed: () {},
  child: const Text('Click me'),
  style: style,
);
```

Or using callable styles:
```dart
final button = RemixButtonStyler()
  .paddingX(16)
  .paddingY(10)
  .color(Colors.blue)
  .borderRadiusAll(const Radius.circular(8))
  .onHovered(.color(Colors.blue.shade700))
  .animate(AnimationConfig.spring(300.ms));

button(
  child: const Text('Click me'),
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
  remix: ^1.0.0-beta.1
```

### Your First Component

Let's build your first button with Remix. This simple example demonstrates how easy it is to create a fully customizable component using Remix's styling API.

```dart
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

class MyApp extends StatelessWidget {

  final button = RemixButtonStyler()
    .paddingX(16)
    .paddingY(10)
    .color(Colors.blue)
    .borderRadiusAll(const Radius.circular(8))
    .label(TextStyler().color(Colors.white));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: button(
            child: const Text('Click Me'),
            onPressed: () => debugPrint('Button pressed!'),
          ),
        ),
      ),
    );
  }
}
```

### Adding Interaction States

Easily define how components should look in different interaction states.

```dart
final button = RemixButtonStyler()
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
final style = RemixButtonStyler()
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
final baseButtonStyle = RemixButtonStyler()
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

While Remix gives you complete freedom to build any design system, it also includes **Fortal Design System**: a set of prebuilt styles aligned with the mapped component contract from Radix Themes 3.3.0. Accordion, Toggle, and ToggleGroup are documented Fortal extensions rather than Radix parity families.

### Quick Start with Fortal

Put `FortalScope` above the app widget so platform appearance and every overlay inherit the same resolved theme. Each `Fortal*` widget has one enum-based constructor; pass `variant:` and `size:` explicitly when they differ from the component defaults:

```dart
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FortalScope(
      appearance: .inherit,
      accentColor: .indigo,
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: FortalButton(
              variant: .solid,
              onPressed: () {},
              child: const Text('Fortal Button'),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Customizing Fortal Styles

Fortal widgets call the matching `fortal*Styler` internally. Use those stylers directly when you need a custom Remix widget composition:

```dart
final style = fortalButtonStyler(variant: FortalButtonVariant.solid)
  .borderRadiusAll(const Radius.circular(8))
  .paddingX(32)
  .onHovered(.scale(1.05));
```

### Fortal Design Tokens

Fortal styles are built on a robust token system that includes:

- **Colors**: 12-step accent and gray scales (powered by Radix Colors)
- **Spacing**: 9-step spacing scale
- **Border Radius**: 6-step radius scale plus theme-derived control radii
- **Surfaces and Shadows**: layered fills, gradients, outer/inset shadows, overlays, and backdrop blur
- **Typography**: 9-size type scale
- **Border Widths**: Consistent stroke weights

You can use these tokens directly in your custom styles:

```dart
final style = RemixButtonStyler()
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
- **ToggleGroup** - Single-select segmented controls

### Overlays
- **Dialog** - Modal dialogs
- **Popover** - Anchored interactive content
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
