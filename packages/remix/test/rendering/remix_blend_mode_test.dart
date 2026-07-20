import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

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
