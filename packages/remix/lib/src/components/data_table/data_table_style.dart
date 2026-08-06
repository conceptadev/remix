part of 'data_table.dart';

/// Style helpers for [RemixDataTable] typography and shared row chrome.
extension RemixDataTableStylerRemixHelpers on DataTableStyler {
  /// Sets the header label text style.
  DataTableStyler headerLabelTextStyle(TextStyleMix style) {
    return headerLabel(TextStyler(style: style));
  }

  /// Sets the header label color.
  DataTableStyler headerLabelColor(Color color) {
    return headerLabel(TextStyler(style: TextStyleMix(color: color)));
  }

  /// Sets the footer label text style.
  DataTableStyler footerLabelTextStyle(TextStyleMix style) {
    return footerLabel(TextStyler(style: style));
  }

  /// Sets the footer label color.
  DataTableStyler footerLabelColor(Color color) {
    return footerLabel(TextStyler(style: TextStyleMix(color: color)));
  }

  /// Sets the sort indicator color.
  DataTableStyler sortIconColor(Color color) {
    return sortIcon(IconStyler(color: color));
  }

  /// Applies [value] to the header cell and both body cell regions at once.
  ///
  /// The selection column shares the body cells' padding by default; call
  /// [DataTableStyler.selectionCell] afterwards to diverge.
  DataTableStyler cellPadding(EdgeInsetsGeometryMix value) {
    return headerCell(BoxStyler().padding(value))
        .bodyCell(BoxStyler().padding(value))
        .selectionCell(BoxStyler().padding(value));
  }

  /// Applies [value] as the divider drawn under header and body rows.
  DataTableStyler rowDivider(BorderSideMix value) {
    final divider = BoxStyler().border(BoxBorderMix.bottom(value));

    return headerRow(divider).bodyRow(divider);
  }
}
