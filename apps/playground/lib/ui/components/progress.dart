import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'progress.g.dart';

/// The bar weights this application offers for a progress indicator.
enum PlaygroundProgressSize {
  /// A 4px bar, for a strip under a header or a card.
  small,

  /// A 6px bar. The default.
  medium,

  /// An 8px bar, when progress is the main thing on screen.
  large,
}

/// The application's Progress recipe.
///
/// Remix owns the geometry that maps a 0-1 value onto the filled width, and
/// the progress semantics; this recipe supplies the track, the indicator, and
/// the bar's weight.
///
/// The track is `muted` and the indicator is `primary`: the same pairing the
/// checked checkbox uses, so "how far along" reads in the accent the rest of
/// the application already uses for state.
///
/// Both the track and the indicator are fully rounded rather than sharing the
/// theme's control radius. The theme radius is authored for 32-40px controls;
/// on a 4px bar anything short of a full round reads as a rendering artifact.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it:
///
/// ```dart
/// PlaygroundProgress(
///   value: 0.4,
///   style: ProgressStyler().indicatorColor(PlaygroundTokens.destructive()),
/// )
/// ```
@MixWidget(name: 'PlaygroundProgress', target: RemixProgress.new)
ProgressStyler playgroundProgressStyle({
  PlaygroundProgressSize size = .medium,
  ProgressStyler style = const ProgressStyler.create(),
}) {
  final thickness = _thicknessFor(size);

  return ProgressStyler()
      // The bar spans whatever it is given: progress is measured against the
      // width of its container, so a shrink-wrapped bar would collapse to
      // nothing. The clip is what rounds the indicator's leading edge as it
      // grows past the track's corner.
      .width(double.infinity)
      .height(thickness)
      .borderRadius(.all(_radiusFor(thickness)))
      .clipBehavior(Clip.antiAlias)
      .track(
        _bar(thickness).width(double.infinity).color(PlaygroundTokens.muted()),
      )
      .indicator(_bar(thickness).color(PlaygroundTokens.primary()))
      .merge(style);
}

/// One rounded bar of [thickness], used for both the track and the fill.
BoxStyler _bar(double thickness) =>
    BoxStyler().height(thickness).borderRadius(.all(_radiusFor(thickness)));

/// Half of [thickness], which is what makes each end a semicircle at every
/// size.
Radius _radiusFor(double thickness) => Radius.circular(thickness / 2);

double _thicknessFor(PlaygroundProgressSize size) => switch (size) {
  .small => 4.0,
  .medium => 6.0,
  .large => 8.0,
};
