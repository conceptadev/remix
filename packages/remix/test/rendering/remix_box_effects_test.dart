import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_box_effects.dart'
    show RemixBoxAdapter, RemixFlexBoxAdapter;

void main() {
  group('RemixBoxEffectsSpec', () {
    test('rejects explicit shadows and a shadow token together', () {
      expect(
        () => RemixBoxEffectLayerMix(
          shadows: [RemixBoxShadowMix()],
          shadowToken: const RemixBoxShadowListToken('test.shadow'),
        ),
        throwsArgumentError,
      );
    });

    testWidgets('rejects a non-finite backdrop blur during build', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RemixBoxAdapter(
            styleSpec: const StyleSpec(spec: BoxSpec()),
            containerEffects: const RemixBoxEffectsSpec(
              backdropBlur: double.infinity,
            ),
            child: const SizedBox.square(dimension: 20),
          ),
        ),
      );

      final exception = tester.takeException();
      expect(exception, isA<FlutterError>());
      expect(exception.toString(), contains('backdropBlur must be finite'));
    });

    final invalidEffects = <(String, RemixBoxEffectsSpec)>[
      (
        'outline.width',
        const RemixBoxEffectsSpec(outline: BorderSide(width: double.infinity)),
      ),
      (
        'gradientInsets must be empty or match',
        const RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            gradients: [
              LinearGradient(colors: [Colors.red, Colors.blue]),
            ],
            gradientInsets: [0, 1],
          ),
        ),
      ),
      (
        'gradientInsets must contain finite',
        const RemixBoxEffectsSpec(
          overContent: RemixBoxEffectLayerSpec(
            gradients: [
              LinearGradient(colors: [Colors.red, Colors.blue]),
            ],
            gradientInsets: [double.infinity],
          ),
        ),
      ),
      (
        'offset must contain finite',
        const RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(offset: Offset(double.infinity, 0))],
          ),
        ),
      ),
      (
        'blurRadius must be finite and non-negative',
        const RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(blurRadius: double.infinity)],
          ),
        ),
      ),
      (
        'spreadRadius must be finite',
        const RemixBoxEffectsSpec(
          overContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(spreadRadius: double.infinity)],
          ),
        ),
      ),
      (
        'shapeInset must be finite and non-negative',
        const RemixBoxEffectsSpec(
          overContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(shapeInset: double.infinity)],
          ),
        ),
      ),
    ];

    for (final (message, effects) in invalidEffects) {
      testWidgets('rejects invalid effects during build: $message', (
        tester,
      ) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: RemixBoxAdapter(
              styleSpec: const StyleSpec(spec: BoxSpec()),
              containerEffects: effects,
            ),
          ),
        );

        final exception = tester.takeException();
        expect(exception, isA<FlutterError>());
        expect(exception.toString(), contains(message));
      });
    }

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
      Widget build(double strokeAlign) => RemixBoxAdapter(
        styleSpec: const StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
        containerEffects: RemixBoxEffectsSpec(
          outline: BorderSide(strokeAlign: strokeAlign),
        ),
      );

      for (final strokeAlign in [
        BorderSide.strokeAlignCenter,
        BorderSide.strokeAlignOutside,
      ]) {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: build(strokeAlign),
          ),
        );
        expect(tester.takeException(), isA<FlutterError>());
      }
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

  group('effect Mixes carry the dot-shorthand pair', () {
    // Every field gets a named constructor and an instance method under the
    // same word, so the same name works as the entry point of an expression
    // and as a link in its chain. These tests are written in the shorthand
    // form on purpose: if a static counterpart went missing the file would
    // stop compiling, which is the assertion.

    test('a layer constructor sets its own field and nothing else', () {
      final shadow = RemixBoxShadowMix(blurRadius: 12);
      expect(
        RemixBoxEffectLayerMix.shadows([shadow]),
        RemixBoxEffectLayerMix(shadows: [shadow]),
      );
      expect(
        RemixBoxEffectLayerMix.gradientInsets(const [1, 2]),
        RemixBoxEffectLayerMix(gradientInsets: const [1, 2]),
      );
    });

    test('a shadow constructor sets its own field and nothing else', () {
      expect(
        RemixBoxShadowMix.blurRadius(12),
        RemixBoxShadowMix(blurRadius: 12),
      );
      expect(
        RemixBoxShadowMix.color(const Color(0xFF00FF00)),
        RemixBoxShadowMix(color: const Color(0xFF00FF00)),
      );
      expect(
        RemixBoxShadowMix.offset(const Offset(0, 4)),
        RemixBoxShadowMix(offset: const Offset(0, 4)),
      );
    });

    test('the chainable counterpart merges rather than replaces', () {
      final chained = RemixBoxShadowMix.color(
        const Color(0xFF00FF00),
      ).blurRadius(12).offset(const Offset(0, 4));

      expect(
        chained,
        RemixBoxShadowMix(
          color: const Color(0xFF00FF00),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      );
    });

    test('a whole layer reads as one shorthand expression', () {
      final RemixBoxEffectsMix shorthand = .behindContent(
        .shadows([.color(const Color(0x1A000000)).blurRadius(12)]),
      );

      expect(
        shorthand,
        RemixBoxEffectsMix(
          behindContent: RemixBoxEffectLayerMix(
            shadows: [
              RemixBoxShadowMix(color: const Color(0x1A000000), blurRadius: 12),
            ],
          ),
        ),
      );
    });
  });

  group('Box effects geometry', () {
    testWidgets('preserves mutable child state across Box renderer routes', (
      tester,
    ) async {
      final lifecycle = _ProbeLifecycle();

      Widget build(RemixBoxEffectsSpec? effects) => Directionality(
        textDirection: TextDirection.ltr,
        child: RemixBoxAdapter(
          styleSpec: const StyleSpec(spec: BoxSpec()),
          containerEffects: effects,
          child: _MutableStateProbe(lifecycle: lifecycle),
        ),
      );

      await tester.pumpWidget(build(null));
      await tester.tap(find.byKey(_MutableStateProbe.tapKey));
      await tester.pump();
      expect(find.text('value: 1'), findsOneWidget);

      await tester.pumpWidget(
        build(
          const RemixBoxEffectsSpec(
            outline: BorderSide(color: Colors.red, width: 1),
          ),
        ),
      );
      expect(find.text('value: 1'), findsOneWidget);
      expect(lifecycle.initCount, 1);
      expect(lifecycle.disposeCount, 0);

      await tester.pumpWidget(build(null));
      expect(find.text('value: 1'), findsOneWidget);
      expect(lifecycle.initCount, 1);
      expect(lifecycle.disposeCount, 0);
    });

    testWidgets('honors caller changes to the logical child key', (
      tester,
    ) async {
      final lifecycle = _ProbeLifecycle();

      Widget build(Key childKey) => Directionality(
        textDirection: TextDirection.ltr,
        child: RemixBoxAdapter(
          styleSpec: const StyleSpec(spec: BoxSpec()),
          child: _MutableStateProbe(key: childKey, lifecycle: lifecycle),
        ),
      );

      await tester.pumpWidget(build(const ValueKey('first-child')));
      await tester.tap(find.byKey(_MutableStateProbe.tapKey));
      await tester.pump();
      expect(find.text('value: 1'), findsOneWidget);

      await tester.pumpWidget(build(const ValueKey('second-child')));
      expect(find.text('value: 0'), findsOneWidget);
      expect(lifecycle.initCount, 2);
      expect(lifecycle.disposeCount, 1);
    });

    testWidgets('preserves mutable child state across Flex renderer routes', (
      tester,
    ) async {
      final lifecycle = _ProbeLifecycle();

      Widget build(RemixBoxEffectsSpec? effects) => Directionality(
        textDirection: TextDirection.ltr,
        child: RemixFlexBoxAdapter(
          styleSpec: const StyleSpec(spec: FlexBoxSpec()),
          direction: Axis.horizontal,
          containerEffects: effects,
          children: [_MutableStateProbe(lifecycle: lifecycle)],
        ),
      );

      await tester.pumpWidget(build(null));
      await tester.tap(find.byKey(_MutableStateProbe.tapKey));
      await tester.pump();
      expect(find.text('value: 1'), findsOneWidget);

      await tester.pumpWidget(
        build(
          const RemixBoxEffectsSpec(
            outline: BorderSide(color: Colors.red, width: 1),
          ),
        ),
      );
      expect(find.text('value: 1'), findsOneWidget);
      expect(lifecycle.initCount, 1);
      expect(lifecycle.disposeCount, 0);

      await tester.pumpWidget(build(null));
      expect(find.text('value: 1'), findsOneWidget);
      expect(lifecycle.initCount, 1);
      expect(lifecycle.disposeCount, 0);
    });

    testWidgets('preserves state across positive and negative margins', (
      tester,
    ) async {
      final lifecycle = _ProbeLifecycle();

      Widget build(double margin) => Directionality(
        textDirection: TextDirection.ltr,
        child: RemixBoxAdapter(
          styleSpec: StyleSpec(spec: BoxSpec(margin: EdgeInsets.all(margin))),
          child: _MutableStateProbe(lifecycle: lifecycle),
        ),
      );

      await tester.pumpWidget(build(4));
      await tester.tap(find.byKey(_MutableStateProbe.tapKey));
      await tester.pump();

      await tester.pumpWidget(build(-4));
      expect(find.text('value: 1'), findsOneWidget);
      expect(lifecycle.initCount, 1);
      expect(lifecycle.disposeCount, 0);

      await tester.pumpWidget(build(4));
      expect(find.text('value: 1'), findsOneWidget);
      expect(lifecycle.initCount, 1);
      expect(lifecycle.disposeCount, 0);
    });

    testWidgets('preserves focus while switching Box renderer routes', (
      tester,
    ) async {
      final nodes = <FocusNode>[];
      var disposeCount = 0;

      Widget build(RemixBoxEffectsSpec? effects) => Directionality(
        textDirection: TextDirection.ltr,
        child: FocusScope(
          child: RemixBoxAdapter(
            styleSpec: const StyleSpec(spec: BoxSpec()),
            containerEffects: effects,
            child: _FocusProbe(
              onCreate: nodes.add,
              onDispose: () => disposeCount += 1,
            ),
          ),
        ),
      );

      await tester.pumpWidget(build(null));
      nodes.single.requestFocus();
      await tester.pump();
      expect(nodes.single.hasFocus, isTrue);

      await tester.pumpWidget(
        build(
          const RemixBoxEffectsSpec(
            outline: BorderSide(color: Colors.red, width: 1),
          ),
        ),
      );
      expect(nodes, hasLength(1));
      expect(nodes.single.hasFocus, isTrue);
      expect(disposeCount, 0);

      await tester.pumpWidget(build(null));
      expect(nodes, hasLength(1));
      expect(nodes.single.hasFocus, isTrue);
      expect(disposeCount, 0);
    });

    testWidgets('uses the real Mix Box when effects are absent', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RemixBoxAdapter(
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
              RemixBoxAdapter(
                styleSpec: const StyleSpec(spec: BoxSpec()),
                containerEffects: const RemixBoxEffectsSpec(
                  behindContent: RemixBoxEffectLayerSpec(),
                ),
              ),
              RemixFlexBoxAdapter(
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

      expect(find.byType(Box), findsNWidgets(2));
      expect(find.byType(RowBox), findsOneWidget);
      expect(find.byType(CustomPaint), findsNothing);
    });

    for (final (direction, mixType) in <(Axis?, Type)>[
      (Axis.horizontal, RowBox),
      (Axis.vertical, ColumnBox),
      (null, FlexBox),
    ]) {
      for (final advanced in [false, true]) {
        testWidgets('uses a real $mixType on the '
            '${advanced ? 'advanced' : 'ordinary'} Flex route', (tester) async {
          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: RemixFlexBoxAdapter(
                styleSpec: StyleSpec(
                  spec: FlexBoxSpec(
                    flex: StyleSpec(spec: FlexSpec(direction: direction)),
                  ),
                ),
                direction: direction,
                containerEffects: advanced
                    ? const RemixBoxEffectsSpec(
                        outline: BorderSide(color: Colors.red, width: 1),
                      )
                    : null,
                children: const [SizedBox.square(dimension: 10)],
              ),
            ),
          );

          expect(find.byType(mixType), findsOneWidget);
          expect(find.byType(Flex), findsOneWidget);
        });
      }
    }

    testWidgets('keeps the real Mix Box for an effects-free negative margin', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  key: const ValueKey('negative-footprint'),
                  child: RemixBoxAdapter(
                    styleSpec: const StyleSpec(
                      spec: BoxSpec(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: -8,
                          vertical: -4,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.blue,
                          shape: StadiumBorder(),
                        ),
                      ),
                    ),
                    child: const SizedBox(width: 20, height: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Box), findsOneWidget);
      expect(find.byType(CustomPaint), findsNothing);
      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byKey(const ValueKey('negative-footprint'))),
        const Size(20, 10),
      );
    });

    testWidgets('keeps a real Mix Box around negative-margin Flex content', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RemixFlexBoxAdapter(
              styleSpec: const StyleSpec(
                spec: FlexBoxSpec(
                  box: StyleSpec(
                    spec: BoxSpec(
                      margin: EdgeInsets.all(-4),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(),
                    ),
                  ),
                  flex: StyleSpec(spec: FlexSpec(direction: Axis.horizontal)),
                ),
              ),
              direction: Axis.horizontal,
              children: const [SizedBox.square(dimension: 12)],
            ),
          ),
        ),
      );

      expect(find.byType(Box), findsOneWidget);
      expect(find.byType(RowBox), findsOneWidget);
      expect(find.byType(Flex), findsOneWidget);
      expect(find.byType(CustomPaint), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('accepts a radius-only rectangular Box decoration', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RemixBoxAdapter(
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
          child: RemixBoxAdapter(
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
            child: RemixBoxAdapter(
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
                child: RemixBoxAdapter(
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
                child: RemixBoxAdapter(
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
              RemixBoxAdapter(
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

    testWidgets('lays out mixed-sign margins with signed CSS arithmetic', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: UnconstrainedBox(
            child: SizedBox(
              key: const ValueKey('mixed-margin-footprint'),
              child: RemixBoxAdapter(
                styleSpec: const StyleSpec(
                  spec: BoxSpec(margin: EdgeInsets.fromLTRB(-10, 4, 6, -2)),
                ),
                child: const SizedBox(
                  key: ValueKey('mixed-margin-child'),
                  width: 40,
                  height: 30,
                ),
              ),
            ),
          ),
        ),
      );

      final footprint = tester.getRect(
        find.byKey(const ValueKey('mixed-margin-footprint')),
      );
      final child = tester.getRect(
        find.byKey(const ValueKey('mixed-margin-child')),
      );
      expect(footprint.size, const Size(36, 32));
      expect(child.topLeft - footprint.topLeft, const Offset(-10, 4));
      expect(child.size, const Size(40, 30));
    });

    testWidgets('honors tight constraints while allowing child overflow', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              key: const ValueKey('tight-margin-footprint'),
              width: 30,
              height: 20,
              child: RemixBoxAdapter(
                styleSpec: const StyleSpec(
                  spec: BoxSpec(margin: EdgeInsets.all(-5)),
                ),
                child: const SizedBox(
                  key: ValueKey('tight-margin-child'),
                  width: 10,
                  height: 10,
                ),
              ),
            ),
          ),
        ),
      );

      final footprint = tester.getRect(
        find.byKey(const ValueKey('tight-margin-footprint')),
      );
      final child = tester.getRect(
        find.byKey(const ValueKey('tight-margin-child')),
      );
      expect(footprint.size, const Size(30, 20));
      expect(child.size, const Size(40, 30));
      expect(child.topLeft - footprint.topLeft, const Offset(-5, -5));
    });

    testWidgets('clamps excessively negative unbounded footprints to zero', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: UnconstrainedBox(
            child: SizedBox(
              key: const ValueKey('unbounded-margin-footprint'),
              child: RemixBoxAdapter(
                styleSpec: const StyleSpec(
                  spec: BoxSpec(margin: EdgeInsets.all(-20)),
                ),
                child: const SizedBox(
                  key: ValueKey('unbounded-margin-child'),
                  width: 10,
                  height: 10,
                ),
              ),
            ),
          ),
        ),
      );

      expect(
        tester.getSize(
          find.byKey(const ValueKey('unbounded-margin-footprint')),
        ),
        Size.zero,
      );
      expect(
        tester.getSize(find.byKey(const ValueKey('unbounded-margin-child'))),
        const Size(40, 40),
      );
    });

    for (final (textDirection, expectedLeft) in <(TextDirection, double)>[
      (TextDirection.ltr, -5),
      (TextDirection.rtl, 10),
    ]) {
      testWidgets('resolves directional margins in $textDirection', (
        tester,
      ) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: textDirection,
            child: UnconstrainedBox(
              child: SizedBox(
                key: const ValueKey('directional-margin-footprint'),
                child: RemixBoxAdapter(
                  styleSpec: const StyleSpec(
                    spec: BoxSpec(
                      margin: EdgeInsetsDirectional.only(start: -5, end: 10),
                    ),
                  ),
                  child: const SizedBox(
                    key: ValueKey('directional-margin-child'),
                    width: 20,
                    height: 10,
                  ),
                ),
              ),
            ),
          ),
        );

        final footprint = tester.getRect(
          find.byKey(const ValueKey('directional-margin-footprint')),
        );
        final child = tester.getRect(
          find.byKey(const ValueKey('directional-margin-child')),
        );
        expect(footprint.size, const Size(25, 10));
        expect(child.left - footprint.left, expectedLeft);
      });
    }

    testWidgets('reports signed intrinsic dimensions and baseline offsets', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: _BaselineRecorder(
              child: RemixBoxAdapter(
                styleSpec: const StyleSpec(
                  spec: BoxSpec(margin: EdgeInsets.fromLTRB(-4, -3, 2, 5)),
                ),
                child: const _TestBaselineBox(),
              ),
            ),
          ),
        ),
      );

      final renderBox = _negativeMarginRenderBox(tester);
      expect(renderBox.getMinIntrinsicWidth(100), 28);
      expect(renderBox.getMaxIntrinsicWidth(100), 28);
      expect(renderBox.getMinIntrinsicHeight(100), 22);
      expect(renderBox.getMaxIntrinsicHeight(100), 22);
      expect(
        tester
            .renderObject<_RenderBaselineRecorder>(
              find.byType(_BaselineRecorder),
            )
            .baseline,
        9,
      );
      expect(
        renderBox.getDryBaseline(
          const BoxConstraints(maxWidth: 100, maxHeight: 100),
          TextBaseline.alphabetic,
        ),
        9,
      );
    });

    testWidgets('hit tests painted child overflow outside the footprint', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RemixBoxAdapter(
              styleSpec: const StyleSpec(
                spec: BoxSpec(margin: EdgeInsets.symmetric(horizontal: -10)),
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => taps += 1,
                child: const SizedBox(
                  key: ValueKey('overflow-hit-child'),
                  width: 40,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      );

      final renderBox = _negativeMarginRenderBox(tester);
      final footprintTopLeft = renderBox.localToGlobal(Offset.zero);
      final childRect = tester.getRect(
        find.byKey(const ValueKey('overflow-hit-child')),
      );
      expect(childRect.left, lessThan(footprintTopLeft.dx));

      await tester.tapAt(Offset(childRect.left + 2, childRect.center.dy));
      expect(taps, 1);
    });

    testWidgets('semantic bounds exclude visual-only paint overflow', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RemixBoxAdapter(
              styleSpec: const StyleSpec(
                spec: BoxSpec(margin: EdgeInsets.symmetric(horizontal: -5)),
              ),
              child: const _OverflowPaintBox(),
            ),
          ),
        ),
      );

      final renderBox = _negativeMarginRenderBox(tester);
      expect(renderBox.size, const Size(10, 10));
      expect(renderBox.paintBounds, const Rect.fromLTRB(-35, -30, 45, 40));
      expect(renderBox.semanticBounds, const Rect.fromLTRB(-5, 0, 15, 10));
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
            child: RemixBoxAdapter(
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
          child: RemixBoxAdapter(
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

    for (final advanced in [false, true]) {
      testWidgets('preserves Box modifiers and animation on the '
          '${advanced ? 'advanced' : 'fast'} path', (tester) async {
        final animation = AnimationConfig.linear(
          const Duration(milliseconds: 100),
        );
        Widget build(double width) => Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RemixBoxAdapter(
              key: const ValueKey('animated-box'),
              styleSpec: StyleSpec(
                spec: BoxSpec(
                  constraints: BoxConstraints.tightFor(
                    width: width,
                    height: 20,
                  ),
                  decoration: const BoxDecoration(),
                ),
                animation: animation,
                widgetModifiers: const [OpacityModifier(0.75)],
              ),
              containerEffects: advanced
                  ? const RemixBoxEffectsSpec(
                      outline: BorderSide(color: Colors.red, width: 1),
                    )
                  : null,
            ),
          ),
        );

        await tester.pumpWidget(build(20));

        expect(find.byType(Opacity), findsOneWidget);
        expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.75);
        final providers = tester.widgetList<StyleSpecProvider<BoxSpec>>(
          find.byType(StyleSpecProvider<BoxSpec>),
        );
        expect(
          providers.where((provider) => provider.spec.animation == animation),
          hasLength(1),
        );

        await tester.pumpWidget(build(40));
        await tester.pump(const Duration(milliseconds: 50));
        final animatedBox = find.byWidgetPredicate(
          (widget) =>
              widget is ConstrainedBox &&
              widget.constraints.hasTightHeight &&
              widget.constraints.maxHeight == 20,
        );
        expect(animatedBox, findsOneWidget);
        expect(tester.getSize(animatedBox).width, closeTo(30, 0.01));
        await tester.pump(const Duration(milliseconds: 50));
        expect(tester.getSize(animatedBox).width, 40);
      });
    }

    for (final advanced in [false, true]) {
      testWidgets('applies outer Flex and nested Box metadata exactly once on '
          'the ${advanced ? 'advanced' : 'ordinary'} route', (tester) async {
        final outerAnimation = AnimationConfig.linear(
          const Duration(milliseconds: 100),
        );
        final innerAnimation = AnimationConfig.linear(
          const Duration(milliseconds: 200),
        );
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: RemixFlexBoxAdapter(
              styleSpec: StyleSpec(
                spec: FlexBoxSpec(
                  box: StyleSpec(
                    spec: const BoxSpec(decoration: BoxDecoration()),
                    animation: innerAnimation,
                    widgetModifiers: const [OpacityModifier(0.6)],
                  ),
                ),
                animation: outerAnimation,
                widgetModifiers: const [OpacityModifier(0.8)],
              ),
              direction: Axis.horizontal,
              containerEffects: advanced
                  ? const RemixBoxEffectsSpec(
                      outline: BorderSide(color: Colors.red, width: 1),
                    )
                  : null,
              children: const [SizedBox.square(dimension: 10)],
            ),
          ),
        );

        final opacities = tester
            .widgetList<Opacity>(find.byType(Opacity))
            .map((widget) => widget.opacity)
            .toList();
        expect(opacities, hasLength(2));
        expect(opacities, containsAll(<double>[0.6, 0.8]));
        expect(
          tester
              .widgetList<StyleSpecProvider<FlexBoxSpec>>(
                find.byType(StyleSpecProvider<FlexBoxSpec>),
              )
              .where((provider) => provider.spec.animation == outerAnimation),
          hasLength(1),
        );
        expect(
          tester
              .widgetList<StyleSpecProvider<BoxSpec>>(
                find.byType(StyleSpecProvider<BoxSpec>),
              )
              .where((provider) => provider.spec.animation == innerAnimation),
          hasLength(1),
        );
      });
    }

    testWidgets('uses Mix forced-direction validation', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RemixFlexBoxAdapter(
            styleSpec: const StyleSpec(
              spec: FlexBoxSpec(
                box: StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
                flex: StyleSpec(spec: FlexSpec(direction: Axis.vertical)),
              ),
            ),
            direction: Axis.horizontal,
            containerEffects: const RemixBoxEffectsSpec(
              outline: BorderSide(color: Colors.red, width: 1),
            ),
          ),
        ),
      );

      final exception = tester.takeException();
      expect(exception, isA<AssertionError>());
      expect(
        exception.toString(),
        contains('Direction cannot be specified in the spec for RowBox'),
      );
    });
  });
}

RenderBox _negativeMarginRenderBox(WidgetTester tester) {
  final finder = find.byWidgetPredicate(
    (widget) => widget.runtimeType.toString() == '_RemixNegativeMargin',
  );
  expect(finder, findsOneWidget);
  return tester.renderObject<RenderBox>(finder);
}

final class _ProbeLifecycle {
  int initCount = 0;
  int disposeCount = 0;
}

final class _MutableStateProbe extends StatefulWidget {
  const _MutableStateProbe({super.key, required this.lifecycle});

  static const tapKey = ValueKey('mutable-state-probe');

  final _ProbeLifecycle lifecycle;

  @override
  State<_MutableStateProbe> createState() => _MutableStateProbeState();
}

final class _MutableStateProbeState extends State<_MutableStateProbe> {
  var _value = 0;

  @override
  void initState() {
    super.initState();
    widget.lifecycle.initCount += 1;
  }

  @override
  void dispose() {
    widget.lifecycle.disposeCount += 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    key: _MutableStateProbe.tapKey,
    behavior: HitTestBehavior.opaque,
    onTap: () => setState(() => _value += 1),
    child: Text('value: $_value'),
  );
}

final class _FocusProbe extends StatefulWidget {
  const _FocusProbe({required this.onCreate, required this.onDispose});

  final ValueChanged<FocusNode> onCreate;
  final VoidCallback onDispose;

  @override
  State<_FocusProbe> createState() => _FocusProbeState();
}

final class _FocusProbeState extends State<_FocusProbe> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    widget.onCreate(_focusNode);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Focus(focusNode: _focusNode, child: const SizedBox.square(dimension: 20));
}

final class _OverflowPaintBox extends LeafRenderObjectWidget {
  const _OverflowPaintBox();

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderOverflowPaintBox();
}

final class _TestBaselineBox extends LeafRenderObjectWidget {
  const _TestBaselineBox();

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderTestBaselineBox();
}

final class _BaselineRecorder extends SingleChildRenderObjectWidget {
  const _BaselineRecorder({required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderBaselineRecorder();
}

final class _RenderBaselineRecorder extends RenderProxyBox {
  double? baseline;

  @override
  void performLayout() {
    child!.layout(constraints.loosen(), parentUsesSize: true);
    size = constraints.constrain(child!.size);
    baseline = child!.getDistanceToBaseline(TextBaseline.alphabetic);
  }
}

final class _RenderOverflowPaintBox extends RenderBox {
  @override
  void performLayout() {
    size = constraints.constrain(const Size(20, 10));
  }

  @override
  Rect get paintBounds =>
      Rect.fromLTRB(-30, -30, size.width + 30, size.height + 30);
}

final class _RenderTestBaselineBox extends RenderBox {
  @override
  void performLayout() {
    size = constraints.constrain(const Size(30, 20));
  }

  @override
  double computeMinIntrinsicWidth(double height) => 30;

  @override
  double computeMaxIntrinsicWidth(double height) => 30;

  @override
  double computeMinIntrinsicHeight(double width) => 20;

  @override
  double computeMaxIntrinsicHeight(double width) => 20;

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) => 12;

  @override
  double? computeDryBaseline(
    covariant BoxConstraints constraints,
    TextBaseline baseline,
  ) => 12;
}
