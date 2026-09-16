import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import '../../agent/components/answer.dart';

import '../components/card.dart';
import '../components/disclosure.dart';
import '../components/icon_button.dart';
import '../theme/theme.dart';

@immutable
final class FortalAgentAnswerRecipe {
  const FortalAgentAnswerRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.sourcesStyle,
    required this.copyStyle,
    required this.retryStyle,
  });
  final AgentAnswerStyler style;
  final CardStyler surfaceStyle;
  final DisclosureStyler sourcesStyle;
  final IconButtonStyler copyStyle;
  final IconButtonStyler retryStyle;
}

FortalAgentAnswerRecipe fortalAgentAnswerRecipe({
  AgentAnswerStyler style = const AgentAnswerStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler sourcesStyle = const DisclosureStyler.create(),
  IconButtonStyler copyStyle = const IconButtonStyler.create(),
  IconButtonStyler retryStyle = const IconButtonStyler.create(),
}) => FortalAgentAnswerRecipe(
  style: AgentAnswerStyler(
    body: BoxStyler(),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    feedback: BoxStyler().padding(.only(top: 6)),
    sourcesLabel: TextStyler().color(FortalTokens.gray12()).fontSize(13),
    indicator: IconStyler().color(FortalTokens.gray12()).size(16),
  ).merge(style),
  surfaceStyle: fortalCardStyle(size: .size2, style: surfaceStyle),
  sourcesStyle: fortalDisclosureStyle(style: sourcesStyle),
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
