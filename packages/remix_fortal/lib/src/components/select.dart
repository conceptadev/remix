import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'select.g.dart';

/// Radix Themes Select root size presets.
enum FortalSelectSize { size1, size2, size3 }

/// Radix Themes Select variants.
enum FortalSelectVariant { surface, soft, ghost }

/// Fortal-themed Select with Radix-owned trigger and content configuration.
@MixWidget(target: RemixSelect.new)
SelectStyler fortalSelectStyle({
  FortalSelectVariant variant = .surface,
  FortalSelectSize size = .size2,
  bool highContrast = false,
  SelectStyler style = const SelectStyler.create(),
}) {
  return SelectStyler()
      .trigger(_fortalSelectTriggerStyler(variant, size))
      .content(_fortalSelectContentStyler(size))
      .item(_fortalSelectItemStyler(variant, size, highContrast: highContrast))
      .merge(style);
}

/// Creates the established combined-variant Select item recipe.
SelectMenuItemStyler fortalSelectMenuItemStyle({
  FortalSelectVariant variant = .surface,
  FortalSelectSize size = .size2,
  bool highContrast = false,
}) => _fortalSelectItemStyler(variant, size, highContrast: highContrast);

SelectTriggerStyler _fortalSelectTriggerStyler(
  FortalSelectVariant variant,
  FortalSelectSize size,
) {
  final radius = _fortalSelectTriggerRadius(size);
  final base = SelectTriggerStyler()
      .direction(.horizontal)
      .mainAxisAlignment(.spaceBetween)
      .borderRadius(.all(radius))
      .label(_fortalSelectTriggerText(size, color: FortalTokens.gray12()))
      .placeholder(
        _fortalSelectTriggerText(size, color: FortalTokens.grayA10()),
      )
      .icon(.color(FortalTokens.gray12()))
      .indicator(.color(FortalTokens.gray12()).size(size == .size3 ? 11 : 9))
      .onFocusVisible(
        .containerEffects(
          RemixBoxEffectsMix.overContent(_fortalSelectFocusRing()),
        ),
      )
      .merge(_fortalSelectTriggerSizeStyler(variant, size));

  return switch (variant) {
    .surface => _fortalSelectSurfaceTrigger(base),
    .soft => _fortalSelectSoftTrigger(base),
    .ghost => _fortalSelectGhostTrigger(base),
  };
}

TextStyler _fortalSelectTriggerText(FortalSelectSize size, {Color? color}) {
  final token = switch (size) {
    .size1 => FortalTokens.text1,
    .size2 => FortalTokens.text2,
    .size3 => FortalTokens.text3,
  };
  return TextStyler(style: token.mix())
      .fontWeight(FortalTokens.fontWeightRegular())
      .color(color ?? FortalTokens.gray12());
}

Radius _fortalSelectTriggerRadius(FortalSelectSize size) => switch (size) {
  .size1 => FortalTokens.radius1OrFull(),
  .size2 => FortalTokens.radius2OrFull(),
  .size3 => FortalTokens.radius3OrFull(),
};

SelectTriggerStyler _fortalSelectTriggerSizeStyler(
  FortalSelectVariant variant,
  FortalSelectSize size,
) {
  final style = SelectTriggerStyler().spacing(switch (size) {
    .size1 => FortalTokens.space1(),
    .size2 => FortalTokens.selectSpace1Half(),
    .size3 => FortalTokens.space2(),
  });
  return switch (variant) {
    .ghost => switch (size) {
      .size1 || .size2 =>
        style
            .padding(.horizontal(FortalTokens.space2()))
            .padding(.vertical(FortalTokens.space1()))
            .margin(.horizontal(FortalTokens.selectGhostMarginX12()))
            .margin(.vertical(FortalTokens.selectGhostMarginY12())),
      .size3 =>
        style
            .padding(.horizontal(FortalTokens.space3()))
            .padding(.vertical(FortalTokens.selectSpace1Half()))
            .margin(.horizontal(FortalTokens.selectGhostMarginX3()))
            .margin(.vertical(FortalTokens.selectGhostMarginY3())),
    },
    .surface || .soft => switch (size) {
      .size1 =>
        style
            .height(FortalTokens.space5())
            .padding(.horizontal(FortalTokens.space2())),
      .size2 =>
        style
            .height(FortalTokens.space6())
            .padding(.horizontal(FortalTokens.space3())),
      .size3 =>
        style
            .height(FortalTokens.space7())
            .padding(.horizontal(FortalTokens.space4())),
    },
  };
}

RemixBoxEffectLayerMix _fortalSelectFocusRing() {
  return RemixBoxEffectLayerMix(
    shadows: [
      RemixBoxShadowMix(color: FortalTokens.focus8(), spreadRadius: 1),
      RemixBoxShadowMix(
        kind: RemixBoxShadowKind.inset,
        color: FortalTokens.focus8(),
        spreadRadius: 1,
      ),
    ],
  );
}

SelectTriggerStyler _fortalSelectSurfaceTrigger(SelectTriggerStyler base) {
  return base
      .indicatorOpacity(0.9)
      .color(FortalTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(
          fortalInsetSurface(strokes: [FortalTokens.grayA7()]),
        ),
      )
      .onHovered(
        .containerEffects(
          RemixBoxEffectsMix.behindContent(
            fortalInsetSurface(strokes: [FortalTokens.grayA8()]),
          ),
        ),
      )
      .onSelected(
        .containerEffects(
          RemixBoxEffectsMix.behindContent(
            fortalInsetSurface(strokes: [FortalTokens.grayA8()]),
          ),
        ),
      )
      .onDisabled(
        .color(FortalTokens.grayA2())
            .label(.color(FortalTokens.grayA11()))
            .icon(.color(FortalTokens.grayA9()))
            .indicator(.color(FortalTokens.grayA9()))
            .containerEffects(
              RemixBoxEffectsMix.behindContent(
                fortalInsetSurface(strokes: [FortalTokens.grayA6()]),
              ),
            ),
      );
}

SelectTriggerStyler _fortalSelectSoftTrigger(SelectTriggerStyler base) {
  return base
      .label(.color(FortalTokens.accent12()))
      .placeholder(.color(FortalTokens.accent12()))
      .placeholderOpacity(0.6)
      .icon(.color(FortalTokens.accent12()))
      .indicator(.color(FortalTokens.accent12()))
      .color(FortalTokens.accentA3())
      .onHovered(.color(FortalTokens.accentA4()))
      .onSelected(.color(FortalTokens.accentA4()))
      .onDisabled(
        .label(.color(FortalTokens.grayA11()))
            .icon(.color(FortalTokens.grayA9()))
            .indicator(.color(FortalTokens.grayA9()))
            .color(FortalTokens.grayA3()),
      );
}

SelectTriggerStyler _fortalSelectGhostTrigger(SelectTriggerStyler base) {
  return base
      .label(.color(FortalTokens.accent12()))
      .placeholder(.color(FortalTokens.accent12()))
      .placeholderOpacity(0.6)
      .icon(.color(FortalTokens.accent12()))
      .indicator(.color(FortalTokens.accent12()))
      .color(const Color(0x00000000))
      .onHovered(.color(FortalTokens.accentA3()))
      .onSelected(.color(FortalTokens.accentA3()))
      .onDisabled(
        .label(.color(FortalTokens.grayA11()))
            .icon(.color(FortalTokens.grayA9()))
            .indicator(.color(FortalTokens.grayA9()))
            .color(const Color(0x00000000)),
      );
}

SelectContentStyler _fortalSelectContentStyler(FortalSelectSize size) {
  final radius = switch (size) {
    .size1 => FortalTokens.radius3(),
    .size2 || .size3 => FortalTokens.radius4(),
  };
  return SelectContentStyler()
      .padding(
        .all(switch (size) {
          .size1 => FortalTokens.space1(),
          .size2 || .size3 => FortalTokens.space2(),
        }),
      )
      .borderRadius(.all(radius))
      .color(FortalTokens.colorPanel())
      .decoration(
        BoxDecorationMix.create(boxShadow: FortalTokens.shadow5.mix()),
      )
      .clipBehavior(Clip.antiAlias)
      .containerEffects(
        RemixBoxEffectsMix.backdropBlur(FortalTokens.panelBlur()),
      );
}

SelectMenuItemStyler _fortalSelectItemStyler(
  FortalSelectVariant variant,
  FortalSelectSize size, {
  bool highContrast = false,
}) {
  final metrics = _fortalSelectContentMetrics(size);
  final base = SelectMenuItemStyler()
      .direction(.horizontal)
      .height(metrics.itemHeight)
      .padding(.horizontal(metrics.indicatorWidth))
      .borderRadius(.all(metrics.itemRadius))
      .text(
        TextStyler(style: metrics.itemText.mix()).color(FortalTokens.gray12()),
      )
      .indicator(
        BoxStyler(
          alignment: .center,
          constraints: BoxConstraintsMix.width(metrics.indicatorWidth),
        ),
      )
      .icon(
        IconStyler(color: FortalTokens.gray12(), size: metrics.indicatorSize),
      );

  final highlighted = switch (variant) {
    .surface || .ghost =>
      SelectMenuItemStyler()
          .color(
            highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
          )
          .text(
            TextStyler().color(
              highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
          )
          .iconColor(
            highContrast
                ? FortalTokens.accent1()
                : FortalTokens.accentContrast(),
          ),
    .soft => SelectMenuItemStyler().color(FortalTokens.accentA4()),
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
        ).text(.color(FortalTokens.grayA8())).iconColor(FortalTokens.grayA8()),
      );
}

({
  double itemHeight,
  double indicatorWidth,
  double indicatorSize,
  Radius itemRadius,
  TextStyleToken itemText,
})
_fortalSelectContentMetrics(FortalSelectSize size) => switch (size) {
  .size1 => (
    itemHeight: FortalTokens.space5(),
    indicatorWidth: FortalTokens.selectIndicatorWidth1(),
    indicatorSize: FortalTokens.selectIndicatorSize1(),
    itemRadius: FortalTokens.radius1(),
    itemText: FortalTokens.text1,
  ),
  .size2 => (
    itemHeight: FortalTokens.space6(),
    indicatorWidth: FortalTokens.space5(),
    indicatorSize: FortalTokens.selectIndicatorSize2(),
    itemRadius: FortalTokens.radius2(),
    itemText: FortalTokens.text2,
  ),
  .size3 => (
    itemHeight: FortalTokens.space6(),
    indicatorWidth: FortalTokens.space5(),
    indicatorSize: FortalTokens.selectIndicatorSize2(),
    itemRadius: FortalTokens.radius2(),
    itemText: FortalTokens.text3,
  ),
};
