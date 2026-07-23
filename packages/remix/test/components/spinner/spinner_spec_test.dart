import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixSpinnerSpec', () {
    test('defaults all optional visual fields', () {
      const spec = RemixSpinnerSpec();

      expect(spec.size, isNull);
      expect(spec.strokeWidth, isNull);
      expect(spec.indicatorColor, isNull);
      expect(spec.trackColor, isNull);
      expect(spec.trackStrokeWidth, isNull);
      expect(spec.color, isNull);
      expect(spec.opacity, isNull);
      expect(spec.leafRadius, isNull);
      expect(spec.duration, isNull);
    });

    test('stores, copies, and compares the leaf-spinner contract', () {
      const spec = RemixSpinnerSpec(
        size: 24,
        color: Colors.red,
        opacity: 0.65,
        leafRadius: Radius.circular(3),
        duration: Duration(milliseconds: 800),
      );
      const equal = RemixSpinnerSpec(
        size: 24,
        color: Colors.red,
        opacity: 0.65,
        leafRadius: Radius.circular(3),
        duration: Duration(milliseconds: 800),
      );
      final copied = spec.copyWith(size: 32, color: Colors.blue);

      expect(spec, equal);
      expect(spec.hashCode, equal.hashCode);
      expect(copied.size, 32);
      expect(copied.color, Colors.blue);
      expect(copied.opacity, 0.65);
      expect(spec.props, [
        spec.size,
        spec.strokeWidth,
        spec.indicatorColor,
        spec.trackColor,
        spec.trackStrokeWidth,
        spec.color,
        spec.opacity,
        spec.leafRadius,
        spec.duration,
      ]);
    });

    test('diagnostics include the complete contract', () {
      const spec = RemixSpinnerSpec();

      expect(spec.props, hasLength(9));
      expect(
        () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
        returnsNormally,
      );
    });
  });
}
