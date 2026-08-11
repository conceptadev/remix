part of 'badge.dart';

/// Style configuration for [RemixBadge] container and label text.
extension RemixBadgeStylerRemixHelpers on BadgeStyler {
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
