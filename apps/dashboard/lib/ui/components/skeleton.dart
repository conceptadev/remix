import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'skeleton.g.dart';

/// Ui recipe for [RemixSkeleton].
///
/// The pulse starts and rests on `grayA3` before moving toward `grayA4`;
/// Radix's CSS `alternate-reverse` phase starts from `grayA4`.
@MixWidget(target: RemixSkeleton.new)
SkeletonStyler uiSkeletonStyle({
  SkeletonStyler style = const SkeletonStyler.create(),
}) {
  return SkeletonStyler()
      .container(
        BoxStyler()
            .minHeight(UiTokens.space3())
            .color(UiTokens.grayA3())
            .borderRadius(.all(UiTokens.radius1())),
      )
      .pulseColor(UiTokens.grayA4())
      .duration(UiTokens.skeletonPulseDuration())
      .merge(style);
}
