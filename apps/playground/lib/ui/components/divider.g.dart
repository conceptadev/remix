// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'divider.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Divider recipe.
///
/// A divider is a hairline in the `border` token, the same color every other
/// control outline uses, so a rule between two rows matches the edge of the
/// card around them.
///
/// It always fills the axis it is laid along rather than offering length
/// presets: a rule that stops short of its container is a decision for the
/// layout that placed it, expressed with ordinary padding.
///
/// [orientation] is a plain Flutter [Axis] rather than an enum of this
/// layer's own. There is nothing application-specific about which way a line
/// runs, and a local enum would only need mapping back at every call site.
/// It is also not named `variant`, so the generator emits no named
/// constructors for it — an axis is a value a caller computes, not a
/// hand-written choice.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it:
///
/// ```dart
/// PlaygroundDivider(
///   orientation: Axis.vertical,
///   style: DividerStyler().color(PlaygroundTokens.muted()),
/// )
/// ```
class PlaygroundDivider extends StatelessWidget {
  const PlaygroundDivider({
    super.key,
    this.orientation = Axis.horizontal,
    this.style = const DividerStyler.create(),
  });

  final Axis orientation;

  final DividerStyler style;

  @override
  Widget build(BuildContext context) {
    return RemixDivider(
      key: this.key,
      style: playgroundDividerStyle(
        orientation: this.orientation,
        style: this.style,
      ),
    );
  }
}
