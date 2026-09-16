import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'accordion.g.dart';

/// Ui accordion size presets.
enum UiAccordionSize { size1, size2, size3 }

/// Ui accordion color variants.
enum UiAccordionVariant { surface, soft }

/// Ui-themed preset for [RemixAccordion].
@MixWidget(target: RemixAccordion.new)
AccordionStyler uiAccordionStyle({
  UiAccordionVariant variant = .surface,
  UiAccordionSize size = .size2,
  AccordionStyler style = const AccordionStyler.create(),
}) {
  return (switch (variant) {
    .surface => _uiAccordionSurfaceStyler(size),
    .soft => _uiAccordionSoftStyler(size),
  }).merge(style);
}

// Panel anatomy follows the mapped Table family (see data_table.dart):
// `container` alone owns radius, frame, fill, and clipping, while trigger and
// content stay flat rectangles that simply get cropped to its rounded shape.
// The frame and divider are foreground borders so edge-to-edge child fills
// cannot partially cover their antialiased edges.
AccordionStyler _uiAccordionBaseStyler(UiAccordionSize size) {
  return AccordionStyler()
      .trigger(.direction(.horizontal))
      .leadingIcon(.color(UiTokens.gray11()))
      .title(.fontWeight(UiTokens.fontWeightMedium()).color(UiTokens.gray12()))
      .trailingIcon(.color(UiTokens.gray11()))
      .content(.width(.infinity))
      .merge(_uiAccordionSizeStyler(size));
}

AccordionStyler _uiAccordionFocusStyler() {
  return AccordionStyler().trigger(FlexBoxStyler().uiFocusRing());
}

AccordionStyler _uiAccordionDisabledStyler() {
  return AccordionStyler()
      .trigger(.color(UiTokens.grayA3()))
      .leadingIcon(.color(UiTokens.gray8()))
      .title(.color(UiTokens.gray8()))
      .trailingIcon(.color(UiTokens.gray8()));
}

AccordionStyler _uiAccordionSurfaceStyler([UiAccordionSize size = .size2]) {
  return _uiAccordionBaseStyler(size)
      .container(
        uiSurfaceFrame(
          fillColor: UiTokens.gray2(),
          borderColor: UiTokens.gray6(),
          borderWidth: UiTokens.borderWidth1(),
          radius: _uiAccordionRadius(size),
        ),
      )
      .trigger(.color(UiTokens.gray1()))
      .content(
        BoxStyler()
            .foregroundDecoration(
              BoxDecorationMix(
                border: BoxBorderMix.top(
                  _uiAccordionBorderSide(UiTokens.gray6()),
                ),
              ),
            )
            .wrap(_uiAccordionContentTypography(UiTokens.gray12())),
      )
      .onHovered(.trigger(.color(UiTokens.gray2())))
      .onPressed(.trigger(.color(UiTokens.gray3())))
      .onFocusVisible(_uiAccordionFocusStyler())
      .onDisabled(_uiAccordionDisabledStyler());
}

AccordionStyler _uiAccordionSoftStyler([UiAccordionSize size = .size2]) {
  return _uiAccordionBaseStyler(size)
      .container(
        uiSurfaceFrame(
          fillColor: UiTokens.accent2(),
          borderColor: UiTokens.accent6(),
          borderWidth: UiTokens.borderWidth1(),
          radius: _uiAccordionRadius(size),
        ),
      )
      .trigger(.color(UiTokens.accent2()))
      .title(.color(UiTokens.accent12()))
      .trailingIcon(.color(UiTokens.accent11()))
      .content(
        BoxStyler()
            .foregroundDecoration(
              BoxDecorationMix(
                border: BoxBorderMix.top(
                  _uiAccordionBorderSide(UiTokens.accent6()),
                ),
              ),
            )
            .wrap(_uiAccordionContentTypography(UiTokens.accent12())),
      )
      .onHovered(.trigger(.color(UiTokens.accent3())))
      .onPressed(.trigger(.color(UiTokens.accent4())))
      .onFocusVisible(_uiAccordionFocusStyler())
      .onDisabled(_uiAccordionDisabledStyler());
}

/// The 1px edge shared by the panel's outer border and the trigger/content
/// divider, so the seam reads as a continuation of the frame rather than an
/// unrelated line.
BorderSideMix _uiAccordionBorderSide(Color color) =>
    BorderSideMix(color: color, width: UiTokens.borderWidth1());

/// Pins bare [Text] accordion content to the 14px type-scale step (`text2`)
/// regardless of accordion size, so content never renders larger than its own
/// trigger's title (measured 14/15/16px at size1/size2/size3). Ui text
/// children pin their own run. [color] supplies the variant's own content tint.
WidgetModifierConfig _uiAccordionContentTypography(Color color) =>
    WidgetModifierConfig.defaultTextStyle(
      style: UiTokens.text2.mix(),
    ).defaultTextStyle(style: TextStyleMix().color(color));

AccordionStyler _uiAccordionSizeStyler(UiAccordionSize size) {
  return switch (size) {
    .size1 => AccordionStyler(
      trigger: FlexBoxStyler().padding(.all(UiTokens.space2())),
      leadingIcon: .size(UiTokens.space4()),
      title: .style(UiTokens.text2.mix()),
      trailingIcon: .size(UiTokens.space4()),
      content: .padding(.all(UiTokens.space2())),
    ),
    .size2 => AccordionStyler(
      trigger: FlexBoxStyler().padding(.all(UiTokens.space3())),
      leadingIcon: .size(UiTokens.spinnerSize3()),
      title: .style(UiTokens.accordionText2.mix()),
      trailingIcon: .size(UiTokens.spinnerSize3()),
      content: .padding(.all(UiTokens.space3())),
    ),
    .size3 => AccordionStyler(
      trigger: FlexBoxStyler().padding(.all(UiTokens.space4())),
      leadingIcon: .size(UiTokens.space5()),
      title: .style(UiTokens.text3.mix()),
      trailingIcon: .size(UiTokens.space5()),
      content: .padding(.all(UiTokens.space4())),
    ),
  };
}

Radius _uiAccordionRadius(UiAccordionSize size) => switch (size) {
  .size1 => UiTokens.radius3(),
  .size2 => UiTokens.radius4(),
  .size3 => UiTokens.radius5(),
};
