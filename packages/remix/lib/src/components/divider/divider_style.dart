part of 'divider.dart';

/// Style configuration for a [RemixDivider] container.
extension RemixDividerStylerRemixHelpers on RemixDividerStyler {
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
