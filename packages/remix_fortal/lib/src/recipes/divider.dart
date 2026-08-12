import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'divider.g.dart';

/// Fortal divider length presets: 16, 32, 64, or the available axis extent.
enum FortalDividerSize { size1, size2, size3, size4 }

/// Fortal-themed preset for [RemixDivider].
@MixWidget(target: RemixDivider.new)
DividerStyler fortalDividerStyle({
  FortalDividerSize size = .size1,
  Axis orientation = Axis.horizontal,
}) {
  return DividerStyler()
      .color(FortalTokens.gray6())
      .merge(_fortalDividerSizeStyler(size, orientation));
}

DividerStyler _fortalDividerSizeStyler(
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
    final style = DividerStyler().height(FortalTokens.borderWidth1());
    return length == null
        ? style.wrap(
            WidgetModifierConfig.fractionallySizedBox(widthFactor: 1).align(),
          )
        : style.width(length);
  }
  final style = DividerStyler().width(FortalTokens.borderWidth1());
  return length == null
      ? style.wrap(
          WidgetModifierConfig.fractionallySizedBox(heightFactor: 1).align(),
        )
      : style.height(length);
}
