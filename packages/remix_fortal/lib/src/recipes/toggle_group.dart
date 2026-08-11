import 'package:flutter/material.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'toggle_group.g.dart';

/// Fortal toggle-group size presets.
enum FortalToggleGroupSize { size1, size2, size3 }

/// Fortal toggle-group color treatments.
enum FortalToggleGroupVariant { soft, surface }

/// Fortal-themed segmented-control preset for [RemixToggleGroup].
@MixWidget(target: RemixToggleGroup.new)
ToggleGroupStyler fortalToggleGroupStyle({
  FortalToggleGroupVariant variant = .soft,
  FortalToggleGroupSize size = .size2,
  bool highContrast = false,
}) {
  final (
    selectedColor,
    selectedHoverColor,
    selectedPressedColor,
  ) = switch (variant) {
    .soft => (
      FortalTokens.accent3(),
      FortalTokens.accent4(),
      FortalTokens.accent5(),
    ),
    .surface => (
      FortalTokens.accentSurface(),
      FortalTokens.accentA4(),
      FortalTokens.accentA5(),
    ),
  };
  final selectedForeground = highContrast
      ? FortalTokens.accent12()
      : FortalTokens.accent11();

  return ToggleGroupStyler(
    container: FlexBoxStyler(
      decoration: BoxDecorationMix(
        border: BorderMix.all(
          BorderSideMix(
            color: FortalTokens.gray7(),
            width: FortalTokens.borderWidth1(),
          ),
        ),
        color: FortalTokens.colorSurface(),
      ),
      clipBehavior: .hardEdge,
      mainAxisSize: .min,
      spacing: 0,
    ),
    item: .alignment(.center)
        .labelColor(FortalTokens.gray11())
        .iconColor(FortalTokens.gray11())
        .labelFontWeight(FortalTokens.fontWeightMedium())
        .onHovered(ToggleGroupItemStyler().color(FortalTokens.grayA3()))
        .onPressed(ToggleGroupItemStyler().color(FortalTokens.grayA4()))
        .onSelected(
          ToggleGroupItemStyler()
              .color(selectedColor)
              .labelColor(selectedForeground)
              .iconColor(selectedForeground)
              .onHovered(ToggleGroupItemStyler().color(selectedHoverColor))
              .onPressed(ToggleGroupItemStyler().color(selectedPressedColor)),
        )
        .onFocusVisible(ToggleGroupItemStyler().fortalFocusRing())
        .onDisabled(
          ToggleGroupItemStyler()
              .color(FortalTokens.grayA3())
              .labelColor(FortalTokens.gray8())
              .iconColor(FortalTokens.gray8()),
        ),
  ).merge(_fortalToggleGroupSizeStyler(size));
}

ToggleGroupStyler _fortalToggleGroupSizeStyler(FortalToggleGroupSize size) {
  return switch (size) {
    .size1 => ToggleGroupStyler(
      container: FlexBoxStyler().borderRadius(.all(FortalTokens.radius2())),
      item:
          .container(
                FlexBoxStyler()
                    .padding(.horizontal(FortalTokens.space2()))
                    .padding(.vertical(FortalTokens.space1()))
                    .spacing(FortalTokens.toggleGap1()),
              )
              .label(.style(FortalTokens.text1.mix()))
              .icon(.size(FortalTokens.space3())),
    ),
    .size2 => ToggleGroupStyler(
      container: FlexBoxStyler().borderRadius(.all(FortalTokens.radius2())),
      item:
          .container(
                FlexBoxStyler()
                    .padding(.horizontal(FortalTokens.space3()))
                    .padding(.vertical(FortalTokens.space2()))
                    .spacing(FortalTokens.space1()),
              )
              .label(.style(FortalTokens.text2.mix()))
              .icon(.size(FortalTokens.space4())),
    ),
    .size3 => ToggleGroupStyler(
      container: FlexBoxStyler().borderRadius(.all(FortalTokens.radius3())),
      item:
          .container(
                FlexBoxStyler()
                    .padding(.horizontal(FortalTokens.space4()))
                    .padding(.vertical(FortalTokens.space2()))
                    .spacing(FortalTokens.toggleGap3()),
              )
              .label(.style(FortalTokens.text3.mix()))
              .icon(.size(FortalTokens.spinnerSize3())),
    ),
  };
}
