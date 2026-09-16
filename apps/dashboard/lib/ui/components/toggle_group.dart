import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'toggle_group.g.dart';

/// Ui toggle-group size presets.
enum UiToggleGroupSize { size1, size2, size3 }

/// Ui toggle-group color treatments.
enum UiToggleGroupVariant { soft, surface }

/// Ui-themed segmented-control preset for [RemixToggleGroup].
@MixWidget(target: RemixToggleGroup.new)
ToggleGroupStyler uiToggleGroupStyle({
  UiToggleGroupVariant variant = .soft,
  UiToggleGroupSize size = .size2,
  bool highContrast = false,
  ToggleGroupStyler style = const ToggleGroupStyler.create(),
}) {
  final (
    selectedColor,
    selectedHoverColor,
    selectedPressedColor,
  ) = switch (variant) {
    .soft => (UiTokens.accent3(), UiTokens.accent4(), UiTokens.accent5()),
    .surface => (
      UiTokens.accentSurface(),
      UiTokens.accentA4(),
      UiTokens.accentA5(),
    ),
  };
  final selectedForeground = highContrast
      ? UiTokens.accent12()
      : UiTokens.accent11();

  return ToggleGroupStyler(
    container: FlexBoxStyler(
      decoration: BoxDecorationMix(
        border: BorderMix.all(
          BorderSideMix(
            color: UiTokens.gray7(),
            width: UiTokens.borderWidth1(),
          ),
        ),
        color: UiTokens.colorSurface(),
      ),
      clipBehavior: .hardEdge,
      mainAxisSize: .min,
      spacing: 0,
    ),
    item: .alignment(.center)
        .labelColor(UiTokens.gray11())
        .iconColor(UiTokens.gray11())
        .labelFontWeight(UiTokens.fontWeightMedium())
        .onHovered(ToggleGroupItemStyler().color(UiTokens.grayA3()))
        .onPressed(ToggleGroupItemStyler().color(UiTokens.grayA4()))
        .onSelected(
          ToggleGroupItemStyler()
              .color(selectedColor)
              .labelColor(selectedForeground)
              .iconColor(selectedForeground)
              .onHovered(ToggleGroupItemStyler().color(selectedHoverColor))
              .onPressed(ToggleGroupItemStyler().color(selectedPressedColor)),
        )
        .onFocusVisible(ToggleGroupItemStyler().uiFocusRing())
        .onDisabled(
          ToggleGroupItemStyler()
              .color(UiTokens.grayA3())
              .labelColor(UiTokens.gray8())
              .iconColor(UiTokens.gray8()),
        ),
  ).merge(_uiToggleGroupSizeStyler(size)).merge(style);
}

ToggleGroupStyler _uiToggleGroupSizeStyler(UiToggleGroupSize size) {
  return switch (size) {
    .size1 => ToggleGroupStyler(
      container: FlexBoxStyler().borderRadius(.all(UiTokens.radius2())),
      item: .container(
        FlexBoxStyler()
            .padding(.horizontal(UiTokens.space2()))
            .padding(.vertical(UiTokens.space1()))
            .spacing(UiTokens.toggleGap1()),
      ).label(.style(UiTokens.text1.mix())).icon(.size(UiTokens.space3())),
    ),
    .size2 => ToggleGroupStyler(
      container: FlexBoxStyler().borderRadius(.all(UiTokens.radius2())),
      item: .container(
        FlexBoxStyler()
            .padding(.horizontal(UiTokens.space3()))
            .padding(.vertical(UiTokens.space2()))
            .spacing(UiTokens.space1()),
      ).label(.style(UiTokens.text2.mix())).icon(.size(UiTokens.space4())),
    ),
    .size3 => ToggleGroupStyler(
      container: FlexBoxStyler().borderRadius(.all(UiTokens.radius3())),
      item:
          .container(
                FlexBoxStyler()
                    .padding(.horizontal(UiTokens.space4()))
                    .padding(.vertical(UiTokens.space2()))
                    .spacing(UiTokens.toggleGap3()),
              )
              .label(.style(UiTokens.text3.mix()))
              .icon(.size(UiTokens.spinnerSize3())),
    ),
  };
}
