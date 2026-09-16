import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/activity.dart';
import '../components/disclosure.dart';
import '../theme/tokens.dart';

@immutable
final class PlaygroundAgentActivityRecipe {
  const PlaygroundAgentActivityRecipe({
    required this.style,
    required this.disclosureStyle,
  });
  final PlaygroundActivityStyler style;
  final DisclosureStyler disclosureStyle;
}

PlaygroundAgentActivityRecipe playgroundAgentActivityRecipe({
  PlaygroundActivityStyler style = const PlaygroundActivityStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
}) => PlaygroundAgentActivityRecipe(
  style: PlaygroundActivityStyler(
    viewport: BoxStyler().maxHeight(200),
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
        .size(12),
    activeStatus: IconStyler().color(PlaygroundTokens.primary()).size(12),
    completedStatus: IconStyler().color(PlaygroundTokens.primary()).size(12),
  ).merge(style),
  disclosureStyle: playgroundDisclosureStyle(
    style: DisclosureStyler()
        .content(BoxStyler().padding(.all(0)))
        .merge(disclosureStyle),
  ),
);
