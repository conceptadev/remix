// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toast.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed toast surface for [RemixToast] and [RemixToastScope].
///
/// A Fortal extension: Radix Themes has no toast, so the recipe reuses the
/// Card panel and shadow tokens. The surface caps at 360 logical pixels and
/// shrinks with the available width.
///
/// ```dart
/// RemixToastScope(style: fortalToastStyle(), child: const Shell())
/// ```
class FortalToast extends StatelessWidget {
  const FortalToast({
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

  const FortalToast.surface({
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
  }) : variant = FortalToastVariant.surface;

  const FortalToast.classic({
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
  }) : variant = FortalToastVariant.classic;

  final FortalToastVariant variant;

  final FortalToastSize size;

  final FortalToastIntent intent;

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
      style: fortalToastStyle(
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
