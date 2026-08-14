part of 'accordion.dart';

/// Style configuration for [RemixAccordion] trigger, icons, title, and content.
extension RemixAccordionStylerRemixHelpers on AccordionStyler {
  /// Sets title color.
  AccordionStyler titleColor(Color value) {
    return title(TextStyler(style: TextStyleMix(color: value)));
  }

  /// Sets title font size.
  AccordionStyler titleFontSize(double value) {
    return title(TextStyler(style: TextStyleMix(fontSize: value)));
  }

  /// Sets title font weight.
  AccordionStyler titleFontWeight(FontWeight value) {
    return title(TextStyler(style: TextStyleMix(fontWeight: value)));
  }

  /// Sets title style using TextStyleMix directly.
  AccordionStyler titleStyle(TextStyleMix value) {
    return title(TextStyler(style: value));
  }

  /// Sets leading icon color.
  AccordionStyler leadingIconColor(Color value) {
    return leadingIcon(IconStyler(color: value));
  }

  /// Sets leading icon size.
  AccordionStyler leadingIconSize(double value) {
    return leadingIcon(IconStyler(size: value));
  }

  /// Sets trailing icon color.
  AccordionStyler trailingIconColor(Color value) {
    return trailingIcon(IconStyler(color: value));
  }

  /// Sets trailing icon size.
  AccordionStyler trailingIconSize(double value) {
    return trailingIcon(IconStyler(size: value));
  }

  /// Sets content background color.
  AccordionStyler contentColor(Color value) {
    return content(BoxStyler(decoration: BoxDecorationMix(color: value)));
  }

  /// Sets content padding.
  AccordionStyler contentPadding(EdgeInsetsGeometryMix value) {
    return content(BoxStyler(padding: value));
  }

  /// Sets content decoration.
  AccordionStyler contentDecoration(DecorationMix value) {
    return content(BoxStyler(decoration: value));
  }

  /// Style applied while the item is expanded.
  ///
  /// The item state is provided above the panel's style builder, so the same
  /// variant can target the container, trigger, content, icons, or title.
  AccordionStyler onExpanded<T>(AccordionStyler value) {
    return variant(
      ContextVariant(
        'onExpanded',
        (context) => _RemixAccordionStyleState.of(context).isExpanded,
      ),
      value,
    );
  }

  /// Style applied while the item is collapsed. See [onExpanded].
  AccordionStyler onCollapsed<T>(AccordionStyler value) {
    return variant(
      ContextVariant(
        'onCollapsed',
        (context) => !_RemixAccordionStyleState.of(context).isExpanded,
      ),
      value,
    );
  }

  /// Style when the accordion item can collapse.
  AccordionStyler onCanCollapse(AccordionStyler value) {
    return variant(
      ContextVariant(
        'onCanCollapse',
        (context) => _RemixAccordionStyleState.of(context).canCollapse,
      ),
      value,
    );
  }

  /// Style when the accordion item can expand.
  AccordionStyler onCanExpand<T>(AccordionStyler value) {
    return variant(
      ContextVariant(
        'onCanExpand',
        (context) => _RemixAccordionStyleState.of(context).canExpand,
      ),
      value,
    );
  }
}
