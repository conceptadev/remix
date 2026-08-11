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
  .borderRadiusAll(const Radius.circular(8))
  .paddingX(32)
  .onHovered(.scale(1.05));
```

## Charts

Fortal includes themed line, bar, and pie chart recipes backed by
[`mix_chart`](https://pub.dev/packages/mix_chart). Add `mix_chart` directly when
constructing chart data; Fortal intentionally does not re-export dependencies.

```bash
flutter pub add mix_chart remix_fortal
```

```dart
import 'package:mix_chart/mix_chart.dart';
import 'package:remix_fortal/remix_fortal.dart';

final chart = FortalLineChart(
  semanticsLabel: 'Weekly revenue',
  series: [
    LineSeries(
      id: 'revenue',
      label: 'Revenue',
      points: [
        ChartPoint(id: 'mon', x: 0, y: 18),
        ChartPoint(id: 'tue', x: 1, y: 31),
      ],
    ),
  ],
);
```

The generated widgets are `FortalLineChart`, `FortalBarChart`, and
`FortalPieChart`. Use `fortalLineChartStyle`, `fortalBarChartStyle`, or
`fortalPieChartStyle` when composing the underlying `mix_chart` widgets. Keep
shared geometry on the chart-level slice style so individual slices remain
data-only:

```dart
final donut = PieChart(
  style: fortalPieChartStyle(centerRadius: 40)
      .slice(PieSliceStyler().radius(36)),
  slices: [
    PieSlice(id: 'core', label: 'Core', value: 54),
    PieSlice(id: 'teams', label: 'Teams', value: 46),
  ],
);
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
  .paddingAll(FortalTokens.space4())
  .borderRadiusAll(FortalTokens.radius3())
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
- **FortalLineChart**, **FortalBarChart**, **FortalPieChart**

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
