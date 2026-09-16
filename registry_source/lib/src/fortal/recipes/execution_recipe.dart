import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import '../../agent/components/execution.dart';

import '../components/card.dart';
import '../components/disclosure.dart';
import '../components/icon_button.dart';
import '../theme/theme.dart';

@immutable
final class FortalAgentExecutionRecipe {
  const FortalAgentExecutionRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.disclosureStyle,
    required this.copyStyle,
    required this.retryStyle,
  });
  final AgentExecutionStyler style;
  final CardStyler surfaceStyle;
  final DisclosureStyler disclosureStyle;
  final IconButtonStyler copyStyle;
  final IconButtonStyler retryStyle;
}

FortalAgentExecutionRecipe fortalAgentExecutionRecipe({
  AgentExecutionStyler style = const AgentExecutionStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
  IconButtonStyler copyStyle = const IconButtonStyler.create(),
  IconButtonStyler retryStyle = const IconButtonStyler.create(),
}) => FortalAgentExecutionRecipe(
  style: AgentExecutionStyler(
    header: FlexBoxStyler().spacing(8),
    output: BoxStyler()
        .color(FortalTokens.gray3())
        .borderRadius(.circular(6))
        .padding(.all(12)),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    tool: TextStyler().color(FortalTokens.gray11()).fontSize(12),
    title: TextStyler()
        .color(FortalTokens.gray12())
        .fontWeight(FontWeight.w600),
    meta: TextStyler().color(FortalTokens.gray11()).fontSize(12),
    status: TextStyler().color(FortalTokens.gray11()).fontSize(12),
    toolIcon: IconStyler().color(FortalTokens.gray12()).size(16),
    statusIcon: IconStyler().color(FortalTokens.accent9()).size(12),
    indicator: IconStyler().color(FortalTokens.gray12()).size(16),
  ).merge(style),
  surfaceStyle: fortalCardStyle(size: .size2, style: surfaceStyle),
  disclosureStyle: fortalDisclosureStyle(style: disclosureStyle),
  copyStyle: fortalIconButtonStyle(
    variant: .ghost,
    size: .size1,
    style: copyStyle,
  ),
  retryStyle: fortalIconButtonStyle(
    variant: .ghost,
    size: .size1,
    style: retryStyle,
  ),
);
