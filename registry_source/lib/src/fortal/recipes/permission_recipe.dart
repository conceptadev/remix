import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import '../../agent/components/permission.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/data_list.dart';
import '../components/disclosure.dart';
import '../theme/theme.dart';

@immutable
final class FortalAgentPermissionRecipe {
  const FortalAgentPermissionRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.detailsStyle,
    required this.parametersStyle,
    required this.allowOnceStyle,
    required this.alwaysAllowStyle,
    required this.denyStyle,
  });
  final AgentPermissionStyler style;
  final CardStyler surfaceStyle;
  final DisclosureStyler detailsStyle;
  final DataListStyler parametersStyle;
  final ButtonStyler allowOnceStyle;
  final ButtonStyler alwaysAllowStyle;
  final ButtonStyler denyStyle;
}

FortalAgentPermissionRecipe fortalAgentPermissionRecipe({
  AgentPermissionStyler style = const AgentPermissionStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler detailsStyle = const DisclosureStyler.create(),
  DataListStyler parametersStyle = const DataListStyler.create(),
  ButtonStyler allowOnceStyle = const ButtonStyler.create(),
  ButtonStyler alwaysAllowStyle = const ButtonStyler.create(),
  ButtonStyler denyStyle = const ButtonStyler.create(),
}) => FortalAgentPermissionRecipe(
  style: AgentPermissionStyler(
    header: FlexBoxStyler().spacing(8),
    actions: FlexBoxStyler().spacing(8).padding(.only(top: 8)),
    title: TextStyler()
        .color(FortalTokens.gray12())
        .fontWeight(FontWeight.w600),
    tool: TextStyler().color(FortalTokens.gray11()).fontSize(12),
    description: TextStyler()
        .color(FortalTokens.gray11())
        .wrap(.padding(.symmetric(vertical: 8))),
    status: TextStyler().color(FortalTokens.gray11()).fontSize(12),
    detailsLabel: TextStyler().color(FortalTokens.gray12()).fontSize(13),
    toolIcon: IconStyler().color(FortalTokens.gray12()).size(16),
    statusIcon: IconStyler().color(FortalTokens.accent9()).size(12),
    indicator: IconStyler().color(FortalTokens.gray12()).size(16),
  ).merge(style),
  surfaceStyle: fortalCardStyle(size: .size2, style: surfaceStyle),
  detailsStyle: fortalDisclosureStyle(style: detailsStyle),
  parametersStyle: fortalDataListStyle(style: parametersStyle),
  allowOnceStyle: fortalButtonStyle(style: allowOnceStyle),
  alwaysAllowStyle: fortalButtonStyle(
    variant: .outline,
    style: alwaysAllowStyle,
  ),
  denyStyle: fortalButtonStyle(variant: .ghost, style: denyStyle),
);
