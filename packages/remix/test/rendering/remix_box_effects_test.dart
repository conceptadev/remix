import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_box_effects.dart'
    show remixBoxWithEffects, remixFlexBoxWithEffects;

void main() {
  group('RemixBoxEffectsSpec', () {
    test('owns only advanced paint', () {
      const background = RemixBoxEffectLayerSpec(
        gradients: [
          LinearGradient(colors: [Colors.red, Colors.blue]),
        ],
        gradientInsets: [1],
        shadows: [RemixBoxShadow(kind: RemixBoxShadowKind.inset)],
      );
      final effects = RemixBoxEffectsSpec(
        behindContent: background,
        backdropBlur: 8,
        outline: BorderSide(color: Colors.green, width: 2),
        outlineOffset: 3,
      );

      expect(effects.behindContent, same(background));
      expect(effects.overContent, isNull);
      expect(effects.backdropBlur, 8);
      expect(effects.outline.color, Colors.green);
      expect(effects.outlineOffset, 3);
      expect(background.props, [
        background.gradients,
        [1],
        background.shadows,
      ]);
    });

    testWidgets('rejects outline stroke alignment other than inside', (
      tester,
    ) async {
      Widget build(double strokeAlign) => remixBoxWithEffects(
        styleSpec: const StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
        containerEffects: RemixBoxEffectsSpec(
          outline: BorderSide(strokeAlign: strokeAlign),
        ),
      );

      expect(() => build(BorderSide.strokeAlignCenter), throwsFlutterError);
      expect(() => build(BorderSide.strokeAlignOutside), throwsFlutterError);
      expect(RemixBoxEffectsSpec().outline, BorderSide.none);
    });

    test('fades an appearing outline through its own transparent hue', () {
      final target = RemixBoxEffectsSpec(
        outline: BorderSide(color: Color(0xFF3A7BD5), width: 4),
        outlineOffset: 6,
      );

      final middle = RemixBoxEffectsSpec.lerpNullable(null, target, 0.5)!;

      expect(middle.outline.color.a, closeTo(0.5, 1e-12));
      expect(middle.outline.color.r, closeTo(target.outline.color.r, 1e-12));
      expect(middle.outline.color.g, closeTo(target.outline.color.g, 1e-12));
      expect(middle.outline.color.b, closeTo(target.outline.color.b, 1e-12));
      expect(middle.outline.width, 2);
      expect(middle.outlineOffset, 3);
    });

    test('fades a disappearing outline through its own transparent hue', () {
      final source = RemixBoxEffectsSpec(
        outline: BorderSide(color: Color(0xFF3A7BD5), width: 4),
        outlineOffset: 6,
      );

      final middle = RemixBoxEffectsSpec.lerpNullable(source, null, 0.5)!;

      expect(middle.outline.color.a, closeTo(0.5, 1e-12));
      expect(middle.outline.color.r, closeTo(source.outline.color.r, 1e-12));
      expect(middle.outline.color.g, closeTo(source.outline.color.g, 1e-12));
      expect(middle.outline.color.b, closeTo(source.outline.color.b, 1e-12));
      expect(middle.outline.width, 2);
      expect(middle.outlineOffset, 3);
    });
  });

  group('Box effects geometry', () {
    testWidgets('uses the real Mix Box when effects are absent', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: remixBoxWithEffects(
            styleSpec: const StyleSpec(spec: BoxSpec()),
            child: const SizedBox.square(dimension: 12),
          ),
        ),
      );

      expect(find.byType(Box), findsOneWidget);
      expect(find.byType(CustomPaint), findsNothing);
    });

    testWidgets('uses the real Mix widgets when effects are empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              remixBoxWithEffects(
                styleSpec: const StyleSpec(spec: BoxSpec()),
                containerEffects: const RemixBoxEffectsSpec(
                  behindContent: RemixBoxEffectLayerSpec(),
                ),
              ),
              remixFlexBoxWithEffects(
                styleSpec: const StyleSpec(spec: FlexBoxSpec()),
                direction: Axis.horizontal,
                containerEffects: const RemixBoxEffectsSpec(
                  overContent: RemixBoxEffectLayerSpec(),
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(Box), findsOneWidget);
      expect(find.byType(RowBox), findsOneWidget);
      expect(find.byType(CustomPaint), findsNothing);
    });

    testWidgets('accepts a radius-only rectangular Box decoration', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: remixBoxWithEffects(
            styleSpec: const StyleSpec(
              spec: BoxSpec(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
              ),
            ),
            containerEffects: RemixBoxEffectsSpec(
              outline: BorderSide(color: Colors.green, width: 2),
            ),
            child: const SizedBox.square(dimension: 20),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('treats a missing decoration as a zero-radius rectangle', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: remixBoxWithEffects(
            styleSpec: const StyleSpec(spec: BoxSpec()),
            containerEffects: const RemixBoxEffectsSpec(
              outline: BorderSide(color: Colors.green, width: 2),
            ),
            child: const SizedBox.square(dimension: 20),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    for (final invalid in <Decoration?>[
      const ShapeDecoration(shape: RoundedRectangleBorder()),
      const BoxDecoration(shape: BoxShape.circle),
    ]) {
      testWidgets('rejects unsupported effect geometry: $invalid', (
        tester,
      ) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: remixBoxWithEffects(
              styleSpec: StyleSpec(spec: BoxSpec(decoration: invalid)),
              containerEffects: RemixBoxEffectsSpec(backdropBlur: 1),
              child: const SizedBox.square(dimension: 20),
            ),
          ),
        );

        final error = tester.takeException();
        expect(error, isA<FlutterError>());
        expect(error.toString(), contains('BoxDecoration'));
      });
    }

    testWidgets('matches Mix Box layout through the effects adapter', (
      tester,
    ) async {
      final spec = StyleSpec(
        spec: BoxSpec(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.all(5),
          constraints: BoxConstraints.tightFor(width: 64, height: 44),
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(width: 2)),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          transform: Matrix4.translationValues(2, 4, 0),
          transformAlignment: Alignment.topLeft,
        ),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                key: const ValueKey('mix-host'),
                width: 100,
                height: 80,
                child: Box(
                  styleSpec: spec,
                  child: const SizedBox(
                    key: ValueKey('mix-child'),
                    width: 11,
                    height: 9,
                  ),
                ),
              ),
              SizedBox(
                key: const ValueKey('effects-host'),
                width: 100,
                height: 80,
                child: remixBoxWithEffects(
                  styleSpec: spec,
                  containerEffects: const RemixBoxEffectsSpec(
                    behindContent: RemixBoxEffectLayerSpec(
                      shadows: [
                        RemixBoxShadow(
                          kind: RemixBoxShadowKind.inset,
                          color: Colors.red,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  child: const SizedBox(
                    key: ValueKey('effects-child'),
                    width: 11,
                    height: 9,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      final mixHost = tester.getTopLeft(find.byKey(const ValueKey('mix-host')));
      final effectsHost = tester.getTopLeft(
        find.byKey(const ValueKey('effects-host')),
      );
      final mixChild = tester.getRect(find.byKey(const ValueKey('mix-child')));
      final effectsChild = tester.getRect(
        find.byKey(const ValueKey('effects-child')),
      );

      expect(effectsChild.size, mixChild.size);
      expect(effectsChild.topLeft - effectsHost, mixChild.topLeft - mixHost);
    });

    testWidgets('preserves negative margins and null-child sizing', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                key: const ValueKey('negative-footprint'),
                child: remixBoxWithEffects(
                  styleSpec: const StyleSpec(
                    spec: BoxSpec(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: EdgeInsets.symmetric(
                        horizontal: -8,
                        vertical: -4,
                      ),
                      decoration: BoxDecoration(),
                    ),
                  ),
                  containerEffects: const RemixBoxEffectsSpec(
                    behindContent: RemixBoxEffectLayerSpec(
                      gradients: [
                        LinearGradient(colors: [Colors.red, Colors.blue]),
                      ],
                    ),
                  ),
                  child: const SizedBox(width: 20, height: 10),
                ),
              ),
              remixBoxWithEffects(
                key: const ValueKey('null-child'),
                styleSpec: const StyleSpec(
                  spec: BoxSpec(
                    constraints: BoxConstraints.tightFor(width: 18, height: 12),
                    decoration: BoxDecoration(),
                  ),
                ),
                containerEffects: const RemixBoxEffectsSpec(backdropBlur: 1),
              ),
            ],
          ),
        ),
      );

      expect(
        tester.getSize(find.byKey(const ValueKey('negative-footprint'))),
        const Size(20, 10),
      );
      expect(
        tester.getSize(find.byKey(const ValueKey('null-child'))),
        const Size(18, 12),
      );
    });

    testWidgets('clips content while preserving hit testing and semantics', (
      tester,
    ) async {
      var taps = 0;
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: remixBoxWithEffects(
              styleSpec: const StyleSpec(
                spec: BoxSpec(
                  constraints: BoxConstraints.tightFor(width: 30, height: 20),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
              containerEffects: const RemixBoxEffectsSpec(
                outline: BorderSide(color: Colors.green, width: 2),
                outlineOffset: 2,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => taps += 1,
                child: Semantics(
                  key: ValueKey('effects-semantics'),
                  label: 'advanced box effects child',
                  child: OverflowBox(
                    maxWidth: 60,
                    maxHeight: 40,
                    child: SizedBox(width: 60, height: 40),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ClipPath), findsOneWidget);
      await tester.tap(
        find.byKey(const ValueKey('effects-semantics')),
        warnIfMissed: false,
      );
      expect(taps, 1);
      expect(
        tester
            .getSemantics(find.byKey(const ValueKey('effects-semantics')))
            .label,
        contains('advanced box effects child'),
      );
      semantics.dispose();
    });

    testWidgets('clips blur and inner effects but not outer paint', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: remixBoxWithEffects(
            styleSpec: const StyleSpec(
              spec: BoxSpec(
                clipBehavior: Clip.hardEdge,
                constraints: BoxConstraints.tightFor(width: 30, height: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
            ),
            containerEffects: const RemixBoxEffectsSpec(
              backdropBlur: 4,
              behindContent: RemixBoxEffectLayerSpec(
                shadows: [
                  RemixBoxShadow(
                    kind: RemixBoxShadowKind.inset,
                    color: Colors.blue,
                    spreadRadius: 1,
                  ),
                  RemixBoxShadow(color: Colors.red, spreadRadius: 3),
                ],
              ),
              outline: BorderSide(color: Colors.green, width: 2),
              outlineOffset: 2,
            ),
          ),
        ),
      );

      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(ClipPath), findsOneWidget);
      expect(find.byType(CustomPaint), findsAtLeastNWidgets(3));
    });
  });
}
