// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tooltip.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixTooltip].
class FortalTooltip extends StatelessWidget {
  const FortalTooltip({
    super.key,
    required this.tooltipChild,
    required this.child,
    this.tooltipSemantics,
    this.positioning = const OverlayPositionConfig(),
  });

  final Widget tooltipChild;

  final Widget child;

  final String? tooltipSemantics;

  final OverlayPositionConfig positioning;

  @override
  Widget build(BuildContext context) {
    return RemixTooltip(
      key: this.key,
      style: fortalTooltipStyle(),
      tooltipChild: this.tooltipChild,
      child: this.child,
      tooltipSemantics: this.tooltipSemantics,
      positioning: this.positioning,
    );
  }
}
