import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/answer.dart';
import '../components/card.dart';
import '../components/disclosure.dart';
import '../components/icon_button.dart';
import '../theme/theme.dart';

@immutable
final class UiAgentAnswerRecipe {
  const UiAgentAnswerRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.sourcesStyle,
    required this.copyStyle,
    required this.retryStyle,
  });
  final UiAnswerStyler style;
  final CardStyler surfaceStyle;
  final DisclosureStyler sourcesStyle;
  final IconButtonStyler copyStyle;
  final IconButtonStyler retryStyle;
}

UiAgentAnswerRecipe uiAgentAnswerRecipe({
  UiAnswerStyler style = const UiAnswerStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler sourcesStyle = const DisclosureStyler.create(),
  IconButtonStyler copyStyle = const IconButtonStyler.create(),
  IconButtonStyler retryStyle = const IconButtonStyler.create(),
}) => UiAgentAnswerRecipe(
  style: UiAnswerStyler(
    body: BoxStyler(),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    feedback: BoxStyler().padding(.only(top: 6)),
    sourcesLabel: TextStyler().color(UiTokens.gray12()).fontSize(13),
    indicator: IconStyler().color(UiTokens.gray12()).size(16),
  ).merge(style),
  surfaceStyle: uiCardStyle(size: .size2, style: surfaceStyle),
  sourcesStyle: uiDisclosureStyle(style: sourcesStyle),
  copyStyle: uiIconButtonStyle(variant: .ghost, size: .size1, style: copyStyle),
  retryStyle: uiIconButtonStyle(
    variant: .ghost,
    size: .size1,
    style: retryStyle,
  ),
);
