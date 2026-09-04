// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed Button with the Radix size, variant, and override contract.
class FortalButton extends StatelessWidget {
  const FortalButton({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.highContrast = false,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.textBuilder,
    this.leadingIconBuilder,
    this.trailingIconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  });

  const FortalButton.classic({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.textBuilder,
    this.leadingIconBuilder,
    this.trailingIconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalButtonVariant.classic;

  const FortalButton.solid({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.textBuilder,
    this.leadingIconBuilder,
    this.trailingIconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalButtonVariant.solid;

  const FortalButton.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.textBuilder,
    this.leadingIconBuilder,
    this.trailingIconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalButtonVariant.soft;

  const FortalButton.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.textBuilder,
    this.leadingIconBuilder,
    this.trailingIconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalButtonVariant.surface;

  const FortalButton.outline({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.textBuilder,
    this.leadingIconBuilder,
    this.trailingIconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalButtonVariant.outline;

  const FortalButton.ghost({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.textBuilder,
    this.leadingIconBuilder,
    this.trailingIconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalButtonVariant.ghost;

  final FortalButtonVariant variant;

  final FortalButtonSize size;

  final bool highContrast;

  final String label;

  final IconData? leadingIcon;

  final IconData? trailingIcon;

  final RemixButtonTextBuilder? textBuilder;

  final RemixButtonIconBuilder? leadingIconBuilder;

  final RemixButtonIconBuilder? trailingIconBuilder;

  final RemixButtonLoadingBuilder? loadingBuilder;

  final bool loading;

  final bool enabled;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool enableFeedback;

  final String? semanticLabel;

  final String? semanticHint;

  final bool excludeSemantics;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return RemixButton(
      key: this.key,
      style: fortalButtonStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      label: this.label,
      leadingIcon: this.leadingIcon,
      trailingIcon: this.trailingIcon,
      textBuilder: this.textBuilder,
      leadingIconBuilder: this.leadingIconBuilder,
      trailingIconBuilder: this.trailingIconBuilder,
      loadingBuilder: this.loadingBuilder,
      loading: this.loading,
      enabled: this.enabled,
      onPressed: this.onPressed,
      onLongPress: this.onLongPress,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      enableFeedback: this.enableFeedback,
      semanticLabel: this.semanticLabel,
      semanticHint: this.semanticHint,
      excludeSemantics: this.excludeSemantics,
      mouseCursor: this.mouseCursor,
    );
  }
}
