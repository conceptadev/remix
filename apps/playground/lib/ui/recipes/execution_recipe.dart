import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/card.dart';
import '../components/disclosure.dart';
import '../components/execution.dart';
import '../components/icon_button.dart';
import '../theme/tokens.dart';

@immutable
final class PlaygroundAgentExecutionRecipe {
  const PlaygroundAgentExecutionRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.disclosureStyle,
    required this.copyStyle,
    required this.retryStyle,
  });
  final PlaygroundExecutionStyler style;
  final CardStyler surfaceStyle;
  final DisclosureStyler disclosureStyle;
  final IconButtonStyler copyStyle;
  final IconButtonStyler retryStyle;
}

PlaygroundAgentExecutionRecipe playgroundAgentExecutionRecipe({
  PlaygroundExecutionStyler style = const PlaygroundExecutionStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
  IconButtonStyler copyStyle = const IconButtonStyler.create(),
  IconButtonStyler retryStyle = const IconButtonStyler.create(),
}) => PlaygroundAgentExecutionRecipe(
  style: PlaygroundExecutionStyler(
    header: FlexBoxStyler().spacing(8),
    output: BoxStyler()
        .color(PlaygroundTokens.muted())
        .borderRadius(.circular(6))
        .padding(.all(12)),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    tool: TextStyler().color(PlaygroundTokens.mutedForeground()).fontSize(12),
    title: TextStyler()
        .color(PlaygroundTokens.foreground())
        .fontWeight(FontWeight.w600),
    meta: TextStyler().color(PlaygroundTokens.mutedForeground()).fontSize(12),
    status: TextStyler().color(PlaygroundTokens.mutedForeground()).fontSize(12),
    toolIcon: IconStyler().color(PlaygroundTokens.foreground()).size(16),
    statusIcon: IconStyler().color(PlaygroundTokens.primary()).size(12),
    indicator: IconStyler().color(PlaygroundTokens.foreground()).size(16),
  ).merge(style),
  surfaceStyle: playgroundCardStyle(style: surfaceStyle),
  disclosureStyle: playgroundDisclosureStyle(style: disclosureStyle),
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
