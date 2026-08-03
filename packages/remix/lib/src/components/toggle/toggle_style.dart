part of 'toggle.dart';

/// Style configuration for [RemixToggle] container, label, icon, and states.
extension RemixToggleStylerRemixHelpers on ToggleStyler {
  /// Sets the background color.
  ToggleStyler backgroundColor(Color value) {
    return merge(
      ToggleStyler(
        container: FlexBoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets the foreground color (label and icon).
  ToggleStyler foregroundColor(Color value) {
    return labelColor(value).iconColor(value);
  }

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
      mouseCursor: mouseCursor,
      style: this,
    );
  }

  ToggleStyler flex(FlexStyler value) {
    return merge(ToggleStyler(container: FlexBoxStyler().flex(value)));
  }
}
