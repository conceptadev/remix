// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_button.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed IconButton with the Radix size, variant, and override contract.
class UiIconButton extends StatelessWidget {
  const UiIconButton({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.highContrast = false,
    this.style = const IconButtonStyler.create(),
    required this.icon,
    required this.semanticLabel,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  });

  const UiIconButton.classic({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const IconButtonStyler.create(),
    required this.icon,
    required this.semanticLabel,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = UiIconButtonVariant.classic;

  const UiIconButton.solid({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const IconButtonStyler.create(),
    required this.icon,
    required this.semanticLabel,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = UiIconButtonVariant.solid;

  const UiIconButton.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const IconButtonStyler.create(),
    required this.icon,
    required this.semanticLabel,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = UiIconButtonVariant.soft;

  const UiIconButton.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const IconButtonStyler.create(),
    required this.icon,
    required this.semanticLabel,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = UiIconButtonVariant.surface;

  const UiIconButton.outline({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const IconButtonStyler.create(),
    required this.icon,
    required this.semanticLabel,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = UiIconButtonVariant.outline;

  const UiIconButton.ghost({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const IconButtonStyler.create(),
    required this.icon,
    required this.semanticLabel,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = UiIconButtonVariant.ghost;

  final UiIconButtonVariant variant;

  final UiIconButtonSize size;

  final bool highContrast;

  final IconButtonStyler style;

  final IconData? icon;

  final String semanticLabel;

  final RemixIconButtonIconBuilder? iconBuilder;

  final RemixIconButtonLoadingBuilder? loadingBuilder;

  final bool loading;

  final bool enabled;

  final bool enableFeedback;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final FocusNode? focusNode;

  final bool autofocus;

  final String? semanticHint;

  final bool excludeSemantics;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return RemixIconButton(
      key: this.key,
      style: uiIconButtonStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
        style: this.style,
      ),
      icon: this.icon,
      semanticLabel: this.semanticLabel,
      iconBuilder: this.iconBuilder,
      loadingBuilder: this.loadingBuilder,
      loading: this.loading,
      enabled: this.enabled,
      enableFeedback: this.enableFeedback,
      onPressed: this.onPressed,
      onLongPress: this.onLongPress,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      semanticHint: this.semanticHint,
      excludeSemantics: this.excludeSemantics,
      mouseCursor: this.mouseCursor,
    );
  }
}
