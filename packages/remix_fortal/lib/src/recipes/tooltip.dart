import 'package:flutter/material.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'tooltip.g.dart';

/// Fortal-themed preset for [RemixTooltip].
@MixWidget(target: RemixTooltip.new)
TooltipStyler fortalTooltipStyle() {
  return TooltipStyler(
        label: .style(FortalTokens.text1.mix()),
        waitDuration: const Duration(milliseconds: 200),
      )
      .borderRadiusAll(FortalTokens.radius2())
      .paddingY(FortalTokens.space1())
      .paddingX(FortalTokens.space2())
      .label(.color(FortalTokens.gray1()))
      .backgroundColor(FortalTokens.gray12());
}
