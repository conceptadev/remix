part of 'skeleton.dart';

/// Fortal recipe for [RemixSkeleton].
@MixWidget(target: RemixSkeleton.new)
SkeletonStyler fortalSkeletonStyle() {
  final metrics = _FortalSkeletonMetrics(
    minHeight: FortalTokens.space3(),
    radius: FortalTokens.radius1(),
  );

  return SkeletonStyler()
      .container(
        BoxStyler()
            .minHeight(metrics.minHeight)
            .color(FortalTokens.grayA3())
            .borderRadiusAll(metrics.radius),
      )
      .pulseColor(FortalTokens.grayA4())
      .duration(FortalTokens.skeletonPulseDuration());
}

class _FortalSkeletonMetrics {
  const _FortalSkeletonMetrics({required this.minHeight, required this.radius});

  final double minHeight;
  final Radius radius;
}
