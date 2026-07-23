part of 'card.dart';

/// A Material Design card component.
///
/// A card is a sheet of Material used to represent some related information,
/// for example an album, a geographical location, a meal, contact details, etc.
///
/// This is a Remix version of the standard Material Card widget, with customizable styling.
///
/// ## Example
///
/// ```dart
/// RemixCard(
///   child: Padding(
///     padding: const EdgeInsets.all(16.0),
///     child: Text('This is a card'),
///   ),
/// )
/// ```
class RemixCard extends StatelessWidget {
  /// Creates a Material Design card.
  const RemixCard({
    super.key,
    this.child,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.focusOnTap = false,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const RemixCardStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = RemixCardStyler.new;

  /// The widget below this widget in the tree.
  ///
  /// This widget can only have one child. To lay out multiple children, let this widget's child be a widget such as [RowBox], [ColumnBox], or [StackBox], which have a children property, and then provide the children to that widget.
  final Widget? child;

  /// Invoked when this card is activated by pointer or keyboard.
  ///
  /// A card with neither [onTap] nor [onLongPress] remains a passive container
  /// and does not acquire button semantics, focus, a cursor, or gesture hooks.
  final GestureTapCallback? onTap;

  /// Invoked when this card is long-pressed.
  final GestureLongPressCallback? onLongPress;

  /// Whether configured card interactions are enabled.
  final bool enabled;

  /// Pointer cursor used by an interactive, enabled card.
  final MouseCursor mouseCursor;

  /// Whether interaction feedback is emitted.
  final bool enableFeedback;

  /// Optional focus node for an interactive card.
  final FocusNode? focusNode;

  /// Whether an interactive card requests focus when first mounted.
  final bool autofocus;

  /// Whether an interactive card requests focus when pressed.
  final bool focusOnTap;

  /// Called when interactive-card focus changes.
  final ValueChanged<bool>? onFocusChange;

  /// Called when interactive-card hover state changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when interactive-card press state changes.
  final ValueChanged<bool>? onPressChange;

  /// Accessibility label for the card.
  final String? semanticLabel;

  /// Whether this card and its descendants are hidden from accessibility.
  final bool excludeSemantics;

  /// The style configuration for the card.
  final RemixCardStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixCardSpec? styleSpec;

  Widget _buildVisual(BuildContext context, RemixCardSpec spec) =>
      RemixBoxWithEffects(
        key: const ValueKey('remix-card-surface'),
        styleSpec: spec.container,
        containerEffects: spec.containerEffects,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final inheritedStateProvider = WidgetStateProvider.of(context);
    final isInteractive = onTap != null || onLongPress != null;
    if (isInteractive) {
      return NakedButton(
        onPressed: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        enabled: enabled,
        mouseCursor: mouseCursor,
        enableFeedback: enableFeedback,
        focusNode: focusNode,
        autofocus: autofocus,
        focusOnPress: focusOnTap,
        onFocusChange: onFocusChange,
        onHoverChange: onHoverChange,
        onPressChange: onPressChange,
        semanticLabel: semanticLabel,
        excludeSemantics: excludeSemantics,
        builder: (context, state, _) {
          final states = <WidgetState>{
            if (inheritedStateProvider?.disabled ?? false) WidgetState.disabled,
            if (inheritedStateProvider?.hovered ?? false) WidgetState.hovered,
            if (inheritedStateProvider?.focused ?? false) WidgetState.focused,
            if (inheritedStateProvider?.pressed ?? false) WidgetState.pressed,
            if (inheritedStateProvider?.dragged ?? false) WidgetState.dragged,
            if (inheritedStateProvider?.selected ?? false) WidgetState.selected,
            if (inheritedStateProvider?.error ?? false) WidgetState.error,
            ...state.states,
          };

          return WidgetStateProvider(
            states: states,
            child: RemixStyleSpecBuilder<RemixCardSpec>(
              style: style,
              styleSpec: styleSpec,
              builder: _buildVisual,
            ),
          );
        },
      );
    }

    final card = RemixStyleSpecBuilder<RemixCardSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        final card = _buildVisual(context, spec);
        if (excludeSemantics) return ExcludeSemantics(child: card);
        if (semanticLabel case final label?) {
          return Semantics(container: true, label: label, child: card);
        }
        return card;
      },
    );

    return inheritedStateProvider == null
        ? WidgetStateProvider(states: const {}, child: card)
        : card;
  }
}
