part of 'avatar.dart';

/// Fortal avatar size presets.
enum FortalAvatarSize { size1, size2, size3, size4 }

/// Fortal avatar color variants.
enum FortalAvatarVariant { soft, solid }

/// Fortal-themed preset for [RemixAvatar].
RemixAvatarStyler fortalAvatarStyler({
  FortalAvatarVariant variant = .soft,
  FortalAvatarSize size = .size2,
}) {
  return switch (variant) {
    .soft => _fortalAvatarSoftStyler(size),
    .solid => _fortalAvatarSolidStyler(size),
  };
}

RemixAvatarStyler _fortalAvatarBaseStyler(FortalAvatarSize size) {
  return RemixAvatarStyler()
      .clipBehavior(.hardEdge)
      .labelFontWeight(.w500)
      .merge(_fortalAvatarSizeStyler(size));
}

RemixAvatarStyler _fortalAvatarSoftStyler([FortalAvatarSize size = .size2]) {
  return _fortalAvatarBaseStyler(size)
      .backgroundColor(FortalTokens.accentA3())
      .foregroundColor(FortalTokens.accentA10());
}

RemixAvatarStyler _fortalAvatarSolidStyler([FortalAvatarSize size = .size2]) {
  return _fortalAvatarBaseStyler(size)
      .backgroundColor(FortalTokens.accent9())
      .foregroundColor(FortalTokens.accentContrast());
}

RemixAvatarStyler _fortalAvatarSizeStyler(FortalAvatarSize size) {
  return switch (size) {
    .size1 =>
      RemixAvatarStyler()
          .square(24.0)
          .borderRadiusAll(FortalTokens.radius2())
          .labelStyle(FortalTokens.text1.mix()),
    .size2 =>
      RemixAvatarStyler()
          .square(32.0)
          .borderRadiusAll(FortalTokens.radius3())
          .labelStyle(FortalTokens.text2.mix()),
    .size3 =>
      RemixAvatarStyler()
          .square(40.0)
          .borderRadiusAll(FortalTokens.radius4())
          .labelStyle(FortalTokens.text3.mix()),
    .size4 =>
      RemixAvatarStyler()
          .square(64.0)
          .borderRadiusAll(FortalTokens.radius5())
          .labelStyle(FortalTokens.text4.mix()),
  };
}

/// Fortal-themed preset for [RemixAvatar].
class FortalAvatar extends StatelessWidget {
  const FortalAvatar({
    super.key,
    this.variant = .soft,
    this.size = .size2,
    this.color,
    this.radius,
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
    this.size = .size2,
    this.color,
    this.radius,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  }) : variant = FortalAvatarVariant.soft;

  const FortalAvatar.solid({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  }) : variant = FortalAvatarVariant.solid;

  final FortalAvatarVariant variant;

  final FortalAvatarSize size;

  /// Optional accent color override for this avatar subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this avatar subtree.
  final FortalRadius? radius;

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
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: fortalAvatarStyler(variant: this.variant, size: this.size).call(
        key: this.key,
        backgroundImage: this.backgroundImage,
        foregroundImage: this.foregroundImage,
        onBackgroundImageError: this.onBackgroundImageError,
        onForegroundImageError: this.onForegroundImageError,
        label: this.label,
        labelBuilder: this.labelBuilder,
        icon: this.icon,
        iconBuilder: this.iconBuilder,
        child: this.child,
      ),
    );
  }
}
