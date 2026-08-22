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

  final Widget trigger;
  final Widget content;
  final ValueWidgetBuilder<NakedDisclosureState>? triggerBuilder;

  /// Controlled expanded state. Null lets the widget own its state.
  final bool? expanded;
  final bool defaultExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final bool enabled;
  final MouseCursor mouseCursor;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final bool autofocus;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<bool>? onHoverChange;
  final ValueChanged<bool>? onPressChange;

  /// Replaces trigger-descendant semantics when nonempty.
  final String? semanticLabel;
  final String? semanticHint;
  final bool excludeSemantics;
  final NakedDisclosureTransitionBuilder transitionBuilder;
  final AnimationStyle animationStyle;
  final DisclosureStyler style;

  /// Bypasses [style] when provided.
  final DisclosureSpec? styleSpec;

  static final styleFrom = DisclosureStyler.new;

  /// Default top-anchored fade and size transition.
  static Widget defaultDisclosureTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    // `alignment` landed in Flutter 3.44; Remix still supports 3.41 consumers.
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        // ignore: deprecated_member_use
        axisAlignment: -1.0,
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
        return _RemixDisclosureTrigger(
          child: triggerBuilder?.call(context, state, child) ?? child!,
        );
      },
      itemBuilder: (context, state, child) {
        return RemixStyleSpecBuilder<DisclosureSpec>(
          style: style,
          styleSpec: styleSpec,
          controller: NakedDisclosureState.controllerOf(context),
          builder: (context, spec) {
            return _RemixDisclosureStyleScope(
              spec: spec,
              child: RemixBoxAdapter(
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
