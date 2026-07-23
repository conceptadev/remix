part of 'tooltip.dart';

/// Fortal-themed preset for [RemixTooltip].
RemixTooltipStyler fortalTooltipStyler() {
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

const _fortalTooltipPositioning = OverlayPositionConfig(
  side: OverlaySide.top,
  alignment: OverlayAlignment.center,
  sideOffset: 4,
  collisionPadding: EdgeInsets.all(10),
);

/// Fortal-themed preset for [RemixTooltip].
class FortalTooltip extends StatelessWidget {
  const FortalTooltip({
    super.key,
    required this.tooltipChild,
    required this.child,
    this.tooltipSemantics,
    this.positioning = _fortalTooltipPositioning,
    this.open,
    this.onOpenChanged,
    this.disableHoverableContent = false,
    this.enableTapToDismiss = true,
    this.triggerMode = TooltipTriggerMode.longPress,
    this.enableFeedback = true,
    this.onTriggered,
    this.animationStyle = const AnimationStyle(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 140),
      reverseDuration: Duration(milliseconds: 75),
    ),
    this.useRootOverlay = false,
    this.excludeSemantics = false,
    this.maxWidth = 360,
    this.showArrow = true,
    this.arrowSize = const Size(10, 5),
  });

  final Widget tooltipChild;

  final Widget child;

  final String? tooltipSemantics;

  final OverlayPositionConfig positioning;

  final bool? open;

  final ValueChanged<bool>? onOpenChanged;

  final bool disableHoverableContent;

  final bool enableTapToDismiss;

  final TooltipTriggerMode triggerMode;

  final bool enableFeedback;

  final TooltipTriggeredCallback? onTriggered;

  final AnimationStyle animationStyle;

  final bool useRootOverlay;

  final bool excludeSemantics;

  final double maxWidth;

  final bool showArrow;

  final Size arrowSize;

  @override
  Widget build(BuildContext context) {
    return fortalTooltipStyler().call(
      key: this.key,
      tooltipChild: this.tooltipChild,
      tooltipSemantics: this.tooltipSemantics,
      positioning: this.positioning,
      open: this.open,
      onOpenChanged: this.onOpenChanged,
      disableHoverableContent: this.disableHoverableContent,
      enableTapToDismiss: this.enableTapToDismiss,
      triggerMode: this.triggerMode,
      enableFeedback: this.enableFeedback,
      onTriggered: this.onTriggered,
      animationStyle: this.animationStyle,
      useRootOverlay: this.useRootOverlay,
      excludeSemantics: this.excludeSemantics,
      maxWidth: this.maxWidth,
      showArrow: this.showArrow,
      arrowSize: this.arrowSize,
      child: this.child,
    );
  }
}
