part of 'card.dart';

/// Style configuration for a [RemixCard] container.
extension RemixCardStylerRemixHelpers on RemixCardStyler {
  /// Sets the card background color.
  RemixCardStyler backgroundColor(Color value) => color(value);

  /// Creates a [RemixCard] widget with this style applied.
  RemixCard call({
    Key? key,
    Widget? child,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    bool enabled = true,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    bool focusOnTap = false,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<bool>? onPressChange,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixCard(
      key: key,
      child: child,
      onTap: onTap,
      onLongPress: onLongPress,
      enabled: enabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      focusOnTap: focusOnTap,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onPressChange: onPressChange,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      style: this,
    );
  }
}
