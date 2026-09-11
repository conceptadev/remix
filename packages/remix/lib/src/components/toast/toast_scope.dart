part of 'toast.dart';

/// Where a [RemixToastScope] stacks toasts; start and end follow
/// [Directionality].
typedef RemixToastPlacement = NakedToastPlacement;

/// Whether a toast is announced as a status (polite) or an alert (assertive).
typedef RemixToastPriority = NakedToastPriority;

/// Why a toast was dismissed.
typedef RemixToastDismissReason = NakedToastDismissReason;

/// A reference to one shown toast, with its `closed` future.
typedef RemixToastHandle = NakedToastHandle;

/// Drives a [RemixToastScope]. Show toasts with
/// [RemixToastControllerShow.showToast].
typedef RemixToastController = NakedToastController<RemixToastData>;

/// A labelled action rendered inside a toast.
///
/// Activating it calls [onPressed], then dismisses the toast with
/// [RemixToastDismissReason.action].
@immutable
final class RemixToastAction {
  const RemixToastAction({required this.label, required this.onPressed});

  /// The visible, localized button label. Must not be blank.
  final String label;

  final VoidCallback onPressed;
}

/// The content and lifetime of one toast shown through a [RemixToastScope].
@immutable
final class RemixToastData {
  const RemixToastData({
    this.id,
    required this.title,
    this.description,
    this.semanticLabel,
    this.icon,
    this.action,
    this.duration = const Duration(seconds: 4),
    this.priority = RemixToastPriority.polite,
    this.showCloseButton = true,
    this.style,
  });

  /// Stable identity. Showing data with an equal id replaces the visible or
  /// queued toast in place and restarts its lifetime.
  final Object? id;

  /// The message. Must not be blank.
  final String title;

  /// Optional supporting text. Must not be blank when provided.
  final String? description;

  /// The announced text. Defaults to [title] and [description] on separate
  /// lines.
  final String? semanticLabel;

  /// A decorative leading icon, excluded from semantics. Put any meaning it
  /// carries in [title] or [semanticLabel].
  final IconData? icon;

  final RemixToastAction? action;

  /// How long the toast stays visible, or null to persist until dismissed.
  ///
  /// A persistent toast needs an [action] or [showCloseButton].
  final Duration? duration;

  /// Use [RemixToastPriority.assertive] only for urgent, destructive, or
  /// time-sensitive messages.
  final RemixToastPriority priority;

  final bool showCloseButton;

  /// Merged over the scope's style for this toast only.
  final ToastStyler? style;
}

void _requireNonblank(String value, String name) {
  if (value.trim().isEmpty) {
    throw ArgumentError.value(value, name, 'must not be blank');
  }
}

NakedToastRequest<RemixToastData> _requestFor(RemixToastData toast) {
  _requireNonblank(toast.title, 'title');
  if (toast.description case final description?) {
    _requireNonblank(description, 'description');
  }
  if (toast.semanticLabel case final semanticLabel?) {
    _requireNonblank(semanticLabel, 'semanticLabel');
  }
  if (toast.action case final action?) {
    _requireNonblank(action.label, 'action.label');
  }

  return NakedToastRequest<RemixToastData>(
    id: toast.id,
    data: toast,
    semanticLabel:
        toast.semanticLabel ?? [toast.title, ?toast.description].join('\n'),
    duration: toast.duration,
    priority: toast.priority,
    interactive: toast.action != null || toast.showCloseButton,
  );
}

/// Shows [RemixToastData] through a [RemixToastController].
extension RemixToastControllerShow on NakedToastController<RemixToastData> {
  /// Shows [toast], or queues it when every visible slot is taken.
  ///
  /// Throws an [ArgumentError] for blank text or a persistent toast without an
  /// action or close button.
  RemixToastHandle showToast(RemixToastData toast) => show(_requestFor(toast));
}

/// Shows [toast] in the nearest [RemixToastScope].
///
/// Call from an event callback, not during build. Throws a [FlutterError]
/// when no scope is found.
///
/// ```dart
/// showRemixToast(
///   context,
///   RemixToastData(
///     title: 'Draft saved',
///     action: RemixToastAction(label: 'Undo', onPressed: undo),
///   ),
/// );
/// ```
RemixToastHandle showRemixToast(BuildContext context, RemixToastData toast) {
  final controller = RemixToastScope.maybeOf(context);
  if (controller == null) {
    throw FlutterError.fromParts([
      ErrorSummary(
        'showRemixToast() was called with a context that has no '
        'RemixToastScope ancestor.',
      ),
      ErrorHint(
        'Place a RemixToastScope below the app Overlay in a subtree that stays '
        'mounted, for example:\n'
        '  MaterialApp(home: RemixToastScope(child: Shell()))\n'
        'No Scaffold is required.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  return controller.showToast(toast);
}

/// Hosts queued, nonmodal toasts styled with [RemixToast].
///
/// Place one scope below the app's [Overlay] in a subtree that stays mounted,
/// such as `MaterialApp.home` or a persistent router shell. Toasts render
/// through one overlay portal, so they inherit the scope's [MixScope] tokens
/// and [Directionality] and update live when those change.
///
/// Queueing, timers, pausing, focus, and status or alert semantics come from
/// [NakedToastScope]; see its documentation for the full behavior contract.
class RemixToastScope extends StatelessWidget {
  const RemixToastScope({
    super.key,
    this.controller,
    this.placement = RemixToastPlacement.bottomEnd,
    this.maxVisible = 3,
    this.maxQueued = 20,
    this.inset = const EdgeInsetsDirectional.all(24),
    this.gap = 12,
    this.dismissLabel = 'Dismiss notification',
    this.style = const ToastStyler.create(),
    required this.child,
  });

  /// An optional caller-owned controller; the scope never disposes it.
  final RemixToastController? controller;

  final RemixToastPlacement placement;

  /// How many toasts can be on screen at once. At least one.
  final int maxVisible;

  /// How many toasts can wait for a visible slot.
  final int maxQueued;

  /// Space between the stack and the safe area's edges.
  final EdgeInsetsGeometry inset;

  /// Space between stacked toasts.
  final double gap;

  /// The localized accessible name of every close button. Must not be blank.
  final String dismissLabel;

  /// The base style of every toast; each [RemixToastData.style] merges over
  /// it.
  final ToastStyler style;

  final Widget child;

  /// Returns the controller of the nearest [RemixToastScope], or null.
  static RemixToastController? maybeOf(BuildContext context) =>
      NakedToastScope.maybeOf<RemixToastData>(context);

  Widget _buildToast(
    BuildContext context,
    NakedToastState<RemixToastData> toast,
    Animation<double> animation,
  ) {
    final data = toast.data;
    final action = data.action;
    final entranceOffset = switch (placement) {
      .topStart || .topCenter || .topEnd => -16.0,
      .bottomStart || .bottomCenter || .bottomEnd => 16.0,
    };
    final dataStyle = data.style;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
        opacity: animation.value,
        // The toast's controls must be reachable from its first frame, while
        // the entrance still starts fully transparent.
        alwaysIncludeSemantics: true,
        child: Transform.translate(
          offset: Offset(0, entranceOffset * (1 - animation.value)),
          child: child,
        ),
      ),
      child: RemixToast(
        title: data.title,
        description: data.description,
        icon: data.icon,
        action: action == null
            ? null
            : RemixToastAction(
                label: action.label,
                onPressed: () {
                  try {
                    action.onPressed();
                  } finally {
                    toast.dismiss(RemixToastDismissReason.action);
                  }
                },
              ),
        onDismiss: data.showCloseButton
            ? () => toast.dismiss(RemixToastDismissReason.close)
            : null,
        dismissLabel: dismissLabel,
        excludeMessageSemantics: true,
        style: dataStyle == null ? style : style.merge(dataStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _requireNonblank(dismissLabel, 'dismissLabel');

    return NakedToastScope<RemixToastData>(
      controller: controller,
      placement: placement,
      maxVisible: maxVisible,
      maxQueued: maxQueued,
      inset: inset,
      gap: gap,
      toastBuilder: _buildToast,
      child: child,
    );
  }
}
