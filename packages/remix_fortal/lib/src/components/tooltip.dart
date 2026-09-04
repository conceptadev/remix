import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'tooltip.g.dart';

/// Fortal-themed preset for [RemixTooltip].
@MixWidget(target: RemixTooltip.new)
TooltipStyler fortalTooltipStyle() {
  return TooltipStyler(
        label: .style(FortalTokens.text1.mix()),
        waitDuration: const Duration(milliseconds: 200),
      )
      .borderRadius(.all(FortalTokens.radius2()))
      .padding(.vertical(FortalTokens.space1()))
      .padding(.horizontal(FortalTokens.space2()))
      .label(.color(FortalTokens.gray1()))
      .color(FortalTokens.gray12());
}
