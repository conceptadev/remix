part of 'disclosure.dart';

final class _RemixDisclosureStyleScope extends InheritedWidget {
  const _RemixDisclosureStyleScope({required this.spec, required super.child});

  final DisclosureSpec spec;

  static DisclosureSpec of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<_RemixDisclosureStyleScope>();
    assert(scope != null, 'No RemixDisclosure style scope found in context.');

    return scope!.spec;
  }

  @override
  bool updateShouldNotify(_RemixDisclosureStyleScope oldWidget) {
    return spec != oldWidget.spec;
  }
}

final class _RemixDisclosureTrigger extends StatelessWidget {
  const _RemixDisclosureTrigger({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Box(
      styleSpec: _RemixDisclosureStyleScope.of(context).trigger,
      child: child,
    );
  }
}

final class _RemixDisclosureContent extends StatelessWidget {
  const _RemixDisclosureContent({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Box(
      styleSpec: _RemixDisclosureStyleScope.of(context).content,
      child: child,
    );
  }
}

/// A standalone trigger that expands or collapses one inline content panel.
///
/// The API follows the Radix Collapsible anatomy: [trigger] and [content] are
/// distinct parts assembled under one root. Expansion may be uncontrolled via
/// [defaultExpanded], or controlled with [expanded] and [onExpandedChanged].
class RemixDisclosure extends StatelessWidget {
  const RemixDisclosure({
    super.key,
    required this.trigger,
    required this.content,
    this.triggerBuilder,
    this.expanded,
    this.defaultExpanded = false,
    this.onExpandedChanged,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    NakedDisclosureTransitionBuilder? transitionBuilder,
    this.animationStyle = const AnimationStyle(
      curve: Curves.ease,
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 200),
    ),
    this.style = const DisclosureStyler.create(),
    this.styleSpec,
  }) : transitionBuilder =
           transitionBuilder ?? defaultDisclosureTransitionBuilder;

  /// The interactive part that toggles [content].
  final Widget trigger;

  /// The inline panel controlled by [trigger].
  final Widget content;

  /// Optionally rebuilds [trigger] from the current disclosure state.
  final ValueWidgetBuilder<NakedDisclosureState>? triggerBuilder;

  /// Whether the content is expanded in controlled mode.
  ///
  /// Leave null to let the disclosure own its state.
  final bool? expanded;

  /// Initial state for an uncontrolled disclosure.
  final bool defaultExpanded;

  /// Called when interaction requests a new expanded value.
  final ValueChanged<bool>? onExpandedChanged;

  /// Whether trigger interaction is enabled.
  final bool enabled;

  /// Mouse cursor used while the trigger is interactive.
  final MouseCursor mouseCursor;

  /// Whether activation provides platform feedback.
  final bool enableFeedback;

  /// Focus node associated with the trigger.
  final FocusNode? focusNode;

  /// Whether the trigger requests focus when first built.
  final bool autofocus;

  /// Called when trigger focus changes.
  final ValueChanged<bool>? onFocusChange;

  /// Called when trigger hover changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when trigger press state changes.
  final ValueChanged<bool>? onPressChange;

  /// Accessible name that replaces trigger-descendant semantics when nonempty.
  final String? semanticLabel;

  /// Additional context announced with the trigger's accessible name.
  final String? semanticHint;

  /// Whether to hide the trigger and content from the semantics tree.
  final bool excludeSemantics;

  /// Transition applied while the content opens and closes.
  final NakedDisclosureTransitionBuilder transitionBuilder;

  /// Curves and durations used by [transitionBuilder].
  final AnimationStyle animationStyle;

  /// Style configuration for the root, trigger, and content.
  final DisclosureStyler style;

  /// Optional resolved style that bypasses [style].
  final DisclosureSpec? styleSpec;

  static final styleFrom = DisclosureStyler.new;

  /// Default top-anchored fade and size transition.
  static Widget defaultDisclosureTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        // `alignment` is only available from Flutter 3.44. Keep the equivalent
        // spelling while Remix supports Flutter 3.41 consumers.
        // ignore: deprecated_member_use
        axisAlignment: -1,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NakedDisclosure(
      child: trigger,
      panel: _RemixDisclosureContent(child: content),
      expanded: expanded,
      defaultExpanded: defaultExpanded,
      onExpandedChanged: onExpandedChanged,
      enabled: enabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onPressChange: onPressChange,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      transitionBuilder: transitionBuilder,
      animationStyle: animationStyle,
      builder: (context, state, child) {
        final resolvedTrigger =
            triggerBuilder?.call(context, state, child) ?? child!;
        return _RemixDisclosureTrigger(child: resolvedTrigger);
      },
      itemBuilder: (context, state, child) {
        return RemixStyleSpecBuilder<DisclosureSpec>(
          style: style,
          styleSpec: styleSpec,
          controller: NakedDisclosureState.controllerOf(context),
          builder: (context, spec) {
            return _RemixDisclosureStyleScope(
              spec: spec,
              child: RemixBoxWithEffects(
                styleSpec: spec.container,
                containerEffects: spec.containerEffects,
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
