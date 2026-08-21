part of 'disclosure.dart';

/// Disclosure-specific state variants.
extension RemixDisclosureStylerRemixHelpers on DisclosureStyler {
  /// Style applied while the content panel is expanded.
  DisclosureStyler onExpanded(DisclosureStyler value) {
    return variant(
      ContextVariant(
        'onExpanded',
        (context) => NakedDisclosureState.of(context).isExpanded,
      ),
      value,
    );
  }

  /// Style applied while the content panel is collapsed.
  DisclosureStyler onCollapsed(DisclosureStyler value) {
    return variant(
      ContextVariant(
        'onCollapsed',
        (context) => !NakedDisclosureState.of(context).isExpanded,
      ),
      value,
    );
  }
}
