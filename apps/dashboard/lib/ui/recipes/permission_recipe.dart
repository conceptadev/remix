import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/data_list.dart';
import '../components/disclosure.dart';
import '../components/permission.dart';
import '../theme/theme.dart';

@immutable
final class UiAgentPermissionRecipe {
  const UiAgentPermissionRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.detailsStyle,
    required this.parametersStyle,
    required this.allowOnceStyle,
    required this.alwaysAllowStyle,
    required this.denyStyle,
  });
  final UiPermissionStyler style;
  final CardStyler surfaceStyle;
  final DisclosureStyler detailsStyle;
  final DataListStyler parametersStyle;
  final ButtonStyler allowOnceStyle;
  final ButtonStyler alwaysAllowStyle;
  final ButtonStyler denyStyle;
}

UiAgentPermissionRecipe uiAgentPermissionRecipe({
  UiPermissionStyler style = const UiPermissionStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler detailsStyle = const DisclosureStyler.create(),
  DataListStyler parametersStyle = const DataListStyler.create(),
  ButtonStyler allowOnceStyle = const ButtonStyler.create(),
  ButtonStyler alwaysAllowStyle = const ButtonStyler.create(),
  ButtonStyler denyStyle = const ButtonStyler.create(),
}) => UiAgentPermissionRecipe(
  style: UiPermissionStyler(
    header: FlexBoxStyler().spacing(8),
    actions: FlexBoxStyler().spacing(8).padding(.only(top: 8)),
    title: TextStyler().color(UiTokens.gray12()).fontWeight(FontWeight.w600),
    tool: TextStyler().color(UiTokens.gray11()).fontSize(12),
    description: TextStyler()
        .color(UiTokens.gray11())
        .wrap(.padding(.symmetric(vertical: 8))),
    status: TextStyler().color(UiTokens.gray11()).fontSize(12),
    detailsLabel: TextStyler().color(UiTokens.gray12()).fontSize(13),
    toolIcon: IconStyler().color(UiTokens.gray12()).size(16),
    statusIcon: IconStyler().color(UiTokens.accent9()).size(12),
    indicator: IconStyler().color(UiTokens.gray12()).size(16),
  ).merge(style),
  surfaceStyle: uiCardStyle(size: .size2, style: surfaceStyle),
  detailsStyle: uiDisclosureStyle(style: detailsStyle),
  parametersStyle: uiDataListStyle(style: parametersStyle),
  allowOnceStyle: uiButtonStyle(style: allowOnceStyle),
  alwaysAllowStyle: uiButtonStyle(variant: .outline, style: alwaysAllowStyle),
  denyStyle: uiButtonStyle(variant: .ghost, style: denyStyle),
);
