import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'slider.g.dart';

/// Radix Themes slider sizes.
enum FortalSliderSize { size1, size2, size3 }

/// Radix Themes slider variants.
enum FortalSliderVariant { classic, surface, soft }

/// Fortal slider with Radix-owned size, variant, and component overrides.
@MixWidget(target: RemixSlider.new)
SliderStyler fortalSliderStyle({
  FortalSliderVariant variant = .surface,
  FortalSliderSize size = .size2,
  bool highContrast = false,
}) {
  final metrics = _fortalSliderMetrics(size);
  final radius = BorderRadiusMix.all(metrics.trackRadius);
  final thumbRadius = BorderRadiusMix.all(FortalTokens.radius1OrThumb());
  final base = SliderStyler()
      .track(.borderRadius(radius))
      .range(.borderRadius(radius))
      .thumb(
        .size(metrics.thumbSize, metrics.thumbSize).borderRadius(thumbRadius),
      )
      .thickness(metrics.trackSize)
      .thumbFocusEffects(
        RemixBoxEffectsMix.overContent(
          RemixBoxEffectLayerMix(
            shadows: [
              RemixBoxShadowMix(color: FortalTokens.accent3(), spreadRadius: 3),
              RemixBoxShadowMix(color: FortalTokens.focus8(), spreadRadius: 5),
            ],
          ),
        ),
      );

  final styled = switch (variant) {
    .classic => _fortalSliderClassic(
      base,
      trackRadius: radius,
      thumbRadius: thumbRadius,
      highContrast: highContrast,
    ),
    .surface => _fortalSliderSurface(
      base,
      trackRadius: radius,
      thumbRadius: thumbRadius,
      highContrast: highContrast,
    ),
    .soft => _fortalSliderSoft(
      base,
      trackRadius: radius,
      thumbRadius: thumbRadius,
      highContrast: highContrast,
    ),
  };
  return styled
      .onDisabled(
        _fortalSliderDisabled(
          variant,
          trackRadius: radius,
          thumbRadius: thumbRadius,
        ),
      )
      .variant(
        ContextVariant(
          'fortalSliderDisabledDarkBlend',
          (context) => FortalTheme.of(context).isDark,
        ),
        SliderStyler().onDisabled(.blendMode(BlendMode.screen)),
      );
}

SliderStyler _fortalSliderSurface(
  SliderStyler base, {
  required BorderRadiusMix trackRadius,
  required BorderRadiusMix thumbRadius,
  required bool highContrast,
}) => base
    .track(.color(FortalTokens.grayA3()))
    .range(.color(FortalTokens.accentTrack()))
    .thumbColor(const Color(0xFFFFFFFF))
    .trackEffects(
      RemixBoxEffectsMix.behindContent(
        fortalInsetSurface(strokes: [FortalTokens.grayA5()]),
      ),
    )
    .rangeEffects(
      RemixBoxEffectsMix.behindContent(
        fortalInsetSurface(strokes: [FortalTokens.grayA5()]).merge(
          RemixBoxEffectLayerMix(
            gradients: _fortalSliderHighContrastGradients(highContrast),
          ),
        ),
      ),
    )
    .thumb(
      BoxStyler().decoration(
        .boxShadow([
          BoxShadowMix(color: FortalTokens.blackA4(), spreadRadius: 1),
        ]),
      ),
    );

SliderStyler _fortalSliderClassic(
  SliderStyler base, {
  required BorderRadiusMix trackRadius,
  required BorderRadiusMix thumbRadius,
  required bool highContrast,
}) => base
    .track(.color(FortalTokens.grayA3()))
    .range(.color(FortalTokens.accentTrack()))
    .thumbColor(const Color(0xFFFFFFFF))
    .trackEffects(
      RemixBoxEffectsMix.overContent(
        RemixBoxEffectLayerMix(shadowToken: FortalTokens.shadow1Layers),
      ),
    )
    .rangeEffects(
      RemixBoxEffectsMix.behindContent(
        RemixBoxEffectLayerMix(
          gradients: _fortalSliderHighContrastGradients(highContrast),
          shadows: highContrast
              ? [
                  _fortalSliderInset(FortalTokens.grayA3()),
                  _fortalSliderInset(FortalTokens.blackA2()),
                  _fortalSliderInset(
                    FortalTokens.blackA2(),
                    offset: const Offset(0, 1.5),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ]
              : [
                  _fortalSliderInset(FortalTokens.grayA3()),
                  _fortalSliderInset(FortalTokens.accentA4()),
                  _fortalSliderInset(FortalTokens.blackA1()),
                  _fortalSliderInset(
                    FortalTokens.blackA2(),
                    offset: const Offset(0, 1.5),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
        ),
      ),
    )
    .thumb(
      BoxStyler().decoration(
        .boxShadow([
          BoxShadowMix(color: FortalTokens.blackA3(), spreadRadius: 1),
          BoxShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
          BoxShadowMix(
            color: FortalTokens.blackA1(),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -1,
          ),
        ]),
      ),
    );

SliderStyler _fortalSliderSoft(
  SliderStyler base, {
  required BorderRadiusMix trackRadius,
  required BorderRadiusMix thumbRadius,
  required bool highContrast,
}) => base
    .track(.color(FortalTokens.grayA4()))
    .range(.color(FortalTokens.accent6()))
    .thumbColor(const Color(0xFFFFFFFF))
    .trackEffects(
      RemixBoxEffectsMix.behindContent(
        RemixBoxEffectLayerMix(
          gradients: [
            RemixLinearGradientMix(
              colors: [FortalTokens.whiteA1(), FortalTokens.whiteA1()],
            ),
          ],
        ),
      ),
    )
    .rangeEffects(
      RemixBoxEffectsMix.behindContent(
        RemixBoxEffectLayerMix(
          gradients: [
            RemixLinearGradientMix(
              colors: [FortalTokens.accentA5(), FortalTokens.accentA5()],
            ),
            ..._fortalSliderHighContrastGradients(highContrast),
          ],
        ),
      ),
    )
    .thumb(
      BoxStyler().decoration(
        .boxShadow([
          BoxShadowMix(color: FortalTokens.blackA3(), spreadRadius: 1),
          BoxShadowMix(color: FortalTokens.grayA2(), spreadRadius: 1),
          BoxShadowMix(color: FortalTokens.accentA2(), spreadRadius: 1),
          BoxShadowMix(
            color: FortalTokens.grayA4(),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadowMix(
            color: FortalTokens.grayA3(),
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: -0.5,
          ),
        ]),
      ),
    );

SliderStyler _fortalSliderDisabled(
  FortalSliderVariant variant, {
  required BorderRadiusMix trackRadius,
  required BorderRadiusMix thumbRadius,
}) {
  final track = switch (variant) {
    .surface =>
      SliderStyler()
          .track(.color(FortalTokens.grayA3()))
          .trackEffects(
            RemixBoxEffectsMix.behindContent(
              fortalInsetSurface(strokes: [FortalTokens.grayA4()]),
            ),
          ),
    .classic =>
      SliderStyler()
          .track(.color(FortalTokens.grayA3()))
          .trackEffects(
            RemixBoxEffectsMix.overContent(
              RemixBoxEffectLayerMix(
                shadowToken: FortalTokens.sliderClassicDisabledTrackShadows,
              ),
            ),
          ),
    .soft =>
      SliderStyler()
          .track(.color(FortalTokens.grayA4()))
          .trackEffects(
            RemixBoxEffectsMix.behindContent(
              RemixBoxEffectLayerMix(gradients: const []),
            ),
          ),
  };
  return track
      .range(.color(const Color(0x00000000)))
      .thumbColor(FortalTokens.gray1())
      .rangeEffects(
        RemixBoxEffectsMix.behindContent(
          RemixBoxEffectLayerMix(gradients: const [], shadows: const []),
        ),
      )
      .rangeEffects(
        RemixBoxEffectsMix.overContent(
          RemixBoxEffectLayerMix(gradients: const [], shadows: const []),
        ),
      )
      .thumb(
        BoxStyler().decoration(
          .boxShadow([
            BoxShadowMix(
              color: switch (variant) {
                .soft => FortalTokens.gray5(),
                .classic || .surface => FortalTokens.gray6(),
              },
              spreadRadius: 1,
            ),
          ]),
        ),
      )
      .thumbFocusEffects(
        RemixBoxEffectsMix.overContent(
          RemixBoxEffectLayerMix(shadows: const []),
        ),
      )
      .blendMode(BlendMode.multiply);
}

RemixBoxShadowMix _fortalSliderInset(
  Color color, {
  Offset offset = Offset.zero,
  double blurRadius = 0,
  double spreadRadius = 1,
}) => RemixBoxShadowMix(
  kind: RemixBoxShadowKind.inset,
  color: color,
  offset: offset,
  blurRadius: blurRadius,
  spreadRadius: spreadRadius,
);

List<RemixLinearGradientMix> _fortalSliderHighContrastGradients(
  bool highContrast,
) => highContrast
    ? [
        RemixLinearGradientMix(
          colors: [
            FortalTokens.sliderHighContrastOverlay(),
            FortalTokens.sliderHighContrastOverlay(),
          ],
        ),
      ]
    : const [];

class _FortalSliderMetrics {
  const _FortalSliderMetrics({
    required this.trackSize,
    required this.thumbSize,
    required this.trackRadius,
  });

  final double trackSize;
  final double thumbSize;
  final Radius trackRadius;
}

_FortalSliderMetrics _fortalSliderMetrics(FortalSliderSize size) =>
    switch (size) {
      .size1 => _FortalSliderMetrics(
        trackSize: FortalTokens.sliderTrackSize1(),
        thumbSize: FortalTokens.sliderThumbSize1(),
        trackRadius: FortalTokens.sliderTrackRadius1(),
      ),
      .size2 => _FortalSliderMetrics(
        trackSize: FortalTokens.sliderTrackSize2(),
        thumbSize: FortalTokens.sliderThumbSize2(),
        trackRadius: FortalTokens.sliderTrackRadius2(),
      ),
      .size3 => _FortalSliderMetrics(
        trackSize: FortalTokens.sliderTrackSize3(),
        thumbSize: FortalTokens.sliderThumbSize3(),
        trackRadius: FortalTokens.sliderTrackRadius3(),
      ),
    };
