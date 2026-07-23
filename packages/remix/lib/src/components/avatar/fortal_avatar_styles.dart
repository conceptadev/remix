part of 'avatar.dart';

/// Radix Themes Avatar size presets.
enum FortalAvatarSize {
  size1,
  size2,
  size3,
  size4,
  size5,
  size6,
  size7,
  size8,
  size9,
}

/// Radix Themes Avatar variants.
enum FortalAvatarVariant { soft, solid }

/// Fortal recipe for [RemixAvatar].
RemixAvatarStyler fortalAvatarStyler({
  FortalAvatarVariant variant = .soft,
  FortalAvatarSize size = .size3,
  bool highContrast = false,
  int fallbackLength = 1,
}) {
  final base = _fortalAvatarBaseStyler(size, fallbackLength: fallbackLength);
  return switch (variant) {
    .soft =>
      base
          .backgroundColor(FortalTokens.accentA3())
          .foregroundColor(
            highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
          ),
    .solid =>
      base
          .backgroundColor(
            highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
          )
          .foregroundColor(
            highContrast
                ? FortalTokens.accent1()
                : FortalTokens.accentContrast(),
          ),
  };
}

RemixAvatarStyler _fortalAvatarBaseStyler(
  FortalAvatarSize size, {
  required int fallbackLength,
}) {
  final fallbackText = _fortalAvatarFallbackText(size, fallbackLength);
  return RemixAvatarStyler()
      .clipBehavior(.hardEdge)
      .label(
        TextStyler(
          style: fallbackText.mix(),
        ).fontWeight(FortalTokens.fontWeightMedium()),
      )
      .icon(
        IconStyler(
          size: _fortalAvatarDimension(size) * 0.5,
        ).color(FortalTokens.accentA11()),
      )
      .square(_fortalAvatarDimension(size))
      .borderRadiusAll(_fortalAvatarRadius(size));
}

double _fortalAvatarDimension(FortalAvatarSize size) => switch (size) {
  .size1 => FortalTokens.space5(),
  .size2 => FortalTokens.space6(),
  .size3 => FortalTokens.space7(),
  .size4 => FortalTokens.space8(),
  .size5 => FortalTokens.space9(),
  .size6 => FortalTokens.avatarSize6(),
  .size7 => FortalTokens.avatarSize7(),
  .size8 => FortalTokens.avatarSize8(),
  .size9 => FortalTokens.avatarSize9(),
};

Radius _fortalAvatarRadius(FortalAvatarSize size) => switch (size) {
  .size1 || .size2 => FortalTokens.radius2OrFull(),
  .size3 || .size4 => FortalTokens.radius3OrFull(),
  .size5 => FortalTokens.radius4OrFull(),
  .size6 || .size7 => FortalTokens.radius5OrFull(),
  .size8 || .size9 => FortalTokens.radius6OrFull(),
};

TextStyleToken _fortalAvatarFallbackText(
  FortalAvatarSize size,
  int fallbackLength,
) => switch ((size, fallbackLength == 2)) {
  (.size1, false) => FortalTokens.avatarFallback1One,
  (.size1, true) => FortalTokens.avatarFallback1Two,
  (.size2, false) => FortalTokens.avatarFallback2One,
  (.size2, true) => FortalTokens.avatarFallback2Two,
  (.size3, false) => FortalTokens.avatarFallback3One,
  (.size3, true) => FortalTokens.avatarFallback3Two,
  (.size4, false) => FortalTokens.avatarFallback4One,
  (.size4, true) => FortalTokens.avatarFallback4Two,
  (.size5, _) => FortalTokens.avatarFallback5,
  (.size6, _) => FortalTokens.avatarFallback6,
  (.size7, _) => FortalTokens.avatarFallback7,
  (.size8, _) => FortalTokens.avatarFallback8,
  (.size9, _) => FortalTokens.avatarFallback9,
};

/// Fortal-themed Avatar with the Radix size, variant, and override contract.
class FortalAvatar extends StatelessWidget {
  const FortalAvatar({
    super.key,
    this.variant = .soft,
    this.size = .size3,
    this.color,
    this.radius,
    this.highContrast = false,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  });

  const FortalAvatar.soft({
    super.key,
    this.size = .size3,
    this.color,
    this.radius,
    this.highContrast = false,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  }) : variant = .soft;

  const FortalAvatar.solid({
    super.key,
    this.size = .size3,
    this.color,
    this.radius,
    this.highContrast = false,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  }) : variant = .solid;

  final FortalAvatarVariant variant;
  final FortalAvatarSize size;

  /// Optional Radix accent override.
  final FortalAccentColor? color;

  /// Optional Radix radius override.
  final FortalRadius? radius;

  /// Whether fallback colors use the high-contrast Radix roles.
  final bool highContrast;

  final ImageProvider<Object>? backgroundImage;
  final ImageProvider<Object>? foregroundImage;
  final ImageErrorListener? onBackgroundImageError;
  final ImageErrorListener? onForegroundImageError;
  final Widget? child;
  final String? label;
  final RemixAvatarLabelBuilder? labelBuilder;
  final IconData? icon;
  final RemixAvatarIconBuilder? iconBuilder;

  @override
  Widget build(BuildContext context) {
    final normalizedLabel = label?.toUpperCase();
    return FortalComponentOverride(
      color: color,
      radius: radius,
      child:
          fortalAvatarStyler(
            variant: variant,
            size: size,
            highContrast: highContrast,
            fallbackLength: normalizedLabel?.runes.length ?? 1,
          ).call(
            key: key,
            backgroundImage: backgroundImage,
            foregroundImage: foregroundImage,
            onBackgroundImageError: onBackgroundImageError,
            onForegroundImageError: onForegroundImageError,
            label: normalizedLabel,
            labelBuilder: labelBuilder,
            icon: icon,
            iconBuilder: iconBuilder,
            child: child,
          ),
    );
  }
}
