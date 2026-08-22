part of 'accordion.dart';

typedef RemixAccordionController<T> = NakedAccordionController<T>;

final class _RemixAccordionStyleState extends InheritedWidget {
  const _RemixAccordionStyleState({
    required this.isExpanded,
    required this.canCollapse,
    required this.canExpand,
    required super.child,
  });

  static _RemixAccordionStyleState of(BuildContext context) {
    final state = context
        .dependOnInheritedWidgetOfExactType<_RemixAccordionStyleState>();
    assert(state != null, 'No RemixAccordion style state found in context.');

    return state!;
  }

  final bool isExpanded;
  final bool canCollapse;
  final bool canExpand;

  @override
  bool updateShouldNotify(_RemixAccordionStyleState oldWidget) {
    return isExpanded != oldWidget.isExpanded ||
        canCollapse != oldWidget.canCollapse ||
        canExpand != oldWidget.canExpand;
  }
}

/// A purely behavioral accordion group component that manages expansion state.
///
/// The [RemixAccordionGroup] manages which accordion items are expanded/collapsed
/// and enforces min/max expansion constraints through its controller.
/// It provides no styling - wrap it in your own container if you need layout styling.
/// Each [RemixAccordion] item must be styled individually.
///
/// ## Example
///
/// ```dart
/// Column(
///   children: [
///     RemixAccordionGroup<String>(
///       controller: RemixAccordionController<String>(min: 0, max: 1),
///       child: Column(
///         children: [
///           RemixAccordion<String>(
///             value: 'item1',
///             title: 'First Item',
///             style: itemStyle,
///             child: Text('First content'),
///           ),
///           RemixAccordion<String>(
///             value: 'item2',
///             title: 'Second Item',
///             style: itemStyle,
///             child: Text('Second content'),
///           ),
///         ],
///       ),
///     ),
///   ],
/// )
/// ```
class RemixAccordionGroup<T> extends StatelessWidget {
  const RemixAccordionGroup({
    super.key,
    required this.child,
    required this.controller,
    this.initialExpandedValues = const [],
  });

  /// Accordion items to render.
  final Widget child;

  /// Controller that manages expanded values.
  final RemixAccordionController<T> controller;

  /// Values expanded on the first build when the controller is empty.
  final List<T> initialExpandedValues;

  @override
  Widget build(BuildContext context) {
    return NakedAccordionGroup(
      controller: controller,
      initialExpandedValues: initialExpandedValues,
      child: child,
    );
  }
}

/// An individual accordion item.
class RemixAccordion<T> extends StatelessWidget {
  const RemixAccordion({
    super.key,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.builder,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    Widget Function(Widget, Animation<double>)? transitionBuilder,
    this.style = const AccordionStyler.create(),
    this.styleSpec,
  }) : transitionBuilder =
           transitionBuilder ?? defaultAccordionTransitionBuilder,
       assert(
         title != null || builder != null,
         'Either title or builder must be provided',
       );

  static Widget defaultAccordionTransitionBuilder(
    Widget panel,
    Animation<double> animation,
  ) {
    // Deliberately the deprecated `axisAlignment` rather than the clearer
    // `alignment: AlignmentDirectional.bottomStart`. The two are equivalent
    // here — on the default vertical axis both resolve to
    // `AlignmentDirectional(-1.0, 1.0)` — but `alignment` was added in Flutter
    // 3.44, and this package's floor is Mix's 3.41. `axisAlignment` is the only
    // spelling that compiles across that whole range.
    //
    // Swap to `alignment` and drop the ignore once the floor reaches 3.44.
    // `accordion_widget_test.dart` pins the rendered alignment either way.
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        // ignore: deprecated_member_use
        axisAlignment: 1.0,
        child: panel,
      ),
    );
  }

  /// Unique identifier tracked by the controller.
  final T value;

  /// Content rendered while expanded.
  final Widget child;

  /// Title text for the trigger.
  final String? title;

  /// Optional leading icon for the trigger.
  final IconData? leadingIcon;

  /// Optional trailing icon for the trigger.
  final IconData? trailingIcon;

  /// Custom builder for the trigger.
  final NakedAccordionTriggerBuilder<T>? builder;

  /// Whether the accordion item is interactive.
  final bool enabled;

  /// Mouse cursor to use when interactive.
  final MouseCursor mouseCursor;

  /// Whether to provide platform feedback on interactions.
  final bool enableFeedback;

  /// Whether the header should autofocus.
  final bool autofocus;

  /// Focus node associated with the header.
  final FocusNode? focusNode;

  /// Called when the header's focus state changes.
  final ValueChanged<bool>? onFocusChange;

  /// Called when the header's hover state changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when the header's pressed state changes.
  final ValueChanged<bool>? onPressChange;

  /// Semantic label announced for the header.
  final String? semanticLabel;

  /// The style configuration for the accordion item.
  final AccordionStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final AccordionSpec? styleSpec;

  /// The transition builder for the accordion item.
  final Widget Function(Widget, Animation<double>) transitionBuilder;

  static final styleFrom = AccordionStyler.new;

  @override
  Widget build(BuildContext context) => _RemixAccordionBody<T>(config: this);
}

class _RemixAccordionBody<T> extends StatefulWidget {
  const _RemixAccordionBody({required this.config});

  final RemixAccordion<T> config;

  @override
  State<_RemixAccordionBody<T>> createState() => _RemixAccordionBodyState<T>();
}

class _RemixAccordionBodyState<T> extends State<_RemixAccordionBody<T>> {
  // NakedAccordion tracks these same states, but only publishes them below
  // itself — and the panel container is mounted above it. Mirroring the
  // trigger's interaction states here is what lets one resolved spec drive
  // the container, the trigger, and the content alike.
  late final WidgetStatesController _statesController;

  RemixAccordion<T> get _config => widget.config;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController({
      if (!_config.enabled) .disabled,
    });
  }

  @override
  void didUpdateWidget(covariant _RemixAccordionBody<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final enabled = _config.enabled;
    _statesController.update(.disabled, !enabled);
    // Deliberate: the trigger's hover region and gesture detector go inert
    // while disabled, so neither ever reports the exit. Hover and press
    // captured just before disabling would otherwise stick.
    if (!enabled) {
      _statesController
        ..update(.hovered, false)
        ..update(.pressed, false);
    }
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool focused) {
    _statesController.update(.focused, focused);
    _config.onFocusChange?.call(focused);
  }

  void _handleHoverChange(bool hovered) {
    _statesController.update(.hovered, hovered);
    _config.onHoverChange?.call(hovered);
  }

  void _handlePressChange(bool pressed) {
    _statesController.update(.pressed, pressed);
    _config.onPressChange?.call(pressed);
  }

  Widget _buildDefaultTrigger(
    AccordionSpec spec,
    NakedAccordionItemState<T> state,
  ) {
    final leadingIcon = _config.leadingIcon;
    final title = _config.title;

    return FlexBox(
      styleSpec: spec.trigger,
      children: [
        if (leadingIcon != null)
          StyledIcon(icon: leadingIcon, styleSpec: spec.leadingIcon),
        if (title != null)
          // ignore: avoid-flexible-outside-flex
          Expanded(child: StyledText(title, styleSpec: spec.title)),
        if (_config.trailingIcon case final icon?)
          StyledIcon(icon: icon, styleSpec: spec.trailingIcon)
        else
          RemixPathIcon(
            glyph: state.isExpanded
                ? RemixPathGlyph.minus
                : RemixPathGlyph.plus,
            styleSpec: spec.trailingIcon,
          ),
      ],
    );
  }

  // [isExpanded] is threaded down from build rather than re-read from the
  // scope here: this state rebuilds from the same InheritedNotifier, and as
  // NakedAccordion's ancestor it always hands down a fresh closure before
  // NakedAccordion rebuilds. One read keeps the panel and the trigger from
  // ever disagreeing about the same frame.
  Widget _buildTransitionWrapper(
    AccordionSpec spec,
    bool isExpanded,
    Widget panel,
  ) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: _config.transitionBuilder,
      child: isExpanded
          ? Box(styleSpec: spec.content, child: panel)
          : const SizedBox.shrink(),
    );
  }

  Widget _buildItem(AccordionSpec spec, bool isExpanded) {
    // One panel wraps the trigger and the (conditionally mounted) content so
    // a single clip + radius crops both, matching the Radix Table idiom:
    // the container owns the outer shape, its children stay flat, and the
    // interior seam is a plain divider rather than two independently
    // rounded boxes. See fortalAccordionStyle for the divider half of that
    // treatment.
    return RemixBoxAdapter(
      styleSpec: spec.container,
      containerEffects: spec.containerEffects,
      child: NakedAccordion<T>(
        value: _config.value,
        transitionBuilder: (panel) =>
            _buildTransitionWrapper(spec, isExpanded, panel),
        enabled: _config.enabled,
        mouseCursor: _config.mouseCursor,
        enableFeedback: _config.enableFeedback,
        autofocus: _config.autofocus,
        focusNode: _config.focusNode,
        onFocusChange: _handleFocusChange,
        onHoverChange: _handleHoverChange,
        // Always non-null: NakedAccordion only wires up press detection when
        // a callback is supplied, and the panel's pressed styling needs it
        // whether or not the caller asked to observe presses.
        onPressChange: _handlePressChange,
        semanticLabel: _config.semanticLabel ?? _config.title,
        child: _config.child,
        builder:
            _config.builder ??
            (context, state) => _buildDefaultTrigger(spec, state),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = NakedAccordionScope.of<T>(context).controller;
    final isExpanded = controller.contains(_config.value);
    final canCollapse = isExpanded && controller.values.length > controller.min;
    final canExpand =
        !isExpanded &&
        (controller.max == null || controller.values.length < controller.max!);

    return _RemixAccordionStyleState(
      isExpanded: isExpanded,
      canCollapse: canCollapse,
      canExpand: canExpand,
      child: RemixStyleSpecBuilder<AccordionSpec>(
        style: _config.style,
        styleSpec: _config.styleSpec,
        controller: _statesController,
        builder: (context, spec) => _buildItem(spec, isExpanded),
      ),
    );
  }
}
