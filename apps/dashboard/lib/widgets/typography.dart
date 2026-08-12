import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// How much attention a run of text asks for.
///
/// Fortal ships the type scale, the weights, and the gray steps, but no opinion
/// about which step carries content, so the example settles that once here.
/// Three tiers is what the dashboard actually needs: an activity row puts all
/// of them side by side.
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

/// Dashboard body text at a Fortal [size].
///
/// This starts from `fortalTextStyle()` so the scale, weights, and flow
/// behaviour stay Fortal's; the only thing layered on top is the neutral tone,
/// which is the one opinion Fortal does not ship. Text that wants [strong] and
/// nothing else should use [FortalText] directly rather than this helper.
///
/// Callers that need more than a weight or tone change chain onto the result
/// rather than reintroducing an inline `TextStyler`.
TextStyler dashboardText(
  FortalTextSize size, {
  FortalTextWeight? weight,
  TextTone tone = TextTone.strong,
}) => fortalTextStyle(size: size, weight: weight).color(tone._color());

/// Puts a dashboard [TextTone] on the ambient text run for [child].
///
/// Fortal's typography widgets deliberately expose no colour parameter: the
/// neutral tone is inherited context, not a per-instance prop. This dashboard
/// runs under `MaterialApp`, so the nearest `DefaultTextStyle` inside a page is
/// the one `Material` installs, whose foreground is Material's — not Fortal's
/// `gray12`. Restating the tone here is how a `FortalText` or `FortalHeading`
/// keeps the dashboard's neutral scale while keeping its whole public API,
/// including heading semantics.
///
/// Only the colour is merged; size, weight, and flow stay with the widget.
class DashboardTextTone extends StatelessWidget {
  const DashboardTextTone({
    super.key,
    this.tone = TextTone.strong,
    required this.child,
  });

  final TextTone tone;
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextStyle.merge(
    style: TextStyle(color: MixScope.tokenOf(tone._color, context)),
    child: child,
  );
}

/// Single-line [dashboardText] that ellipsizes, for text sharing a row with a
/// fixed-width neighbour.
TextStyler dashboardTextLine(
  FortalTextSize size, {
  FortalTextWeight? weight,
  TextTone tone = TextTone.strong,
}) => fortalTextStyle(
  size: size,
  weight: weight,
  truncate: true,
).color(tone._color());
