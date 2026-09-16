import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'checkbox.g.dart';

/// Radix Themes Checkbox size presets.
enum UiCheckboxSize { size1, size2, size3 }

/// Radix Themes Checkbox variants.
enum UiCheckboxVariant { classic, surface, soft }

/// Ui recipe for [RemixCheckbox].
@MixWidget(target: RemixCheckbox.new)
CheckboxStyler uiCheckboxStyle({
  UiCheckboxVariant variant = .surface,
  UiCheckboxSize size = .size2,
  bool highContrast = false,
  CheckboxStyler style = const CheckboxStyler.create(),
}) {
  final metrics = _uiCheckboxMetrics(size);
  final base =
      CheckboxStyler(
        container: .size(
          metrics.size,
          metrics.size,
        ).alignment(.center).borderRadius(.all(metrics.radius)),
        indicator: .size(metrics.indicatorSize),
        containerEffects: RemixBoxEffectsMix(
          behindContent: RemixBoxEffectLayerMix(),
          overContent: RemixBoxEffectLayerMix(),
        ),
      ).onFocusVisible(
        .containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(
              color: UiTokens.focus8(),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            outlineOffset: 2,
          ),
        ),
      );

  return (switch (variant) {
    .classic => _uiCheckboxClassic(base, highContrast),
    .surface => _uiCheckboxSurface(base, highContrast),
    .soft => _uiCheckboxSoft(base, highContrast),
  }).merge(style);
}

/// Ui recipe for [RemixCheckboxGroupItem].
///
/// Combines the mapped checkbox recipe with Radix's size-linked item label
/// typography and `0.5em` label gap. The behavioral group remains layout
/// transparent, so callers continue to own root direction and spacing.
///
/// It exists because `RemixCheckboxGroup` is behavioral and carries no styler,
/// so unlike every other Remix item (menu, select, segmented control, toggle
/// group) there is no parent recipe to push item styling down. Without this,
/// callers hand-attach a styler to each item and a missed one in a loop renders
/// unstyled beside its styled siblings.
@MixWidget(target: RemixCheckboxGroupItem.new)
CheckboxStyler uiCheckboxGroupItemStyle({
  UiCheckboxVariant variant = .surface,
  UiCheckboxSize size = .size2,
  bool highContrast = false,
  CheckboxStyler style = const CheckboxStyler.create(),
}) {
  final checkbox = uiCheckboxStyle(
    variant: variant,
    size: size,
    highContrast: highContrast,
  );

  return (switch (size) {
    .size1 =>
      checkbox
          .label(.style(UiTokens.text1.mix()))
          .labelSpacing(UiTokens.checkboxGroupItemGap1()),
    .size2 =>
      checkbox
          .label(.style(UiTokens.text2.mix()))
          .labelSpacing(UiTokens.checkboxGroupItemGap2()),
    .size3 =>
      checkbox
          .label(.style(UiTokens.text3.mix()))
          .labelSpacing(UiTokens.checkboxGroupItemGap3()),
  }).merge(style);
}

({double size, double indicatorSize, Radius radius}) _uiCheckboxMetrics(
  UiCheckboxSize size,
) => switch (size) {
  .size1 => (
    size: UiTokens.checkboxSize1(),
    indicatorSize: UiTokens.checkboxIndicatorSize1(),
    radius: UiTokens.checkboxRadius1(),
  ),
  .size2 => (
    size: UiTokens.space4(),
    indicatorSize: UiTokens.checkboxIndicatorSize2(),
    radius: UiTokens.radius1(),
  ),
  .size3 => (
    size: UiTokens.checkboxSize3(),
    indicatorSize: UiTokens.checkboxIndicatorSize3(),
    radius: UiTokens.checkboxRadius3(),
  ),
};

CheckboxStyler _uiCheckboxSurface(CheckboxStyler base, bool highContrast) {
  final selected = CheckboxStyler()
      .color(highContrast ? UiTokens.accent12() : UiTokens.accentIndicator())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
      )
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          RemixBoxEffectLayerMix(shadows: const []),
        ),
      )
      .indicatorColor(
        highContrast ? UiTokens.accent1() : UiTokens.accentContrast(),
      );

  return base
      .color(UiTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
      )
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          uiInsetSurface(strokes: [UiTokens.grayA7()]),
        ),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        .color(UiTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
            )
            .containerEffects(
              RemixBoxEffectsMix.overContent(
                uiInsetSurface(strokes: [UiTokens.grayA6()]),
              ),
            )
            .indicatorColor(UiTokens.grayA8()),
      );
}

CheckboxStyler _uiCheckboxClassic(CheckboxStyler base, bool highContrast) {
  final selected = CheckboxStyler()
      .color(highContrast ? UiTokens.accent12() : UiTokens.accentIndicator())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(
          RemixBoxEffectLayerMix(
            gradients: [
              RemixLinearGradientMix(
                colors: [
                  UiTokens.whiteA3(),
                  const Color(0x00000000),
                  UiTokens.blackA1(),
                ],
              ),
            ],
            shadows: [
              RemixBoxShadowMix(
                kind: .inset,
                color: UiTokens.whiteA4(),
                offset: const Offset(0, 0.5),
                blurRadius: 0.5,
              ),
              RemixBoxShadowMix(
                kind: .inset,
                color: UiTokens.blackA4(),
                offset: const Offset(0, -0.5),
                blurRadius: 0.5,
              ),
            ],
          ),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          RemixBoxEffectLayerMix(shadows: const []),
        ),
      )
      .indicatorColor(
        highContrast ? UiTokens.accent1() : UiTokens.accentContrast(),
      );

  return base
      .color(UiTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(
          RemixBoxEffectLayerMix(shadowToken: UiTokens.shadow1Layers),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          uiInsetSurface(strokes: [UiTokens.grayA3()]),
        ),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        .color(UiTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix.behindContent(
                RemixBoxEffectLayerMix(
                  gradients: const [],
                  shadowToken: UiTokens.shadow1Layers,
                ),
              ),
            )
            .containerEffects(
              RemixBoxEffectsMix.overContent(
                RemixBoxEffectLayerMix(shadows: const []),
              ),
            )
            .indicatorColor(UiTokens.grayA8()),
      );
}

CheckboxStyler _uiCheckboxSoft(CheckboxStyler base, bool highContrast) {
  final selected = CheckboxStyler().indicatorColor(
    highContrast ? UiTokens.accent12() : UiTokens.accentA11(),
  );

  return base
      .color(UiTokens.accentA5())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        .color(UiTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
            )
            .indicatorColor(UiTokens.grayA8()),
      );
}
