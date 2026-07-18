part of 'tooltip.dart';

/// Fortal-themed preset for [RemixTooltip].
RemixTooltipStyler fortalTooltipStyler() {
  return RemixTooltipStyler()
      .borderRadiusAll(FortalTokens.radius2())
      .paddingY(FortalTokens.space2())
      .paddingX(FortalTokens.space2())
      .marginY(FortalTokens.space1())
      .wrap(
        .defaultTextStyle(style: TextStyleMix().color(FortalTokens.gray1())),
      )
      .backgroundColor(FortalTokens.gray12());
}

/// Fortal-themed preset for [RemixTooltip].
class FortalTooltip extends StatelessWidget {
  const FortalTooltip({
    super.key,
    this.color,
    this.radius,
    required this.tooltipChild,
    required this.child,
    this.tooltipSemantics,
    this.positioning = const OverlayPositionConfig(),
  });

  final Widget tooltipChild;

  /// Optional accent color override for this tooltip subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this tooltip subtree.
  final FortalRadius? radius;

  final Widget child;

  final String? tooltipSemantics;

  final OverlayPositionConfig positioning;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: fortalTooltipStyler().call(
        key: this.key,
        tooltipChild: this.tooltipChild,
        tooltipSemantics: this.tooltipSemantics,
        positioning: this.positioning,
        child: this.child,
      ),
    );
  }
}
