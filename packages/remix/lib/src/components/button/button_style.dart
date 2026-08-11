part of 'button.dart';

/// Style builder for [RemixButton].
///
/// Use this class to style the button container, label, icons, and loading
/// spinner. It supports Mix variants and widget state variants for focused,
/// hovered, pressed, disabled, and loading states.
extension RemixButtonStylerRemixHelpers on ButtonStyler {
  /// Creates a [RemixButton] widget with this style applied.
  RemixButton call({
    Key? key,
    required String label,
    IconData? leadingIcon,
    IconData? trailingIcon,
    RemixButtonTextBuilder? textBuilder,
    RemixButtonIconBuilder? leadingIconBuilder,
    RemixButtonIconBuilder? trailingIconBuilder,
    RemixButtonLoadingBuilder? loadingBuilder,
    bool loading = false,
    bool enabled = true,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableFeedback = true,
    String? semanticLabel,
    String? semanticHint,
    bool excludeSemantics = false,
    MouseCursor mouseCursor = SystemMouseCursors.click,
  }) {
    return RemixButton(
      key: key,
      label: label,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      textBuilder: textBuilder,
      leadingIconBuilder: leadingIconBuilder,
      trailingIconBuilder: trailingIconBuilder,
      loadingBuilder: loadingBuilder,
      loading: loading,
      enabled: enabled,
      onPressed: onPressed,
      onLongPress: onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      enableFeedback: enableFeedback,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      mouseCursor: mouseCursor,
      style: this,
    );
  }
}
