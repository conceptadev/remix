// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_list.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixNavigationList].
///
/// The recipe keeps section labels compact and muted, separates sections with
/// Fortal's `space3` token, and reuses the ghost `size2` toggle treatment for
/// full-width destinations. [highContrast] strengthens section and selected
/// destination content without changing layout.
class FortalNavigationList<T extends Object> extends StatelessWidget {
  const FortalNavigationList({
    super.key,
    this.highContrast = false,
    required this.sections,
    required this.selectedValue,
    this.onSelected,
    this.enabled = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final bool highContrast;

  final List<RemixNavigationSection<T>> sections;

  final T? selectedValue;

  final ValueChanged<T>? onSelected;

  final bool enabled;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixNavigationList<T>(
      key: this.key,
      style: fortalNavigationListStyle(highContrast: this.highContrast),
      sections: this.sections,
      selectedValue: this.selectedValue,
      onSelected: this.onSelected,
      enabled: this.enabled,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
