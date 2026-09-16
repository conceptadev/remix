// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidebar.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixSidebar].
///
/// The recipe paints the solid panel surface with a trailing edge border,
/// pads the scrolling destination region, keeps section labels compact and
/// muted, separates sections with Fortal's `space3` token, and reuses the
/// ghost `size2` toggle treatment inside full-width destinations with a
/// 48-logical-pixel minimum height. The footer carries the divider that
/// separates account content from navigation. [highContrast] strengthens
/// section and selected destination content without changing layout.
/// [panelPadding] applies host-owned insets inside the painted panel surface.
///
/// The recipe sets no panel width and no header padding. The host can supply
/// expanded/collapsed widths to the widget for coordinated animation, or size
/// the panel itself. Header metrics usually match an application top bar.
class FortalSidebar<T extends Object> extends StatelessWidget {
  const FortalSidebar({
    super.key,
    this.highContrast = false,
    this.collapsed = false,
    this.panelPadding,
    this.style = const SidebarStyler.create(),
    this.header,
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
  });

  final bool highContrast;

  final bool collapsed;

  final EdgeInsetsGeometry? panelPadding;

  final SidebarStyler style;

  final Widget? header;

  final bool showTooltips;

  final OverlayPositionConfig? tooltipPositioning;

  final double? expandedWidth;

  final double? collapsedWidth;

  final AnimationStyle animationStyle;

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
      style: fortalSidebarStyle(
        highContrast: this.highContrast,
        collapsed: this.collapsed,
        panelPadding: this.panelPadding,
        style: this.style,
      ),
      header: this.header,
      collapsed: this.collapsed,
      showTooltips: this.showTooltips,
      tooltipPositioning: this.tooltipPositioning,
      expandedWidth: this.expandedWidth,
      collapsedWidth: this.collapsedWidth,
      animationStyle: this.animationStyle,
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
