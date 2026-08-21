part of 'disclosure.dart';

extension RemixDisclosureStylerRemixHelpers on DisclosureStyler {
  DisclosureStyler onExpanded(DisclosureStyler value) {
    return variant(
      ContextVariant(
        'onExpanded',
        (context) => NakedDisclosureState.of(context).isExpanded,
      ),
      value,
    );
  }

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
