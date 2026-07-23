import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_box_effects.dart'
    show RemixBoxWithEffects;

const _boundaryKey = ValueKey('blend-boundary');

void main() {
  testWidgets(
    'rejects composited descendants instead of silently skipping them',
    (tester) async {
      await tester.pumpWidget(
        _blendHarness(
          blendMode: BlendMode.multiply,
          child: const RepaintBoundary(
            child: ColoredBox(
              color: Colors.red,
              child: SizedBox.square(dimension: 20),
            ),
          ),
        ),
      );

      final error = tester.takeException();
      expect(error, isA<FlutterError>());
      expect(
        error.toString(),
        contains('does not support composited descendants'),
      );
    },
  );

  testWidgets('limits the blend operation to the child paint bounds', (
    tester,
  ) async {
    await tester.pumpWidget(
      _blendHarness(
        blendMode: BlendMode.src,
        child: const ColoredBox(
          color: Colors.red,
          child: SizedBox.square(dimension: 20),
        ),
      ),
    );

    final pixels = await _capture(tester);
    expect(_pixel(pixels, 30, 30), _rgba(Colors.red));
    expect(_pixel(pixels, 5, 5), _rgba(Colors.blue));
  });

  testWidgets('includes overflowing descendants in the blend layer bounds', (
    tester,
  ) async {
    await tester.pumpWidget(
      _blendHarness(
        blendMode: BlendMode.src,
        child: const SizedBox.square(
          dimension: 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: -8,
                top: 6,
                width: 8,
                height: 8,
                child: ColoredBox(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );

    final pixels = await _capture(tester);
    expect(_pixel(pixels, 16, 30), _rgba(Colors.red));
    expect(_pixel(pixels, 5, 5), _rgba(Colors.blue));
  });

  testWidgets(
    'includes overflowing surface paint effects in the blend bounds',
    (tester) async {
      await tester.pumpWidget(
        _blendHarness(
          blendMode: BlendMode.src,
          child: SizedBox.square(
            dimension: 20,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -8,
                  top: 6,
                  width: 8,
                  height: 8,
                  child: RemixBoxWithEffects(
                    styleSpec: const StyleSpec(
                      spec: BoxSpec(
                        decoration: BoxDecoration(color: Colors.red),
                      ),
                    ),
                    containerEffects: const RemixBoxEffectsSpec(
                      behindContent: RemixBoxEffectLayerSpec(
                        shadows: [
                          RemixBoxShadow(color: Colors.green, spreadRadius: 2),
                        ],
                      ),
                      outline: BorderSide(color: Colors.yellow, width: 1),
                      outlineOffset: 3,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      final pixels = await _capture(tester);
      expect(_pixel(pixels, 8, 30), _rgba(Colors.yellow));
      expect(_pixel(pixels, 10, 30), _rgba(Colors.green));
      expect(_pixel(pixels, 13, 30), _rgba(Colors.red));
      expect(_pixel(pixels, 5, 5), _rgba(Colors.blue));
    },
  );

  testWidgets('does not expand the blend bounds past descendant clips', (
    tester,
  ) async {
    await tester.pumpWidget(
      _blendHarness(
        blendMode: BlendMode.src,
        child: const SizedBox.square(
          dimension: 20,
          child: ClipRect(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -8,
                  top: 6,
                  width: 8,
                  height: 8,
                  child: ColoredBox(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final pixels = await _capture(tester);
    expect(_pixel(pixels, 16, 30), _rgba(Colors.blue));
  });
}

Widget _blendHarness({required BlendMode blendMode, required Widget child}) =>
    MaterialApp(
      home: Center(
        child: RepaintBoundary(
          key: _boundaryKey,
          child: SizedBox.square(
            dimension: 60,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const ColoredBox(color: Colors.blue),
                Center(
                  child: RemixBlendMode(blendMode: blendMode, child: child),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Future<({ByteData bytes, int width})> _capture(WidgetTester tester) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(_boundaryKey),
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

int _rgba(Color color) {
  final argb = color.toARGB32();
  return ((argb & 0x00FFFFFF) << 8) | (argb >>> 24);
}
