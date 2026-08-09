import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

/// The nine-step Radix Themes text scale supplied by [FortalTokens].
enum FortalTextSize {
  size1,
  size2,
  size3,
  size4,
  size5,
  size6,
  size7,
  size8,
  size9,
}

/// Font weights supported by the Fortal typography scale.
///
/// Deliberately a closed enum rather than Flutter's [FontWeight]: `FontWeight`
/// is an open class accepting any value from 1 to 1000, while Radix ships
/// exactly these four. Routing through tokens also keeps the concrete weights
/// overridable through `MixScope` instead of baked into every recipe.
enum FortalTextWeight { light, regular, medium, bold }

/// Maps a [FortalTextSize] onto its pinned text token by exhaustive switch.
TextStyleToken fortalTextSizeToken(FortalTextSize size) => switch (size) {
  .size1 => FortalTokens.text1,
  .size2 => FortalTokens.text2,
  .size3 => FortalTokens.text3,
  .size4 => FortalTokens.text4,
  .size5 => FortalTokens.text5,
  .size6 => FortalTokens.text6,
  .size7 => FortalTokens.text7,
  .size8 => FortalTokens.text8,
  .size9 => FortalTokens.text9,
};

/// Maps a [FortalTextWeight] onto its shared font-weight token.
FontWeightToken fortalTextWeightToken(FortalTextWeight weight) =>
    switch (weight) {
      .light => FortalTokens.fontWeightLight,
      .regular => FortalTokens.fontWeightRegular,
      .medium => FortalTokens.fontWeightMedium,
      .bold => FortalTokens.fontWeightBold,
    };

/// Applies the shared alignment, wrapping, and truncation policy.
///
/// [truncate] deliberately wins over [softWrap], forcing a single ellipsized
/// line. Alignment is Flutter's [TextAlign] rather than a Radix-shaped subset,
/// so `start`/`end` stay available for direction-aware layouts.
TextStyler fortalApplyTextFlow(
  TextStyler style, {
  TextAlign? align,
  required bool softWrap,
  required bool truncate,
}) {
  if (align != null) style = style.textAlign(align);
  if (truncate) {
    return style.maxLines(1).softWrap(false).overflow(TextOverflow.ellipsis);
  }

  return style.softWrap(softWrap);
}

/// Resolves the accent foreground shared by Text, Heading, Code, and Link.
TextStyler fortalAccentForeground(
  TextStyler style, {
  required bool highContrast,
}) => style.color(
  highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
);

/// Resolves a text token to its concrete [TextStyle] at [context].
///
/// Code, Kbd, and Link derive em-relative geometry from the resolved font size,
/// so unlike the other recipes they cannot stay context-free.
TextStyle fortalResolveTextToken(BuildContext context, FortalTextSize size) =>
    MixScope.tokenOf(fortalTextSizeToken(size), context);

/// Resolves a colour token at [context].
Color fortalResolveColor(BuildContext context, ColorToken token) =>
    MixScope.tokenOf(token, context);

/// The em base for the boxed typography formulas.
///
/// Falls back to what Flutter actually paints when the ambient style omits a
/// size. `DefaultTextStyle.fallback().style.fontSize` is null, so reading it
/// with `!` would always throw rather than ever supply a default.
double fortalResolvedFontSize(TextStyle style) =>
    style.fontSize ?? kDefaultFontSize;

/// Recovers the theme's radius multiplier from the resolved `radius1` token.
///
/// Derived rather than duplicating the Fortal radius enum table, so a theme
/// radius or scaling change flows through automatically.
double fortalRadiusFactor(BuildContext context) {
  final scaling = FortalTheme.of(context).scaling.factor;
  final radius = MixScope.tokenOf(FortalTokens.radius1, context);

  return radius.x / (3 * scaling);
}
