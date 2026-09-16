import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import '../../agent/components/plan.dart';

import '../components/disclosure.dart';
import '../theme/theme.dart';

@immutable
final class FortalAgentPlanRecipe {
  const FortalAgentPlanRecipe({
    required this.style,
    required this.disclosureStyle,
  });
  final AgentPlanStyler style;
  final DisclosureStyler disclosureStyle;
}

FortalAgentPlanRecipe fortalAgentPlanRecipe({
  AgentPlanStyler style = const AgentPlanStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
}) => FortalAgentPlanRecipe(
  style: AgentPlanStyler(
    viewport: BoxStyler().maxHeight(220),
    item: FlexBoxStyler().spacing(6).padding(.symmetric(vertical: 6)),
    summaryTitle: TextStyler()
        .color(FortalTokens.gray12())
        .fontSize(14)
        .fontWeight(FontWeight.w600),
    itemTitle: TextStyler().color(FortalTokens.gray12()).fontSize(14),
    itemDetail: TextStyler().color(FortalTokens.gray11()).fontSize(12),
    count: TextStyler()
        .color(FortalTokens.gray11())
        .fontSize(12)
        .wrap(.padding(.only(right: 8))),
    indicator: IconStyler().color(FortalTokens.gray12()).size(16),
    pendingStatus: IconStyler().color(FortalTokens.gray9()).size(18),
    activeStatus: IconStyler().color(FortalTokens.accent9()).size(18),
    completedStatus: IconStyler().color(FortalTokens.accent9()).size(18),
    cancelledStatus: IconStyler().color(FortalTokens.gray9()).size(18),
  ).merge(style),
  disclosureStyle: fortalDisclosureStyle(style: disclosureStyle),
);
