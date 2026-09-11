import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'progress.g.dart';

/// The application's Progress recipe.
///
/// Remix owns the geometry that maps a 0-1 value onto the filled width, and
/// the progress semantics; this recipe supplies the track and the indicator.
///
/// One weight, not a scale. A progress bar has no size relationship to the
/// controls around it — it spans its container and is read by length rather
/// than by height — so the sizes this recipe used to offer were three numbers
/// with nothing to anchor them. shadcn ships `h-2` and nothing else, and this
/// is that bar. A call site that wants a different weight sets `.height(...)`
/// through [style], which is one line and says what it means.
///
/// The track is `muted` and the indicator is `primary`: the same pairing the
/// checked checkbox uses, so "how far along" reads in the accent the rest of
/// the application already uses for state.
///
/// Both are fully rounded rather than sharing the theme's control radius. The
/// theme radius is authored for 32-40px controls; on an 8px bar anything
/// short of a full round reads as a rendering artifact.
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
@MixWidget(target: RemixProgress.new)
ProgressStyler playgroundProgressStyle({
  ProgressStyler style = const ProgressStyler.create(),
}) => ProgressStyler()
    // The bar spans whatever it is given: progress is measured against the
    // width of its container, so a shrink-wrapped bar would collapse to
    // nothing. The clip is what rounds the indicator's leading edge as it
    // grows past the track's corner.
    .width(double.infinity)
    .height(_thickness)
    .borderRadius(.all(_radius))
    .clipBehavior(Clip.antiAlias)
    .track(_bar().width(double.infinity).color(PlaygroundTokens.muted()))
    .indicator(_bar().color(PlaygroundTokens.primary()))
    .merge(style);

/// The bar's weight, matching shadcn's `h-2`.
const _thickness = 8.0;

/// Half of [_thickness], which is what makes each end a semicircle.
const _radius = Radius.circular(_thickness / 2);

/// One rounded bar, used for both the track and the fill.
BoxStyler _bar() => BoxStyler().height(_thickness).borderRadius(.all(_radius));
