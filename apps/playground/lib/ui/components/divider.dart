import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'divider.g.dart';

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
@MixWidget(name: 'PlaygroundDivider', target: RemixDivider.new)
DividerStyler playgroundDividerStyle({
  Axis orientation = Axis.horizontal,
  DividerStyler style = const DividerStyler.create(),
}) => DividerStyler()
    .color(PlaygroundTokens.border())
    .merge(_extent(orientation))
    .merge(style);

/// Thickness of the rule.
///
/// One logical pixel, matching the hairline every bordered control draws, so
/// a divider and a card edge do not read as two different weights.
const _thickness = 1.0;

/// Pins the cross-axis thickness and stretches along the main axis.
///
/// A `FractionallySizedBox` rather than an explicit width or height: the
/// divider does not know how wide its parent is, and a fixed length would be
/// wrong the moment the layout changed.
DividerStyler _extent(Axis orientation) => switch (orientation) {
  .horizontal =>
    DividerStyler()
        .height(_thickness)
        .wrap(
          WidgetModifierConfig.fractionallySizedBox(widthFactor: 1).align(),
        ),
  .vertical =>
    DividerStyler()
        .width(_thickness)
        .wrap(
          WidgetModifierConfig.fractionallySizedBox(heightFactor: 1).align(),
        ),
};
