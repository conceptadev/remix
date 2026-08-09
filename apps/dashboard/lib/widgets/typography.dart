import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// How much attention a run of text asks for.
///
/// Fortal ships type scales and gray steps but no opinion about which step
/// carries content, so the example settles that once here. Three tiers is what
/// the dashboard actually needs: an activity row puts all of them side by side.
enum TextTone {
  /// `gray-12` — text the eye lands on.
  strong(FortalTokens.gray12),

  /// `gray-11` — supporting copy next to [strong].
  muted(FortalTokens.gray11),

  /// `gray-10` — metadata that should recede even beside [muted].
  subtle(FortalTokens.gray10);

  const TextTone(this._color);
  final ColorToken _color;
}

/// Dashboard body text at a Fortal type [scale].
///
/// Callers that need more than a weight or tone change chain onto the result
/// rather than reintroducing an inline `TextStyler`.
TextStyler dashboardText(
  TextStyleToken scale, {
  FontWeight? weight,
  TextTone tone = TextTone.strong,
}) {
  final style = TextStyler(style: scale.mix()).color(tone._color());

  return weight == null ? style : style.fontWeight(weight);
}

/// Single-line [dashboardText] that ellipsizes, for text sharing a row with a
/// fixed-width neighbour.
TextStyler dashboardTextLine(
  TextStyleToken scale, {
  FontWeight? weight,
  TextTone tone = TextTone.strong,
}) => dashboardText(
  scale,
  weight: weight,
  tone: tone,
).maxLines(1).overflow(TextOverflow.ellipsis);
