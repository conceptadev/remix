import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix/mix.dart';
import 'package:remix/src/utilities/remix_path_icon.dart';

/// Captures the glyph path handed to [Canvas.drawPath] without transforms so
/// assertions run against the raw pinned nine-unit coordinates.
class _PathRecorder implements Canvas {
  final List<Path> paths = [];

  @override
  void drawPath(Path path, Paint paint) => paths.add(path);

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

Future<Path> _recordGlyphPath(WidgetTester tester, RemixPathGlyph glyph) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Center(
        child: RemixPathIcon(
          glyph: glyph,
          styleSpec: const StyleSpec(spec: IconSpec(size: 9)),
        ),
      ),
    ),
  );
  final custom = tester.widget<CustomPaint>(
    find.descendant(
      of: find.byType(RemixPathIcon),
      matching: find.byType(CustomPaint),
    ),
  );
  final recorder = _PathRecorder();
  custom.painter!.paint(recorder, const Size(9, 9));

  expect(recorder.paths, hasLength(1));

  return recorder.paths.single;
}

double _perimeter(Path path) => path
    .computeMetrics()
    .fold(0.0, (total, metric) => total + metric.length);

void main() {
  // The parity manifest promises the exact Radix Themes 3.3.0 vector paths.
  // Bounds and perimeter fingerprint the pinned nine-unit coordinates, so any
  // edit to a path constant fails here.
  const pinnedGeometry = {
    RemixPathGlyph.chevronDown: (
      bounds: Rect.fromLTRB(-0.0536285, 2.9463699, 9.0536003, 7.7951002),
      perimeter: 24.5066948,
    ),
    RemixPathGlyph.thickCheck: (
      bounds: Rect.fromLTRB(0.2852460, 0.3964140, 8.9797602, 8.5216703),
      perimeter: 26.7144108,
    ),
    RemixPathGlyph.thickChevronRight: (
      bounds: Rect.fromLTRB(2.9190900, -0.0809141, 8.0672398, 9.0809202),
      perimeter: 24.3844013,
    ),
  };

  for (final MapEntry(key: glyph, value: expected) in pinnedGeometry.entries) {
    testWidgets('${glyph.name} keeps the pinned Radix path geometry', (
      tester,
    ) async {
      final path = await _recordGlyphPath(tester, glyph);
      final bounds = path.getBounds();

      expect(bounds.left, closeTo(expected.bounds.left, 1e-3));
      expect(bounds.top, closeTo(expected.bounds.top, 1e-3));
      expect(bounds.right, closeTo(expected.bounds.right, 1e-3));
      expect(bounds.bottom, closeTo(expected.bounds.bottom, 1e-3));
      expect(_perimeter(path), closeTo(expected.perimeter, 1e-2));
    });
  }
}
