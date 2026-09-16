// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toast.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed toast surface for [RemixToast] and [RemixToastScope].
///
/// A Ui extension: Radix Themes has no toast, so the recipe reuses the
/// Card panel and shadow tokens. The surface caps at 360 logical pixels and
/// shrinks with the available width.
///
/// ```dart
/// RemixToastScope(style: uiToastStyle(), child: const Shell())
/// ```
class UiToast extends StatelessWidget {
  const UiToast({
    super.key,
    this.variant = .classic,
    this.size = .size2,
    this.intent = .accent,
    this.style = const ToastStyler.create(),
    required this.title,
    this.description,
    this.icon,
    this.action,
    this.onDismiss,
    this.dismissLabel,
    this.excludeMessageSemantics = false,
  });

  const UiToast.surface({
    super.key,
    this.size = .size2,
    this.intent = .accent,
    this.style = const ToastStyler.create(),
    required this.title,
    this.description,
    this.icon,
    this.action,
    this.onDismiss,
    this.dismissLabel,
    this.excludeMessageSemantics = false,
  }) : variant = UiToastVariant.surface;

  const UiToast.classic({
    super.key,
    this.size = .size2,
    this.intent = .accent,
    this.style = const ToastStyler.create(),
    required this.title,
    this.description,
    this.icon,
    this.action,
    this.onDismiss,
    this.dismissLabel,
    this.excludeMessageSemantics = false,
  }) : variant = UiToastVariant.classic;

  final UiToastVariant variant;

  final UiToastSize size;

  final UiToastIntent intent;

  final ToastStyler style;

  final String title;

  final String? description;

  final IconData? icon;

  final RemixToastAction? action;

  final VoidCallback? onDismiss;

  final String? dismissLabel;

  final bool excludeMessageSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixToast(
      key: this.key,
      style: uiToastStyle(
        variant: this.variant,
        size: this.size,
        intent: this.intent,
        style: this.style,
      ),
      title: this.title,
      description: this.description,
      icon: this.icon,
      action: this.action,
      onDismiss: this.onDismiss,
      dismissLabel: this.dismissLabel,
      excludeMessageSemantics: this.excludeMessageSemantics,
    );
  }
}
