part of 'tooltip.dart';

/// Fortal-themed preset for [RemixTooltip].
@MixWidget(target: RemixTooltip.new)
RemixTooltipStyler fortalTooltipStyle() {
  return RemixTooltipStyler(
        label: .style(FortalTokens.text1.mix()),
        waitDuration: const Duration(milliseconds: 200),
        arrowColor: FortalTokens.gray12(),
      )
      .borderRadiusAll(FortalTokens.radius2())
      .paddingY(FortalTokens.space1())
      .paddingX(FortalTokens.space2())
      .label(.color(FortalTokens.gray1()))
      .backgroundColor(FortalTokens.gray12());
}

/// Fortal-themed preset for [RemixTooltip].
