import 'package:flutter/material.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';
import 'typography_shared.dart';

part 'text.g.dart';

/// Fortal-themed body text on the Radix nine-step scale.
///
/// Omitted [size] and [weight] inherit the ambient `DefaultTextStyle`, matching
/// Radix, where Text without a size prop renders at the inherited `1em`.
/// Set [accent] to take the surrounding [FortalScope]'s accent colour; leaving
/// it false preserves the inherited foreground.
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
  var style = TextStyler();
  if (size != null) style = style.style(fortalTextSizeToken(size).mix());
  if (weight != null) {
    style = style.fontWeight(fortalTextWeightToken(weight)());
  }
  if (accent) {
    style = fortalAccentForeground(style, highContrast: highContrast);
  }

  return fortalApplyTextFlow(
    style,
    align: align,
    softWrap: softWrap,
    truncate: truncate,
  );
}
