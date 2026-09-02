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
class RemixSidebarDestination<T extends Object> {
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
class RemixSidebarSection<T extends Object> {
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
class RemixSidebar<T extends Object> extends StatelessWidget {
  const RemixSidebar({
    super.key,
    this.header,
    required this.sections,
    required this.selectedValue,
    this.onSelected,
    this.footer,
    this.enabled = true,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const SidebarStyler.create(),
    this.styleSpec,
  });

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
        .direction(Axis.vertical)
        .mainAxisSize(MainAxisSize.max)
        .crossAxisAlignment(CrossAxisAlignment.stretch);
    final stack = FlexBoxStyler()
        .direction(Axis.vertical)
        .mainAxisSize(MainAxisSize.min)
        .crossAxisAlignment(CrossAxisAlignment.stretch);

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
            direction: Axis.vertical,
            verticalDirection: VerticalDirection.down,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugConfigurationIsValid());

    final effectiveStyle = _effectiveStyle();
    final handleSelected = onSelected;
    final listDisabled = !enabled || handleSelected == null;

    return WidgetStateProvider(
      states: listDisabled ? const {WidgetState.disabled} : const {},
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
                          child: StyledText(
                            label,
                            styleSpec: spec.sectionLabel,
                          ),
                        ),
                      FlexBox(
                        styleSpec: _forceSourceOrder(spec.destinations),
                        children: [
                          for (final destination in section.destinations)
                            _RemixSidebarDestinationWidget<T>(
                              key: ValueKey<T>(destination.value),
                              data: destination,
                              selected: destination.value == selectedValue,
                              listEnabled: enabled,
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

          // A Column hands its children unbounded main-axis constraints, so the
          // panel's own constraints must be measured above the FlexBox. Only a
          // bounded panel can scroll or pin the footer to its bottom edge.
          return LayoutBuilder(
            builder: (context, constraints) {
              final bounded = constraints.hasBoundedHeight;

              return FlexBox(
                key: const ValueKey('RemixSidebar.container'),
                styleSpec: _forceSourceOrder(spec.container),
                children: [
                  if (header case final header?)
                    Box(styleSpec: spec.header, child: header),
                  if (bounded)
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

class _RemixSidebarDestinationWidget<T extends Object> extends StatelessWidget {
  const _RemixSidebarDestinationWidget({
    super.key,
    required this.data,
    required this.selected,
    required this.listEnabled,
    required this.onSelected,
    this.defaultStyle,
    this.defaultStyleSpec,
  });

  final RemixSidebarDestination<T> data;
  final bool selected;
  final bool listEnabled;
  final ValueChanged<T>? onSelected;
  final SidebarStyler? defaultStyle;
  final StyleSpec<ToggleSpec>? defaultStyleSpec;

  @override
  Widget build(BuildContext context) {
    final handleSelected = onSelected;
    final effectiveEnabled =
        listEnabled && data.enabled && handleSelected != null;
    void activate() => handleSelected!(data.value);

    return Semantics(
      button: true,
      selected: selected,
      enabled: effectiveEnabled,
      label: data.semanticLabel ?? data.label,
      onTap: effectiveEnabled ? activate : null,
      child: RemixToggle(
        selected: selected,
        enabled: effectiveEnabled,
        onChanged: effectiveEnabled ? (_) => activate() : null,
        label: data.label,
        icon: data.icon,
        focusNode: data.focusNode,
        autofocus: data.autofocus,
        excludeSemantics: true,
        style: defaultStyleSpec != null
            ? _RawSidebarDestinationStyler(defaultStyleSpec!)
            : _SidebarDestinationStyler(
                defaultStyle: defaultStyle!,
                itemStyle: data.style,
              ),
      ),
    );
  }
}

/// Resolves the sidebar's nested destination style inside RemixToggle's state
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

/// Adapts a nested raw destination spec to RemixToggle's style input so its
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
