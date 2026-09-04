# Fortal authoring package

A Radix Themes-inspired preset theme and widget catalog for
[Remix](https://pub.dev/packages/remix).

Remix gives you complete freedom to build any design system, which also means it
ships no theme of its own. Fortal is the ready-made alternative: a comprehensive
set of prebuilt styles based on
[Radix Themes 3.3.0](https://www.radix-ui.com/themes), providing a polished,
modern UI out of the box while remaining fully customizable.

This workspace package is no longer released for consumers. It is the
analyzer-checked source of truth for the application-owned `fortal` preset
bundled with `remix_cli`, plus the target of Fortal's tests and Radix parity
checks. Consumer applications copy the source into their own project instead
of depending on `remix_fortal`.

## Installation

```bash
flutter pub add dev:remix_cli
dart run remix_cli:remix init --prefix Fortal --preset fortal
dart run remix_cli:remix add button
```

The `Fortal` prefix preserves the API names in this guide. Add each additional
item when you use it, then import the generated `lib/ui/ui.dart` barrel from
application code.

## Quick Start

Wrap your app with `FortalScope` to provide the design tokens, then use the
`Fortal*` widgets. Named constructors select a fixed variant; use the unnamed
constructor with `variant:` when the choice is dynamic:

```dart
import 'package:flutter/widgets.dart';
import 'ui/ui.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FortalScope(
      child: WidgetsApp(
        color: const Color(0xFFFFFFFF),
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

`FortalScope` is a `MixScope`. The outermost one also establishes the Radix
theme root's `text3` at `gray-12` run as a courtesy `DefaultTextStyle` for bare
Flutter `Text`. Fortal typography does not depend on that inherited run:
unsized `FortalText`, `FortalCode`, `FortalKbd`, and `FortalLink` resolve their
documented defaults directly from the active scope's tokens. A nested scope
re-scopes those tokens without restating the courtesy bare-`Text` run. The one
deliberate foreground exception is transparent, non-accent `FortalCode.ghost`,
which blends with its surrounding text unless explicitly restyled.

Place it above your app widget so that overlay and route content inherits the
tokens — **except** under `MaterialApp` or `CupertinoApp`, which install their
own root text style below anything wrapping the app. There, put the scope in
`builder:` so it still covers routes and overlays:

```dart
import 'package:flutter/material.dart';
import 'ui/ui.dart';

final app = MaterialApp(
  builder: (context, child) => FortalScope(child: child!),
  home: const Center(child: FortalText('Themed')),
);
```

This is a fallback, not a forced global style. A nearer `DefaultTextStyle`,
including one installed by `Material` or `Scaffold`, still wins for bare
Flutter `Text`. Fortal typography ignores that ambient run for token metrics
and default roles: an omitted size uses `text3`, while an explicit `size:`
selects another token size. This is a deliberate deviation from Radix's
ambient CSS `1em` behavior. The sole ambient field retained by Fortal
typography is the foreground of transparent, non-accent `FortalCode.ghost`.

## Customizing Fortal styles

Fortal widgets call the matching `fortal*Style` recipe internally. Use those
recipes directly when you need a custom Remix widget composition:

```dart
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'ui/ui.dart';

final style = fortalButtonStyle(variant: FortalButtonVariant.solid)
  .borderRadius(.all(const Radius.circular(8)))
  .padding(.horizontal(32))
  .onHovered(.scale(1.05));
```

## Icons

Install the optional application-owned icon aliases through the configured
preset:

```bash
dart run remix_cli:remix add icons
```

That item adds `remix_ui_icons` and creates a small `FortalIcons` alias set you
can edit as the application's vocabulary evolves:

```dart
const Icon(FortalIcons.check)
```

Import `package:remix_ui_icons/remix_ui_icons.dart` and use `RemixIcons`
directly for the complete 318-glyph Radix Icons 1.3.2 catalog. There is
deliberately no runtime name-to-icon map on `RemixIcons` itself because dynamic
lookup would keep the full catalog reachable. Fortal controls otherwise use
Remix's inline Radix-shaped vector defaults.

Catalogs, galleries, and drift tests that must enumerate every glyph can import
the opt-in index. An application that never imports it keeps full font
subsetting:

```dart
import 'package:remix_ui_icons/icons_index.dart';

final icon = remixIconsByName['check'];
```

The `shadow`, `shadowInner`, `shadowNone`, `shadowOuter`, and
`transparencyGrid` glyphs approximate Radix's partial opacity as opaque
coverage; the other 313 glyphs are lossless conversions.

## Soft variants and contrast

Default `fortalBadgeStyle(variant: .soft)` pairs fill `accentA3` with label
`accentA11`. That is the Radix step-11 **low-contrast text** role, not a WCAG
AA 4.5:1 guarantee. In light mode, compositing that label over the fill over
`colorPanelSolid` (a badge inside a card) misses 4.5:1 for some of the 31
accents. Dark-mode default and `highContrast: true` — which promotes the label
to `accent12` -- pass AA on that composite. Use `highContrast: true` when
light-mode soft labels must meet WCAG AA.

## Charts

Fortal includes themed line, bar, and pie chart recipes backed by
[`mix_chart`](https://pub.dev/packages/mix_chart). The chart item adds that
dependency automatically; import it directly when constructing chart data
because the application-owned barrel does not re-export it.

```bash
dart run remix_cli:remix add chart
```

```dart
import 'package:mix_chart/mix_chart.dart';
import 'ui/ui.dart';

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
import 'ui/ui.dart';

final style = ButtonStyler()
  .color(FortalTokens.accent9())
  .padding(.all(FortalTokens.space4()))
  .borderRadius(.all(FortalTokens.radius3()))
  .label(TextStyler().color(FortalTokens.accentContrast()));
```

## Covered components

Every Remix component has a matching Fortal recipe and preset widget:

### Typography
- **FortalText**, **FortalHeading**, **FortalCode**, **FortalKbd**, **FortalLink**

These five families exist only in Fortal — base Remix ships no `RemixText` — and
they share one nine-step `FortalTextSize` scale plus one `FortalTextWeight`
enum. See the [Typography guide](https://docs.page/btwld/remix/fortal/typography)
for controls, semantics, and parity boundaries.

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
- **FortalDisclosure**, **FortalSidebar**
- **FortalMenu**, **FortalSegmentedControl**, **FortalToggleGroup**

There is no `FortalTabs`: the behavioral root stays `RemixTabs`, which takes no
style. The same applies to the other behavioral roots (`RemixRadioGroup`,
`RemixCheckboxGroup`, `RemixAccordionGroup`).

`FortalSidebar` is a Fortal extension rather than a Radix Themes parity
family. It applies the solid panel surface, the scrolling-region padding, the
footer divider, compact uppercase section headings, and the ghost `size2`
toggle treatment to the public `RemixSidebar` behavior. It sets no panel width
and no header padding, because the host owns placement and usually has to match
its own top bar. Its optional `panelPadding` keeps host-provided display insets
inside the painted surface when that surface must extend to the display edge.

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

- [Remix CLI on pub.dev](https://pub.dev/packages/remix_cli)
- [Documentation](https://docs.page/btwld/remix/fortal)
- [GitHub](https://github.com/btwld/remix)

## License

BSD-3-Clause. See [LICENSE](LICENSE).
