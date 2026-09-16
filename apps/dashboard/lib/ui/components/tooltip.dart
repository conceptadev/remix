import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'tooltip.g.dart';

/// Ui-themed preset for [RemixTooltip].
@MixWidget(target: RemixTooltip.new)
TooltipStyler uiTooltipStyle({
  TooltipStyler style = const TooltipStyler.create(),
}) {
  return TooltipStyler(
        label: .style(UiTokens.text1.mix()),
        waitDuration: const Duration(milliseconds: 200),
      )
      .borderRadius(.all(UiTokens.radius2()))
      .padding(.vertical(UiTokens.space1()))
      .padding(.horizontal(UiTokens.space2()))
      .label(.color(UiTokens.gray1()))
      .color(UiTokens.gray12())
      .merge(style);
}
