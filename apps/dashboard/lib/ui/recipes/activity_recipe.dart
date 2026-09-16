import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/activity.dart';
import '../components/disclosure.dart';
import '../theme/theme.dart';

@immutable
final class UiAgentActivityRecipe {
  const UiAgentActivityRecipe({
    required this.style,
    required this.disclosureStyle,
  });
  final UiActivityStyler style;
  final DisclosureStyler disclosureStyle;
}

UiAgentActivityRecipe uiAgentActivityRecipe({
  UiActivityStyler style = const UiActivityStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
}) => UiAgentActivityRecipe(
  style: UiActivityStyler(
    viewport: BoxStyler().maxHeight(200),
    item: FlexBoxStyler().spacing(6).padding(.symmetric(vertical: 6)),
    summaryTitle: TextStyler()
        .color(UiTokens.gray12())
        .fontSize(14)
        .fontWeight(FontWeight.w600),
    itemTitle: TextStyler().color(UiTokens.gray12()).fontSize(14),
    itemDetail: TextStyler().color(UiTokens.gray11()).fontSize(12),
    count: TextStyler()
        .color(UiTokens.gray11())
        .fontSize(12)
        .wrap(.padding(.only(right: 8))),
    indicator: IconStyler().color(UiTokens.gray12()).size(16),
    pendingStatus: IconStyler().color(UiTokens.gray9()).size(12),
    activeStatus: IconStyler().color(UiTokens.accent9()).size(12),
    completedStatus: IconStyler().color(UiTokens.accent9()).size(12),
  ).merge(style),
  disclosureStyle: uiDisclosureStyle(
    style: DisclosureStyler()
        .content(BoxStyler().padding(.all(0)))
        .merge(disclosureStyle),
  ),
);
