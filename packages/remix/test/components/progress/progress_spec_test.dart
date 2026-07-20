import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixProgressSpec', () {
    test('defaults all box parts and leaves paint layers absent', () {
      const spec = RemixProgressSpec();

      expect(spec.container, isA<StyleSpec<BoxSpec>>());
      expect(spec.track, isA<StyleSpec<BoxSpec>>());
      expect(spec.indicator, isA<StyleSpec<BoxSpec>>());
      expect(spec.surface, isNull);
      expect(spec.overlay, isNull);
    });

    test('stores every structural part', () {
      final container = StyleSpec(spec: BoxSpec());
      final track = StyleSpec(spec: BoxSpec());
      final indicator = StyleSpec(spec: BoxSpec());
      const surface = RemixSurfaceLayerSpec(color: Colors.red);
      const overlay = RemixSurfaceLayerSpec(color: Colors.blue);

      final spec = RemixProgressSpec(
        container: container,
        track: track,
        indicator: indicator,
        surface: surface,
        overlay: overlay,
      );

      expect(spec.container, same(container));
      expect(spec.track, same(track));
      expect(spec.indicator, same(indicator));
      expect(spec.surface, same(surface));
      expect(spec.overlay, same(overlay));
    });

    test(
      'copyWith updates every structural part without mutating the source',
      () {
        const original = RemixProgressSpec();
        final container = StyleSpec(spec: BoxSpec());
        final track = StyleSpec(spec: BoxSpec());
        final indicator = StyleSpec(spec: BoxSpec());
        const surface = RemixSurfaceLayerSpec(color: Colors.red);
        const overlay = RemixSurfaceLayerSpec(color: Colors.blue);

        final updated = original.copyWith(
          container: container,
          track: track,
          indicator: indicator,
          surface: surface,
          overlay: overlay,
        );

        expect(original, const RemixProgressSpec());
        expect(updated.container, same(container));
        expect(updated.track, same(track));
        expect(updated.indicator, same(indicator));
        expect(updated.surface, same(surface));
        expect(updated.overlay, same(overlay));
      },
    );

    test('equality and diagnostics include all seven structural parts', () {
      const spec = RemixProgressSpec(
        surface: RemixSurfaceLayerSpec(color: Colors.red),
        overlay: RemixSurfaceLayerSpec(color: Colors.blue),
        indicatorSurface: RemixSurfaceLayerSpec(color: Colors.green),
        indicatorOverlay: RemixSurfaceLayerSpec(color: Colors.yellow),
      );
      const equal = RemixProgressSpec(
        surface: RemixSurfaceLayerSpec(color: Colors.red),
        overlay: RemixSurfaceLayerSpec(color: Colors.blue),
        indicatorSurface: RemixSurfaceLayerSpec(color: Colors.green),
        indicatorOverlay: RemixSurfaceLayerSpec(color: Colors.yellow),
      );

      expect(spec, equal);
      expect(spec.hashCode, equal.hashCode);
      expect(spec.props, hasLength(7));
      expect(spec.props, [
        spec.container,
        spec.track,
        spec.indicator,
        spec.surface,
        spec.overlay,
        spec.indicatorSurface,
        spec.indicatorOverlay,
      ]);
      expect(
        () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
        returnsNormally,
      );
    });

    test('lerp snaps optional paint layers', () {
      const source = RemixProgressSpec(
        surface: RemixSurfaceLayerSpec(color: Colors.red),
      );
      const destination = RemixProgressSpec(
        surface: RemixSurfaceLayerSpec(color: Colors.blue),
      );

      expect(source.lerp(destination, 0.49).surface?.color, Colors.red);
      expect(source.lerp(destination, 0.5).surface?.color, Colors.blue);
    });
  });
}
