import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'toggle.g.dart';

/// Ui toggle size presets.
enum UiToggleSize { size1, size2, size3 }

/// Ui toggle color and border variants.
enum UiToggleVariant { ghost, outline }

/// Ui-themed preset for [RemixToggle].
@MixWidget(target: RemixToggle.new)
ToggleStyler uiToggleStyle({
  UiToggleVariant variant = .ghost,
  UiToggleSize size = .size2,
  bool highContrast = false,
  ToggleStyler style = const ToggleStyler.create(),
}) {
  return (switch (variant) {
    .ghost => _uiToggleGhostStyler(size, highContrast: highContrast),
    .outline => _uiToggleOutlineStyler(size, highContrast: highContrast),
  }).merge(style);
}

ToggleStyler _uiToggleBaseStyler(UiToggleSize size) {
  return ToggleStyler()
      .container(.mainAxisSize(.min))
      .labelColor(UiTokens.gray12())
      .iconColor(UiTokens.gray12())
      .labelFontWeight(UiTokens.fontWeightMedium())
      .merge(_uiToggleSizeStyler(size));
}

ToggleStyler _uiToggleFocusStyler() => ToggleStyler().uiFocusRing();

ToggleStyler _uiToggleDisabledStyler({bool outlined = false}) {
  final style = ToggleStyler()
      .color(UiTokens.grayA3())
      .labelColor(UiTokens.gray8())
      .iconColor(UiTokens.gray8());
  return outlined
      ? style.border(
          .color(UiTokens.grayA6())
              .width(UiTokens.borderWidth1())
              .strokeAlign(BorderSide.strokeAlignInside),
        )
      : style;
}

ToggleStyler _uiToggleGhostStyler(
  UiToggleSize size, {
  required bool highContrast,
}) {
  final selectedContent = highContrast
      ? UiTokens.accent12()
      : UiTokens.accent11();
  return _uiToggleBaseStyler(size)
      .color(const Color(0x00000000))
      .onHovered(ToggleStyler().color(UiTokens.grayA3()))
      .onPressed(ToggleStyler().color(UiTokens.grayA4()))
      .onSelected(
        ToggleStyler()
            .color(UiTokens.accent3())
            .labelColor(selectedContent)
            .iconColor(selectedContent)
            .onHovered(ToggleStyler().color(UiTokens.accent4()))
            .onPressed(ToggleStyler().color(UiTokens.accent5())),
      )
      .onFocusVisible(_uiToggleFocusStyler())
      .onDisabled(_uiToggleDisabledStyler());
}

ToggleStyler _uiToggleOutlineStyler(
  UiToggleSize size, {
  required bool highContrast,
}) {
  final selectedContent = highContrast
      ? UiTokens.accent12()
      : UiTokens.accent11();
  return _uiToggleBaseStyler(size)
      .color(const Color(0x00000000))
      .border(
        .color(UiTokens.gray7())
            .width(UiTokens.borderWidth1())
            .strokeAlign(BorderSide.strokeAlignInside),
      )
      .onHovered(ToggleStyler().color(UiTokens.grayA3()))
      .onPressed(ToggleStyler().color(UiTokens.grayA4()))
      .onSelected(
        ToggleStyler()
            .color(UiTokens.accentA3())
            .labelColor(selectedContent)
            .iconColor(selectedContent)
            .border(.color(UiTokens.accentA5()))
            .onHovered(ToggleStyler().color(UiTokens.accentA4()))
            .onPressed(ToggleStyler().color(UiTokens.accentA5())),
      )
      .onFocusVisible(_uiToggleFocusStyler())
      .onDisabled(_uiToggleDisabledStyler(outlined: true));
}

ToggleStyler _uiToggleSizeStyler(UiToggleSize size) {
  return switch (size) {
    .size1 => ToggleStyler(
      container: FlexBoxStyler()
          .padding(.horizontal(UiTokens.space2()))
          .padding(.vertical(UiTokens.space1()))
          .borderRadius(.all(UiTokens.radius2()))
          .spacing(UiTokens.toggleGap1()),
      label: .style(UiTokens.text1.mix()),
      icon: .size(UiTokens.space3()),
    ),
    .size2 => ToggleStyler(
      container: FlexBoxStyler()
          .padding(.horizontal(UiTokens.space3()))
          .padding(.vertical(UiTokens.space2()))
          .borderRadius(.all(UiTokens.radius2()))
          .spacing(UiTokens.space1()),
      label: .style(UiTokens.text2.mix()),
      icon: .size(UiTokens.space4()),
    ),
    .size3 => ToggleStyler(
      container: FlexBoxStyler()
          .padding(.horizontal(UiTokens.space4()))
          .padding(.vertical(UiTokens.space2()))
          .borderRadius(.all(UiTokens.radius3()))
          .spacing(UiTokens.toggleGap3()),
      label: .style(UiTokens.text3.mix()),
      icon: .size(UiTokens.spinnerSize3()),
    ),
  };
}
