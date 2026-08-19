// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixRadio].
class FortalRadio<T> extends StatelessWidget {
  const FortalRadio({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.highContrast = false,
    required this.value,
    required this.semanticLabel,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
  });

  /// Raised treatment with Radix's classic shadow and gradient layers.
  const FortalRadio.classic({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.value,
    required this.semanticLabel,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
  }) : variant = FortalRadioVariant.classic;

  /// Surface treatment with neutral border.
  const FortalRadio.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.value,
    required this.semanticLabel,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
  }) : variant = FortalRadioVariant.surface;

  /// Soft accent treatment.
  const FortalRadio.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.value,
    required this.semanticLabel,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
  }) : variant = FortalRadioVariant.soft;

  final FortalRadioVariant variant;

  final FortalRadioSize size;

  final bool highContrast;

  final T value;

  final String semanticLabel;

  final bool enabled;

  final bool toggleable;

  final MouseCursor? mouseCursor;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixRadio<T>(
      key: this.key,
      style: fortalRadioStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      value: this.value,
      semanticLabel: this.semanticLabel,
      enabled: this.enabled,
      toggleable: this.toggleable,
      mouseCursor: this.mouseCursor,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
