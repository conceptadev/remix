import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixProgressStyler', () {
    test('constructor forwards every component style', () {
      final container = BoxStyler();
      final track = BoxStyler();
      final indicator = BoxStyler();
      final surface = RemixSurfaceLayerMix();
      final overlay = RemixSurfaceLayerMix();
      final effects = RemixSurfaceEffectsMix(
        background: surface,
        foreground: overlay,
      );

      final style = RemixProgressStyler(
        container: container,
        track: track,
        indicator: indicator,
        trackEffects: effects,
      );

      expect(style.$container, Prop.maybeMix(container));
      expect(style.$track, Prop.maybeMix(track));
      expect(style.$indicator, Prop.maybeMix(indicator));
      expect(style.$trackEffects, Prop.maybeMix(effects));
    });

    testWidgets('resolves box and surface fields', (tester) async {
      final style = RemixProgressStyler()
          .height(12)
          .trackColor(Colors.grey)
          .indicatorColor(Colors.blue)
          .trackEffects(
            RemixSurfaceEffectsMix(
              background: RemixSurfaceLayerMix(
                shadows: [RemixPaintShadowMix(color: Colors.red)],
              ),
            ),
          )
          .trackEffects(
            RemixSurfaceEffectsMix(
              foreground: RemixSurfaceLayerMix(
                shadows: [RemixPaintShadowMix(color: Colors.green)],
              ),
            ),
          );

      late StyleSpec<RemixProgressSpec> resolved;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              resolved = style.resolve(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(resolved.spec.container.spec.constraints?.maxHeight, 12);
      expect(
        (resolved.spec.track.spec.decoration as BoxDecoration).color,
        Colors.grey,
      );
      expect(
        (resolved.spec.indicator.spec.decoration as BoxDecoration).color,
        Colors.blue,
      );
      expect(
        resolved.spec.trackEffects?.background?.shadows.first.color,
        Colors.red,
      );
      expect(
        resolved.spec.trackEffects?.foreground?.shadows.first.color,
        Colors.green,
      );
    });

    test('merge is immutable and preserves unrelated fields', () {
      final base = RemixProgressStyler().height(8).trackColor(Colors.grey);
      final merged = base.merge(
        RemixProgressStyler().indicatorColor(Colors.blue),
      );

      expect(base.$indicator, isNull);
      expect(merged.$track, base.$track);
      expect(merged.$indicator, isNotNull);
    });

    test('call forwards the progress contract', () {
      final styler = RemixProgressStyler().height(8);
      final widget = styler(
        value: 25,
        max: 200,
        duration: const Duration(seconds: 3),
        semanticLabel: 'Upload',
        excludeSemantics: true,
      );

      expect(widget.value, 25);
      expect(widget.max, 200);
      expect(widget.duration, const Duration(seconds: 3));
      expect(widget.semanticLabel, 'Upload');
      expect(widget.excludeSemantics, isTrue);
      expect(widget.style, same(styler));
    });

    test('identical styles compare equal', () {
      expect(RemixProgressStyler().height(8), RemixProgressStyler().height(8));
      expect(
        RemixProgressStyler().height(8),
        isNot(RemixProgressStyler().height(12)),
      );
    });
  });
}
