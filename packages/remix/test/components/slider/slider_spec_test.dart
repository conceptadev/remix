import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('RemixSliderSpec provides neutral structured defaults', () {
    const spec = RemixSliderSpec();

    expect(spec.track, isA<StyleSpec<BoxSpec>>());
    expect(spec.trackEffects?.background, isNull);
    expect(spec.trackEffects?.foreground, isNull);
    expect(spec.range, isA<StyleSpec<BoxSpec>>());
    expect(spec.rangeEffects?.background, isNull);
    expect(spec.rangeEffects?.foreground, isNull);
    expect(spec.thumb, isA<StyleSpec<BoxSpec>>());
    expect(spec.thumbEffects?.background, isNull);
    expect(spec.thumbEffects?.foreground, isNull);
    expect(spec.thumbFocusEffects?.foreground, isNull);
    expect(spec.trackThickness, RemixSliderSpec.defaultTrackThickness);
    expect(spec.blendMode, isNull);
  });

  test('RemixSliderSpec retains every paint layer and behavior field', () {
    const trackSurface = RemixSurfaceLayerSpec(
      shadows: [RemixPaintShadow(color: Colors.grey)],
    );
    const rangeSurface = RemixSurfaceLayerSpec(
      shadows: [RemixPaintShadow(color: Colors.blue)],
    );
    const thumbSurface = RemixSurfaceLayerSpec(
      shadows: [RemixPaintShadow(color: Colors.white)],
    );
    const focusOverlay = RemixSurfaceLayerSpec(
      shadows: [RemixPaintShadow(color: Colors.transparent)],
    );
    const spec = RemixSliderSpec(
      trackEffects: RemixSurfaceEffectsSpec(background: trackSurface),
      rangeEffects: RemixSurfaceEffectsSpec(background: rangeSurface),
      thumbEffects: RemixSurfaceEffectsSpec(background: thumbSurface),
      thumbFocusEffects: RemixSurfaceEffectsSpec(foreground: focusOverlay),
      trackThickness: 10,
      blendMode: BlendMode.multiply,
    );

    expect(spec.trackEffects?.background, trackSurface);
    expect(spec.rangeEffects?.background, rangeSurface);
    expect(spec.thumbEffects?.background, thumbSurface);
    expect(spec.thumbFocusEffects?.foreground, focusOverlay);
    expect(spec.trackThickness, 10);
    expect(spec.blendMode, BlendMode.multiply);
  });
}
