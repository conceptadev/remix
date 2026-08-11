part of 'toggle.dart';

/// Style configuration for [RemixToggle] container, label, icon, and states.
extension RemixToggleStylerRemixHelpers on ToggleStyler {
  /// Creates a [RemixToggle] widget with this style applied.
  RemixToggle call({
    Key? key,
    required bool selected,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    String? label,
    IconData? icon,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    String? semanticLabel,
    bool excludeSemantics = false,
    MouseCursor mouseCursor = SystemMouseCursors.click,
  }) {
    return RemixToggle(
      key: key,
      selected: selected,
      onChanged: onChanged,
      enabled: enabled,
      label: label,
      icon: icon,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      mouseCursor: mouseCursor,
      style: this,
    );
  }
}
