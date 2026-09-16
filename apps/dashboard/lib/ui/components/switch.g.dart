// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed preset for [RemixSwitch].
class UiSwitch extends StatelessWidget {
  const UiSwitch({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.highContrast = false,
    this.style = const SwitchStyler.create(),
    required this.selected,
    required this.semanticLabel,
    this.onChanged,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  });

  /// Raised treatment with Radix's classic shadows.
  const UiSwitch.classic({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const SwitchStyler.create(),
    required this.selected,
    required this.semanticLabel,
    this.onChanged,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = UiSwitchVariant.classic;

  /// Surface treatment with a visible border.
  const UiSwitch.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const SwitchStyler.create(),
    required this.selected,
    required this.semanticLabel,
    this.onChanged,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = UiSwitchVariant.surface;

  /// Softer accent treatment.
  const UiSwitch.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const SwitchStyler.create(),
    required this.selected,
    required this.semanticLabel,
    this.onChanged,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = UiSwitchVariant.soft;

  final UiSwitchVariant variant;

  final UiSwitchSize size;

  final bool highContrast;

  final SwitchStyler style;

  final bool selected;

  final String semanticLabel;

  final ValueChanged<bool>? onChanged;

  final bool enabled;

  final bool enableFeedback;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool excludeSemantics;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return RemixSwitch(
      key: this.key,
      style: uiSwitchStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
        style: this.style,
      ),
      selected: this.selected,
      semanticLabel: this.semanticLabel,
      onChanged: this.onChanged,
      enabled: this.enabled,
      enableFeedback: this.enableFeedback,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      excludeSemantics: this.excludeSemantics,
      mouseCursor: this.mouseCursor,
    );
  }
}
