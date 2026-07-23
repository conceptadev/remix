import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('slider styler exposes track, range, thumb, and painter slots', () {
    final style = RemixSliderStyler()
        .track(BoxStyler().borderRadiusAll(const Radius.circular(4)))
        .trackEffects(
          RemixBoxEffectsMix(behindContent: RemixBoxEffectLayerMix()),
        )
        .trackEffects(RemixBoxEffectsMix(overContent: RemixBoxEffectLayerMix()))
        .range(BoxStyler().borderRadiusAll(const Radius.circular(4)))
        .rangeEffects(
          RemixBoxEffectsMix(behindContent: RemixBoxEffectLayerMix()),
        )
        .rangeEffects(RemixBoxEffectsMix(overContent: RemixBoxEffectLayerMix()))
        .thumb(BoxStyler().size(16, 16))
        .thumbEffects(
          RemixBoxEffectsMix(behindContent: RemixBoxEffectLayerMix()),
        )
        .thumbEffects(RemixBoxEffectsMix(overContent: RemixBoxEffectLayerMix()))
        .thumbFocusEffects(
          RemixBoxEffectsMix(overContent: RemixBoxEffectLayerMix()),
        )
        .trackThickness(8)
        .blendMode(BlendMode.multiply);

    expect(style, isA<RemixSliderStyler>());
  });

  test('convenience helpers target painter-backed fields', () {
    final style = RemixSliderStyler()
        .thumbColor(Colors.white)
        .thumbSize(const Size.square(16))
        .trackColor(Colors.grey)
        .rangeColor(Colors.blue)
        .thickness(8);

    expect(style, isA<RemixSliderStyler>());
  });

  test('Fortal exposes the exact Radix size and variant matrix', () {
    expect(FortalSliderSize.values, [
      FortalSliderSize.size1,
      FortalSliderSize.size2,
      FortalSliderSize.size3,
    ]);
    expect(FortalSliderVariant.values, [
      FortalSliderVariant.classic,
      FortalSliderVariant.surface,
      FortalSliderVariant.soft,
    ]);

    for (final size in FortalSliderSize.values) {
      for (final variant in FortalSliderVariant.values) {
        expect(
          fortalSliderStyler(size: size, variant: variant, highContrast: true),
          isA<RemixSliderStyler>(),
        );
      }
    }
  });

  test('FortalSlider defaults match Radix Themes 3.3.0', () {
    const slider = FortalSlider(values: [50]);

    expect(slider.variant, FortalSliderVariant.surface);
    expect(slider.size, FortalSliderSize.size2);
    expect(slider.min, 0);
    expect(slider.max, 100);
    expect(slider.step, 1);
    expect(slider.minSpacing, 0);
    expect(slider.orientation, Axis.horizontal);
    expect(slider.inverted, isFalse);
    expect(slider.highContrast, isFalse);
  });
}
