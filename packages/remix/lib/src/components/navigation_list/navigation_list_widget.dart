part of 'navigation_list.dart';

/// Declarative data for one in-app destination in a [RemixNavigationList].
///
/// [T] is non-nullable because `null` is reserved by the owning list as the
/// no-selection sentinel. Values must be unique across all sections and keep
/// stable equality and hash-code behavior while rendered.
class RemixNavigationDestination<T extends Object> {
  const RemixNavigationDestination({
    required this.value,
    required this.label,
    this.icon,
    this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.style = const ToggleStyler.create(),
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

  /// Per-destination style merged after the list's default destination style.
  ///
  /// An authoritative raw `styleSpec` on the owning list bypasses this style.
  final ToggleStyler style;
}

/// Declarative data for one section in a [RemixNavigationList].
///
/// A section with no [destinations] is skipped together with its [label].
class RemixNavigationSection<T extends Object> {
  const RemixNavigationSection({this.label, required this.destinations});

  /// Optional visible and semantic section heading.
  ///
  /// Visual text transforms do not rewrite this authored accessible name. When
  /// provided, it must contain at least one non-whitespace character.
  final String? label;

  /// Destinations rendered in visual and focus-traversal order.
  ///
  /// Do not mutate this list during a build; rebuild with a new list when its
  /// contents or order change.
  final List<RemixNavigationDestination<T>> destinations;
}

/// A controlled, vertical list of in-app navigation destinations.
///
/// The list publishes a navigation landmark and selected-button destination
/// semantics. It uses ordinary Tab traversal; Enter and Space activate the
/// focused destination. Activating the selected destination calls
/// [onSelected] again rather than suppressing reselection.
///
/// This widget owns neither scrolling nor shell behavior. Callers compose it
/// inside a sidebar, drawer, rail-like layout, or scroll view and retain
/// responsibility for routing, dismissal, and focus restoration. Use
/// `RemixLink` instead for true URL or document destinations.
///
/// ```dart
/// RemixNavigationList<String>(
///   sections: const [
///     RemixNavigationSection(
///       label: 'Workspace',
///       destinations: [
///         RemixNavigationDestination(
///           value: 'overview',
///           label: 'Overview',
///         ),
///       ],
///     ),
///   ],
///   selectedValue: selectedPage,
///   onSelected: selectPage,
/// )
/// ```
class RemixNavigationList<T extends Object> extends StatelessWidget {
  const RemixNavigationList({
    super.key,
    required this.sections,
    required this.selectedValue,
    this.onSelected,
    this.enabled = true,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const NavigationListStyler.create(),
    this.styleSpec,
  });

  /// Sections rendered in visual and focus-traversal order.
  ///
  /// Destination values must be unique across every section. Do not mutate
  /// this list or its nested destination lists during a build; rebuild with
  /// new lists when their contents or order change.
  final List<RemixNavigationSection<T>> sections;

  /// The selected destination value, or null when no destination is selected.
  ///
  /// A non-null value must match exactly one destination across [sections].
  final T? selectedValue;

  /// Called once for every enabled activation, including reselection.
  ///
  /// When null, every destination is disabled while [selectedValue] styling is
  /// preserved.
  final ValueChanged<T>? onSelected;

  /// Whether the complete list is interactive.
  ///
  /// When false, destinations expose no activation action or focus stop while
  /// [selectedValue] styling is preserved.
  final bool enabled;

  /// Optional accessible name for the navigation landmark.
  ///
  /// Use this to distinguish multiple navigation landmarks. When provided, it
  /// must contain at least one non-whitespace character.
  final String? semanticLabel;

  /// Whether to hide the landmark and every destination from semantics.
  final bool excludeSemantics;

  /// Fluent visual style for the list and its default destination style.
  final NavigationListStyler style;

  /// Optional raw style spec that bypasses fluent and per-destination styles.
  ///
  /// Structural direction is still forced to source-order vertical layout.
  final NavigationListSpec? styleSpec;

  /// Creates a fluent style for this component.
  static final styleFrom = NavigationListStyler.new;

  bool _debugConfigurationIsValid() {
    final landmarkLabel = semanticLabel;
    assert(
      landmarkLabel == null || landmarkLabel.trim().isNotEmpty,
      'RemixNavigationList semanticLabel must not be blank.',
    );

    final values = <T>{};
    var autofocusCount = 0;

    for (final section in sections) {
      final sectionLabel = section.label;
      assert(
        sectionLabel == null || sectionLabel.trim().isNotEmpty,
        'RemixNavigationList section labels must not be blank.',
      );

      for (final destination in section.destinations) {
        assert(
          destination.label.trim().isNotEmpty,
          'RemixNavigationList destination labels must not be blank.',
        );
        final destinationSemanticLabel = destination.semanticLabel;
        assert(
          destinationSemanticLabel == null ||
              destinationSemanticLabel.trim().isNotEmpty,
          'RemixNavigationList destination semantic labels must not be blank.',
        );

        if (!values.add(destination.value)) {
          throw FlutterError(
            'RemixNavigationList destination values must be unique. '
            'Duplicate value: ${destination.value}.',
          );
        }
        if (destination.autofocus) autofocusCount += 1;
      }
    }

    if (selectedValue != null && !values.contains(selectedValue)) {
      throw FlutterError(
        'RemixNavigationList selectedValue must match one destination. '
        'No destination has value: $selectedValue.',
      );
    }

    if (autofocusCount > 1) {
      throw FlutterError(
        'Only one destination may autofocus in a RemixNavigationList.',
      );
    }

    return true;
  }

  NavigationListStyler _effectiveStyle() {
    final vertical = FlexBoxStyler()
        .direction(Axis.vertical)
        .mainAxisSize(MainAxisSize.min)
        .crossAxisAlignment(CrossAxisAlignment.stretch);

    return NavigationListStyler(
      container: vertical,
      section: vertical,
      destinations: vertical,
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

    final landmark = Semantics(
      role: ui.SemanticsRole.navigation,
      container: true,
      explicitChildNodes: true,
      label: semanticLabel,
      child: WidgetStateProvider(
        states: listDisabled ? const {WidgetState.disabled} : const {},
        child: RemixStyleSpecBuilder<NavigationListSpec>(
          style: effectiveStyle,
          styleSpec: styleSpec,
          builder: (context, spec) {
            return FlexBox(
              key: const ValueKey('RemixNavigationList.container'),
              styleSpec: _forceSourceOrder(spec.container),
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
                              _RemixNavigationDestinationWidget<T>(
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
          },
        ),
      ),
    );

    return ExcludeSemantics(excluding: excludeSemantics, child: landmark);
  }
}

class _RemixNavigationDestinationWidget<T extends Object>
    extends StatelessWidget {
  const _RemixNavigationDestinationWidget({
    super.key,
    required this.data,
    required this.selected,
    required this.listEnabled,
    required this.onSelected,
    this.defaultStyle,
    this.defaultStyleSpec,
  });

  final RemixNavigationDestination<T> data;
  final bool selected;
  final bool listEnabled;
  final ValueChanged<T>? onSelected;
  final NavigationListStyler? defaultStyle;
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
            ? _RawNavigationDestinationStyler(defaultStyleSpec!)
            : _NavigationDestinationStyler(
                defaultStyle: defaultStyle!,
                itemStyle: data.style,
              ),
      ),
    );
  }
}

/// Resolves the list's nested destination style inside RemixToggle's state
/// context, then merges the per-destination override after it.
///
/// Resolving this at the list root would discard selected, hovered, pressed,
/// focused, and disabled variants because those states belong to each toggle.
final class _NavigationDestinationStyler extends ToggleStyler {
  const _NavigationDestinationStyler({
    required this.defaultStyle,
    required this.itemStyle,
  }) : super.create();

  final NavigationListStyler defaultStyle;
  final ToggleStyler itemStyle;

  @override
  ToggleStyler merge(ToggleStyler? other) {
    if (other == null) return this;

    return _NavigationDestinationStyler(
      defaultStyle: defaultStyle,
      itemStyle: itemStyle.merge(other),
    );
  }

  @override
  StyleSpec<ToggleSpec> resolve(BuildContext context) {
    return defaultStyle
        .merge(NavigationListStyler(destination: itemStyle))
        .build(context)
        .spec
        .destination;
  }

  @override
  List<Object?> get props => [defaultStyle, itemStyle];
}

/// Adapts a nested raw destination spec to RemixToggle's style input so its
/// animation and modifier metadata remain intact.
final class _RawNavigationDestinationStyler extends ToggleStyler {
  const _RawNavigationDestinationStyler(this.value) : super.create();

  final StyleSpec<ToggleSpec> value;

  @override
  ToggleStyler merge(ToggleStyler? other) {
    // A raw NavigationListSpec is authoritative by contract.
    return this;
  }

  @override
  StyleSpec<ToggleSpec> resolve(BuildContext context) => value;

  @override
  List<Object?> get props => [value];
}
