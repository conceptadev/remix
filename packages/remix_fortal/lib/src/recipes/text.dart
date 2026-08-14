import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';
import 'typography_shared.dart';

part 'text.g.dart';

/// Fortal-themed body text on the Radix nine-step scale.
///
/// Omitted [size] and [weight] resolve to the Radix root run (`text3`,
/// regular) from the active [FortalScope]'s tokens rather than the ambient
/// `DefaultTextStyle`. This deliberately deviates from Radix's CSS `1em`
/// inheritance: a token default cannot be silently replaced by a host-installed
/// text run (a `Material` surface, or a host with no run at all), which keeps
/// Fortal text a function of the theme alone. Set [accent] to take the
/// surrounding [FortalScope]'s accent colour; leaving it false uses the
/// neutral `gray12` foreground.
@MixWidget()
TextStyler fortalTextStyle({
  FortalTextSize? size,
  FortalTextWeight? weight,
  TextAlign? align,
  bool softWrap = true,
  bool truncate = false,
  bool accent = false,
  bool highContrast = false,
}) {
  var style = TextStyler().style(
    fortalTextSizeToken(size ?? FortalTextSize.size3).mix(),
  );
  style = style.fontWeight(
    fortalTextWeightToken(weight ?? FortalTextWeight.regular)(),
  );
  style = accent
      ? fortalAccentForeground(style, highContrast: highContrast)
      : style.color(FortalTokens.gray12());
  style = style.inherit(false);

  return fortalApplyTextFlow(
    style,
    align: align,
    softWrap: softWrap,
    truncate: truncate,
  );
}
