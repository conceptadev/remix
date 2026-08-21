import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'disclosure.g.dart';

/// Fortal disclosure size presets.
enum FortalDisclosureSize { size1, size2, size3 }

/// Fortal disclosure color variants.
enum FortalDisclosureVariant { surface, soft }

/// Fortal-themed preset for [RemixDisclosure].
///
/// Radix Primitives calls this anatomy Collapsible: one root containing a
/// trigger and content. Radix Themes does not style that primitive, so Fortal
/// applies the same panel treatment as its standalone accordion items.
@MixWidget(target: RemixDisclosure.new)
DisclosureStyler fortalDisclosureStyle({
  FortalDisclosureVariant variant = .surface,
  FortalDisclosureSize size = .size2,
}) {
  return switch (variant) {
    .surface => _fortalDisclosureSurfaceStyler(size),
    .soft => _fortalDisclosureSoftStyler(size),
  };
}

DisclosureStyler _fortalDisclosureBaseStyler(FortalDisclosureSize size) {
  final metrics = _fortalDisclosureMetrics(size);

  return DisclosureStyler()
      .container(
        BoxStyler()
            .clipBehavior(.antiAlias)
            .borderRadius(.all(metrics.radius)),
      )
      .trigger(
        BoxStyler()
            .width(.infinity)
            .alignment(.centerLeft)
            .padding(.all(metrics.padding))
            .wrap(
              _fortalDisclosureTypography(
                style: metrics.triggerText,
                color: FortalTokens.gray12(),
                iconColor: FortalTokens.gray11(),
                iconSize: metrics.iconSize,
              ),
            ),
      )
      .content(
        BoxStyler()
            .width(.infinity)
            .padding(.all(metrics.padding))
            .wrap(
              _fortalDisclosureTypography(
                style: FortalTokens.text2,
                color: FortalTokens.gray12(),
                iconColor: FortalTokens.gray11(),
                iconSize: metrics.iconSize,
              ),
            ),
      );
}

DisclosureStyler _fortalDisclosureSurfaceStyler(FortalDisclosureSize size) {
  return _fortalDisclosureBaseStyler(size)
      .container(
        .color(
          FortalTokens.gray2(),
        ).border(.all(_fortalDisclosureBorderSide(FortalTokens.gray6()))),
      )
      .trigger(.color(FortalTokens.gray1()))
      .content(
        .foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.top(
              _fortalDisclosureBorderSide(FortalTokens.gray6()),
            ),
          ),
        ),
      )
      .onHovered(.trigger(.color(FortalTokens.gray2())))
      .onPressed(.trigger(.color(FortalTokens.gray3())))
      .onFocusVisible(DisclosureStyler().fortalFocusRing())
      .onDisabled(_fortalDisclosureDisabledStyler());
}

DisclosureStyler _fortalDisclosureSoftStyler(FortalDisclosureSize size) {
  return _fortalDisclosureBaseStyler(size)
      .container(
        .color(
          FortalTokens.accent2(),
        ).border(.all(_fortalDisclosureBorderSide(FortalTokens.accent6()))),
      )
      .trigger(
        BoxStyler()
            .color(FortalTokens.accent2())
            .wrap(
              _fortalDisclosureForeground(
                color: FortalTokens.accent12(),
                iconColor: FortalTokens.accent11(),
              ),
            ),
      )
      .content(
        BoxStyler()
            .foregroundDecoration(
              BoxDecorationMix(
                border: BoxBorderMix.top(
                  _fortalDisclosureBorderSide(FortalTokens.accent6()),
                ),
              ),
            )
            .wrap(
              _fortalDisclosureForeground(
                color: FortalTokens.accent12(),
                iconColor: FortalTokens.accent11(),
              ),
            ),
      )
      .onHovered(.trigger(.color(FortalTokens.accent3())))
      .onPressed(.trigger(.color(FortalTokens.accent4())))
      .onFocusVisible(DisclosureStyler().fortalFocusRing())
      .onDisabled(_fortalDisclosureDisabledStyler());
}

DisclosureStyler _fortalDisclosureDisabledStyler() {
  return DisclosureStyler().trigger(
    BoxStyler()
        .color(FortalTokens.grayA3())
        .wrap(
          _fortalDisclosureForeground(
            color: FortalTokens.gray8(),
            iconColor: FortalTokens.gray8(),
          ),
        ),
  );
}

BorderSideMix _fortalDisclosureBorderSide(Color color) =>
    BorderSideMix(color: color, width: FortalTokens.borderWidth1());

WidgetModifierConfig _fortalDisclosureTypography({
  required TextStyleToken style,
  required Color color,
  required Color iconColor,
  required double iconSize,
}) {
  return WidgetModifierConfig.defaultTextStyle(style: style.mix())
      .defaultTextStyle(style: TextStyleMix().color(color))
      .merge(WidgetModifierConfig.iconTheme(color: iconColor, size: iconSize));
}

WidgetModifierConfig _fortalDisclosureForeground({
  required Color color,
  required Color iconColor,
}) {
  return WidgetModifierConfig.defaultTextStyle(
    style: TextStyleMix().color(color),
  ).merge(WidgetModifierConfig.iconTheme(color: iconColor));
}

({double padding, Radius radius, TextStyleToken triggerText, double iconSize})
_fortalDisclosureMetrics(FortalDisclosureSize size) {
  return switch (size) {
    .size1 => (
      padding: FortalTokens.space2(),
      radius: FortalTokens.radius3(),
      triggerText: FortalTokens.text2,
      iconSize: FortalTokens.space4(),
    ),
    .size2 => (
      padding: FortalTokens.space3(),
      radius: FortalTokens.radius4(),
      triggerText: FortalTokens.accordionText2,
      iconSize: FortalTokens.spinnerSize3(),
    ),
    .size3 => (
      padding: FortalTokens.space4(),
      radius: FortalTokens.radius5(),
      triggerText: FortalTokens.text3,
      iconSize: FortalTokens.space5(),
    ),
  };
}
