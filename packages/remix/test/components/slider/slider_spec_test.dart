import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('RemixSliderSpec provides neutral structured defaults', () {
    const spec = RemixSliderSpec();

    expect(spec.track, isA<StyleSpec<BoxSpec>>());
    expect(spec.trackEffects?.behindContent, isNull);
    expect(spec.trackEffects?.overContent, isNull);
    expect(spec.range, isA<StyleSpec<BoxSpec>>());
    expect(spec.rangeEffects?.behindContent, isNull);
    expect(spec.rangeEffects?.overContent, isNull);
    expect(spec.thumb, isA<StyleSpec<BoxSpec>>());
    expect(spec.thumbEffects?.behindContent, isNull);
    expect(spec.thumbEffects?.overContent, isNull);
    expect(spec.thumbFocusEffects?.overContent, isNull);
    expect(spec.trackThickness, RemixSliderSpec.defaultTrackThickness);
    expect(spec.blendMode, isNull);
  });

  test('RemixSliderSpec retains every paint layer and behavior field', () {
    const trackSurface = RemixBoxEffectLayerSpec(
      shadows: [RemixBoxShadow(color: Colors.grey)],
    );
    const rangeSurface = RemixBoxEffectLayerSpec(
      shadows: [RemixBoxShadow(color: Colors.blue)],
    );
    const thumbSurface = RemixBoxEffectLayerSpec(
      shadows: [RemixBoxShadow(color: Colors.white)],
    );
    const focusOverlay = RemixBoxEffectLayerSpec(
      shadows: [RemixBoxShadow(color: Colors.transparent)],
    );
    const spec = RemixSliderSpec(
      trackEffects: RemixBoxEffectsSpec(behindContent: trackSurface),
      rangeEffects: RemixBoxEffectsSpec(behindContent: rangeSurface),
      thumbEffects: RemixBoxEffectsSpec(behindContent: thumbSurface),
      thumbFocusEffects: RemixBoxEffectsSpec(overContent: focusOverlay),
      trackWidth: 10,
      rangeWidth: 10,
      blendMode: BlendMode.multiply,
    );

    expect(spec.trackEffects?.behindContent, trackSurface);
    expect(spec.rangeEffects?.behindContent, rangeSurface);
    expect(spec.thumbEffects?.behindContent, thumbSurface);
    expect(spec.thumbFocusEffects?.overContent, focusOverlay);
    expect(spec.trackThickness, 10);
    expect(spec.blendMode, BlendMode.multiply);
  });
}
