import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';
import 'typography.dart';

part 'text.g.dart';

/// Ui-themed body text on the Radix nine-step scale.
///
/// Omitted [size] and [weight] resolve to the Radix root run (`text3`,
/// regular) from the active [UiScope]'s tokens rather than the ambient
/// `DefaultTextStyle`. This deliberately deviates from Radix's CSS `1em`
/// inheritance: a token default cannot be silently replaced by a host-installed
/// text run (a `Material` surface, or a host with no run at all), which keeps
/// Ui text a function of the theme alone. Set [accent] to take the
/// surrounding [UiScope]'s accent colour; leaving it false uses the
/// neutral `gray12` foreground.
@MixWidget()
TextStyler uiTextStyle({
  UiTextSize? size,
  UiTextWeight? weight,
  TextAlign? align,
  bool softWrap = true,
  bool truncate = false,
  bool accent = false,
  bool highContrast = false,
  TextStyler style = const TextStyler.create(),
}) {
  var recipe = TextStyler().style(
    uiTextSizeToken(size ?? UiTextSize.size3).mix(),
  );
  recipe = recipe.fontWeight(
    uiTextWeightToken(weight ?? UiTextWeight.regular)(),
  );
  recipe = accent
      ? uiAccentForeground(recipe, highContrast: highContrast)
      : recipe.color(UiTokens.gray12());
  recipe = recipe.inherit(false);

  return uiApplyTextFlow(
    recipe,
    align: align,
    softWrap: softWrap,
    truncate: truncate,
  ).merge(style);
}
