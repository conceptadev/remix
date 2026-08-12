import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'accordion.g.dart';

/// Fortal accordion size presets.
enum FortalAccordionSize { size1, size2, size3 }

/// Fortal accordion color variants.
enum FortalAccordionVariant { surface, soft }

/// Fortal-themed preset for [RemixAccordion].
@MixWidget(target: RemixAccordion.new)
AccordionStyler fortalAccordionStyle({
  FortalAccordionVariant variant = .surface,
  FortalAccordionSize size = .size2,
}) {
  return switch (variant) {
    .surface => _fortalAccordionSurfaceStyler(size),
    .soft => _fortalAccordionSoftStyler(size),
  };
}

// Panel anatomy follows the mapped Table family (see data_table.dart):
// `container` alone owns radius, border, fill, and clipping, while trigger
// and content stay flat rectangles that simply get cropped to its rounded
// shape. That is what lets an expanded trigger meet its content with no
// corner notch — neither part rounds its own corners, so there is no curve
// for the divider to miss. The divider itself is a foreground border (see
// `_fortalAccordionBorderSide`), matching the Table row divider technique so
// it paints without insetting content by a pixel.
AccordionStyler _fortalAccordionBaseStyler(FortalAccordionSize size) {
  return AccordionStyler()
      .container(.clipBehavior(.antiAlias))
      .trigger(.direction(.horizontal))
      .leadingIcon(.color(FortalTokens.gray11()))
      .title(
        .fontWeight(
          FortalTokens.fontWeightMedium(),
        ).color(FortalTokens.gray12()),
      )
      .trailingIcon(.color(FortalTokens.gray11()))
      .content(.width(.infinity))
      .merge(_fortalAccordionSizeStyler(size));
}

AccordionStyler _fortalAccordionFocusStyler() {
  return AccordionStyler().trigger(FlexBoxStyler().fortalFocusRing());
}

AccordionStyler _fortalAccordionDisabledStyler() {
  return AccordionStyler()
      .trigger(.color(FortalTokens.grayA3()))
      .leadingIcon(.color(FortalTokens.gray8()))
      .title(.color(FortalTokens.gray8()))
      .trailingIcon(.color(FortalTokens.gray8()));
}

AccordionStyler _fortalAccordionSurfaceStyler([
  FortalAccordionSize size = .size2,
]) {
  return _fortalAccordionBaseStyler(size)
      .container(
        .color(
          FortalTokens.gray2(),
        ).border(.all(_fortalAccordionBorderSide(FortalTokens.gray6()))),
      )
      .trigger(.color(FortalTokens.gray1()))
      .content(
        BoxStyler()
            .foregroundDecoration(
              BoxDecorationMix(
                border: BoxBorderMix.top(
                  _fortalAccordionBorderSide(FortalTokens.gray6()),
                ),
              ),
            )
            .wrap(_fortalAccordionContentTypography(FortalTokens.gray12())),
      )
      .onHovered(.trigger(.color(FortalTokens.gray2())))
      .onPressed(.trigger(.color(FortalTokens.gray3())))
      .onFocusVisible(_fortalAccordionFocusStyler())
      .onDisabled(_fortalAccordionDisabledStyler());
}

AccordionStyler _fortalAccordionSoftStyler([
  FortalAccordionSize size = .size2,
]) {
  return _fortalAccordionBaseStyler(size)
      .container(
        .color(
          FortalTokens.accent2(),
        ).border(.all(_fortalAccordionBorderSide(FortalTokens.accent6()))),
      )
      .trigger(.color(FortalTokens.accent2()))
      .title(.color(FortalTokens.accent12()))
      .trailingIcon(.color(FortalTokens.accent11()))
      .content(
        BoxStyler()
            .foregroundDecoration(
              BoxDecorationMix(
                border: BoxBorderMix.top(
                  _fortalAccordionBorderSide(FortalTokens.accent6()),
                ),
              ),
            )
            .wrap(_fortalAccordionContentTypography(FortalTokens.accent12())),
      )
      .onHovered(.trigger(.color(FortalTokens.accent3())))
      .onPressed(.trigger(.color(FortalTokens.accent4())))
      .onFocusVisible(_fortalAccordionFocusStyler())
      .onDisabled(_fortalAccordionDisabledStyler());
}

/// The 1px edge shared by the panel's outer border and the trigger/content
/// divider, so the seam reads as a continuation of the frame rather than an
/// unrelated line.
BorderSideMix _fortalAccordionBorderSide(Color color) =>
    BorderSideMix(color: color, width: FortalTokens.borderWidth1());

/// Pins accordion content to the 14px type-scale step (`text2`) regardless
/// of accordion size, so content never renders larger than its own
/// trigger's title (measured 14/15/16px at size1/size2/size3). [color]
/// supplies the variant's own content tint.
WidgetModifierConfig _fortalAccordionContentTypography(Color color) =>
    WidgetModifierConfig.defaultTextStyle(
      style: FortalTokens.text2.mix(),
    ).defaultTextStyle(style: TextStyleMix().color(color));

AccordionStyler _fortalAccordionSizeStyler(FortalAccordionSize size) {
  return switch (size) {
    .size1 => AccordionStyler(
      container: .borderRadius(.all(FortalTokens.radius3())),
      trigger: FlexBoxStyler().padding(.all(FortalTokens.space2())),
      leadingIcon: .size(FortalTokens.space4()),
      title: .style(FortalTokens.text2.mix()),
      trailingIcon: .size(FortalTokens.space4()),
      content: .padding(.all(FortalTokens.space2())),
    ),
    .size2 => AccordionStyler(
      container: .borderRadius(.all(FortalTokens.radius4())),
      trigger: FlexBoxStyler().padding(.all(FortalTokens.space3())),
      leadingIcon: .size(FortalTokens.spinnerSize3()),
      title: .style(FortalTokens.accordionText2.mix()),
      trailingIcon: .size(FortalTokens.spinnerSize3()),
      content: .padding(.all(FortalTokens.space3())),
    ),
    .size3 => AccordionStyler(
      container: .borderRadius(.all(FortalTokens.radius5())),
      trigger: FlexBoxStyler().padding(.all(FortalTokens.space4())),
      leadingIcon: .size(FortalTokens.space5()),
      title: .style(FortalTokens.text3.mix()),
      trailingIcon: .size(FortalTokens.space5()),
      content: .padding(.all(FortalTokens.space4())),
    ),
  };
}
