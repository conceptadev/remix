import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_box_effects.dart'
    show RemixBoxWithEffects;

void main() {
  group('Remix box effects pixel contract', () {
    testWidgets('clips inset gradients and preserves CSS layer order', (
      tester,
    ) async {
      final pixels = await _render(
        tester,
        size: const Size(12, 12),
        child: RemixBoxWithEffects(
          styleSpec: const StyleSpec(
            spec: BoxSpec(
              constraints: BoxConstraints.tightFor(width: 12, height: 12),
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
          containerEffects: const RemixBoxEffectsSpec(
            behindContent: RemixBoxEffectLayerSpec(
              gradients: [
                LinearGradient(colors: [Colors.red, Colors.red]),
                LinearGradient(colors: [Colors.green, Colors.green]),
              ],
              gradientInsets: [3, 1],
            ),
          ),
        ),
      );

      expect(_pixel(pixels, 0, 6), _rgba(Colors.blue));
      expect(_pixel(pixels, 1, 6), _rgba(Colors.green));
      expect(_pixel(pixels, 3, 6), _rgba(Colors.red));
    });

    testWidgets('preserves inset spread, offset, blur, and shapeInset', (
      tester,
    ) async {
      final pixels = await _render(
        tester,
        size: const Size(80, 24),
        child: Row(
          children: [
            _insetSample(
              const RemixBoxShadow(
                kind: RemixBoxShadowKind.inset,
                color: Colors.black,
                spreadRadius: 3,
              ),
            ),
            _insetSample(
              const RemixBoxShadow(
                kind: RemixBoxShadowKind.inset,
                color: Colors.black,
                spreadRadius: -3,
              ),
            ),
            _insetSample(
              const RemixBoxShadow(
                kind: RemixBoxShadowKind.inset,
                color: Colors.black,
                offset: Offset(3, 0),
              ),
            ),
            _insetSample(
              const RemixBoxShadow(
                kind: RemixBoxShadowKind.inset,
                color: Colors.black,
                blurRadius: 8,
                shapeInset: 3,
              ),
            ),
          ],
        ),
      );

      expect(_pixel(pixels, 1, 12), _rgba(Colors.black));
      expect(_pixel(pixels, 6, 12), _rgba(Colors.white));
      expect(_pixel(pixels, 21, 12), _rgba(Colors.white));
      expect(_pixel(pixels, 41, 12), _rgba(Colors.black));
      expect(_pixel(pixels, 58, 12), _rgba(Colors.white));
      expect(_red(_pixel(pixels, 61, 12)), greaterThan(240));
      expect(
        _red(_pixel(pixels, 63, 12)),
        lessThan(_red(_pixel(pixels, 66, 12))),
      );
      expect(
        _red(_pixel(pixels, 66, 12)),
        lessThan(_red(_pixel(pixels, 70, 12))),
      );
    });

    testWidgets(
      'orders border, content, foreground decoration, effects, outline',
      (tester) async {
        final pixels = await _render(
          tester,
          size: const Size(32, 32),
          child: Center(
            child: RemixBoxWithEffects(
              styleSpec: const StyleSpec(
                spec: BoxSpec(
                  constraints: BoxConstraints.tightFor(width: 20, height: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.yellow, width: 2),
                    ),
                  ),
                  foregroundDecoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.purple, width: 2),
                    ),
                  ),
                ),
              ),
              containerEffects: const RemixBoxEffectsSpec(
                overContent: RemixBoxEffectLayerSpec(
                  gradients: [
                    LinearGradient(colors: [Colors.green, Colors.green]),
                  ],
                  gradientInsets: [5],
                ),
                outline: BorderSide(color: Colors.red, width: 2),
                outlineOffset: 2,
              ),
              child: const ColoredBox(color: Colors.orange),
            ),
          ),
        );

        expect(_pixel(pixels, 2, 16), _rgba(Colors.red));
        expect(_pixel(pixels, 4, 16), _rgba(Colors.transparent));
        expect(_pixel(pixels, 6, 16), _rgba(Colors.purple));
        expect(_pixel(pixels, 9, 16), _rgba(Colors.orange));
        expect(_pixel(pixels, 11, 16), _rgba(Colors.green));
      },
    );

    testWidgets(
      'keeps ordinary and advanced shadows outside clipping and blur',
      (tester) async {
        final pixels = await _render(
          tester,
          size: const Size(48, 32),
          background: Colors.white,
          child: Center(
            child: RemixBoxWithEffects(
              styleSpec: const StyleSpec(
                spec: BoxSpec(
                  constraints: BoxConstraints.tightFor(width: 20, height: 20),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    boxShadow: [BoxShadow(color: Colors.red, spreadRadius: 2)],
                  ),
                ),
              ),
              containerEffects: const RemixBoxEffectsSpec(
                backdropBlur: 4,
                behindContent: RemixBoxEffectLayerSpec(
                  shadows: [
                    RemixBoxShadow(color: Colors.blue, spreadRadius: 4),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(_pixel(pixels, 10, 16), _rgba(Colors.blue));
        expect(_pixel(pixels, 12, 16), _rgba(Colors.red));
        expect(_pixel(pixels, 24, 16), _rgba(Colors.white));
      },
    );
  });
}

Widget _insetSample(RemixBoxShadow shadow) => RemixBoxWithEffects(
  styleSpec: const StyleSpec(
    spec: BoxSpec(
      constraints: BoxConstraints.tightFor(width: 20, height: 24),
      decoration: BoxDecoration(color: Colors.white),
    ),
  ),
  containerEffects: RemixBoxEffectsSpec(
    behindContent: RemixBoxEffectLayerSpec(shadows: [shadow]),
  ),
);

Future<({ByteData bytes, int width})> _render(
  WidgetTester tester, {
  required Size size,
  required Widget child,
  Color background = Colors.transparent,
}) async {
  const boundaryKey = ValueKey('box-effects-pixels');
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RepaintBoundary(
          key: boundaryKey,
          child: ColoredBox(
            color: background,
            child: SizedBox.fromSize(size: size, child: child),
          ),
        ),
      ),
    ),
  );
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(boundaryKey),
  );
  final result = await tester.runAsync(() async {
    final image = boundary.toImageSync(pixelRatio: 1);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final width = image.width;
    image.dispose();
    return (bytes: bytes!, width: width);
  });
  return result!;
}

int _pixel(({ByteData bytes, int width}) image, int x, int y) =>
    image.bytes.getUint32((y * image.width + x) * 4);

int _rgba(Color color) =>
    (color.r * 255).round() << 24 |
    (color.g * 255).round() << 16 |
    (color.b * 255).round() << 8 |
    (color.a * 255).round();

int _red(int rgba) => rgba >> 24 & 0xFF;
