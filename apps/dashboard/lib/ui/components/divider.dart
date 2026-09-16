import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'divider.g.dart';

/// Ui divider length presets: 16, 32, 64, or the available axis extent.
enum UiDividerSize { size1, size2, size3, size4 }

/// Ui-themed preset for [RemixDivider].
@MixWidget(target: RemixDivider.new)
DividerStyler uiDividerStyle({
  UiDividerSize size = .size1,
  Axis orientation = Axis.horizontal,
  DividerStyler style = const DividerStyler.create(),
}) {
  return DividerStyler()
      .color(UiTokens.gray6())
      .merge(_uiDividerSizeStyler(size, orientation))
      .merge(style);
}

DividerStyler _uiDividerSizeStyler(UiDividerSize size, Axis orientation) {
  final length = switch (size) {
    .size1 => UiTokens.space4(),
    .size2 => UiTokens.space6(),
    .size3 => UiTokens.space9(),
    .size4 => null,
  };
  if (orientation == Axis.horizontal) {
    final style = DividerStyler().height(UiTokens.borderWidth1());
    return length == null
        ? style.wrap(
            WidgetModifierConfig.fractionallySizedBox(widthFactor: 1).align(),
          )
        : style.width(length);
  }
  final style = DividerStyler().width(UiTokens.borderWidth1());
  return length == null
      ? style.wrap(
          WidgetModifierConfig.fractionallySizedBox(heightFactor: 1).align(),
        )
      : style.height(length);
}
