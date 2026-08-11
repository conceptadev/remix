# Fortal

A Radix Themes-inspired preset theme and widget catalog for
[Remix](https://pub.dev/packages/remix).

Remix gives you complete freedom to build any design system, which also means it
ships no theme of its own. Fortal is the ready-made alternative: a comprehensive
set of prebuilt styles based on
[Radix Themes 3.3.0](https://www.radix-ui.com/themes), providing a polished,
modern UI out of the box while remaining fully customizable.

Fortal lives in its own package so that `remix` stays genuinely theme-free. If
you are building your own design system on Remix, you pay nothing for a theme you
never use — no token tables, no Radix color data, no parity contract.

## Installation

```bash
flutter pub add remix_fortal
```

`remix_fortal` depends on `remix` and does not re-export it. Import both when you
need base Remix widgets alongside Fortal ones.

## Quick Start

Wrap your app with `FortalScope` to provide the design tokens, then use the
`Fortal*` widgets. Named constructors select a fixed variant; use the unnamed
constructor with `variant:` when the choice is dynamic:

```dart
import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

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

`FortalScope` is a `MixScope`. Place it above your app widget so that overlay and
route content inherits the tokens.

## Customizing Fortal styles

Fortal widgets call the matching `fortal*Style` recipe internally. Use those
recipes directly when you need a custom Remix widget composition:

```dart
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

final style = fortalButtonStyle(variant: FortalButtonVariant.solid)
  .borderRadius(.all(const Radius.circular(8)))
  .padding(.horizontal(32))
  .onHovered(.scale(1.05));
```

## Design tokens

Fortal styles are built on a token system that includes:

- **Colors**: 12-step accent and gray scales (powered by Radix Colors)
- **Spacing**: 9-step spacing scale
- **Border Radius**: 6-step radius scale
- **Shadows**: 6-level shadow system
- **Typography**: 9-size type scale
- **Border Widths**: Consistent stroke weights

You can use these tokens directly in your own styles:

```dart
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

final style = ButtonStyler()
  .color(FortalTokens.accent9())
  .padding(.all(FortalTokens.space4()))
  .borderRadius(.all(FortalTokens.radius3()))
  .label(TextStyler().color(FortalTokens.accentContrast()));
```

## Covered components

Every Remix component has a matching Fortal recipe and generated widget:

### Interactive Elements
- **FortalButton**, **FortalIconButton**, **FortalSwitch**, **FortalToggle**
- **FortalCheckbox**, **FortalRadio**, **FortalSlider**

### Input Components
- **FortalTextField**, **FortalTextArea**, **FortalSelect**

### Display Components
- **FortalAvatar**, **FortalBadge**, **FortalCard**, **FortalDataList**
- **FortalDataTable**, **FortalDivider**, **FortalProgress**
- **FortalSkeleton**, **FortalSpinner**

### Layout & Navigation
- **FortalTabBar**, **FortalTab**, **FortalTabView**, **FortalAccordion**
- **FortalMenu**, **FortalSegmentedControl**, **FortalToggleGroup**

There is no `FortalTabs`: the behavioral root stays `RemixTabs`, which takes no
style. The same applies to the other behavioral roots (`RemixRadioGroup`,
`RemixCheckboxGroup`, `RemixAccordionGroup`).

### Overlays
- **FortalDialog**, **FortalTooltip**, **FortalPopover**, **FortalCallout**

## Radix parity

Fortal's mapping to Radix Themes 3.3.0 is enforced by a checked-in parity
contract (`reference/radix_themes_3_3_0/`) verified in CI. Every mapped family
documents its upstream selectors, supported style props, and the tests that cover
them.

## Built on Remix

Fortal is a preset, not a fork. Every `Fortal*` widget is a thin generated
wrapper that calls the corresponding `Remix*` constructor with a `fortal*Style()`
recipe. Anything you can do with Remix, you can do with Fortal — and you can drop
down to plain Remix stylers at any point.

- [Remix on pub.dev](https://pub.dev/packages/remix)
- [Documentation](https://docs.page/btwld/remix/fortal)
- [GitHub](https://github.com/btwld/remix)

## License

BSD-3-Clause. See [LICENSE](LICENSE).
