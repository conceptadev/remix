// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidebar.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Sidebar recipe.
///
/// A sidebar is the navigation panel down one edge of an application shell.
/// Remix owns the rendering, the header/content/footer stacking, the roving
/// focus across destinations, the selection semantics, and the navigation
/// landmark; this recipe owns the panel surface, the region insets, the
/// section rhythm, and the label type.
///
/// It takes no variant and no size. There is one panel per shell, and the
/// thing that actually varies between applications — how wide it is — is not
/// the recipe's to decide: the host sizes the panel, because the same panel
/// is usually presented as a drawer at narrow widths and the drawer's width
/// is a layout decision. Nothing here sets a width, and nothing here pads the
/// header, whose metrics normally have to line up with an application top bar.
///
/// This recipe **depends on the `toggle` item**, which is why its registry
/// entry lists `toggle` beside `theme`. A destination is a toggle: it is a
/// control that stays pressed, and `SidebarSpec` takes its style as a
/// `ToggleStyler` field. Handing it the application's own ghost toggle recipe
/// is what keeps a selected destination and a selected toggle the same colour
/// without restating one component inside another.
///
/// The panel fill is `background`, the same token the page uses, and the
/// trailing hairline in `border` is what separates the two — the same choice
/// the card recipe makes, for the same reason.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it:
///
/// ```dart
/// PlaygroundSidebar(
///   style: SidebarStyler().width(_shellSidebarWidth),
///   sections: sections,
///   selectedValue: current,
///   onSelected: go,
/// )
/// ```
class PlaygroundSidebar<T extends Object> extends StatelessWidget {
  const PlaygroundSidebar({
    super.key,
    this.style = const SidebarStyler.create(),
    this.header,
    required this.sections,
    required this.selectedValue,
    this.onSelected,
    this.footer,
    this.enabled = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final SidebarStyler style;

  final Widget? header;

  final List<RemixSidebarSection<T>> sections;

  final T? selectedValue;

  final ValueChanged<T>? onSelected;

  final Widget? footer;

  final bool enabled;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixSidebar<T>(
      key: this.key,
      style: playgroundSidebarStyle(style: this.style),
      header: this.header,
      sections: this.sections,
      selectedValue: this.selectedValue,
      onSelected: this.onSelected,
      footer: this.footer,
      enabled: this.enabled,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
