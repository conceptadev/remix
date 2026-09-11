part of 'sidebar.dart';

/// Per-destination style for a [RemixSidebarDestination].
///
/// Destinations reuse toggle interaction states, so this is a [ToggleStyler].
/// Depend on this name rather than on the toggle implementation behind it.
typedef SidebarDestinationStyler = ToggleStyler;

/// Declarative data for one in-app destination in a [RemixSidebar].
///
/// [T] is non-nullable because `null` is reserved by the owning sidebar as the
/// no-selection sentinel. Values must be unique across all sections and keep
/// stable equality and hash-code behavior while rendered.
@immutable
final class RemixSidebarDestination<T extends Object> {
  const RemixSidebarDestination({
    required this.value,
    required this.label,
    this.icon,
    this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.style = const SidebarDestinationStyler.create(),
  });

  /// The value reported whenever this destination is activated.
  final T value;

  /// Visible text and the default accessible name.
  ///
  /// It must contain at least one non-whitespace character. The displayed
  /// value is not trimmed.
  final String label;

  /// Optional icon rendered before [label].
  final IconData? icon;

  /// Optional accessible name replacing [label].
  ///
  /// When provided, it must contain at least one non-whitespace character.
  final String? semanticLabel;

  /// Whether this destination can receive focus and be activated.
  final bool enabled;

  /// Optional caller-owned focus node.
  final FocusNode? focusNode;

  /// Whether this destination requests initial focus.
  final bool autofocus;

  /// Per-destination style merged after the sidebar's default destination
  /// style.
  ///
  /// An authoritative raw `styleSpec` on the owning sidebar bypasses this
  /// style.
  final SidebarDestinationStyler style;
}

/// Declarative data for one section in a [RemixSidebar].
///
/// A section with no [destinations] is skipped together with its [label].
@immutable
final class RemixSidebarSection<T extends Object> {
  const RemixSidebarSection({this.label, required this.destinations});

  /// Optional visible and semantic section heading.
  ///
  /// Visual text transforms do not rewrite this authored accessible name. When
  /// provided, it must contain at least one non-whitespace character.
  final String? label;

  /// Destinations rendered in visual and focus-traversal order.
  ///
  /// Do not mutate this list during a build; rebuild with a new list when its
  /// contents or order change.
  final List<RemixSidebarDestination<T>> destinations;
}

/// A controlled navigation panel with a fixed header, a scrollable list of
/// destinations, and a fixed footer.
///
/// The destination region publishes a navigation landmark and selected-button
/// destination semantics. It uses ordinary Tab traversal; Enter and Space
/// activate the focused destination. Activating the selected destination calls
/// [onSelected] again rather than suppressing reselection.
///
/// [header] and [footer] sit outside the navigation landmark because brand,
/// search, and account content are not navigation destinations.
///
/// The panel fills the height it is given and scrolls its destination region.
/// Given unbounded height it sizes to its content and scrolls nothing, leaving
/// scrolling to the host. This widget owns no placement, safe area, overlay,
/// routing, or dismissal behavior. Callers compose it inline or inside their
/// own drawer or sheet. Use `RemixLink` instead for true URL or document
/// destinations.
///
/// ```dart
/// RemixSidebar<String>(
///   header: const BrandHeader(),
///   sections: const [
///     RemixSidebarSection(
///       label: 'Workspace',
///       destinations: [
///         RemixSidebarDestination(
///           value: 'overview',
///           label: 'Overview',
///         ),
///       ],
///     ),
///   ],
///   selectedValue: selectedPage,
///   onSelected: selectPage,
///   footer: const AccountMenu(),
/// )
/// ```
class RemixSidebar<T extends Object> extends StatefulWidget {
  const RemixSidebar({
    super.key,
    this.header,
    this.collapsed = false,
    this.showTooltips = true,
    this.tooltipPositioning,
    this.expandedWidth,
    this.collapsedWidth,
    this.animationStyle = const AnimationStyle(),
    required this.sections,
    required this.selectedValue,
    this.onSelected,
    this.footer,
    this.enabled = true,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const SidebarStyler.create(),
    this.styleSpec,
  }) : assert((expandedWidth == null) == (collapsedWidth == null)),
       assert(
         expandedWidth == null ||
             (expandedWidth > 0 && expandedWidth < double.infinity),
       ),
       assert(
         collapsedWidth == null ||
             (collapsedWidth > 0 &&
                 (expandedWidth == null || collapsedWidth <= expandedWidth)),
       );

  /// Whether to present only destination icons. Every destination must have
  /// an icon in this mode. The collapse trigger belongs to the host.
  final bool collapsed;

  /// Whether collapsed destinations reveal their labels in tooltips.
  ///
  /// Automatic tooltips require a caller-owned Overlay. Expanded sidebars and
  /// sidebars with this set to false need no overlay.
  final bool showTooltips;

  /// Tooltip placement override; defaults to logical end with collision handling.
  final OverlayPositionConfig? tooltipPositioning;

  /// Expanded panel width. Set together with [collapsedWidth] to animate width
  /// with the labels and headings. When both are null, the host sizes the panel.
  /// Parent constraints still take precedence.
  final double? expandedWidth;

  /// Icon-rail width; must be positive and no greater than [expandedWidth].
  final double? collapsedWidth;

  /// Timing for expansion and collapse, matching RemixDisclosure's API.
  ///
  /// Defaults to 200ms and ease-in-out. Collapse uses reverseDuration and
  /// reverseCurve when provided, otherwise the forward settings. Text eases
  /// out over the first 30% of collapse and in over the final 75% of
  /// expansion. Icons and section rows hold their positions while moving.
  /// Overshooting curves are clamped to the panel's width endpoints.
  /// AnimationStyle.noAnimation and reduced motion settle immediately.
  final AnimationStyle animationStyle;

  /// Reads the sidebar-owned animation for custom header/footer content.
  /// The context must be below a sidebar, for example inside a slot's Builder.
  static SidebarAnimation animationOf(BuildContext context) {
    final motion = maybeAnimationOf(context);
    if (motion == null) {
      throw FlutterError(
        'RemixSidebar.animationOf requires a sidebar ancestor.',
      );
    }
    return motion;
  }

  /// Reads the current frame, or null outside a sidebar.
  /// Style recipes can use this to coordinate their resolved visual values.
  static SidebarAnimation? maybeAnimationOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_SidebarAnimationScope>()
      ?.motion;

  /// Optional fixed content above the destination region.
  ///
  /// It stays outside the navigation landmark and never scrolls.
  final Widget? header;

  /// Sections rendered in visual and focus-traversal order.
  ///
  /// Destination values must be unique across every section. Do not mutate
  /// this list or its nested destination lists during a build; rebuild with
  /// new lists when their contents or order change.
  final List<RemixSidebarSection<T>> sections;

  /// The selected destination value, or null when no destination is selected.
  ///
  /// A non-null value must match exactly one destination across [sections].
  final T? selectedValue;

  /// Called once for every enabled activation, including reselection.
  ///
  /// When null, every destination is disabled while [selectedValue] styling is
  /// preserved.
  final ValueChanged<T>? onSelected;

  /// Optional fixed content below the destination region.
  ///
  /// It stays outside the navigation landmark and never scrolls.
  final Widget? footer;

  /// Whether the destinations are interactive.
  ///
  /// When false, destinations expose no activation action or focus stop while
  /// [selectedValue] styling is preserved. [header] and [footer] content is
  /// unaffected.
  final bool enabled;

  /// Optional accessible name for the navigation landmark.
  ///
  /// Use this to distinguish multiple navigation landmarks. When provided, it
  /// must contain at least one non-whitespace character.
  final String? semanticLabel;

  /// Whether to hide the navigation landmark and every destination from
  /// semantics.
  ///
  /// [header] and [footer] content keeps its own semantics; wrap that content
  /// yourself to hide it.
  final bool excludeSemantics;

  /// Fluent visual style for the panel and its default destination style.
  final SidebarStyler style;

  /// Optional raw style spec that bypasses fluent and per-destination styles.
  ///
  /// Structural direction is still forced to source-order vertical layout.
  final SidebarSpec? styleSpec;

  /// Creates a fluent style for this component.
  static final styleFrom = SidebarStyler.new;

  bool _debugConfigurationIsValid() {
    final landmarkLabel = semanticLabel;
    assert(
      landmarkLabel == null || landmarkLabel.trim().isNotEmpty,
      'RemixSidebar semanticLabel must not be blank.',
    );

    final values = <T>{};
    var autofocusCount = 0;

    for (final section in sections) {
      final sectionLabel = section.label;
      assert(
        sectionLabel == null || sectionLabel.trim().isNotEmpty,
        'RemixSidebar section labels must not be blank.',
      );

      for (final destination in section.destinations) {
        assert(
          destination.label.trim().isNotEmpty,
          'RemixSidebar destination labels must not be blank.',
        );
        final destinationSemanticLabel = destination.semanticLabel;
        assert(
          destinationSemanticLabel == null ||
              destinationSemanticLabel.trim().isNotEmpty,
          'RemixSidebar destination semantic labels must not be blank.',
        );

        if (!values.add(destination.value)) {
          throw FlutterError(
            'RemixSidebar destination values must be unique. '
            'Duplicate value: ${destination.value}.',
          );
        }
        if (destination.autofocus) autofocusCount += 1;
      }
    }

    if (selectedValue != null && !values.contains(selectedValue)) {
      throw FlutterError(
        'RemixSidebar selectedValue must match one destination. '
        'No destination has value: $selectedValue.',
      );
    }

    if (autofocusCount > 1) {
      throw FlutterError(
        'Only one destination may autofocus in a RemixSidebar.',
      );
    }

    return true;
  }

  SidebarStyler _effectiveStyle() {
    final panel = FlexBoxStyler()
        .direction(.vertical)
        .mainAxisSize(.max)
        .crossAxisAlignment(.stretch);
    final stack = FlexBoxStyler()
        .direction(.vertical)
        .mainAxisSize(.min)
        .crossAxisAlignment(.stretch);

    return SidebarStyler(
      container: panel,
      content: stack,
      section: stack,
      destinations: stack,
    ).merge(style);
  }

  StyleSpec<FlexBoxSpec> _forceSourceOrder(StyleSpec<FlexBoxSpec> value) {
    final flex = value.spec.flex ?? const StyleSpec(spec: FlexSpec());

    return value.copyWith(
      spec: value.spec.copyWith(
        flex: flex.copyWith(
          spec: flex.spec.copyWith(
            direction: .vertical,
            verticalDirection: .down,
          ),
        ),
      ),
    );
  }

  @override
  State<RemixSidebar<T>> createState() => _RemixSidebarState<T>();

  Widget _build(BuildContext context, SidebarAnimation motion) {
    assert(_debugConfigurationIsValid());
    if (collapsed) {
      for (final section in sections) {
        for (final destination in section.destinations) {
          if (destination.icon == null) {
            throw FlutterError(
              'Collapsed RemixSidebar destination ${destination.value} '
              'must provide an icon.',
            );
          }
        }
      }
      if (showTooltips && Overlay.maybeOf(context) == null) {
        throw FlutterError(
          'Collapsed RemixSidebar tooltips require an Overlay. '
          'Provide Overlay.wrap or set showTooltips to false.',
        );
      }
    }
    final panel = _buildPanel(context, motion);
    return _SidebarAnimationScope(
      motion: motion,
      child: expandedWidth == null
          ? panel
          : Box(
              style: BoxStyler().width(
                ui.lerpDouble(collapsedWidth, expandedWidth, motion.expansion)!,
              ),
              child: panel,
            ),
    );
  }

  Widget _buildPanel(BuildContext context, SidebarAnimation motion) {
    final effectiveStyle = _effectiveStyle();
    final handleSelected = onSelected;
    final destinationsDisabled = !enabled || handleSelected == null;

    return WidgetStateProvider(
      states: destinationsDisabled ? const {WidgetState.disabled} : const {},
      child: RemixStyleSpecBuilder<SidebarSpec>(
        style: effectiveStyle,
        styleSpec: styleSpec,
        builder: (context, spec) {
          final destinations = FlexBox(
            styleSpec: _forceSourceOrder(spec.content),
            children: [
              for (final section in sections)
                if (section.destinations.isNotEmpty)
                  FlexBox(
                    styleSpec: _forceSourceOrder(spec.section),
                    children: [
                      if (section.label case final label?)
                        Semantics(
                          header: true,
                          label: label,
                          excludeSemantics: true,
                          // The heading keeps its row in the rail, so
                          // destinations never shift vertically; only the
                          // text fades.
                          child: Opacity(
                            opacity: motion.labelOpacity,
                            child: StyledText(
                              label,
                              styleSpec: motion.expansion == 1
                                  ? spec.sectionLabel
                                  : spec.sectionLabel.copyWith(
                                      spec: spec.sectionLabel.spec.copyWith(
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      FlexBox(
                        styleSpec: _forceSourceOrder(spec.destinations),
                        children: [
                          for (final destination in section.destinations)
                            _RemixSidebarDestinationWidget<T>(
                              key: ValueKey<T>(destination.value),
                              data: destination,
                              motion: motion,
                              tooltipsEnabled: collapsed && showTooltips,
                              tooltipStyle: spec.tooltip,
                              tooltipPositioning:
                                  tooltipPositioning ??
                                  OverlayPositionConfig(
                                    side:
                                        Directionality.of(context) ==
                                            TextDirection.ltr
                                        ? OverlaySide.right
                                        : OverlaySide.left,
                                    alignment: OverlayAlignment.center,
                                    sideOffset: 8,
                                  ),
                              selected: destination.value == selectedValue,
                              sidebarEnabled: enabled,
                              onSelected: handleSelected,
                              defaultStyle: styleSpec == null
                                  ? effectiveStyle
                                  : null,
                              defaultStyleSpec: styleSpec == null
                                  ? null
                                  : spec.destination,
                            ),
                        ],
                      ),
                    ],
                  ),
            ],
          );

          final landmark = ExcludeSemantics(
            excluding: excludeSemantics,
            child: Semantics(
              role: ui.SemanticsRole.navigation,
              container: true,
              explicitChildNodes: true,
              label: semanticLabel,
              child: destinations,
            ),
          );

          final container = _forceSourceOrder(spec.container);

          // FlexBox applies its Box constraints below this builder. Enforce
          // those constraints here as ConstrainedBox will so style-provided
          // height bounds also enable scrolling and pin the footer.
          return LayoutBuilder(
            builder: (context, parentConstraints) {
              final styleConstraints = container.spec.box?.spec.constraints;
              final effectiveConstraints =
                  styleConstraints?.enforce(parentConstraints) ??
                  parentConstraints;
              final hasBoundedHeight = effectiveConstraints.hasBoundedHeight;

              return FlexBox(
                key: const ValueKey('RemixSidebar.container'),
                styleSpec: container,
                children: [
                  if (header case final header?)
                    Box(styleSpec: spec.header, child: header),
                  if (hasBoundedHeight)
                    Expanded(child: SingleChildScrollView(child: landmark))
                  else
                    landmark,
                  if (footer case final footer?)
                    Box(styleSpec: spec.footer, child: footer),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/// One frame of a sidebar's coordinated geometry and text transition.
///
/// Read this value with [RemixSidebar.animationOf] inside a header or footer
/// to coordinate custom content with the sidebar-owned animation.
@immutable
final class SidebarAnimation {
  const SidebarAnimation._({
    required this.expansion,
    required this.labelOpacity,
    this.isAnimating = false,
  }) : assert(expansion >= 0 && expansion <= 1),
       assert(labelOpacity >= 0 && labelOpacity <= 1);

  /// Zero for the icon rail and one for the expanded panel.
  final double expansion;

  /// Coordinated visibility of destination, brand, and account text.
  final double labelOpacity;

  /// Whether tooltips should remain suppressed while geometry moves.
  final bool isAnimating;
}

class _RemixSidebarState<T extends Object> extends State<RemixSidebar<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: 1,
  );
  late double _fromExpansion = widget.collapsed ? 0 : 1;
  late double _fromOpacity = _fromExpansion;
  bool _reduceMotion = false;

  SidebarAnimation _frame(bool collapsed, AnimationStyle style) {
    final end = collapsed ? 0.0 : 1.0;
    final t = _controller.value;
    final textT = Curves.easeOut.transform(
      collapsed ? (t / .3).clamp(0.0, 1.0) : ((t - .25) / .75).clamp(0.0, 1.0),
    );
    final curve =
        (collapsed ? style.reverseCurve : null) ??
        style.curve ??
        Curves.easeInOut;
    return SidebarAnimation._(
      expansion: ui.lerpDouble(
        _fromExpansion,
        end,
        curve.transform(t).clamp(0.0, 1.0),
      )!,
      labelOpacity: ui.lerpDouble(_fromOpacity, end, textT)!,
      isAnimating: _controller.isAnimating,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (_reduceMotion) _controller.value = 1;
  }

  @override
  void didUpdateWidget(RemixSidebar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final targetChanged = oldWidget.collapsed != widget.collapsed;
    final timingChanged = oldWidget.animationStyle != widget.animationStyle;
    if (!targetChanged && !timingChanged) return;
    // Sample the old direction AND timing before retargeting either channel.
    final previous = _frame(oldWidget.collapsed, oldWidget.animationStyle);
    _fromExpansion = previous.expansion;
    _fromOpacity = previous.labelOpacity;
    final style = widget.animationStyle;
    final duration =
        (widget.collapsed ? style.reverseDuration : null) ??
        style.duration ??
        const Duration(milliseconds: 200);
    if (_reduceMotion ||
        duration == Duration.zero ||
        (!targetChanged && !_controller.isAnimating)) {
      _controller.value = 1;
    } else {
      _controller.duration = duration;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (context, child) =>
        widget._build(context, _frame(widget.collapsed, widget.animationStyle)),
  );
}

/// Makes the internally owned frame available to slots and style resolution.
class _SidebarAnimationScope extends InheritedWidget {
  const _SidebarAnimationScope({required this.motion, required super.child});
  final SidebarAnimation motion;

  @override
  bool updateShouldNotify(_SidebarAnimationScope oldWidget) =>
      motion.expansion != oldWidget.motion.expansion ||
      motion.labelOpacity != oldWidget.motion.labelOpacity ||
      motion.isAnimating != oldWidget.motion.isAnimating;
}

class _RemixSidebarDestinationWidget<T extends Object> extends StatefulWidget {
  const _RemixSidebarDestinationWidget({
    super.key,
    required this.data,
    required this.selected,
    required this.sidebarEnabled,
    required this.onSelected,
    required this.motion,
    required this.tooltipsEnabled,
    required this.tooltipStyle,
    required this.tooltipPositioning,
    this.defaultStyle,
    this.defaultStyleSpec,
  });

  final RemixSidebarDestination<T> data;
  final bool selected;
  final bool sidebarEnabled;
  final ValueChanged<T>? onSelected;
  final SidebarAnimation motion;
  final bool tooltipsEnabled;
  final StyleSpec<TooltipSpec> tooltipStyle;
  final OverlayPositionConfig tooltipPositioning;
  final SidebarStyler? defaultStyle;
  final StyleSpec<ToggleSpec>? defaultStyleSpec;

  @override
  State<_RemixSidebarDestinationWidget<T>> createState() =>
      _RemixSidebarDestinationState<T>();
}

class _RemixSidebarDestinationState<T extends Object>
    extends State<_RemixSidebarDestinationWidget<T>> {
  bool _tooltipOpen = false;
  bool _hovered = false;
  bool _focused = false;
  Timer? _resumeTooltip;

  bool get _canShow => widget.tooltipsEnabled && !widget.motion.isAnimating;

  @override
  void didUpdateWidget(_RemixSidebarDestinationWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_canShow) {
      _resumeTooltip?.cancel();
      _tooltipOpen = false;
    } else if ((!oldWidget.tooltipsEnabled || oldWidget.motion.isAnimating) &&
        (_hovered || _focused)) {
      _resumeTooltip?.cancel();
      _resumeTooltip = Timer(
        widget.tooltipStyle.spec.waitDuration ??
            const Duration(milliseconds: 300),
        () {
          if (mounted && _canShow && (_hovered || _focused)) {
            setState(() => _tooltipOpen = true);
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _resumeTooltip?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final handleSelected = widget.onSelected;
    final enabled =
        widget.sidebarEnabled && data.enabled && handleSelected != null;
    void activate() => handleSelected!(data.value);
    final style = widget.defaultStyleSpec != null
        ? _RawSidebarDestinationStyler(widget.defaultStyleSpec!)
        : _SidebarDestinationStyler(
            defaultStyle: widget.defaultStyle!,
            itemStyle: data.style,
          );

    final button = Semantics(
      button: true,
      selected: widget.selected,
      enabled: enabled,
      label: data.semanticLabel ?? data.label,
      onTap: enabled ? activate : null,
      child: NakedToggle(
        value: widget.selected,
        enabled: enabled,
        onChanged: enabled ? (_) => activate() : null,
        focusNode: data.focusNode,
        autofocus: data.autofocus,
        excludeSemantics: true,
        builder: (context, _, _) => RemixStyleSpecBuilder<ToggleSpec>(
          style: style,
          styleSpec: null,
          controller: NakedToggleState.controllerOf(context),
          builder: (context, spec) => _destinationContent(spec),
        ),
      ),
    );
    // The wrapper stays mounted in overlay hosts in both presentations, so
    // toggling label/tooltip visibility cannot replace the focused button.
    if (Overlay.maybeOf(context) == null) return button;
    return MouseRegion(
      onEnter: (_) => _hovered = true,
      onExit: (_) {
        _hovered = false;
        if (!_focused) _resumeTooltip?.cancel();
      },
      child: Focus(
        canRequestFocus: false,
        skipTraversal: true,
        includeSemantics: false,
        onFocusChange: (value) {
          _focused = value;
          if (!value && !_hovered) _resumeTooltip?.cancel();
        },
        child: RemixTooltip(
          open: _canShow && _tooltipOpen,
          onOpenChanged: (value) {
            if (!value) _resumeTooltip?.cancel();
            final next = _canShow && value;
            if (next != _tooltipOpen) setState(() => _tooltipOpen = next);
          },
          // The button already owns the accessible name. Suppress the
          // duplicate tooltip name that Flutter web appends to button labels.
          tooltipChild: ExcludeSemantics(child: Text(data.label)),
          positioning: widget.tooltipPositioning,
          style: _SidebarTooltipStyler(widget.tooltipStyle),
          child: button,
        ),
      ),
    );
  }

  Widget _destinationContent(ToggleSpec spec) {
    final motion = widget.motion;
    // Keep the expanded contract (including caller-supplied wrapping and
    // space-between alignment) and avoid reveal wrappers at rest. Only the
    // content changes here; the interactive NakedToggle remains mounted.
    if (motion.expansion == 1 && !motion.isAnimating) {
      return LayoutBuilder(
        builder: (context, constraints) => RowBox(
          styleSpec: spec.container,
          children: [
            if (widget.data.icon case final icon?)
              StyledIcon(icon: icon, styleSpec: spec.icon),
            if (constraints.hasBoundedWidth)
              Flexible(
                child: StyledText(widget.data.label, styleSpec: spec.label),
              )
            else
              StyledText(widget.data.label, styleSpec: spec.label),
          ],
        ),
      );
    }
    final flex = spec.container.spec.flex?.spec;
    final expandedAlignment = switch (flex?.mainAxisAlignment) {
      MainAxisAlignment.center => AlignmentDirectional.center,
      MainAxisAlignment.end => AlignmentDirectional.centerEnd,
      _ => AlignmentDirectional.centerStart,
    };
    // Icons hold their expanded position while the narrowing row clips the
    // label; only the settled rail centers them.
    final railAtRest = motion.expansion == 0 && !motion.isAnimating;
    Widget content(bool bounded) {
      final label = Offstage(
        offstage: motion.expansion == 0,
        child: Opacity(
          opacity: motion.labelOpacity,
          child: StyledText(
            widget.data.label,
            styleSpec: spec.label.copyWith(
              spec: spec.label.spec.copyWith(
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      );
      return Align(
        alignment: railAtRest ? AlignmentDirectional.center : expandedAlignment,
        widthFactor: bounded ? null : 1,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.data.icon case final icon?) ...[
              StyledIcon(icon: icon, styleSpec: spec.icon),
              SizedBox(width: (flex?.spacing ?? 0) * motion.expansion),
            ],
            if (bounded) Flexible(child: label) else label,
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) => RowBox(
        styleSpec: railAtRest
            ? _centeredContainer(spec.container)
            : spec.container,
        children: [
          if (constraints.hasBoundedWidth)
            Flexible(child: content(true))
          else
            content(false),
        ],
      ),
    );
  }

  /// Centers the settled rail icon in the whole target, not only in the space
  /// left by a recipe's (possibly asymmetric) horizontal padding.
  StyleSpec<FlexBoxSpec> _centeredContainer(StyleSpec<FlexBoxSpec> container) {
    final box = container.spec.box;
    final padding = box?.spec.padding?.resolve(Directionality.of(context));
    if (box == null || padding == null) return container;
    return container.copyWith(
      spec: container.spec.copyWith(
        box: box.copyWith(
          spec: box.spec.copyWith(
            padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
          ),
        ),
      ),
    );
  }
}

final class _SidebarTooltipStyler extends TooltipStyler {
  const _SidebarTooltipStyler(this.value) : super.create();
  final StyleSpec<TooltipSpec> value;
  @override
  StyleSpec<TooltipSpec> resolve(BuildContext context) => value;
  @override
  List<Object?> get props => [value];
}

/// Resolves the sidebar's nested destination style inside NakedToggle's state
/// context, then merges the per-destination override after it.
///
/// Resolving this at the panel root would discard selected, hovered, pressed,
/// focused, and disabled variants because those states belong to each toggle.
final class _SidebarDestinationStyler extends ToggleStyler {
  const _SidebarDestinationStyler({
    required this.defaultStyle,
    required this.itemStyle,
  }) : super.create();

  final SidebarStyler defaultStyle;
  final ToggleStyler itemStyle;

  @override
  ToggleStyler merge(ToggleStyler? other) {
    if (other == null) return this;

    return _SidebarDestinationStyler(
      defaultStyle: defaultStyle,
      itemStyle: itemStyle.merge(other),
    );
  }

  @override
  StyleSpec<ToggleSpec> resolve(BuildContext context) {
    return defaultStyle
        .merge(SidebarStyler(destination: itemStyle))
        .build(context)
        .spec
        .destination;
  }

  @override
  List<Object?> get props => [defaultStyle, itemStyle];
}

/// Adapts a nested raw destination spec to the destination's style input so its
/// animation and modifier metadata remain intact.
final class _RawSidebarDestinationStyler extends ToggleStyler {
  const _RawSidebarDestinationStyler(this.value) : super.create();

  final StyleSpec<ToggleSpec> value;

  @override
  ToggleStyler merge(ToggleStyler? other) {
    // A raw SidebarSpec is authoritative by contract.
    return this;
  }

  @override
  StyleSpec<ToggleSpec> resolve(BuildContext context) => value;

  @override
  List<Object?> get props => [value];
}
