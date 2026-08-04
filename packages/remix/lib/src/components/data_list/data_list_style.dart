part of 'data_list.dart';

/// Style helpers for [RemixDataList] label/value typography.
extension RemixDataListStylerRemixHelpers on DataListStyler {
  /// Sets the label text style.
  DataListStyler labelTextStyle(TextStyleMix style) {
    return label(TextStyler(style: style));
  }

  /// Sets the label text color.
  DataListStyler labelColor(Color color) {
    return label(TextStyler(style: TextStyleMix(color: color)));
  }

  /// Sets the value text style.
  DataListStyler valueTextStyle(TextStyleMix style) {
    return value(TextStyler(style: style));
  }

  /// Sets the value text color.
  DataListStyler valueColor(Color color) {
    return value(TextStyler(style: TextStyleMix(color: color)));
  }

  /// Creates a [RemixDataList] widget with this style applied.
  RemixDataList call({
    Key? key,
    required List<RemixDataListItem> items,
    Axis orientation = Axis.horizontal,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixDataList(
      key: key,
      items: items,
      orientation: orientation,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      style: this,
    );
  }
}
