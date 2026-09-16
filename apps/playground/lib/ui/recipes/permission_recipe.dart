import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/data_list.dart';
import '../components/disclosure.dart';
import '../components/permission.dart';
import '../theme/tokens.dart';

@immutable
final class PlaygroundAgentPermissionRecipe {
  const PlaygroundAgentPermissionRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.detailsStyle,
    required this.parametersStyle,
    required this.allowOnceStyle,
    required this.alwaysAllowStyle,
    required this.denyStyle,
  });
  final PlaygroundPermissionStyler style;
  final CardStyler surfaceStyle;
  final DisclosureStyler detailsStyle;
  final DataListStyler parametersStyle;
  final ButtonStyler allowOnceStyle;
  final ButtonStyler alwaysAllowStyle;
  final ButtonStyler denyStyle;
}

PlaygroundAgentPermissionRecipe playgroundAgentPermissionRecipe({
  PlaygroundPermissionStyler style = const PlaygroundPermissionStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler detailsStyle = const DisclosureStyler.create(),
  DataListStyler parametersStyle = const DataListStyler.create(),
  ButtonStyler allowOnceStyle = const ButtonStyler.create(),
  ButtonStyler alwaysAllowStyle = const ButtonStyler.create(),
  ButtonStyler denyStyle = const ButtonStyler.create(),
}) => PlaygroundAgentPermissionRecipe(
  style: PlaygroundPermissionStyler(
    header: FlexBoxStyler().spacing(8),
    actions: FlexBoxStyler().spacing(8).padding(.only(top: 8)),
    title: TextStyler()
        .color(PlaygroundTokens.foreground())
        .fontWeight(FontWeight.w600),
    tool: TextStyler().color(PlaygroundTokens.mutedForeground()).fontSize(12),
    description: TextStyler()
        .color(PlaygroundTokens.mutedForeground())
        .wrap(.padding(.symmetric(vertical: 8))),
    status: TextStyler().color(PlaygroundTokens.mutedForeground()).fontSize(12),
    detailsLabel: TextStyler()
        .color(PlaygroundTokens.foreground())
        .fontSize(13),
    toolIcon: IconStyler().color(PlaygroundTokens.foreground()).size(16),
    statusIcon: IconStyler().color(PlaygroundTokens.primary()).size(12),
    indicator: IconStyler().color(PlaygroundTokens.foreground()).size(16),
  ).merge(style),
  surfaceStyle: playgroundCardStyle(style: surfaceStyle),
  detailsStyle: playgroundDisclosureStyle(style: detailsStyle),
  parametersStyle: playgroundDataListStyle(style: parametersStyle),
  allowOnceStyle: playgroundButtonStyle(style: allowOnceStyle),
  alwaysAllowStyle: playgroundButtonStyle(
    variant: .outline,
    style: alwaysAllowStyle,
  ),
  denyStyle: playgroundButtonStyle(variant: .ghost, style: denyStyle),
);
