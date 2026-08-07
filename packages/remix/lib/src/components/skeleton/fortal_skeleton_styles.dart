part of 'skeleton.dart';

/// Fortal recipe for [RemixSkeleton].
@MixWidget(target: RemixSkeleton.new)
SkeletonStyler fortalSkeletonStyle() {
  return SkeletonStyler()
      .container(
        BoxStyler()
            .minHeight(FortalTokens.space3())
            .color(FortalTokens.grayA3())
            .borderRadiusAll(FortalTokens.radius1()),
      )
      .pulseColor(FortalTokens.grayA4())
      .duration(FortalTokens.skeletonPulseDuration());
}
