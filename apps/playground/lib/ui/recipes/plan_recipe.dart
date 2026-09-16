import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/disclosure.dart';
import '../components/plan.dart';
import '../theme/tokens.dart';

@immutable
final class PlaygroundAgentPlanRecipe {
  const PlaygroundAgentPlanRecipe({
    required this.style,
    required this.disclosureStyle,
  });
  final PlaygroundPlanStyler style;
  final DisclosureStyler disclosureStyle;
}

PlaygroundAgentPlanRecipe playgroundAgentPlanRecipe({
  PlaygroundPlanStyler style = const PlaygroundPlanStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
}) => PlaygroundAgentPlanRecipe(
  style: PlaygroundPlanStyler(
    viewport: BoxStyler().maxHeight(220),
    item: FlexBoxStyler().spacing(6).padding(.symmetric(vertical: 6)),
    summaryTitle: TextStyler()
        .color(PlaygroundTokens.foreground())
        .fontSize(14)
        .fontWeight(FontWeight.w600),
    itemTitle: TextStyler().color(PlaygroundTokens.foreground()).fontSize(14),
    itemDetail: TextStyler()
        .color(PlaygroundTokens.mutedForeground())
        .fontSize(12),
    count: TextStyler()
        .color(PlaygroundTokens.mutedForeground())
        .fontSize(12)
        .wrap(.padding(.only(right: 8))),
    indicator: IconStyler().color(PlaygroundTokens.foreground()).size(16),
    pendingStatus: IconStyler()
        .color(PlaygroundTokens.mutedForeground())
        .size(18),
    activeStatus: IconStyler().color(PlaygroundTokens.primary()).size(18),
    completedStatus: IconStyler().color(PlaygroundTokens.primary()).size(18),
    cancelledStatus: IconStyler()
        .color(PlaygroundTokens.mutedForeground())
        .size(18),
  ).merge(style),
  disclosureStyle: playgroundDisclosureStyle(style: disclosureStyle),
);
