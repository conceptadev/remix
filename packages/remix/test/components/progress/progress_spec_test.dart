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
      expect(spec.trackEffects?.behindContent, isNull);
      expect(spec.trackEffects?.overContent, isNull);
    });

    test('stores every structural part', () {
      final container = StyleSpec(spec: BoxSpec());
      final track = StyleSpec(spec: BoxSpec());
      final indicator = StyleSpec(spec: BoxSpec());
      const surface = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.red)],
      );
      const overlay = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.blue)],
      );

      final spec = RemixProgressSpec(
        container: container,
        track: track,
        indicator: indicator,
        trackEffects: RemixBoxEffectsSpec(
          behindContent: surface,
          overContent: overlay,
        ),
      );

      expect(spec.container, same(container));
      expect(spec.track, same(track));
      expect(spec.indicator, same(indicator));
      expect(spec.trackEffects?.behindContent, same(surface));
      expect(spec.trackEffects?.overContent, same(overlay));
    });

    test(
      'copyWith updates every structural part without mutating the source',
      () {
        const original = RemixProgressSpec();
        final container = StyleSpec(spec: BoxSpec());
        final track = StyleSpec(spec: BoxSpec());
        final indicator = StyleSpec(spec: BoxSpec());
        const surface = RemixBoxEffectLayerSpec(
          shadows: [RemixBoxShadow(color: Colors.red)],
        );
        const overlay = RemixBoxEffectLayerSpec(
          shadows: [RemixBoxShadow(color: Colors.blue)],
        );

        final updated = original.copyWith(
          container: container,
          track: track,
          indicator: indicator,
          trackEffects: RemixBoxEffectsSpec(
            behindContent: surface,
            overContent: overlay,
          ),
        );

        expect(original, RemixProgressSpec());
        expect(updated.container, same(container));
        expect(updated.track, same(track));
        expect(updated.indicator, same(indicator));
        expect(updated.trackEffects?.behindContent, same(surface));
        expect(updated.trackEffects?.overContent, same(overlay));
      },
    );

    test('equality and diagnostics include all seven structural parts', () {
      const spec = RemixProgressSpec(
        trackEffects: RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.red)],
          ),
          overContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.blue)],
          ),
        ),
        indicatorEffects: RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.green)],
          ),
          overContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.yellow)],
          ),
        ),
      );
      const equal = RemixProgressSpec(
        trackEffects: RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.red)],
          ),
          overContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.blue)],
          ),
        ),
        indicatorEffects: RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.green)],
          ),
          overContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.yellow)],
          ),
        ),
      );

      expect(spec, equal);
      expect(spec.hashCode, equal.hashCode);
      expect(spec.props, hasLength(6));
      expect(spec.props, [
        spec.container,
        spec.track,
        spec.indicator,
        spec.trackContainer,
        spec.trackEffects,
        spec.indicatorEffects,
      ]);
      expect(
        () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
        returnsNormally,
      );
    });

    test('lerp interpolates optional paint layers', () {
      const source = RemixProgressSpec(
        trackEffects: RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.red)],
          ),
        ),
      );
      const destination = RemixProgressSpec(
        trackEffects: RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.blue)],
          ),
        ),
      );

      expect(
        source
            .lerp(destination, 0.49)
            .trackEffects
            ?.behindContent
            ?.shadows
            .first
            .color,
        Color.lerp(Colors.red, Colors.blue, 0.49),
      );
      expect(
        source
            .lerp(destination, 0.5)
            .trackEffects
            ?.behindContent
            ?.shadows
            .first
            .color,
        Color.lerp(Colors.red, Colors.blue, 0.5),
      );
    });
  });
}
