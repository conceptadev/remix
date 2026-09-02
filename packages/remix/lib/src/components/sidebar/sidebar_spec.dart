part of 'sidebar.dart';

/// Resolved visual properties for a [RemixSidebar].
@MixableSpec(target: RemixSidebar.new, extraStylerMixins: [RemixBoxStylerMixin])
@immutable
final class SidebarSpec with _$SidebarSpec {
  /// Layout and decoration for the panel that stacks header, content, and
  /// footer.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  /// Layout and decoration for the fixed header region.
  ///
  /// Resolved but unused when the sidebar has no header.
  @override
  final StyleSpec<BoxSpec> header;

  /// Layout and decoration for the scrollable destination region.
  @override
  final StyleSpec<FlexBoxSpec> content;

  /// Layout and decoration for the fixed footer region.
  ///
  /// Resolved but unused when the sidebar has no footer.
  @override
  final StyleSpec<BoxSpec> footer;

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

  const SidebarSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<BoxSpec>? header,
    StyleSpec<FlexBoxSpec>? content,
    StyleSpec<BoxSpec>? footer,
    StyleSpec<FlexBoxSpec>? section,
    StyleSpec<TextSpec>? sectionLabel,
    StyleSpec<FlexBoxSpec>? destinations,
    StyleSpec<ToggleSpec>? destination,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       header = header ?? const StyleSpec(spec: BoxSpec()),
       content = content ?? const StyleSpec(spec: FlexBoxSpec()),
       footer = footer ?? const StyleSpec(spec: BoxSpec()),
       section = section ?? const StyleSpec(spec: FlexBoxSpec()),
       sectionLabel = sectionLabel ?? const StyleSpec(spec: TextSpec()),
       destinations = destinations ?? const StyleSpec(spec: FlexBoxSpec()),
       destination = destination ?? const StyleSpec(spec: ToggleSpec());
}
