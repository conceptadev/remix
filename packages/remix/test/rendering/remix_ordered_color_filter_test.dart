import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/src/rendering/remix_ordered_color_filter.dart';

void main() {
  group('RemixCssColorFilterOperation', () {
    test('uses the W3C sRGB brightness, contrast, and saturation matrices', () {
      expect(
        const RemixCssColorFilterOperation.brightness(1.1).matrix,
        _closeMatrix([
          1.1,
          0,
          0,
          0,
          0,
          0,
          1.1,
          0,
          0,
          0,
          0,
          0,
          1.1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
      );
      expect(
        const RemixCssColorFilterOperation.contrast(0.88).matrix,
        _closeMatrix([
          0.88,
          0,
          0,
          0,
          15.3,
          0,
          0.88,
          0,
          0,
          15.3,
          0,
          0,
          0.88,
          0,
          15.3,
          0,
          0,
          0,
          1,
          0,
        ]),
      );
      expect(
        const RemixCssColorFilterOperation.saturate(1.1).matrix,
        _closeMatrix([
          1.0787,
          -0.0715,
          -0.0072,
          0,
          0,
          -0.0213,
          1.0285,
          -0.0072,
          0,
          0,
          -0.0213,
          -0.0715,
          1.0928,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
      );
    });
  });

  group('RemixOrderedColorFilterModifier', () {
    testWidgets('matches pinned Chromium pixels in CSS function order', (
      tester,
    ) async {
      const boundaryKey = ValueKey('filter-boundary');
      const input = [
        Color(0xFFC43B72),
        Color(0xFF287FBD),
        Color(0xFF65AD38),
        Color(0xFFE6B84D),
      ];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: boundaryKey,
              child:
                  const RemixOrderedColorFilterModifier([
                    RemixCssColorFilterOperation.contrast(0.88),
                    RemixCssColorFilterOperation.saturate(1.1),
                    RemixCssColorFilterOperation.brightness(1.1),
                  ]).build(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final color in input)
                          ColoredBox(
                            color: color,
                            child: SizedBox.square(dimension: 20),
                          ),
                      ],
                    ),
                  ),
            ),
          ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));

      // Generated independently by Chromium from the pinned Radix sequence.
      // A one-channel-value tolerance accounts for engine raster rounding.
      _expectPixelClose(_pixel(pixels, 10, 10), 0xD94781FF);
      _expectPixelClose(_pixel(pixels, 30, 10), 0x308DCFFF);
      _expectPixelClose(_pixel(pixels, 50, 10), 0x6EBB3EFF);
      _expectPixelClose(_pixel(pixels, 70, 10), 0xF4C351FF);
    });

    test('interpolates compatible lists with CSS identity lacuna values', () {
      const none = RemixOrderedColorFilterModifier([]);
      const filtered = RemixOrderedColorFilterModifier([
        RemixCssColorFilterOperation.contrast(0.8),
        RemixCssColorFilterOperation.saturate(1.2),
      ]);

      expect(none.lerp(filtered, 0.5).operations, const [
        RemixCssColorFilterOperation.contrast(0.9),
        RemixCssColorFilterOperation.saturate(1.1),
      ]);

      const shorter = RemixOrderedColorFilterModifier([
        RemixCssColorFilterOperation.contrast(0.8),
      ]);
      expect(shorter.lerp(filtered, 0.5).operations, const [
        RemixCssColorFilterOperation.contrast(0.8),
        RemixCssColorFilterOperation.saturate(1.1),
      ]);
    });

    test('uses discrete interpolation for incompatible function order', () {
      const first = RemixOrderedColorFilterModifier([
        RemixCssColorFilterOperation.contrast(0.8),
        RemixCssColorFilterOperation.brightness(1.1),
      ]);
      const second = RemixOrderedColorFilterModifier([
        RemixCssColorFilterOperation.brightness(1.1),
        RemixCssColorFilterOperation.contrast(0.8),
      ]);

      expect(first.lerp(second, 0.49), first);
      expect(first.lerp(second, 0.5), second);
    });

    testWidgets('filters the entire subtree without changing behavior', (
      tester,
    ) async {
      var taps = 0;
      const modifier = RemixOrderedColorFilterModifier([
        RemixCssColorFilterOperation.saturate(0),
      ]);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: modifier.build(
              GestureDetector(
                onTap: () => taps += 1,
                child: Semantics(
                  label: 'filtered subtree',
                  child: const ColoredBox(
                    color: Colors.red,
                    child: SizedBox(width: 40, height: 30),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(ColoredBox)), const Size(40, 30));
      await tester.tap(find.byType(ColoredBox));
      expect(taps, 1);
      expect(
        tester.getSemantics(find.byType(Semantics).last).label,
        contains('filtered subtree'),
      );
      expect(find.byType(ColorFiltered), findsOneWidget);
    });

    testWidgets('returns the child unchanged for an empty sequence', (
      tester,
    ) async {
      const child = SizedBox(key: ValueKey('unchanged'));
      const modifier = RemixOrderedColorFilterModifier([]);

      expect(modifier.build(child), same(child));
    });
  });
}

Matcher _closeMatrix(List<double> expected) => pairwiseCompare<double, double>(
  expected,
  (actual, value) => (actual - value).abs() < 1e-10,
  'matrix values within 1e-10',
);

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

void _expectPixelClose(int actual, int expected) {
  for (var shift = 0; shift <= 24; shift += 8) {
    expect(
      ((actual >> shift) & 0xFF) - ((expected >> shift) & 0xFF),
      inInclusiveRange(-1, 1),
      reason:
          'actual 0x${actual.toRadixString(16)}, '
          'expected 0x${expected.toRadixString(16)}',
    );
  }
}
