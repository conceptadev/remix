# Fortal

Use this reference whenever a task mentions Fortal, `remix_fortal`, Radix
Themes parity, `FortalScope`, `FortalTokens`, `Fortal*` widgets, or
`fortal*Style()` recipes.

## What Fortal Is

Fortal is a preset for Remix, not a fork and not part of the `remix` package.
It supplies Radix Themes-inspired tokens, recipes, and generated wrappers while
Remix retains component behavior and remains theme-free.

Choose Fortal when the user wants a ready-made visual system. Use base Remix
when the user is building a distinct design system and does not want Fortal's
token tables, Radix colors, or parity contract.

## Authoritative Sources

Resolve questions in this order:

1. `packages/remix_fortal/lib/remix_fortal.dart` for the public export surface.
2. `packages/remix_fortal/lib/src/fortal/fortal_theme.dart` for scope, theme,
   and token behavior.
3. `packages/remix_fortal/lib/src/recipes/<component>.dart` for exact variants,
   sizes, defaults, and recipe behavior.
4. `docs/fortal.mdx` for the overview and
   `docs/components/<component>.mdx` for consumer examples.
5. `packages/remix_fortal/reference/radix_themes_3_3_0/manifest.json` for pinned
   upstream parity claims and documented Flutter exceptions.

Do not infer a constructor or enum from a different component. Fortal families
have component-specific variants and sizes.

## Consumer Setup

Add the package and place `FortalScope` above every subtree that renders Fortal
styles. Put it above the application widget when overlays and routes must inherit
the tokens.

```bash
flutter pub add remix_fortal
```

```dart
import 'package:flutter/widgets.dart';
import 'package:remix_fortal/remix_fortal.dart';

FortalScope(
  accent: FortalAccentColor.indigo,
  brightness: Brightness.light,
  child: WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (_, _) => FortalButton.solid(
      label: 'Continue',
      onPressed: () {},
    ),
  ),
)
```

`FortalScope` provides both `FortalTheme` and `MixScope`. It can configure the
accent, gray family, brightness, panel background, radius, scaling, background,
and modifier ordering.

## Widgets, Recipes, and Tokens

- Prefer a `Fortal*` widget when its generated wrapper matches the composition.
- Use a named constructor such as `FortalButton.solid` for a fixed variant.
- Use the unnamed constructor with `variant:` when the variant is dynamic.
- Use the matching `fortal*Style()` recipe for custom Remix compositions.
- Use `FortalTokens` rather than duplicating pinned theme values.
- Import `package:remix/remix.dart` explicitly when using Remix widgets,
  stylers, or data classes; `remix_fortal` does not re-export Remix.

```dart
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

final style = fortalButtonStyle(
  variant: FortalButtonVariant.solid,
).paddingX(FortalTokens.space5());

final custom = ButtonStyler()
    .color(FortalTokens.accent9())
    .label(TextStyler().color(FortalTokens.accentContrast()));
```

Some nonvisual coordination remains in Remix. For example, tab, radio,
checkbox, and accordion roots may compose Fortal-styled children without having
a one-to-one `Fortal*` root wrapper. Check the component page and public barrel
instead of inventing an API.

## Making Changes

Keep changes in the layer that owns the behavior:

- Generic component behavior, accessibility, interaction, and reusable styling
  utilities belong in `packages/remix`.
- Radix-specific values, states, recipes, and theme configuration belong in
  `packages/remix_fortal`.
- Generated wrappers come from `@MixWidget` recipe declarations. Edit the
  recipe source and regenerate; never hand-edit `*.g.dart`.
- When changing a mapped family, update parity evidence and its component docs
  alongside tests.

## Verification

During iteration, run the narrow checks that match the change. Before handing
off a Fortal change, run the complete gate.

```bash
melos run generate:check
melos run docs:check
melos run fortal:parity:check
melos run test:flutter
melos run ci
```

The parity check validates the pinned Radix Themes 3.3.0 contract, mapped
families, enum/state coverage, cited tests, dependency pins, and documented
approximations. It is not a substitute for Flutter tests or documentation
validation.
