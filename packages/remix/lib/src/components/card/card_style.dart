part of 'card.dart';

/// Style configuration for a [RemixCard] container.
extension RemixCardStylerRemixHelpers on CardStyler {
  /// Sets the card background color.
  CardStyler backgroundColor(Color value) => color(value);

  /// Creates a [RemixCard] widget with this style applied.
  RemixCard call({Key? key, Widget? child}) {
    return RemixCard(key: key, style: this, child: child);
  }
}
