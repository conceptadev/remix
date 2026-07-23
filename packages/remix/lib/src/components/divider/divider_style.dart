part of 'divider.dart';

/// Style configuration for a [RemixDivider] container.
extension RemixDividerStylerRemixHelpers on RemixDividerStyler {
  /// Sets divider thickness (height for horizontal, width for vertical).
  RemixDividerStyler thickness(double value) {
    return merge(RemixDividerStyler(thickness: value));
  }

  /// Creates a [RemixDivider] widget with this style applied.
  RemixDivider call({
    Key? key,
    Axis orientation = Axis.horizontal,
    bool decorative = true,
    String? semanticLabel,
  }) {
    return RemixDivider(
      key: key,
      orientation: orientation,
      decorative: decorative,
      semanticLabel: semanticLabel,
      style: this,
    );
  }
}
