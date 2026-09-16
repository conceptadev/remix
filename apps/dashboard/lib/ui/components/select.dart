import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'select.g.dart';

/// Radix Themes Select root size presets.
enum UiSelectSize { size1, size2, size3 }

/// Radix Themes Select variants.
enum UiSelectVariant { surface, soft, ghost }

/// Ui-themed Select with Radix-owned trigger and content configuration.
///
/// Content icons use size-matched 12/16/20 token defaults rather than the
/// ambient icon size. Override the trigger icon through [style] when needed.
@MixWidget(target: RemixSelect.new)
SelectStyler uiSelectStyle({
  UiSelectVariant variant = .surface,
  UiSelectSize size = .size2,
  bool highContrast = false,
  SelectStyler style = const SelectStyler.create(),
}) {
  return SelectStyler()
      .trigger(_uiSelectTriggerStyler(variant, size))
      .content(_uiSelectContentStyler(size))
      .item(_uiSelectItemStyler(variant, size, highContrast: highContrast))
      .merge(style);
}

/// Creates the established combined-variant Select item recipe.
SelectMenuItemStyler uiSelectMenuItemStyle({
  UiSelectVariant variant = .surface,
  UiSelectSize size = .size2,
  bool highContrast = false,
}) => _uiSelectItemStyler(variant, size, highContrast: highContrast);

SelectTriggerStyler _uiSelectTriggerStyler(
  UiSelectVariant variant,
  UiSelectSize size,
) {
  final radius = _uiSelectTriggerRadius(size);
  final base = SelectTriggerStyler()
      .direction(.horizontal)
      .mainAxisAlignment(.spaceBetween)
      .borderRadius(.all(radius))
      .label(_uiSelectTriggerText(size, color: UiTokens.gray12()))
      .placeholder(_uiSelectTriggerText(size, color: UiTokens.grayA10()))
      .icon(
        .color(UiTokens.gray12()).size(switch (size) {
          .size1 => UiTokens.space3(),
          .size2 => UiTokens.space4(),
          .size3 => UiTokens.spinnerSize3(),
        }),
      )
      .indicator(.color(UiTokens.gray12()).size(size == .size3 ? 11 : 9))
      .onFocusVisible(
        .containerEffects(RemixBoxEffectsMix.overContent(_uiSelectFocusRing())),
      )
      .merge(_uiSelectTriggerSizeStyler(variant, size));

  return switch (variant) {
    .surface => _uiSelectSurfaceTrigger(base),
    .soft => _uiSelectSoftTrigger(base),
    .ghost => _uiSelectGhostTrigger(base),
  };
}

TextStyler _uiSelectTriggerText(UiSelectSize size, {Color? color}) {
  final token = switch (size) {
    .size1 => UiTokens.text1,
    .size2 => UiTokens.text2,
    .size3 => UiTokens.text3,
  };
  return TextStyler(
    style: token.mix(),
  ).fontWeight(UiTokens.fontWeightRegular()).color(color ?? UiTokens.gray12());
}

Radius _uiSelectTriggerRadius(UiSelectSize size) => switch (size) {
  .size1 => UiTokens.radius1OrFull(),
  .size2 => UiTokens.radius2OrFull(),
  .size3 => UiTokens.radius3OrFull(),
};

SelectTriggerStyler _uiSelectTriggerSizeStyler(
  UiSelectVariant variant,
  UiSelectSize size,
) {
  final style = SelectTriggerStyler().spacing(switch (size) {
    .size1 => UiTokens.space1(),
    .size2 => UiTokens.selectSpace1Half(),
    .size3 => UiTokens.space2(),
  });
  return switch (variant) {
    .ghost => switch (size) {
      .size1 || .size2 =>
        style
            .padding(.horizontal(UiTokens.space2()))
            .padding(.vertical(UiTokens.space1()))
            .margin(.horizontal(UiTokens.selectGhostMarginX12()))
            .margin(.vertical(UiTokens.selectGhostMarginY12())),
      .size3 =>
        style
            .padding(.horizontal(UiTokens.space3()))
            .padding(.vertical(UiTokens.selectSpace1Half()))
            .margin(.horizontal(UiTokens.selectGhostMarginX3()))
            .margin(.vertical(UiTokens.selectGhostMarginY3())),
    },
    .surface || .soft => switch (size) {
      .size1 =>
        style.height(UiTokens.space5()).padding(.horizontal(UiTokens.space2())),
      .size2 =>
        style.height(UiTokens.space6()).padding(.horizontal(UiTokens.space3())),
      .size3 =>
        style.height(UiTokens.space7()).padding(.horizontal(UiTokens.space4())),
    },
  };
}

RemixBoxEffectLayerMix _uiSelectFocusRing() {
  return RemixBoxEffectLayerMix(
    shadows: [
      RemixBoxShadowMix(color: UiTokens.focus8(), spreadRadius: 1),
      RemixBoxShadowMix(
        kind: RemixBoxShadowKind.inset,
        color: UiTokens.focus8(),
        spreadRadius: 1,
      ),
    ],
  );
}

SelectTriggerStyler _uiSelectSurfaceTrigger(SelectTriggerStyler base) {
  return base
      .indicatorOpacity(0.9)
      .color(UiTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(
          uiInsetSurface(strokes: [UiTokens.grayA7()]),
        ),
      )
      .onHovered(
        .containerEffects(
          RemixBoxEffectsMix.behindContent(
            uiInsetSurface(strokes: [UiTokens.grayA8()]),
          ),
        ),
      )
      .onSelected(
        .containerEffects(
          RemixBoxEffectsMix.behindContent(
            uiInsetSurface(strokes: [UiTokens.grayA8()]),
          ),
        ),
      )
      .onDisabled(
        .color(UiTokens.grayA2())
            .label(.color(UiTokens.grayA11()))
            .icon(.color(UiTokens.grayA9()))
            .indicator(.color(UiTokens.grayA9()))
            .containerEffects(
              RemixBoxEffectsMix.behindContent(
                uiInsetSurface(strokes: [UiTokens.grayA6()]),
              ),
            ),
      );
}

SelectTriggerStyler _uiSelectSoftTrigger(SelectTriggerStyler base) {
  return base
      .label(.color(UiTokens.accent12()))
      .placeholder(.color(UiTokens.accent12()))
      .placeholderOpacity(0.6)
      .icon(.color(UiTokens.accent12()))
      .indicator(.color(UiTokens.accent12()))
      .color(UiTokens.accentA3())
      .onHovered(.color(UiTokens.accentA4()))
      .onSelected(.color(UiTokens.accentA4()))
      .onDisabled(
        .label(.color(UiTokens.grayA11()))
            .icon(.color(UiTokens.grayA9()))
            .indicator(.color(UiTokens.grayA9()))
            .color(UiTokens.grayA3()),
      );
}

SelectTriggerStyler _uiSelectGhostTrigger(SelectTriggerStyler base) {
  return base
      .label(.color(UiTokens.accent12()))
      .placeholder(.color(UiTokens.accent12()))
      .placeholderOpacity(0.6)
      .icon(.color(UiTokens.accent12()))
      .indicator(.color(UiTokens.accent12()))
      .color(const Color(0x00000000))
      .onHovered(.color(UiTokens.accentA3()))
      .onSelected(.color(UiTokens.accentA3()))
      .onDisabled(
        .label(.color(UiTokens.grayA11()))
            .icon(.color(UiTokens.grayA9()))
            .indicator(.color(UiTokens.grayA9()))
            .color(const Color(0x00000000)),
      );
}

SelectContentStyler _uiSelectContentStyler(UiSelectSize size) {
  final radius = switch (size) {
    .size1 => UiTokens.radius3(),
    .size2 || .size3 => UiTokens.radius4(),
  };
  return SelectContentStyler()
      .padding(
        .all(switch (size) {
          .size1 => UiTokens.space1(),
          .size2 || .size3 => UiTokens.space2(),
        }),
      )
      .borderRadius(.all(radius))
      .color(UiTokens.colorPanel())
      .decoration(BoxDecorationMix.create(boxShadow: UiTokens.shadow5.mix()))
      .clipBehavior(Clip.antiAlias)
      .containerEffects(RemixBoxEffectsMix.backdropBlur(UiTokens.panelBlur()));
}

SelectMenuItemStyler _uiSelectItemStyler(
  UiSelectVariant variant,
  UiSelectSize size, {
  bool highContrast = false,
}) {
  final metrics = _uiSelectContentMetrics(size);
  final base = SelectMenuItemStyler()
      .direction(.horizontal)
      .height(metrics.itemHeight)
      .padding(.horizontal(metrics.indicatorWidth))
      .borderRadius(.all(metrics.itemRadius))
      .text(TextStyler(style: metrics.itemText.mix()).color(UiTokens.gray12()))
      .indicator(
        BoxStyler(
          alignment: .center,
          constraints: BoxConstraintsMix.width(metrics.indicatorWidth),
        ),
      )
      .icon(IconStyler(color: UiTokens.gray12(), size: metrics.indicatorSize));

  final highlighted = switch (variant) {
    .surface || .ghost =>
      SelectMenuItemStyler()
          .color(highContrast ? UiTokens.accent12() : UiTokens.accent9())
          .text(
            TextStyler().color(
              highContrast ? UiTokens.accent1() : UiTokens.accentContrast(),
            ),
          )
          .iconColor(
            highContrast ? UiTokens.accent1() : UiTokens.accentContrast(),
          ),
    .soft => SelectMenuItemStyler().color(UiTokens.accentA4()),
  };

  // Naked's focused option is Radix's roving `data-highlighted` item, not a
  // CSS focus ring, so this intentionally follows raw focus.
  return base
      .onHovered(highlighted)
      .onFocused(highlighted)
      .onPressed(highlighted)
      .onDisabled(
        .color(
          const Color(0x00000000),
        ).text(.color(UiTokens.grayA8())).iconColor(UiTokens.grayA8()),
      );
}

({
  double itemHeight,
  double indicatorWidth,
  double indicatorSize,
  Radius itemRadius,
  TextStyleToken itemText,
})
_uiSelectContentMetrics(UiSelectSize size) => switch (size) {
  .size1 => (
    itemHeight: UiTokens.space5(),
    indicatorWidth: UiTokens.selectIndicatorWidth1(),
    indicatorSize: UiTokens.selectIndicatorSize1(),
    itemRadius: UiTokens.radius1(),
    itemText: UiTokens.text1,
  ),
  .size2 => (
    itemHeight: UiTokens.space6(),
    indicatorWidth: UiTokens.space5(),
    indicatorSize: UiTokens.selectIndicatorSize2(),
    itemRadius: UiTokens.radius2(),
    itemText: UiTokens.text2,
  ),
  .size3 => (
    itemHeight: UiTokens.space6(),
    indicatorWidth: UiTokens.space5(),
    indicatorSize: UiTokens.selectIndicatorSize2(),
    itemRadius: UiTokens.radius2(),
    itemText: UiTokens.text3,
  ),
};
