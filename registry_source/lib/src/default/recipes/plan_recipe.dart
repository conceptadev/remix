import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import '../../agent/components/plan.dart';

import '../components/disclosure.dart';
import '../theme/tokens.dart';

@immutable
final class VanillaAgentPlanRecipe {
  const VanillaAgentPlanRecipe({
    required this.style,
    required this.disclosureStyle,
  });
  final AgentPlanStyler style;
  final DisclosureStyler disclosureStyle;
}

VanillaAgentPlanRecipe vanillaAgentPlanRecipe({
  AgentPlanStyler style = const AgentPlanStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
}) => VanillaAgentPlanRecipe(
  style: AgentPlanStyler(
    viewport: BoxStyler().maxHeight(220),
    item: FlexBoxStyler().spacing(6).padding(.symmetric(vertical: 6)),
    summaryTitle: TextStyler()
        .color(VanillaTokens.foreground())
        .fontSize(14)
        .fontWeight(FontWeight.w600),
    itemTitle: TextStyler().color(VanillaTokens.foreground()).fontSize(14),
    itemDetail: TextStyler()
        .color(VanillaTokens.mutedForeground())
        .fontSize(12),
    count: TextStyler()
        .color(VanillaTokens.mutedForeground())
        .fontSize(12)
        .wrap(.padding(.only(right: 8))),
    indicator: IconStyler().color(VanillaTokens.foreground()).size(16),
    pendingStatus: IconStyler().color(VanillaTokens.mutedForeground()).size(18),
    activeStatus: IconStyler().color(VanillaTokens.primary()).size(18),
    completedStatus: IconStyler().color(VanillaTokens.primary()).size(18),
    cancelledStatus: IconStyler()
        .color(VanillaTokens.mutedForeground())
        .size(18),
  ).merge(style),
  disclosureStyle: vanillaDisclosureStyle(style: disclosureStyle),
);
