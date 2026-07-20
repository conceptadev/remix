import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_surface.dart' show RemixSurfaceBox;

void main() {
  group('Remix paint models', () {
    test(
      'shadow interpolation preserves geometry and switches kind discretely',
      () {
        const outer = RemixPaintShadow(
          kind: RemixPaintShadowKind.outer,
          color: Color(0xFF000000),
          offset: Offset(2, 4),
          blurRadius: 6,
          spreadRadius: 8,
        );
        const inset = RemixPaintShadow(
          kind: RemixPaintShadowKind.inset,
          color: Color(0xFFFFFFFF),
          offset: Offset(6, 8),
          blurRadius: 10,
          spreadRadius: 12,
          shapeInset: 14,
        );

        expect(
          RemixPaintShadow.lerp(outer, inset, 0.25),
          const RemixPaintShadow(
            kind: RemixPaintShadowKind.outer,
            color: Color.from(alpha: 1, red: 0.25, green: 0.25, blue: 0.25),
            offset: Offset(3, 5),
            blurRadius: 7,
            spreadRadius: 9,
            shapeInset: 3.5,
          ),
        );
        expect(
          RemixPaintShadow.lerp(outer, inset, 0.75)!.kind,
          RemixPaintShadowKind.inset,
        );
      },
    );

    testWidgets('shadow and gradient mixes resolve nested token references', (
      tester,
    ) async {
      const color = ColorToken('surface.test.color');
      const distance = DoubleToken('surface.test.distance');
      const position = DoubleToken('surface.test.position');
      const radius = RadiusToken('surface.test.radius');
      late RemixPaintShadow shadow;
      late LinearGradient gradient;
      late RemixSurfaceLayerSpec surface;

      await tester.pumpWidget(
        MixScope(
          tokens: {
            color: Color(0xFF123456),
            distance: 7.0,
            position: 1.0,
            radius: Radius.circular(11),
          },
          child: Builder(
            builder: (context) {
              shadow = RemixPaintShadowMix(
                kind: .inset,
                color: color(),
                offset: const Offset(2, 3),
                blurRadius: distance(),
                spreadRadius: distance(),
                shapeInset: distance(),
              ).resolve(context);
              gradient = RemixLinearGradientMix(
                colors: [color(), const Color(0xFFFFFFFF)],
                stops: [0, position()],
              ).resolve(context);
              surface = RemixSurfaceLayerMix(
                color: color(),
                borderRadius: BorderRadiusMix.all(radius()),
                backdropBlur: distance(),
                gradients: [
                  RemixLinearGradientMix(
                    colors: [color(), const Color(0xFFFFFFFF)],
                  ),
                ],
                gradientInsets: const [2],
                shadows: [RemixPaintShadowMix(color: color())],
                outlineColor: color(),
                outlineWidth: distance(),
                outlineOffset: 2,
              ).resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(shadow.kind, RemixPaintShadowKind.inset);
      expect(shadow.color, const Color(0xFF123456));
      expect(shadow.blurRadius, 7);
      expect(shadow.spreadRadius, 7);
      expect(shadow.shapeInset, 7);
      expect(gradient.colors, [
        const Color(0xFF123456),
        const Color(0xFFFFFFFF),
      ]);
      expect(gradient.stops, [0, 1]);
      expect(surface.color, const Color(0xFF123456));
      expect(surface.borderRadius, const BorderRadius.all(Radius.circular(11)));
      expect(surface.backdropBlur, 7);
      expect(surface.gradients, hasLength(1));
      expect(surface.gradientInsets, [2]);
      expect(surface.shadows.single.color, const Color(0xFF123456));
      expect(surface.outlineColor, const Color(0xFF123456));
      expect(surface.outlineWidth, 7);
      expect(surface.outlineOffset, 2);
    });

    testWidgets('explicit shadows replace a token-backed shadow recipe', (
      tester,
    ) async {
      late RemixSurfaceLayerSpec cleared;
      late RemixSurfaceLayerSpec restored;

      await tester.pumpWidget(
        FortalScope(
          child: Builder(
            builder: (context) {
              final tokenBacked = RemixSurfaceLayerMix(
                shadowToken: FortalTokens.shadow1,
              );
              final explicit = RemixSurfaceLayerMix(shadows: const []);
              cleared = tokenBacked.merge(explicit).resolve(context);
              restored = explicit.merge(tokenBacked).resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(cleared.shadows, isEmpty);
      expect(restored.shadows, isNotEmpty);
    });

    testWidgets('linear gradients normalize CSS stops outside the paint line', (
      tester,
    ) async {
      late LinearGradient gradient;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            gradient = RemixLinearGradientMix(
              colors: const [Colors.red, Colors.green, Colors.blue],
              stops: const [-0.2, 0.5, 1.2],
            ).resolve(context);
            return const SizedBox.shrink();
          },
        ),
      );

      expect(gradient.stops, [0, 0.5, 1]);
      _expectColorClose(
        gradient.colors.first,
        Color.lerp(Colors.red, Colors.green, (0 - -0.2) / (0.5 - -0.2))!,
      );
      expect(gradient.colors[1], Colors.green);
      _expectColorClose(
        gradient.colors.last,
        Color.lerp(Colors.green, Colors.blue, (1 - 0.5) / (1.2 - 0.5))!,
      );
    });

    testWidgets('linear gradients preserve hard stops at paint boundaries', (
      tester,
    ) async {
      late LinearGradient gradient;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            gradient = RemixLinearGradientMix(
              colors: const [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
              ],
              stops: const [-0.2, 0, 0, 1.2],
            ).resolve(context);
            return const SizedBox.shrink();
          },
        ),
      );

      expect(gradient.stops, [0, 0, 0, 1]);
      _expectColorClose(gradient.colors[0], Colors.green);
      _expectColorClose(gradient.colors[1], Colors.green);
      _expectColorClose(gradient.colors[2], Colors.blue);
      _expectColorClose(
        gradient.colors[3],
        Color.lerp(Colors.blue, Colors.yellow, 1 / 1.2)!,
      );
    });

    testWidgets('linear gradients reject non-finite stops', (tester) async {
      Object? error;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            try {
              RemixLinearGradientMix(
                colors: const [Colors.red, Colors.blue],
                stops: const [0, double.nan],
              ).resolve(context);
            } catch (value) {
              error = value;
            }
            return const SizedBox.shrink();
          },
        ),
      );

      expect(error, isA<FlutterError>());
    });

    test('surface interpolation normalizes unequal layer counts', () {
      const first = RemixSurfaceLayerSpec(
        color: Color(0xFF000000),
        gradients: [
          LinearGradient(colors: [Color(0xFFFF0000), Color(0xFF00FF00)]),
        ],
        gradientInsets: [2],
        shadows: [RemixPaintShadow(color: Color(0xFF000000), blurRadius: 4)],
      );
      const second = RemixSurfaceLayerSpec(
        color: Color(0xFFFFFFFF),
        gradients: [
          LinearGradient(colors: [Color(0xFF0000FF), Color(0xFFFFFFFF)]),
          LinearGradient(colors: [Color(0xFFFF00FF), Color(0xFF00FFFF)]),
        ],
        gradientInsets: [4, 6],
        shadows: [
          RemixPaintShadow(color: Color(0xFFFFFFFF), blurRadius: 8),
          RemixPaintShadow(kind: .inset, color: Color(0xFFFF0000)),
        ],
      );

      final middle = first.lerp(second, 0.5);

      expect(
        middle.color,
        const Color.from(alpha: 1, red: 0.5, green: 0.5, blue: 0.5),
      );
      expect(middle.gradients, hasLength(2));
      expect(middle.gradientInsets, [3, 3]);
      expect(middle.shadows, hasLength(2));
      expect(middle.shadows.first.blurRadius, 6);
      expect(middle.shadows.last.kind, RemixPaintShadowKind.inset);
    });

    test('surface interpolation expands implicit zero gradient insets', () {
      const first = RemixSurfaceLayerSpec(
        gradients: [
          LinearGradient(colors: [Colors.red, Colors.red]),
          LinearGradient(colors: [Colors.green, Colors.green]),
        ],
      );
      const second = RemixSurfaceLayerSpec(
        gradients: [
          LinearGradient(colors: [Colors.blue, Colors.blue]),
        ],
        gradientInsets: [2],
      );

      final middle = first.lerp(second, 0.5);

      expect(middle.gradients, hasLength(2));
      expect(middle.gradientInsets, [1, 0]);
    });

    test('surface interpolation keeps extrapolated insets non-negative', () {
      const first = RemixSurfaceLayerSpec(
        gradients: [
          LinearGradient(colors: [Colors.red, Colors.red]),
        ],
        gradientInsets: [2],
      );
      const second = RemixSurfaceLayerSpec(
        gradients: [
          LinearGradient(colors: [Colors.blue, Colors.blue]),
        ],
      );

      final extrapolated = first.lerp(second, 1.2);

      expect(extrapolated.gradientInsets, [0]);
    });
  });

  group('RemixSurface', () {
    testWidgets('clips individual gradients to their configured inset', (
      tester,
    ) async {
      const boundaryKey = ValueKey('gradient-inset-boundary');

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: RepaintBoundary(
            key: boundaryKey,
            child: SizedBox.square(
              dimension: 10,
              child: RemixSurface(
                spec: RemixSurfaceLayerSpec(
                  color: Colors.blue,
                  gradients: [
                    LinearGradient(colors: [Colors.red, Colors.red]),
                  ],
                  gradientInsets: [2],
                ),
                child: SizedBox.expand(),
              ),
            ),
          ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));

      expect(_pixel(pixels, 0, 5), _rgba(Colors.blue));
      expect(_pixel(pixels, 2, 5), _rgba(Colors.red));
      expect(_pixel(pixels, 5, 5), _rgba(Colors.red));
    });

    testWidgets('paints CSS layer order and inset/outer geometry', (
      tester,
    ) async {
      const boundaryKey = ValueKey('boundary');

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: boundaryKey,
              child: SizedBox.square(
                dimension: 20,
                child: Center(
                  child: RemixSurface(
                    spec: RemixSurfaceLayerSpec(
                      color: Colors.blue,
                      gradients: [
                        LinearGradient(colors: [Colors.green, Colors.green]),
                        LinearGradient(colors: [Colors.purple, Colors.purple]),
                      ],
                      shadows: [
                        RemixPaintShadow(color: Colors.cyan, spreadRadius: 2),
                        RemixPaintShadow(
                          kind: RemixPaintShadowKind.inset,
                          color: Colors.yellow,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: SizedBox.square(dimension: 10),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));

      expect(_pixel(pixels, 4, 10), _rgba(Colors.cyan));
      expect(_pixel(pixels, 6, 10), _rgba(Colors.yellow));
      expect(_pixel(pixels, 10, 10), _rgba(Colors.green));
    });

    testWidgets('paints an offset outline with a transparent gap', (
      tester,
    ) async {
      const boundaryKey = ValueKey('outline-boundary');

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: boundaryKey,
              child: SizedBox.square(
                dimension: 20,
                child: Center(
                  child: RemixSurface(
                    spec: RemixSurfaceLayerSpec(
                      color: Colors.blue,
                      outlineColor: Colors.red,
                      outlineWidth: 2,
                      outlineOffset: 2,
                    ),
                    child: SizedBox.square(dimension: 10),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));

      expect(_pixel(pixels, 2, 10), _rgba(Colors.red));
      expect(_pixel(pixels, 4, 10), _rgba(Colors.transparent));
      expect(_pixel(pixels, 5, 10), _rgba(Colors.blue));
    });

    testWidgets('paints a negative outline over the surface fill', (
      tester,
    ) async {
      const boundaryKey = ValueKey('negative-outline-boundary');

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: boundaryKey,
              child: SizedBox.square(
                dimension: 20,
                child: Center(
                  child: RemixSurface(
                    spec: RemixSurfaceLayerSpec(
                      color: Colors.blue,
                      outlineColor: Colors.red,
                      outlineWidth: 2,
                      outlineOffset: -1,
                    ),
                    child: SizedBox.square(dimension: 10),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));

      expect(_pixel(pixels, 5, 10), _rgba(Colors.red));
      expect(_pixel(pixels, 10, 10), _rgba(Colors.blue));
    });

    testWidgets('does not make an ignored child hittable', (tester) async {
      var backgroundTaps = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => backgroundTaps += 1,
              ),
              const RemixSurface(
                spec: RemixSurfaceLayerSpec(color: Colors.transparent),
                child: IgnorePointer(child: SizedBox.expand()),
              ),
            ],
          ),
        ),
      );

      await tester.tapAt(const Offset(100, 100));
      expect(backgroundTaps, 1);
    });

    testWidgets('preserves layout, baseline, hit testing, and semantics', (
      tester,
    ) async {
      var taps = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                const Text('plain', key: ValueKey('plain')),
                RemixSurface(
                  spec: const RemixSurfaceLayerSpec(color: Colors.red),
                  child: GestureDetector(
                    onTap: () => taps += 1,
                    child: Semantics(
                      key: const ValueKey('surface-semantics'),
                      label: 'surface child',
                      child: const Text('wrapped', key: ValueKey('wrapped')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(
        tester.getTopLeft(find.byKey(const ValueKey('plain'))).dy,
        tester.getTopLeft(find.byKey(const ValueKey('wrapped'))).dy,
      );
      expect(
        tester.getSize(find.byType(RemixSurface)),
        tester.getSize(find.byKey(const ValueKey('wrapped'))),
      );
      await tester.tap(find.byKey(const ValueKey('wrapped')));
      expect(taps, 1);
      expect(
        tester
            .getSemantics(find.byKey(const ValueKey('surface-semantics')))
            .label,
        contains('surface child'),
      );
    });

    testWidgets('clips backdrop blur to the resolved surface radius', (
      tester,
    ) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: RemixSurface(
            spec: RemixSurfaceLayerSpec(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              backdropBlur: 64,
            ),
            child: SizedBox.square(dimension: 20),
          ),
        ),
      );

      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(
        tester.widget<ClipRRect>(find.byType(ClipRRect)).borderRadius,
        const BorderRadius.all(Radius.circular(12)),
      );
    });

    testWidgets('paints inset offset, positive spread, and negative spread', (
      tester,
    ) async {
      const boundaryKey = ValueKey('inset-geometry');

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: boundaryKey,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RemixSurface(
                    spec: RemixSurfaceLayerSpec(
                      color: Colors.white,
                      shadows: [
                        RemixPaintShadow(
                          kind: RemixPaintShadowKind.inset,
                          color: Colors.black,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: SizedBox.square(dimension: 20),
                  ),
                  RemixSurface(
                    spec: RemixSurfaceLayerSpec(
                      color: Colors.white,
                      shadows: [
                        RemixPaintShadow(
                          kind: RemixPaintShadowKind.inset,
                          color: Colors.black,
                          spreadRadius: -3,
                        ),
                      ],
                    ),
                    child: SizedBox.square(dimension: 20),
                  ),
                  RemixSurface(
                    spec: RemixSurfaceLayerSpec(
                      color: Colors.white,
                      shadows: [
                        RemixPaintShadow(
                          kind: RemixPaintShadowKind.inset,
                          color: Colors.black,
                          offset: Offset(3, 0),
                        ),
                      ],
                    ),
                    child: SizedBox.square(dimension: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));

      expect(_pixel(pixels, 1, 10), _rgba(Colors.black));
      expect(_pixel(pixels, 5, 10), _rgba(Colors.white));
      expect(_pixel(pixels, 21, 10), _rgba(Colors.white));
      expect(_pixel(pixels, 41, 10), _rgba(Colors.black));
      expect(_pixel(pixels, 58, 10), _rgba(Colors.white));
    });

    testWidgets('inset blur falls off from the inner edge', (tester) async {
      const boundaryKey = ValueKey('inset-blur');

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: boundaryKey,
              child: RemixSurface(
                spec: RemixSurfaceLayerSpec(
                  color: Colors.white,
                  shadows: [
                    RemixPaintShadow(
                      kind: RemixPaintShadowKind.inset,
                      color: Colors.black,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: SizedBox.square(dimension: 30),
              ),
            ),
          ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));
      final nearEdge = _red(_pixel(pixels, 1, 15));
      final middle = _red(_pixel(pixels, 5, 15));
      final center = _red(_pixel(pixels, 15, 15));

      expect(nearEdge, lessThan(middle));
      expect(middle, lessThan(center));
      expect(center, 255);
    });

    testWidgets('shadow shape insets target an inset pseudo-element', (
      tester,
    ) async {
      const boundaryKey = ValueKey('shape-inset');
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: boundaryKey,
              child: RemixSurface(
                spec: RemixSurfaceLayerSpec(
                  color: Colors.white,
                  shadows: [
                    RemixPaintShadow(
                      kind: RemixPaintShadowKind.inset,
                      color: Colors.black,
                      spreadRadius: 2,
                      shapeInset: 3,
                    ),
                  ],
                ),
                child: SizedBox.square(dimension: 20),
              ),
            ),
          ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));
      expect(_pixel(pixels, 1, 10), _rgba(Colors.white));
      expect(_pixel(pixels, 3, 10), _rgba(Colors.black));
      expect(_pixel(pixels, 6, 10), _rgba(Colors.white));
    });

    testWidgets(
      'surface boxes paint inside constraints and margin with border on top',
      (tester) async {
        const boundaryKey = ValueKey('surface-box-placement');

        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: RepaintBoundary(
                key: boundaryKey,
                child: RemixSurfaceBox(
                  styleSpec: StyleSpec(
                    spec: BoxSpec(
                      constraints: BoxConstraints.tightFor(
                        width: 20,
                        height: 20,
                      ),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                  ),
                  surface: RemixSurfaceLayerSpec(color: Colors.red),
                  child: ColoredBox(color: Colors.green),
                ),
              ),
            ),
          ),
        );

        final pixels = await _capture(tester, find.byKey(boundaryKey));

        expect(_pixel(pixels, 2, 15), 0);
        expect(_pixel(pixels, 5, 15), _rgba(Colors.blue));
        expect(_pixel(pixels, 7, 15), _rgba(Colors.red));
        expect(_pixel(pixels, 10, 15), _rgba(Colors.green));
      },
    );

    testWidgets('surface boxes paint translucent decoration borders once', (
      tester,
    ) async {
      const boundaryKey = ValueKey('single-border-composition');
      const borderColor = Color(0x80000000);

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: boundaryKey,
              child: RemixSurfaceBox(
                styleSpec: StyleSpec(
                  spec: BoxSpec(
                    constraints: BoxConstraints.tightFor(width: 20, height: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.fromBorderSide(
                        BorderSide(color: borderColor, width: 2),
                      ),
                    ),
                  ),
                ),
                surface: RemixSurfaceLayerSpec(color: Colors.red),
              ),
            ),
          ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));
      expect(
        _pixel(pixels, 1, 10),
        _rgba(Color.alphaBlend(borderColor, Colors.white)),
      );
    });

    testWidgets('surface boxes keep decoration shadows outside their clip', (
      tester,
    ) async {
      const boundaryKey = ValueKey('unclipped-decoration-shadow');

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: boundaryKey,
              child: SizedBox.square(
                dimension: 40,
                child: Center(
                  child: RemixSurfaceBox(
                    styleSpec: StyleSpec(
                      spec: BoxSpec(
                        constraints: BoxConstraints.tightFor(
                          width: 20,
                          height: 20,
                        ),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          boxShadow: [
                            BoxShadow(color: Colors.red, spreadRadius: 4),
                          ],
                        ),
                      ),
                    ),
                    surface: RemixSurfaceLayerSpec(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final shadowDecorations = tester
          .widgetList<DecoratedBox>(
            find.descendant(
              of: find.byKey(boundaryKey),
              matching: find.byType(DecoratedBox),
            ),
          )
          .where(
            (box) => switch (box.decoration) {
              BoxDecoration(:final boxShadow?) => boxShadow.isNotEmpty,
              _ => false,
            },
          );
      final pixels = await _capture(tester, find.byKey(boundaryKey));
      expect(shadowDecorations, hasLength(1));
      expect(_pixel(pixels, 7, 20), _rgba(Colors.red));
      expect(_pixel(pixels, 20, 20), _rgba(Colors.white));
    });

    testWidgets('surface boxes support CSS-style negative margins', (
      tester,
    ) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              key: ValueKey('layout-footprint'),
              child: RemixSurfaceBox(
                styleSpec: StyleSpec(
                  spec: BoxSpec(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: -8, vertical: -4),
                  ),
                ),
                child: SizedBox(width: 20, height: 10),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byKey(const ValueKey('layout-footprint'))),
        const Size(20, 10),
      );
    });
  });
}

Future<({ByteData bytes, int width})> _capture(
  WidgetTester tester,
  Finder finder,
) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(finder);
  final result = await tester.runAsync(() async {
    final image = boundary.toImageSync(pixelRatio: 1);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final width = image.width;
    image.dispose();
    return (bytes: bytes!, width: width);
  });
  return result!;
}

int _pixel(({ByteData bytes, int width}) image, int x, int y) {
  final offset = (y * image.width + x) * 4;
  return image.bytes.getUint32(offset);
}

int _rgba(Color color) {
  final argb = color.toARGB32();
  return ((argb & 0x00FFFFFF) << 8) | (argb >>> 24);
}

int _red(int rgba) => rgba >>> 24;

void _expectColorClose(Color actual, Color expected) {
  expect(actual.a, closeTo(expected.a, 1e-12));
  expect(actual.r, closeTo(expected.r, 1e-12));
  expect(actual.g, closeTo(expected.g, 1e-12));
  expect(actual.b, closeTo(expected.b, 1e-12));
}
