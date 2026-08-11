part of 'avatar.dart';

/// Style configuration for [RemixAvatar] container, label, and fallback icon.
extension RemixAvatarStylerRemixHelpers on AvatarStyler {
  /// Creates a [RemixAvatar] widget with this style applied.
  RemixAvatar call({
    Key? key,
    ImageProvider? backgroundImage,
    ImageProvider? foregroundImage,
    ImageErrorListener? onBackgroundImageError,
    ImageErrorListener? onForegroundImageError,
    Widget? child,
    String? label,
    RemixAvatarLabelBuilder? labelBuilder,
    IconData? icon,
    RemixAvatarIconBuilder? iconBuilder,
  }) {
    return RemixAvatar(
      key: key,
      backgroundImage: backgroundImage,
      foregroundImage: foregroundImage,
      onBackgroundImageError: onBackgroundImageError,
      onForegroundImageError: onForegroundImageError,
      label: label,
      labelBuilder: labelBuilder,
      icon: icon,
      iconBuilder: iconBuilder,
      style: this,
      child: child,
    );
  }
}
