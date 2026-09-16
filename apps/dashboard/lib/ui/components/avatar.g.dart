// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed Avatar with the Radix size, variant, and override contract.
///
/// [fallbackLength] selects the pinned one- or two-character fallback
/// typography. Pass `2` when [RemixAvatar.label] contains two initials.
class UiAvatar extends StatelessWidget {
  const UiAvatar({
    super.key,
    this.variant = .soft,
    this.size = .size3,
    this.highContrast = false,
    this.fallbackLength = 1,
    this.style = const AvatarStyler.create(),
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

  const UiAvatar.soft({
    super.key,
    this.size = .size3,
    this.highContrast = false,
    this.fallbackLength = 1,
    this.style = const AvatarStyler.create(),
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  }) : variant = UiAvatarVariant.soft;

  const UiAvatar.solid({
    super.key,
    this.size = .size3,
    this.highContrast = false,
    this.fallbackLength = 1,
    this.style = const AvatarStyler.create(),
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  }) : variant = UiAvatarVariant.solid;

  final UiAvatarVariant variant;

  final UiAvatarSize size;

  final bool highContrast;

  final int fallbackLength;

  final AvatarStyler style;

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
    return RemixAvatar(
      key: this.key,
      style: uiAvatarStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
        fallbackLength: this.fallbackLength,
        style: this.style,
      ),
      backgroundImage: this.backgroundImage,
      foregroundImage: this.foregroundImage,
      onBackgroundImageError: this.onBackgroundImageError,
      onForegroundImageError: this.onForegroundImageError,
      child: this.child,
      label: this.label,
      labelBuilder: this.labelBuilder,
      icon: this.icon,
      iconBuilder: this.iconBuilder,
    );
  }
}
