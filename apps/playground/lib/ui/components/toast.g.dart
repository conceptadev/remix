// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toast.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Toast recipe.
///
/// Remix owns the queue, the timers, focus, and the announcement through
/// `RemixToastScope`; this recipe owns the surface, the type, and the colors.
/// Hand it to the scope once, above the app's `Navigator` so every route,
/// including dialogs, can reach it:
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) => Overlay.wrap(
///     child: RemixToastScope(style: playgroundToastStyle(), child: child!),
///   ),
/// )
/// ```
///
/// One toast can switch tone through `RemixToastData.style`, which merges over
/// the scope's style:
///
/// ```dart
/// showRemixToast(
///   context,
///   RemixToastData(
///     title: 'Upload failed',
///     priority: RemixToastPriority.assertive,
///     style: playgroundToastStyle(variant: .destructive),
///   ),
/// );
/// ```
///
/// The action and the close button reuse this application's Button and
/// IconButton recipes, so they keep their own hover, focus, and press states.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
class PlaygroundToast extends StatelessWidget {
  const PlaygroundToast({
    super.key,
    this.variant = .neutral,
    this.style = const ToastStyler.create(),
    required this.title,
    this.description,
    this.icon,
    this.action,
    this.onDismiss,
    this.dismissLabel,
    this.excludeMessageSemantics = false,
  });

  /// An ordinary confirmation or notice.
  const PlaygroundToast.neutral({
    super.key,
    this.style = const ToastStyler.create(),
    required this.title,
    this.description,
    this.icon,
    this.action,
    this.onDismiss,
    this.dismissLabel,
    this.excludeMessageSemantics = false,
  }) : variant = PlaygroundToastVariant.neutral;

  /// A failure the reader should notice.
  ///
  /// Visual only. Pair it with `RemixToastPriority.assertive` when the message
  /// must interrupt a screen reader; a red outline alone announces nothing.
  const PlaygroundToast.destructive({
    super.key,
    this.style = const ToastStyler.create(),
    required this.title,
    this.description,
    this.icon,
    this.action,
    this.onDismiss,
    this.dismissLabel,
    this.excludeMessageSemantics = false,
  }) : variant = PlaygroundToastVariant.destructive;

  final PlaygroundToastVariant variant;

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
      style: playgroundToastStyle(variant: this.variant, style: this.style),
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
