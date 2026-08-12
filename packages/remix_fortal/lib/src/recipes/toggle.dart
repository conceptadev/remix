import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'toggle.g.dart';

/// Fortal toggle size presets.
enum FortalToggleSize { size1, size2, size3 }

/// Fortal toggle color and border variants.
enum FortalToggleVariant { ghost, outline }

/// Fortal-themed preset for [RemixToggle].
@MixWidget(target: RemixToggle.new)
ToggleStyler fortalToggleStyle({
  FortalToggleVariant variant = .ghost,
  FortalToggleSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .ghost => _fortalToggleGhostStyler(size, highContrast: highContrast),
    .outline => _fortalToggleOutlineStyler(size, highContrast: highContrast),
  };
}

ToggleStyler _fortalToggleBaseStyler(FortalToggleSize size) {
  return ToggleStyler()
      .container(.mainAxisSize(.min))
      .labelColor(FortalTokens.gray12())
      .iconColor(FortalTokens.gray12())
      .labelFontWeight(FortalTokens.fontWeightMedium())
      .merge(_fortalToggleSizeStyler(size));
}

ToggleStyler _fortalToggleFocusStyler() => ToggleStyler().fortalFocusRing();

ToggleStyler _fortalToggleDisabledStyler({bool outlined = false}) {
  final style = ToggleStyler()
      .color(FortalTokens.grayA3())
      .labelColor(FortalTokens.gray8())
      .iconColor(FortalTokens.gray8());
  return outlined
      ? style.border(
          .color(FortalTokens.grayA6())
              .width(FortalTokens.borderWidth1())
              .strokeAlign(BorderSide.strokeAlignInside),
        )
      : style;
}

ToggleStyler _fortalToggleGhostStyler(
  FortalToggleSize size, {
  required bool highContrast,
}) {
  final selectedContent = highContrast
      ? FortalTokens.accent12()
      : FortalTokens.accent11();
  return _fortalToggleBaseStyler(size)
      .color(const Color(0x00000000))
      .onHovered(ToggleStyler().color(FortalTokens.grayA3()))
      .onPressed(ToggleStyler().color(FortalTokens.grayA4()))
      .onSelected(
        ToggleStyler()
            .color(FortalTokens.accent3())
            .labelColor(selectedContent)
            .iconColor(selectedContent)
            .onHovered(ToggleStyler().color(FortalTokens.accent4()))
            .onPressed(ToggleStyler().color(FortalTokens.accent5())),
      )
      .onFocusVisible(_fortalToggleFocusStyler())
      .onDisabled(_fortalToggleDisabledStyler());
}

ToggleStyler _fortalToggleOutlineStyler(
  FortalToggleSize size, {
  required bool highContrast,
}) {
  final selectedContent = highContrast
      ? FortalTokens.accent12()
      : FortalTokens.accent11();
  return _fortalToggleBaseStyler(size)
      .color(const Color(0x00000000))
      .border(
        .color(FortalTokens.gray7())
            .width(FortalTokens.borderWidth1())
            .strokeAlign(BorderSide.strokeAlignInside),
      )
      .onHovered(ToggleStyler().color(FortalTokens.grayA3()))
      .onPressed(ToggleStyler().color(FortalTokens.grayA4()))
      .onSelected(
        ToggleStyler()
            .color(FortalTokens.accentA3())
            .labelColor(selectedContent)
            .iconColor(selectedContent)
            .border(.color(FortalTokens.accentA5()))
            .onHovered(ToggleStyler().color(FortalTokens.accentA4()))
            .onPressed(ToggleStyler().color(FortalTokens.accentA5())),
      )
      .onFocusVisible(_fortalToggleFocusStyler())
      .onDisabled(_fortalToggleDisabledStyler(outlined: true));
}

ToggleStyler _fortalToggleSizeStyler(FortalToggleSize size) {
  return switch (size) {
    .size1 => ToggleStyler(
      container: FlexBoxStyler()
          .padding(.horizontal(FortalTokens.space2()))
          .padding(.vertical(FortalTokens.space1()))
          .borderRadius(.all(FortalTokens.radius2()))
          .spacing(FortalTokens.toggleGap1()),
      label: .style(FortalTokens.text1.mix()),
      icon: .size(FortalTokens.space3()),
    ),
    .size2 => ToggleStyler(
      container: FlexBoxStyler()
          .padding(.horizontal(FortalTokens.space3()))
          .padding(.vertical(FortalTokens.space2()))
          .borderRadius(.all(FortalTokens.radius2()))
          .spacing(FortalTokens.space1()),
      label: .style(FortalTokens.text2.mix()),
      icon: .size(FortalTokens.space4()),
    ),
    .size3 => ToggleStyler(
      container: FlexBoxStyler()
          .padding(.horizontal(FortalTokens.space4()))
          .padding(.vertical(FortalTokens.space2()))
          .borderRadius(.all(FortalTokens.radius3()))
          .spacing(FortalTokens.toggleGap3()),
      label: .style(FortalTokens.text3.mix()),
      icon: .size(FortalTokens.spinnerSize3()),
    ),
  };
}
