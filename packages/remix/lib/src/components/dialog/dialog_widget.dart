part of 'dialog.dart';

WidgetBuilder _captureInheritedScopes(
  BuildContext context,
  WidgetBuilder builder,
) {
  final scope = MixScope.maybeOf(context);
  final theme = FortalTheme.maybeOf(context);
  if (scope == null && theme == null) return builder;

  return (_) {
    Widget child = Builder(builder: builder);

    if (scope != null) {
      child = MixScope(
        tokens: scope.tokens,
        orderOfModifiers: scope.orderOfModifiers,
        child: child,
      );
    }

    if (theme != null) {
      child = FortalTheme(data: theme, child: child);
    }

    return child;
  };
}

Color _resolveBarrierColor(BuildContext context, Color? explicitColor) {
  if (explicitColor != null) return explicitColor;

  final tokens = MixScope.maybeOf(context)?.tokens;
  if (tokens?.containsKey(FortalTokens.colorOverlay) == true) {
    return MixScope.tokenOf(FortalTokens.colorOverlay, context);
  }

  return Colors.black54;
}

/// Shows a customizable dialog.
///
/// ## Example
///
/// ```dart
/// await showRemixDialog<String>(
///   context: context,
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
  return showNakedDialog(
    context: context,
    barrierColor: _resolveBarrierColor(context, barrierColor),
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    transitionDuration: transitionDuration,
    transitionBuilder: transitionBuilder,
    requestFocus: requestFocus,
    traversalEdgeBehavior: traversalEdgeBehavior,
    builder: _captureInheritedScopes(context, builder),
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
    barrierColor: _resolveBarrierColor(context, barrierColor),
    semanticLabel: semanticLabel,
    barrierLabel: barrierLabel,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    transitionDuration: transitionDuration,
    transitionBuilder: transitionBuilder,
    initialFocusNode: initialFocusNode,
    builder: _captureInheritedScopes(context, builder),
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
///       onPressed: () => Navigator.pop(context),
///       child: Text('Cancel'),
///     ),
///     RemixButton(
///       onPressed: () => Navigator.pop(context),
///       child: Text('Delete'),
///     ),
///   ],
/// )
/// ```
enum RemixDialogAlignment { start, center }

class RemixDialog extends StatelessWidget {
  const RemixDialog({
    super.key,
    this.child,
    this.title,
    this.description,
    this.actions,
    this.modal = true,
    this.semanticLabel,
    this.alignment = RemixDialogAlignment.center,
    this.width,
    this.minWidth,
    this.maxWidth,
    this.height,
    this.minHeight,
    this.maxHeight,
    this.insetPadding = EdgeInsets.zero,
    this.style = const RemixDialogStyler.create(),
    this.styleSpec,
  }) : assert(width == null || width >= 0),
       assert(minWidth == null || minWidth >= 0),
       assert(maxWidth == null || maxWidth >= 0),
       assert(height == null || height >= 0),
       assert(minHeight == null || minHeight >= 0),
       assert(maxHeight == null || maxHeight >= 0),
       assert(
         minWidth == null || maxWidth == null || minWidth <= maxWidth,
         'minWidth must not exceed maxWidth',
       ),
       assert(
         minHeight == null || maxHeight == null || minHeight <= maxHeight,
         'minHeight must not exceed maxHeight',
       ),
       assert(
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

  /// Whether this wrapper establishes modal accessibility route semantics.
  ///
  /// When true, the dialog scopes and names the semantics route and blocks
  /// earlier semantics nodes. Pointer modality belongs to the route created by
  /// [showRemixDialog] and is unaffected by this value.
  final bool modal;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Positions the dialog at the start or center of its available viewport.
  final RemixDialogAlignment alignment;

  /// Preferred dialog width, clamped by [minWidth] and [maxWidth].
  final double? width;

  /// Minimum dialog width.
  final double? minWidth;

  /// Maximum dialog width.
  final double? maxWidth;

  /// Preferred dialog height, clamped by [minHeight] and [maxHeight].
  final double? height;

  /// Minimum dialog height.
  final double? minHeight;

  /// Maximum dialog height.
  final double? maxHeight;

  /// Empty space between the scrollable viewport and dialog surface.
  final EdgeInsetsGeometry insetPadding;

  /// The style configuration for the dialog.
  final RemixDialogStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixDialogSpec? styleSpec;

  static final styleFrom = RemixDialogStyler.new;

  @override
  Widget build(BuildContext context) {
    Widget content = RemixStyleSpecBuilder<RemixDialogSpec>(
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
        Widget body = isLoneChild
            ? child!
            : Column(
                mainAxisAlignment: .start,
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  if (title != null) StyledText(title!, styleSpec: spec.title),
                  if (description != null)
                    StyledText(description!, styleSpec: spec.description),
                  ?child,
                  if (hasActions)
                    FlexBox(styleSpec: spec.actions, children: actions!),
                ],
              );
        if (height != null || maxHeight != null) {
          body = SingleChildScrollView(primary: false, child: body);
        }

        return remixSurfaceBox(
          key: const ValueKey('remix-dialog-surface'),
          styleSpec: spec.container,
          effects: spec.effects,
          child: body,
        );
      },
    );

    content = _RemixDialogViewport(
      alignment: alignment,
      insetPadding: insetPadding,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
          maxWidth: maxWidth ?? double.infinity,
          minHeight: minHeight ?? 0,
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: SizedBox(width: width, height: height, child: content),
      ),
    );

    final hasDialogAncestor =
        context.findAncestorWidgetOfExactType<NakedDialog>() != null;
    if (hasDialogAncestor) return content;

    return NakedDialog(
      modal: modal,
      semanticLabel: semanticLabel ?? title,
      child: content,
    );
  }
}

class _RemixDialogViewport extends StatelessWidget {
  const _RemixDialogViewport({
    required this.alignment,
    required this.insetPadding,
    required this.child,
  });

  final RemixDialogAlignment alignment;
  final EdgeInsetsGeometry insetPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final padding = insetPadding.resolve(Directionality.of(context));

    return LayoutBuilder(
      builder: (context, constraints) {
        final minimumHeight = constraints.hasBoundedHeight
            ? (constraints.maxHeight - padding.vertical).clamp(
                0.0,
                double.infinity,
              )
            : 0.0;

        return SingleChildScrollView(
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minimumHeight),
            child: Align(
              alignment: switch (alignment) {
                RemixDialogAlignment.start => Alignment.topCenter,
                RemixDialogAlignment.center => Alignment.center,
              },
              child: child,
            ),
          ),
        );
      },
    );
  }
}
