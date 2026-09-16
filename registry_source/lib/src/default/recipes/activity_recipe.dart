import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import '../../agent/components/activity.dart';

import '../components/disclosure.dart';
import '../theme/tokens.dart';

@immutable
final class VanillaAgentActivityRecipe {
  const VanillaAgentActivityRecipe({
    required this.style,
    required this.disclosureStyle,
  });
  final AgentActivityStyler style;
  final DisclosureStyler disclosureStyle;
}

VanillaAgentActivityRecipe vanillaAgentActivityRecipe({
  AgentActivityStyler style = const AgentActivityStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
}) => VanillaAgentActivityRecipe(
  style: AgentActivityStyler(
    viewport: BoxStyler().maxHeight(200),
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
    pendingStatus: IconStyler().color(VanillaTokens.mutedForeground()).size(12),
    activeStatus: IconStyler().color(VanillaTokens.primary()).size(12),
    completedStatus: IconStyler().color(VanillaTokens.primary()).size(12),
  ).merge(style),
  disclosureStyle: vanillaDisclosureStyle(
    style: DisclosureStyler()
        .content(BoxStyler().padding(.all(0)))
        .merge(disclosureStyle),
  ),
);
