part of 'badge.dart';

/// Fortal badge size presets.
enum FortalBadgeSize { size1, size2, size3 }

/// Fortal badge color and emphasis variants.
enum FortalBadgeVariant { solid, soft, surface, outline }

/// Fortal-themed preset for [RemixBadge].
RemixBadgeStyler fortalBadgeStyler({
  FortalBadgeVariant variant = .solid,
  FortalBadgeSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .solid => _fortalBadgeSolidStyler(size, highContrast: highContrast),
    .soft => _fortalBadgeSoftStyler(size, highContrast: highContrast),
    .surface => _fortalBadgeSurfaceStyler(size, highContrast: highContrast),
    .outline => _fortalBadgeOutlineStyler(size, highContrast: highContrast),
  };
}

RemixBadgeStyler _fortalBadgeBaseStyler(FortalBadgeSize size) {
  return RemixBadgeStyler().merge(_fortalBadgeSizeStyler(size));
}

RemixBadgeStyler _fortalBadgeSolidStyler(
  FortalBadgeSize size, {
  bool highContrast = false,
}) {
  return _fortalBadgeBaseStyler(size)
      .backgroundColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
      )
      .foregroundColor(
        highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
      );
}

RemixBadgeStyler _fortalBadgeSoftStyler(
  FortalBadgeSize size, {
  bool highContrast = false,
}) {
  return _fortalBadgeBaseStyler(size)
      .backgroundColor(FortalTokens.accentA3())
      .foregroundColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
      );
}

RemixBadgeStyler _fortalBadgeSurfaceStyler(
  FortalBadgeSize size, {
  bool highContrast = false,
}) {
  return _fortalBadgeBaseStyler(size)
      .backgroundColor(FortalTokens.accentA2())
      .borderAll(
        color: FortalTokens.accent6(),
        width: FortalTokens.borderWidth1(),
      )
      .foregroundColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
      );
}

RemixBadgeStyler _fortalBadgeOutlineStyler(
  FortalBadgeSize size, {
  bool highContrast = false,
}) {
  return _fortalBadgeBaseStyler(size)
      .backgroundColor(Colors.transparent)
      .borderAll(
        color: FortalTokens.accent7(),
        width: FortalTokens.borderWidth1(),
      )
      .foregroundColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
      );
}

RemixBadgeStyler _fortalBadgeSizeStyler(FortalBadgeSize size) {
  return switch (size) {
    .size1 => RemixBadgeStyler(
      container: BoxStyler()
          .paddingX(6.0)
          .paddingY(2.0)
          .borderRadiusAll(FortalTokens.radius2()),
      label: TextStyler().fontSize(11.0).height(16.0 / 11.0),
    ),
    .size2 => RemixBadgeStyler(
      container: BoxStyler()
          .paddingX(8.0)
          .paddingY(3.0)
          .borderRadiusAll(FortalTokens.radius3()),
      label: TextStyler().fontSize(12.0).height(18.0 / 12.0),
    ),
    .size3 => RemixBadgeStyler(
      container: BoxStyler()
          .paddingX(10.0)
          .paddingY(4.0)
          .borderRadiusAll(FortalTokens.radius3()),
      label: TextStyler().fontSize(13.0).height(20.0 / 13.0),
    ),
  };
}

/// Fortal-themed preset for [RemixBadge].
class FortalBadge extends StatelessWidget {
  const FortalBadge({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  });

  const FortalBadge.solid({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.solid;

  const FortalBadge.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.soft;

  const FortalBadge.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.surface;

  const FortalBadge.outline({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.outline;

  final FortalBadgeVariant variant;

  final FortalBadgeSize size;

  /// Optional accent color override for this badge subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this badge subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

  final String? label;

  final Widget? child;

  final RemixBadgeLabelBuilder? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child:
          fortalBadgeStyler(
            variant: this.variant,
            size: this.size,
            highContrast: this.highContrast,
          ).call(
            key: this.key,
            label: this.label,
            labelBuilder: this.labelBuilder,
            child: this.child,
          ),
    );
  }
}
