import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'skeleton.g.dart';

/// The application's Skeleton recipe.
///
/// A skeleton is a placeholder that keeps a layout the right shape while its
/// content loads. Remix owns the pulse animation, the semantics, and the rule
/// that a wrapped child keeps sizing the placeholder in both states; this
/// recipe supplies only the two colors and the tempo.
///
/// It takes no size. A skeleton is measured by the content it stands in for —
/// either the child it wraps, or explicit constraints on the caller's own
/// [style]:
///
/// ```dart
/// PlaygroundSkeleton(
///   style: SkeletonStyler().container(BoxStyler().size(160, 20)),
/// )
/// ```
///
/// The pulse runs between `muted` and `accent`, the theme's two neutral
/// surfaces, so a loading block reads as scenery rather than as content. Both
/// tokens shift with light and dark, and a theme that wants a stronger pulse
/// only widens the gap between them.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
@MixWidget(name: 'PlaygroundSkeleton', target: RemixSkeleton.new)
SkeletonStyler playgroundSkeletonStyle({
  SkeletonStyler style = const SkeletonStyler.create(),
}) => SkeletonStyler()
    .container(
      BoxStyler()
          .color(PlaygroundTokens.muted())
          .borderRadius(.all(PlaygroundTokens.radius())),
    )
    .pulseColor(PlaygroundTokens.accent())
    .duration(_pulseDuration)
    .merge(style);

/// The length of one forward pulse leg; the reverse leg takes the same time.
///
/// Slow on purpose. A placeholder that pulses at interaction speed competes
/// with the content arriving beside it.
const _pulseDuration = Duration(milliseconds: 1000);
