import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

/// The nine-step Radix Themes text scale supplied by [UiTokens].
enum UiTextSize {
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

/// Font weights supported by the Ui typography scale.
///
/// Closed rather than Flutter's [FontWeight], which is an open class accepting
/// any value from 1 to 1000; Radix ships exactly these four.
enum UiTextWeight { light, regular, medium, bold }

TextStyleToken uiTextSizeToken(UiTextSize size) => switch (size) {
  .size1 => UiTokens.text1,
  .size2 => UiTokens.text2,
  .size3 => UiTokens.text3,
  .size4 => UiTokens.text4,
  .size5 => UiTokens.text5,
  .size6 => UiTokens.text6,
  .size7 => UiTokens.text7,
  .size8 => UiTokens.text8,
  .size9 => UiTokens.text9,
};

FontWeightToken uiTextWeightToken(UiTextWeight weight) => switch (weight) {
  .light => UiTokens.fontWeightLight,
  .regular => UiTokens.fontWeightRegular,
  .medium => UiTokens.fontWeightMedium,
  .bold => UiTokens.fontWeightBold,
};

/// [truncate] deliberately wins over [softWrap], forcing one ellipsized line.
TextStyler uiApplyTextFlow(
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

TextStyler uiAccentForeground(TextStyler style, {required bool highContrast}) =>
    style.color(highContrast ? UiTokens.accent12() : UiTokens.accentA11());

/// Code, Kbd, and Link derive em-relative geometry from the resolved font size,
/// so unlike the other recipes they cannot stay context-free.
TextStyle uiResolveTextToken(BuildContext context, UiTextSize size) =>
    MixScope.tokenOf(uiTextSizeToken(size), context);

Color uiResolveColor(BuildContext context, ColorToken token) =>
    MixScope.tokenOf(token, context);

/// Derived from the resolved `radius1` rather than duplicating the Ui
/// radius enum table, so theme radius and scaling changes flow through.
double uiRadiusFactor(BuildContext context) {
  final scaling = UiTheme.of(context).scaling.factor;
  final radius = MixScope.tokenOf(UiTokens.radius1, context);

  return radius.x / (3 * scaling);
}
