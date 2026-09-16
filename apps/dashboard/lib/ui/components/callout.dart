import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'callout.g.dart';

/// Radix Themes Callout size presets.
enum UiCalloutSize { size1, size2, size3 }

/// Radix Themes Callout variants.
enum UiCalloutVariant { soft, surface, outline }

/// Ui-themed Callout with the Radix size, variant, and override contract.
@MixWidget(target: RemixCallout.new)
CalloutStyler uiCalloutStyle({
  UiCalloutVariant variant = .soft,
  UiCalloutSize size = .size2,
  bool highContrast = false,
  CalloutStyler style = const CalloutStyler.create(),
}) {
  final contentColor = highContrast
      ? UiTokens.accent12()
      : UiTokens.accentA11();
  final base = _uiCalloutBaseStyler(
    size,
  ).iconColor(contentColor).textColor(contentColor);
  return (switch (variant) {
    .soft => base.color(UiTokens.accentA3()),
    .surface =>
      base
          .color(UiTokens.accentA2())
          .containerEffects(
            RemixBoxEffectsMix.behindContent(
              uiInsetSurface(strokes: [UiTokens.accentA6()]),
            ),
          ),
    .outline => base.containerEffects(
      RemixBoxEffectsMix.behindContent(
        uiInsetSurface(strokes: [UiTokens.accentA7()]),
      ),
    ),
  }).merge(style);
}

CalloutStyler _uiCalloutBaseStyler(UiCalloutSize size) {
  final radius = _uiCalloutRadius(size);
  return CalloutStyler(
    container: .direction(.horizontal)
        .mainAxisSize(.min)
        .crossAxisAlignment(.start)
        .spacing(_uiCalloutGap(size))
        .padding(EdgeInsetsGeometryMix.all(_uiCalloutPadding(size))),
    text: .style(_uiCalloutText(size).mix()),
    icon: .size(_uiCalloutIconSize(size)),
  ).borderRadius(.all(radius));
}

double _uiCalloutPadding(UiCalloutSize size) => switch (size) {
  .size1 => UiTokens.space3(),
  .size2 => UiTokens.space4(),
  .size3 => UiTokens.space5(),
};

double _uiCalloutGap(UiCalloutSize size) => switch (size) {
  .size1 => UiTokens.space2(),
  .size2 => UiTokens.space3(),
  .size3 => UiTokens.space4(),
};

TextStyleToken _uiCalloutText(UiCalloutSize size) => switch (size) {
  .size1 || .size2 => UiTokens.text2,
  .size3 => UiTokens.text3,
};

double _uiCalloutIconSize(UiCalloutSize size) => switch (size) {
  .size1 || .size2 => UiTokens.space4(),
  .size3 => UiTokens.spinnerSize3(),
};

Radius _uiCalloutRadius(UiCalloutSize size) => switch (size) {
  .size1 => UiTokens.radius3(),
  .size2 => UiTokens.radius4(),
  .size3 => UiTokens.radius5(),
};
