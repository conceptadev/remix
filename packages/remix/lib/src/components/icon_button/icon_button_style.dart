part of 'icon_button.dart';

/// Style configuration for [RemixIconButton] container, icon, and loading spinner.
extension RemixIconButtonStylerRemixHelpers on RemixIconButtonStyler {
  /// Sets the background color of the icon button container.
  RemixIconButtonStyler backgroundColor(Color value) {
    return color(value);
  }

  /// Sets the foreground color (icon color) of the icon button.
  RemixIconButtonStyler foregroundColor(Color value) {
    return iconColor(value);
  }

  /// Sets size (width and height - icon buttons are square)
  RemixIconButtonStyler iconButtonSize(double size) {
    return merge(
      RemixIconButtonStyler(
        container: BoxStyler(
          constraints: BoxConstraintsMix(
            minWidth: size,
            maxWidth: size,
            minHeight: size,
            maxHeight: size,
          ),
        ),
      ),
    );
  }

  /// Sets the minimum size of the icon button.
  RemixIconButtonStyler minimumSize(Size value) {
    return merge(
      RemixIconButtonStyler().constraintsOnly(
        minWidth: value.width,
        minHeight: value.height,
      ),
    );
  }

  /// Sets the maximum size of the icon button.
  RemixIconButtonStyler maximumSize(Size value) {
    return merge(
      RemixIconButtonStyler().constraintsOnly(
        maxWidth: value.width,
        maxHeight: value.height,
      ),
    );
  }

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
