import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import '../../agent/components/execution.dart';

import '../components/card.dart';
import '../components/disclosure.dart';
import '../components/icon_button.dart';
import '../theme/tokens.dart';

@immutable
final class VanillaAgentExecutionRecipe {
  const VanillaAgentExecutionRecipe({
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

VanillaAgentExecutionRecipe vanillaAgentExecutionRecipe({
  AgentExecutionStyler style = const AgentExecutionStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
  IconButtonStyler copyStyle = const IconButtonStyler.create(),
  IconButtonStyler retryStyle = const IconButtonStyler.create(),
}) => VanillaAgentExecutionRecipe(
  style: AgentExecutionStyler(
    header: FlexBoxStyler().spacing(8),
    output: BoxStyler()
        .color(VanillaTokens.muted())
        .borderRadius(.circular(6))
        .padding(.all(12)),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    tool: TextStyler().color(VanillaTokens.mutedForeground()).fontSize(12),
    title: TextStyler()
        .color(VanillaTokens.foreground())
        .fontWeight(FontWeight.w600),
    meta: TextStyler().color(VanillaTokens.mutedForeground()).fontSize(12),
    status: TextStyler().color(VanillaTokens.mutedForeground()).fontSize(12),
    toolIcon: IconStyler().color(VanillaTokens.foreground()).size(16),
    statusIcon: IconStyler().color(VanillaTokens.primary()).size(12),
    indicator: IconStyler().color(VanillaTokens.foreground()).size(16),
  ).merge(style),
  surfaceStyle: vanillaCardStyle(style: surfaceStyle),
  disclosureStyle: vanillaDisclosureStyle(style: disclosureStyle),
  copyStyle: vanillaIconButtonStyle(
    variant: .ghost,
    size: .small,
    style: copyStyle,
  ),
  retryStyle: vanillaIconButtonStyle(
    variant: .ghost,
    size: .small,
    style: retryStyle,
  ),
);
