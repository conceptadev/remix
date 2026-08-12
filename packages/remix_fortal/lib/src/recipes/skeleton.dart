import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'skeleton.g.dart';

/// Fortal recipe for [RemixSkeleton].
///
/// The pulse starts and rests on `grayA3` before moving toward `grayA4`;
/// Radix's CSS `alternate-reverse` phase starts from `grayA4`.
@MixWidget(target: RemixSkeleton.new)
SkeletonStyler fortalSkeletonStyle() {
  return SkeletonStyler()
      .container(
        BoxStyler()
            .minHeight(FortalTokens.space3())
            .color(FortalTokens.grayA3())
            .borderRadius(.all(FortalTokens.radius1())),
      )
      .pulseColor(FortalTokens.grayA4())
      .duration(FortalTokens.skeletonPulseDuration());
}
