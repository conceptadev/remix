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

AccordionStyler _fortalAccordionBaseStyler(FortalAccordionSize size) {
  return AccordionStyler()
      .trigger(.direction(.horizontal).clipBehavior(.antiAlias))
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
      .trigger(.color(FortalTokens.gray1()))
      .content(
        BoxStyler()
            .border(
              .top(
                .color(FortalTokens.gray6()).width(FortalTokens.borderWidth1()),
              ),
            )
            .color(FortalTokens.gray2())
            .wrap(
              .defaultTextStyle(
                style: TextStyleMix().color(FortalTokens.gray12()),
              ),
            ),
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
      .trigger(.color(FortalTokens.accent2()))
      .title(.color(FortalTokens.accent12()))
      .trailingIcon(.color(FortalTokens.accent11()))
      .content(
        BoxStyler()
            .border(
              .top(
                .color(
                  FortalTokens.accent6(),
                ).width(FortalTokens.borderWidth1()),
              ),
            )
            .color(FortalTokens.accent2())
            .wrap(
              .defaultTextStyle(
                style: TextStyleMix().color(FortalTokens.accent12()),
              ),
            ),
      )
      .onHovered(.trigger(.color(FortalTokens.accent3())))
      .onPressed(.trigger(.color(FortalTokens.accent4())))
      .onFocusVisible(_fortalAccordionFocusStyler())
      .onDisabled(_fortalAccordionDisabledStyler());
}

AccordionStyler _fortalAccordionSizeStyler(FortalAccordionSize size) {
  return switch (size) {
    .size1 => AccordionStyler(
      trigger: FlexBoxStyler()
          .padding(.horizontal(FortalTokens.space2()))
          .padding(.vertical(FortalTokens.space2()))
          .borderRadius(.all(FortalTokens.radius3())),
      leadingIcon: .size(FortalTokens.space4()),
      title: .style(FortalTokens.text2.mix()),
      trailingIcon: .size(FortalTokens.space4()),
      content: BoxStyler()
          .padding(.all(FortalTokens.space2()))
          .borderRadius(.bottom(FortalTokens.radius3()))
          .clipBehavior(.antiAlias),
    ),
    .size2 => AccordionStyler(
      trigger: FlexBoxStyler()
          .padding(.horizontal(FortalTokens.space3()))
          .padding(.vertical(FortalTokens.space3()))
          .borderRadius(.all(FortalTokens.radius4())),
      leadingIcon: .size(FortalTokens.spinnerSize3()),
      title: .style(FortalTokens.accordionText2.mix()),
      trailingIcon: .size(FortalTokens.spinnerSize3()),
      content: BoxStyler()
          .padding(.all(FortalTokens.space3()))
          .borderRadius(.bottom(FortalTokens.radius4()))
          .clipBehavior(.antiAlias),
    ),
    .size3 => AccordionStyler(
      trigger: FlexBoxStyler()
          .padding(.horizontal(FortalTokens.space4()))
          .padding(.vertical(FortalTokens.space4()))
          .borderRadius(.all(FortalTokens.radius5())),
      leadingIcon: .size(FortalTokens.space5()),
      title: .style(FortalTokens.text3.mix()),
      trailingIcon: .size(FortalTokens.space5()),
      content: BoxStyler()
          .padding(.all(FortalTokens.space4()))
          .borderRadius(.bottom(FortalTokens.radius5()))
          .clipBehavior(.antiAlias),
    ),
  };
}
