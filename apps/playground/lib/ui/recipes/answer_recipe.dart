import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/answer.dart';
import '../components/card.dart';
import '../components/disclosure.dart';
import '../components/icon_button.dart';
import '../theme/tokens.dart';

@immutable
final class PlaygroundAgentAnswerRecipe {
  const PlaygroundAgentAnswerRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.sourcesStyle,
    required this.copyStyle,
    required this.retryStyle,
  });
  final PlaygroundAnswerStyler style;
  final CardStyler surfaceStyle;
  final DisclosureStyler sourcesStyle;
  final IconButtonStyler copyStyle;
  final IconButtonStyler retryStyle;
}

PlaygroundAgentAnswerRecipe playgroundAgentAnswerRecipe({
  PlaygroundAnswerStyler style = const PlaygroundAnswerStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler sourcesStyle = const DisclosureStyler.create(),
  IconButtonStyler copyStyle = const IconButtonStyler.create(),
  IconButtonStyler retryStyle = const IconButtonStyler.create(),
}) => PlaygroundAgentAnswerRecipe(
  style: PlaygroundAnswerStyler(
    body: BoxStyler(),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    feedback: BoxStyler().padding(.only(top: 6)),
    sourcesLabel: TextStyler()
        .color(PlaygroundTokens.foreground())
        .fontSize(13),
    indicator: IconStyler().color(PlaygroundTokens.foreground()).size(16),
  ).merge(style),
  surfaceStyle: playgroundCardStyle(style: surfaceStyle),
  sourcesStyle: playgroundDisclosureStyle(style: sourcesStyle),
  copyStyle: playgroundIconButtonStyle(
    variant: .ghost,
    size: .small,
    style: copyStyle,
  ),
  retryStyle: playgroundIconButtonStyle(
    variant: .ghost,
    size: .small,
    style: retryStyle,
  ),
);
