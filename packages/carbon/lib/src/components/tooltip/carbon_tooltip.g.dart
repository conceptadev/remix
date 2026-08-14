// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carbon_tooltip.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Carbon tooltip recipe generated over [RemixTooltip].
class CarbonTooltip extends StatelessWidget {
  const CarbonTooltip({
    super.key,
    this.highContrast = true,
    required this.tooltipChild,
    required this.child,
    this.tooltipSemantics,
    this.positioning = const OverlayPositionConfig(),
  });

  final bool highContrast;

  final Widget tooltipChild;

  final Widget child;

  final String? tooltipSemantics;

  final OverlayPositionConfig positioning;

  @override
  Widget build(BuildContext context) {
    return RemixTooltip(
      key: this.key,
      style: carbonTooltipStyle(highContrast: this.highContrast),
      tooltipChild: this.tooltipChild,
      child: this.child,
      tooltipSemantics: this.tooltipSemantics,
      positioning: this.positioning,
    );
  }
}
