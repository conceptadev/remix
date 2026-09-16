import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import '../../agent/components/activity.dart';

import '../components/disclosure.dart';
import '../theme/theme.dart';

@immutable
final class FortalAgentActivityRecipe {
  const FortalAgentActivityRecipe({
    required this.style,
    required this.disclosureStyle,
  });
  final AgentActivityStyler style;
  final DisclosureStyler disclosureStyle;
}

FortalAgentActivityRecipe fortalAgentActivityRecipe({
  AgentActivityStyler style = const AgentActivityStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
}) => FortalAgentActivityRecipe(
  style: AgentActivityStyler(
    viewport: BoxStyler().maxHeight(200),
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
    pendingStatus: IconStyler().color(FortalTokens.gray9()).size(12),
    activeStatus: IconStyler().color(FortalTokens.accent9()).size(12),
    completedStatus: IconStyler().color(FortalTokens.accent9()).size(12),
  ).merge(style),
  disclosureStyle: fortalDisclosureStyle(
    style: DisclosureStyler()
        .content(BoxStyler().padding(.all(0)))
        .merge(disclosureStyle),
  ),
);
