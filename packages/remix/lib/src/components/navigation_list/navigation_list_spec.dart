part of 'navigation_list.dart';

/// Resolved visual properties for a [RemixNavigationList].
@MixableSpec(
  target: RemixNavigationList.new,
  extraStylerMixins: [RemixBoxStylerMixin],
)
class NavigationListSpec with _$NavigationListSpec {
  /// Layout and decoration for the section list.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  /// Layout and decoration for each section.
  @override
  final StyleSpec<FlexBoxSpec> section;

  /// Typography and modifiers for section labels.
  @override
  final StyleSpec<TextSpec> sectionLabel;

  /// Layout and decoration for each section's destination collection.
  @override
  final StyleSpec<FlexBoxSpec> destinations;

  /// Default visual style for every destination.
  @override
  final StyleSpec<ToggleSpec> destination;

  const NavigationListSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<FlexBoxSpec>? section,
    StyleSpec<TextSpec>? sectionLabel,
    StyleSpec<FlexBoxSpec>? destinations,
    StyleSpec<ToggleSpec>? destination,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       section = section ?? const StyleSpec(spec: FlexBoxSpec()),
       sectionLabel = sectionLabel ?? const StyleSpec(spec: TextSpec()),
       destinations = destinations ?? const StyleSpec(spec: FlexBoxSpec()),
       destination = destination ?? const StyleSpec(spec: ToggleSpec());
}
