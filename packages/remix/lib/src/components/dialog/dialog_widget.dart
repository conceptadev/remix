part of 'dialog.dart';

String? _nonblank(String? value) =>
    value == null || value.trim().isEmpty ? null : value;

String? _resolveDismissibleBarrierLabel({
  required bool barrierDismissible,
  required String? barrierLabel,
}) {
  if (barrierDismissible &&
      (barrierLabel == null || barrierLabel.trim().isEmpty)) {
    throw ArgumentError.value(
      barrierLabel,
      'barrierLabel',
      'Dismissible dialogs require a nonblank localized barrier label.',
    );
  }
  // Trim only for the check above; the caller-supplied label is passed
  // through unmodified on both branches.
  return barrierLabel;
}

WidgetBuilder _captureMixScope(BuildContext context, WidgetBuilder builder) {
  final scope = MixScope.maybeOf(context);
  if (scope == null) return builder;

  return (_) => MixScope(
    tokens: scope.tokens,
    orderOfModifiers: scope.orderOfModifiers,
    child: Builder(builder: builder),
  );
}

/// Shows a customizable dialog.
///
/// ## Example
///
/// ```dart
/// await showRemixDialog<String>(
///   context: context,
///   barrierLabel: 'Dismiss',
///   builder: (context) => RemixDialog(
///     title: 'Delete Item',
///     description: 'Are you sure you want to delete this item?',
///     actions: [
///       TextButton(
///         onPressed: () => Navigator.pop(context, 'cancel'),
///         child: Text('Cancel'),
///       ),
///       TextButton(
///         onPressed: () => Navigator.pop(context, 'delete'),
///         child: Text('Delete'),
///       ),
///     ],
///   ),
/// )
/// ```
Future<T?> showRemixDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? barrierColor,
  bool barrierDismissible = true,
  String? barrierLabel,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  Duration transitionDuration = const Duration(milliseconds: 400),
  RouteTransitionsBuilder? transitionBuilder,
  bool requestFocus = true,
  TraversalEdgeBehavior? traversalEdgeBehavior,
}) {
  final resolvedBarrierLabel = _resolveDismissibleBarrierLabel(
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
  );
  return showNakedDialog(
    context: context,
    barrierColor: barrierColor ?? const Color(0x8A000000),
    barrierDismissible: barrierDismissible,
    barrierLabel: resolvedBarrierLabel,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    transitionDuration: transitionDuration,
    transitionBuilder: transitionBuilder,
    requestFocus: requestFocus,
    traversalEdgeBehavior: traversalEdgeBehavior,
    builder: _captureMixScope(context, builder),
  );
}

/// Shows an urgent modal alert dialog with Remix styling support.
///
/// [semanticLabel] must be a non-empty, localized description of the alert.
/// When [barrierDismissible] is true, [barrierLabel] must also be non-empty.
///
/// [initialFocusNode] remains owned by the caller and should be attached to a
/// focusable descendant of [builder]. Without one, focus falls back to an
/// autofocus or the first traversable descendant. Escape and platform Back
/// dismiss the alert with a null result.
Future<T?> showRemixAlertDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required String semanticLabel,
  Color? barrierColor,
  String? barrierLabel,
  bool barrierDismissible = false,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  Duration transitionDuration = const Duration(milliseconds: 400),
  RouteTransitionsBuilder? transitionBuilder,
  FocusNode? initialFocusNode,
}) {
  return showNakedAlertDialog(
    context: context,
    barrierColor: barrierColor ?? const Color(0x8A000000),
    semanticLabel: semanticLabel,
    barrierLabel: barrierLabel,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    transitionDuration: transitionDuration,
    transitionBuilder: transitionBuilder,
    initialFocusNode: initialFocusNode,
    builder: _captureMixScope(context, builder),
  );
}

/// A customizable dialog component.
///
/// ## Example
///
/// ```dart
/// RemixDialog(
///   title: 'Delete Item',
///   description: 'Are you sure you want to delete this item?',
///   actions: [
///     RemixButton(
///       label: 'Cancel',
///       onPressed: () => Navigator.pop(context),
///     ),
///     RemixButton(
///       label: 'Delete',
///       onPressed: () => Navigator.pop(context),
///     ),
///   ],
/// )
/// ```
class RemixDialog extends StatelessWidget {
  const RemixDialog({
    super.key,
    this.child,
    this.title,
    this.description,
    this.actions,
    this.scrollable = false,
    this.modal = true,
    this.semanticLabel,
    this.style = const DialogStyler.create(),
    this.styleSpec,
  }) : assert(
         child != null || title != null || description != null,
         'Either child, title, or description must be provided',
       );

  /// Custom body content.
  ///
  /// Composes with [title], [description], and [actions] in [AlertDialog]
  /// order. Alone, placed directly in the container (no default column).
  final Widget? child;

  /// Dialog title text.
  final String? title;

  /// Dialog description text.
  final String? description;

  /// Action buttons (typically placed at the bottom).
  final List<Widget>? actions;

  /// Whether structured body content can scroll within a bounded dialog.
  ///
  /// When true, [description] and [child] share a vertical scroll region while
  /// [title] and [actions] remain outside it. A lone [child] remains fully
  /// caller-owned and is never wrapped in the structured scroll region.
  final bool scrollable;

  /// Whether to block background content interaction.
  final bool modal;

  /// Semantic label for accessibility.
  ///
  /// A standalone dialog requires this or a nonblank [title]. A dialog nested
  /// under a caller-owned [NakedDialog] inherits that ancestor's dialog role
  /// and accessible name.
  final String? semanticLabel;

  /// The style configuration for the dialog.
  final DialogStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final DialogSpec? styleSpec;

  static final styleFrom = DialogStyler.new;

  @override
  Widget build(BuildContext context) {
    final resolvedSemanticLabel = _nonblank(semanticLabel) ?? _nonblank(title);
    final hasDialogAncestor =
        context.findAncestorWidgetOfExactType<NakedDialog>() != null;
    if (!hasDialogAncestor && resolvedSemanticLabel == null) {
      throw ArgumentError(
        'A standalone RemixDialog requires a nonblank semanticLabel or title.',
      );
    }

    final content = RemixStyleSpecBuilder<DialogSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        final hasActions = actions != null && actions!.isNotEmpty;
        final isLoneChild =
            child != null &&
            title == null &&
            description == null &&
            !hasActions;

        // Skip the default column so a fully custom body keeps its layout.
        if (isLoneChild) {
          return RemixBoxAdapter(
            styleSpec: spec.container,
            containerEffects: spec.containerEffects,
            child: child!,
          );
        }

        final hasBody = description != null || child != null;
        final titleWidget = title == null
            ? null
            : StyledText(title!, styleSpec: spec.title);
        final bodyChildren = <Widget>[
          if (description != null)
            StyledText(description!, styleSpec: spec.description),
          ?child,
        ];
        final actionsWidget = hasActions
            ? FlexBox(styleSpec: spec.actions, children: actions!)
            : null;

        // title → description → child → actions; never discard provided content.
        return RemixBoxAdapter(
          styleSpec: spec.container,
          containerEffects: spec.containerEffects,
          child: scrollable && hasBody
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    final body = SingleChildScrollView(
                      child: Column(
                        mainAxisSize: .min,
                        crossAxisAlignment: .start,
                        children: bodyChildren,
                      ),
                    );

                    return Column(
                      mainAxisAlignment: .start,
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      children: [
                        ?titleWidget,
                        if (constraints.hasBoundedHeight)
                          Flexible(fit: FlexFit.loose, child: body)
                        else
                          body,
                        ?actionsWidget,
                      ],
                    );
                  },
                )
              : Column(
                  mainAxisAlignment: .start,
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [?titleWidget, ...bodyChildren, ?actionsWidget],
                ),
        );
      },
    );

    if (hasDialogAncestor) return content;

    return NakedDialog(
      modal: modal,
      semanticLabel: resolvedSemanticLabel,
      child: content,
    );
  }
}
