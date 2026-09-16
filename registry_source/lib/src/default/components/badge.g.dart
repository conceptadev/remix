// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Badge recipe.
///
/// A badge is a static label: no interaction, no states. That is why this
/// recipe has no hover, focus, or disabled fragments — there is nothing to
/// report.
///
/// It takes no size. A badge sits inline beside other content and reads at
/// one scale; a size axis would have to be threaded through every call site
/// for no gain.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. Because [variant] is a non-nullable
/// enum, the generator also emits one named constructor per enum value:
///
/// ```dart
/// VanillaBadge.destructive(label: 'Failing')
/// ```
class VanillaBadge extends StatelessWidget {
  const VanillaBadge({
    super.key,
    this.variant = .primary,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  });

  /// Highest emphasis: a solid `primary` fill.
  const VanillaBadge.primary({
    super.key,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = VanillaBadgeVariant.primary;

  /// Medium emphasis: a solid `secondary` fill.
  const VanillaBadge.secondary({
    super.key,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = VanillaBadgeVariant.secondary;

  /// Low emphasis with a hairline `border` and no fill.
  const VanillaBadge.outline({
    super.key,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = VanillaBadgeVariant.outline;

  /// Highest emphasis for a problem the reader must notice.
  const VanillaBadge.destructive({
    super.key,
    this.style = const BadgeStyler.create(),
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = VanillaBadgeVariant.destructive;

  final VanillaBadgeVariant variant;

  final BadgeStyler style;

  final String? label;

  final Widget? child;

  final RemixBadgeLabelBuilder? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return RemixBadge(
      key: this.key,
      style: vanillaBadgeStyle(variant: this.variant, style: this.style),
      label: this.label,
      child: this.child,
      labelBuilder: this.labelBuilder,
    );
  }
}
