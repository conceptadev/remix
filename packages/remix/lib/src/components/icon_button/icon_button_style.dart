part of 'icon_button.dart';

/// Style configuration for [RemixIconButton] container, icon, and loading spinner.
extension RemixIconButtonStylerRemixHelpers on IconButtonStyler {
  RemixIconButton call({
    Key? key,
    required IconData icon,
    RemixIconButtonIconBuilder? iconBuilder,
    RemixIconButtonLoadingBuilder? loadingBuilder,
    bool loading = false,
    bool enabled = true,
    bool enableFeedback = true,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    bool autofocus = false,
    String? semanticLabel,
    String? semanticHint,
    bool excludeSemantics = false,
    MouseCursor mouseCursor = SystemMouseCursors.click,
  }) {
    return RemixIconButton(
      key: key,
      icon: icon,
      iconBuilder: iconBuilder,
      loadingBuilder: loadingBuilder,
      loading: loading,
      enabled: enabled,
      enableFeedback: enableFeedback,
      onPressed: onPressed,
      onLongPress: onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      mouseCursor: mouseCursor,
      style: this,
    );
  }
}
