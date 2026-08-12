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

/// Restores Fortal's neutral foreground under a Material surface.
///
/// `FortalScope` establishes the Radix root run at `gray12`, but `Scaffold`
/// and `Drawer` each install their own `DefaultTextStyle` below it, coloured
/// from Material's `colorScheme.onSurface`. Anything inheriting its colour —
/// every unsized [FortalText] and [FortalHeading] — would take Material's
/// foreground instead of the active gray scale.
///
/// This re-asserts the scale once per Material surface rather than at each
/// call site: Fortal models neutral tone as inherited context, so the fix
/// belongs at the boundary that broke the inheritance. [dashboardText]'s
/// explicit tones still override it, and both follow live theme changes.
class DashboardSurfaceTone extends StatelessWidget {
  const DashboardSurfaceTone({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextStyle.merge(
    style: TextStyle(color: MixScope.tokenOf(TextTone.strong._color, context)),
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
