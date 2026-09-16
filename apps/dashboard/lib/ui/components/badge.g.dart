// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed Badge with the Radix size, variant, and override contract.
class UiBadge extends StatelessWidget {
  const UiBadge({
    super.key,
    this.variant = .soft,
    this.size = .size1,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  });

  const UiBadge.solid({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = UiBadgeVariant.solid;

  const UiBadge.soft({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = UiBadgeVariant.soft;

  const UiBadge.surface({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = UiBadgeVariant.surface;

  const UiBadge.outline({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = UiBadgeVariant.outline;

  final UiBadgeVariant variant;

  final UiBadgeSize size;

  final bool highContrast;

  final BadgeStyler style;

  final String? label;

  final Widget? child;

  final RemixBadgeLabelBuilder? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return RemixBadge(
      key: this.key,
      style: uiBadgeStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
        style: this.style,
      ),
      label: this.label,
      child: this.child,
      labelBuilder: this.labelBuilder,
    );
  }
}
