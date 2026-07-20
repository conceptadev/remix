import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('RemixSliderSpec provides neutral structured defaults', () {
    const spec = RemixSliderSpec();

    expect(spec.track, isA<StyleSpec<BoxSpec>>());
    expect(spec.trackSurface, isNull);
    expect(spec.trackOverlay, isNull);
    expect(spec.range, isA<StyleSpec<BoxSpec>>());
    expect(spec.rangeSurface, isNull);
    expect(spec.rangeOverlay, isNull);
    expect(spec.thumb, isA<StyleSpec<BoxSpec>>());
    expect(spec.thumbSurface, isNull);
    expect(spec.thumbOverlay, isNull);
    expect(spec.thumbFocusOverlay, isNull);
    expect(spec.trackThickness, RemixSliderSpec.defaultTrackThickness);
    expect(spec.blendMode, isNull);
  });

  test('RemixSliderSpec retains every paint layer and behavior field', () {
    const trackSurface = RemixSurfaceLayerSpec(color: Colors.grey);
    const rangeSurface = RemixSurfaceLayerSpec(color: Colors.blue);
    const thumbSurface = RemixSurfaceLayerSpec(color: Colors.white);
    const focusOverlay = RemixSurfaceLayerSpec(color: Colors.transparent);
    const spec = RemixSliderSpec(
      trackSurface: trackSurface,
      rangeSurface: rangeSurface,
      thumbSurface: thumbSurface,
      thumbFocusOverlay: focusOverlay,
      trackThickness: 10,
      blendMode: BlendMode.multiply,
    );

    expect(spec.trackSurface, trackSurface);
    expect(spec.rangeSurface, rangeSurface);
    expect(spec.thumbSurface, thumbSurface);
    expect(spec.thumbFocusOverlay, focusOverlay);
    expect(spec.trackThickness, 10);
    expect(spec.blendMode, BlendMode.multiply);
  });
}
