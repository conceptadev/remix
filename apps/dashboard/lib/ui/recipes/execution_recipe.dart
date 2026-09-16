import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/card.dart';
import '../components/disclosure.dart';
import '../components/execution.dart';
import '../components/icon_button.dart';
import '../theme/theme.dart';

@immutable
final class UiAgentExecutionRecipe {
  const UiAgentExecutionRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.disclosureStyle,
    required this.copyStyle,
    required this.retryStyle,
  });
  final UiExecutionStyler style;
  final CardStyler surfaceStyle;
  final DisclosureStyler disclosureStyle;
  final IconButtonStyler copyStyle;
  final IconButtonStyler retryStyle;
}

UiAgentExecutionRecipe uiAgentExecutionRecipe({
  UiExecutionStyler style = const UiExecutionStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
  IconButtonStyler copyStyle = const IconButtonStyler.create(),
  IconButtonStyler retryStyle = const IconButtonStyler.create(),
}) => UiAgentExecutionRecipe(
  style: UiExecutionStyler(
    header: FlexBoxStyler().spacing(8),
    output: BoxStyler()
        .color(UiTokens.gray3())
        .borderRadius(.circular(6))
        .padding(.all(12)),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    tool: TextStyler().color(UiTokens.gray11()).fontSize(12),
    title: TextStyler().color(UiTokens.gray12()).fontWeight(FontWeight.w600),
    meta: TextStyler().color(UiTokens.gray11()).fontSize(12),
    status: TextStyler().color(UiTokens.gray11()).fontSize(12),
    toolIcon: IconStyler().color(UiTokens.gray12()).size(16),
    statusIcon: IconStyler().color(UiTokens.accent9()).size(12),
    indicator: IconStyler().color(UiTokens.gray12()).size(16),
  ).merge(style),
  surfaceStyle: uiCardStyle(size: .size2, style: surfaceStyle),
  disclosureStyle: uiDisclosureStyle(style: disclosureStyle),
  copyStyle: uiIconButtonStyle(variant: .ghost, size: .size1, style: copyStyle),
  retryStyle: uiIconButtonStyle(
    variant: .ghost,
    size: .size1,
    style: retryStyle,
  ),
);
