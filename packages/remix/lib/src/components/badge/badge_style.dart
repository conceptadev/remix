part of 'badge.dart';

/// Style configuration for [RemixBadge] container and label text.
extension RemixBadgeStylerRemixHelpers on BadgeStyler {
  /// Sets background color
  BadgeStyler backgroundColor(Color value) {
    return merge(
      BadgeStyler(
        container: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets the foreground color (text) of the badge.
  BadgeStyler foregroundColor(Color value) {
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
