// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed Badge with the Radix size, variant, and override contract.
class FortalBadge extends StatelessWidget {
  const FortalBadge({
    super.key,
    this.variant = .soft,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  });

  const FortalBadge.solid({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.solid;

  const FortalBadge.soft({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.soft;

  const FortalBadge.surface({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.surface;

  const FortalBadge.outline({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.outline;

  final FortalBadgeVariant variant;

  final FortalBadgeSize size;

  final bool highContrast;

  final String? label;

  final Widget? child;

  final RemixBadgeLabelBuilder? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return RemixBadge(
      key: this.key,
      style: fortalBadgeStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      label: this.label,
      child: this.child,
      labelBuilder: this.labelBuilder,
    );
  }
}
