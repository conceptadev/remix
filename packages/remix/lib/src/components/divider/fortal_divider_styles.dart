part of 'divider.dart';

/// Fortal divider length presets: 16, 32, 64, or the available axis extent.
enum FortalDividerSize { size1, size2, size3, size4 }

/// Fortal-themed preset for [RemixDivider].
RemixDividerStyler fortalDividerStyler({
  FortalDividerSize size = .size1,
  Axis orientation = Axis.horizontal,
}) {
  return RemixDividerStyler()
      .color(FortalTokens.gray6())
      .merge(_fortalDividerSizeStyler(size, orientation));
}

RemixDividerStyler _fortalDividerSizeStyler(
  FortalDividerSize size,
  Axis orientation,
) {
  final length = switch (size) {
    .size1 => FortalTokens.space4(),
    .size2 => FortalTokens.space6(),
    .size3 => FortalTokens.space9(),
    .size4 => null,
  };
  if (orientation == Axis.horizontal) {
    final style = RemixDividerStyler().height(FortalTokens.borderWidth1());
    return length == null
        ? style.wrap(
            WidgetModifierConfig.fractionallySizedBox(widthFactor: 1).align(),
          )
        : style.width(length);
  }
  final style = RemixDividerStyler().width(FortalTokens.borderWidth1());
  return length == null
      ? style.wrap(
          WidgetModifierConfig.fractionallySizedBox(heightFactor: 1).align(),
        )
      : style.height(length);
}

/// Fortal-themed preset for [RemixDivider].
class FortalDivider extends StatelessWidget {
  const FortalDivider({
    super.key,
    this.size = .size1,
    this.orientation = Axis.horizontal,
    this.color,
    this.decorative = true,
    this.semanticLabel,
  });

  final FortalDividerSize size;
  final Axis orientation;

  /// Optional accent color override for this divider subtree.
  final FortalAccentColor? color;

  final bool decorative;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final style = fortalDividerStyler(
      size: this.size,
      orientation: this.orientation,
    );

    return FortalComponentOverride(
      color: this.color,
      child: (this.color == null ? style : style.color(FortalTokens.accentA6()))
          .call(
            key: this.key,
            orientation: this.orientation,
            decorative: this.decorative,
            semanticLabel: this.semanticLabel,
          ),
    );
  }
}
