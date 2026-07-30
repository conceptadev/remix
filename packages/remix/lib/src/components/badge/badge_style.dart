part of 'badge.dart';

/// Style configuration for [RemixBadge] container and label text.
extension RemixBadgeStylerRemixHelpers on RemixBadgeStyler {
  /// Sets background color
  RemixBadgeStyler backgroundColor(Color value) {
    return merge(
      RemixBadgeStyler(
        container: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets the foreground color (text) of the badge.
  RemixBadgeStyler foregroundColor(Color value) {
    return labelColor(value);
  }

  /// Creates a [RemixBadge] widget with this style applied.
  RemixBadge call({
    Key? key,
    String? label,
    Widget? child,
    RemixBadgeLabelBuilder? labelBuilder,
  }) => RemixBadge(
    key: key,
    label: label,
    child: child,
    labelBuilder: labelBuilder,
    style: this,
  );
}
