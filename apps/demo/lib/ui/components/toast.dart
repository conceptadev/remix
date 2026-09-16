import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';
import 'button.dart';
import 'icon_button.dart';

part 'toast.g.dart';

/// Fortal toast size presets.
enum FortalToastSize { size1, size2, size3 }

/// Fortal toast surfaces, matching the Card surface and classic treatments.
enum FortalToastVariant { surface, classic }

/// The color role of the leading icon.
///
/// Visual only: it never changes [RemixToastData.priority]. Choose
/// [RemixToastPriority.assertive] explicitly when a message needs an
/// immediate announcement.
enum FortalToastIntent { accent, neutral, error }

/// Fortal-themed toast surface for [RemixToast] and [RemixToastScope].
///
/// A Fortal extension: Radix Themes has no toast, so the recipe reuses the
/// Card panel and shadow tokens. The surface caps at 360 logical pixels and
/// shrinks with the available width.
///
/// ```dart
/// RemixToastScope(style: fortalToastStyle(), child: const Shell())
/// ```
@MixWidget(target: RemixToast.new)
ToastStyler fortalToastStyle({
  FortalToastVariant variant = .classic,
  FortalToastSize size = .size2,
  FortalToastIntent intent = .accent,
  ToastStyler style = const ToastStyler.create(),
}) {
  final metrics = _fortalToastMetrics(size);
  final base =
      ToastStyler(
            container: FlexBoxStyler().spacing(metrics.gap),
            content: FlexBoxStyler().spacing(FortalTokens.space1()),
            icon: IconStyler()
                .size(metrics.iconSize)
                .color(_fortalToastIntentColor(intent)),
            title: TextStyler(style: metrics.text.mix())
                .fontWeight(FortalTokens.fontWeightMedium())
                .color(FortalTokens.gray12()),
            description: TextStyler(
              style: metrics.text.mix(),
            ).color(FortalTokens.gray11()),
            action: fortalButtonStyle(variant: .ghost, size: .size1),
            closeButton: fortalIconButtonStyle(variant: .ghost, size: .size1)
                .merge(
                  IconButtonStyler().icon(
                    IconStyler().color(FortalTokens.gray11()),
                  ),
                ),
          )
          .padding(.all(metrics.padding))
          .borderRadius(.all(metrics.radius))
          .maxWidth(360)
          .containerEffects(
            RemixBoxEffectsMix.backdropBlur(FortalTokens.panelBlur()),
          );

  return (switch (variant) {
    .surface =>
      base
          .containerEffects(
            RemixBoxEffectsMix.behindContent(_fortalToastPanel()),
          )
          .containerEffects(
            RemixBoxEffectsMix.overContent(
              RemixBoxEffectLayerMix(
                shadows: [
                  RemixBoxShadowMix(
                    color: FortalTokens.grayStroke5(),
                    spreadRadius: 1,
                    shapeInset: 1,
                  ),
                ],
              ),
            ),
          )
          .decoration(
            BoxDecorationMix.create(boxShadow: FortalTokens.shadow4.mix()),
          ),
    .classic =>
      base
          .containerEffects(
            RemixBoxEffectsMix.behindContent(
              _fortalToastPanel(
                shadowToken: FortalTokens.cardClassicOuterShadows,
              ),
            ),
          )
          .containerEffects(
            RemixBoxEffectsMix.overContent(
              RemixBoxEffectLayerMix(
                shadowToken: FortalTokens.cardClassicInnerShadows,
              ),
            ),
          ),
  }).merge(style);
}

({
  double padding,
  double gap,
  double iconSize,
  Radius radius,
  TextStyleToken text,
})
_fortalToastMetrics(FortalToastSize size) => switch (size) {
  .size1 => (
    padding: FortalTokens.space3(),
    gap: FortalTokens.space2(),
    iconSize: FortalTokens.space4(),
    radius: FortalTokens.radius3(),
    text: FortalTokens.text1,
  ),
  .size2 => (
    padding: FortalTokens.space4(),
    gap: FortalTokens.space3(),
    iconSize: FortalTokens.space4(),
    radius: FortalTokens.radius4(),
    text: FortalTokens.text2,
  ),
  .size3 => (
    padding: FortalTokens.space5(),
    gap: FortalTokens.space3(),
    iconSize: FortalTokens.space5(),
    radius: FortalTokens.radius5(),
    text: FortalTokens.text3,
  ),
};

Color _fortalToastIntentColor(FortalToastIntent intent) => switch (intent) {
  .accent => FortalTokens.accent11(),
  .neutral => FortalTokens.gray11(),
  .error => FortalTokens.error11(),
};

RemixBoxEffectLayerMix _fortalToastPanel({
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(
  gradients: [
    RemixLinearGradientMix(
      colors: [FortalTokens.colorPanel(), FortalTokens.colorPanel()],
    ),
  ],
  gradientInsets: const [1],
  shadowToken: shadowToken,
);
