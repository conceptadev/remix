// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tooltip.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixTooltip].
class FortalTooltip extends StatelessWidget {
  const FortalTooltip({
    super.key,
    this.style = const TooltipStyler.create(),
    required this.tooltipChild,
    required this.child,
    this.open,
    this.onOpenChanged,
    this.tooltipSemantics,
    this.positioning = const OverlayPositionConfig(),
  });

  final TooltipStyler style;

  final Widget tooltipChild;

  final Widget child;

  final bool? open;

  final ValueChanged<bool>? onOpenChanged;

  final String? tooltipSemantics;

  final OverlayPositionConfig positioning;

  @override
  Widget build(BuildContext context) {
    return RemixTooltip(
      key: this.key,
      style: fortalTooltipStyle(style: this.style),
      tooltipChild: this.tooltipChild,
      child: this.child,
      open: this.open,
      onOpenChanged: this.onOpenChanged,
      tooltipSemantics: this.tooltipSemantics,
      positioning: this.positioning,
    );
  }
}
