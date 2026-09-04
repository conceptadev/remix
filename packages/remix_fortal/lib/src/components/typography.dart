import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

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
/// Closed rather than Flutter's [FontWeight], which is an open class accepting
/// any value from 1 to 1000; Radix ships exactly these four.
enum FortalTextWeight { light, regular, medium, bold }

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

FontWeightToken fortalTextWeightToken(FortalTextWeight weight) =>
    switch (weight) {
      .light => FortalTokens.fontWeightLight,
      .regular => FortalTokens.fontWeightRegular,
      .medium => FortalTokens.fontWeightMedium,
      .bold => FortalTokens.fontWeightBold,
    };

/// [truncate] deliberately wins over [softWrap], forcing one ellipsized line.
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

TextStyler fortalAccentForeground(
  TextStyler style, {
  required bool highContrast,
}) => style.color(
  highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
);

/// Code, Kbd, and Link derive em-relative geometry from the resolved font size,
/// so unlike the other recipes they cannot stay context-free.
TextStyle fortalResolveTextToken(BuildContext context, FortalTextSize size) =>
    MixScope.tokenOf(fortalTextSizeToken(size), context);

Color fortalResolveColor(BuildContext context, ColorToken token) =>
    MixScope.tokenOf(token, context);

/// Derived from the resolved `radius1` rather than duplicating the Fortal
/// radius enum table, so theme radius and scaling changes flow through.
double fortalRadiusFactor(BuildContext context) {
  final scaling = FortalTheme.of(context).scaling.factor;
  final radius = MixScope.tokenOf(FortalTokens.radius1, context);

  return radius.x / (3 * scaling);
}
