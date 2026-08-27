import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'spinner.g.dart';

/// The sizes this application offers for a standalone spinner.
///
/// A button draws its own spinner from the button recipe, so these are the
/// sizes for a spinner that stands on its own: inline beside a label, in a
/// row, or centered in an empty panel.
enum PlaygroundSpinnerSize {
  /// A 16px spinner, matching an inline icon.
  small,

  /// A 20px spinner. The default.
  medium,

  /// A 24px spinner, for a panel waiting on its first load.
  large,
}

/// The application's Spinner recipe.
///
/// The spinner is the one component here that is pure motion: Remix owns the
/// eight-leaf geometry, the animation, and the progress semantics, and this
/// recipe supplies only its size, color, and tempo.
///
/// The content color is `foreground` rather than `primary`. A spinner most
/// often replaces text while something loads, so it should read at the same
/// weight as the text it stands in for.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
@MixWidget(name: 'PlaygroundSpinner', target: RemixSpinner.new)
SpinnerStyler playgroundSpinnerStyle({
  PlaygroundSpinnerSize size = .medium,
  SpinnerStyler style = const SpinnerStyler.create(),
}) => SpinnerStyler()
    .size(_diameterFor(size))
    .color(PlaygroundTokens.foreground())
    .duration(_duration)
    .merge(style);

/// One full revolution.
const _duration = Duration(milliseconds: 800);

double _diameterFor(PlaygroundSpinnerSize size) => switch (size) {
  .small => 16.0,
  .medium => 20.0,
  .large => 24.0,
};
