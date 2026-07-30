import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixSpinnerSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixSpinnerSpec();

        expect(spec.size, isNull);
        expect(spec.strokeWidth, isNull);
        expect(spec.indicatorColor, isNull);
        expect(spec.trackColor, isNull);
        expect(spec.trackStrokeWidth, isNull);
        expect(spec.duration, isNull);
      });

      test('creates spec with provided parameters', () {
        const size = 24.0;
        const strokeWidth = 2.0;
        const indicatorColor = Color(0xFF0000FF);
        const trackColor = Color(0xFFCCCCCC);
        const trackStrokeWidth = 1.0;
        const duration = Duration(milliseconds: 1000);

        const spec = RemixSpinnerSpec(
          size: size,
          strokeWidth: strokeWidth,
          indicatorColor: indicatorColor,
          trackColor: trackColor,
          trackStrokeWidth: trackStrokeWidth,
          duration: duration,
        );

        expect(spec.size, equals(size));
        expect(spec.strokeWidth, equals(strokeWidth));
        expect(spec.indicatorColor, equals(indicatorColor));
        expect(spec.trackColor, equals(trackColor));
        expect(spec.trackStrokeWidth, equals(trackStrokeWidth));
        expect(spec.duration, equals(duration));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixSpinnerSpec();
        const newSize = 32.0;

        final updatedSpec = originalSpec.copyWith(size: newSize);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.size, equals(newSize));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixSpinnerSpec(size: 24.0);
        final originalSize = originalSpec.size;
        const newSize = 32.0;

        final updatedSpec = originalSpec.copyWith(size: newSize);

        expect(originalSpec.size, equals(originalSize));
        expect(updatedSpec.size, equals(newSize));
        expect(updatedSpec.size, isNot(same(originalSize)));
      });

      test('returns new instance with all properties updated', () {
        const originalSpec = RemixSpinnerSpec();
        const newSize = 32.0;
        const newStrokeWidth = 3.0;
        const newIndicatorColor = Color(0xFF0000FF);
        const newTrackColor = Color(0xFFCCCCCC);
        const newTrackStrokeWidth = 2.0;
        const newDuration = Duration(milliseconds: 500);

        final updatedSpec = originalSpec.copyWith(
          size: newSize,
          strokeWidth: newStrokeWidth,
          indicatorColor: newIndicatorColor,
          trackColor: newTrackColor,
          trackStrokeWidth: newTrackStrokeWidth,
          duration: newDuration,
        );

        expect(updatedSpec.size, equals(newSize));
        expect(updatedSpec.strokeWidth, equals(newStrokeWidth));
        expect(updatedSpec.indicatorColor, equals(newIndicatorColor));
        expect(updatedSpec.trackColor, equals(newTrackColor));
        expect(updatedSpec.trackStrokeWidth, equals(newTrackStrokeWidth));
        expect(updatedSpec.duration, equals(newDuration));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = RemixSpinnerSpec();
        const RemixSpinnerSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        const color1 = Color(0xFF0000FF);
        const color2 = Color(0xFF00FF00);
        const spec1 = RemixSpinnerSpec(
          size: 24.0,
          strokeWidth: 2.0,
          indicatorColor: color1,
          trackColor: color1,
          trackStrokeWidth: 1.0,
          duration: Duration(milliseconds: 1000),
        );
        const spec2 = RemixSpinnerSpec(
          size: 32.0,
          strokeWidth: 4.0,
          indicatorColor: color2,
          trackColor: color2,
          trackStrokeWidth: 2.0,
          duration: Duration(milliseconds: 500),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.size, equals(spec1.size));
        expect(result.strokeWidth, equals(spec1.strokeWidth));
        expect(result.indicatorColor, equals(spec1.indicatorColor));
        expect(result.trackColor, equals(spec1.trackColor));
        expect(result.trackStrokeWidth, equals(spec1.trackStrokeWidth));
        expect(result.duration, equals(spec1.duration));
      });

      test('interpolates between two specs at t=1.0', () {
        const color1 = Color(0xFF0000FF);
        const color2 = Color(0xFF00FF00);
        const spec1 = RemixSpinnerSpec(
          size: 24.0,
          strokeWidth: 2.0,
          indicatorColor: color1,
          trackColor: color1,
          trackStrokeWidth: 1.0,
          duration: Duration(milliseconds: 1000),
        );
        const spec2 = RemixSpinnerSpec(
          size: 32.0,
          strokeWidth: 4.0,
          indicatorColor: color2,
          trackColor: color2,
          trackStrokeWidth: 2.0,
          duration: Duration(milliseconds: 500),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.size, equals(spec2.size));
        expect(result.strokeWidth, equals(spec2.strokeWidth));
        expect(result.indicatorColor, equals(spec2.indicatorColor));
        expect(result.trackColor, equals(spec2.trackColor));
        expect(result.trackStrokeWidth, equals(spec2.trackStrokeWidth));
        expect(result.duration, equals(spec2.duration));
      });

      test('interpolates between two specs at t=0.5', () {
        const spec1 = RemixSpinnerSpec(size: 24.0, strokeWidth: 2.0);
        const spec2 = RemixSpinnerSpec(size: 32.0, strokeWidth: 4.0);

        final result = spec1.lerp(spec2, 0.5);

        expect(result.size, equals(28.0));
        expect(result.strokeWidth, equals(3.0));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixSpinnerSpec();
        const spec2 = RemixSpinnerSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixSpinnerSpec(size: 24.0);
        const spec2 = RemixSpinnerSpec(size: 32.0);

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = RemixSpinnerSpec();

        expect(spec.props, hasLength(9));
        expect(spec.props, contains(spec.size));
        expect(spec.props, contains(spec.strokeWidth));
        expect(spec.props, contains(spec.indicatorColor));
        expect(spec.props, contains(spec.trackColor));
        expect(spec.props, contains(spec.trackStrokeWidth));
        expect(spec.props, contains(spec.duration));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixSpinnerSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixSpinnerSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixSpinnerSpec(size: 24.0);
        final originalSize = spec.size;

        final updatedSpec = spec.copyWith(size: null);

        expect(updatedSpec.size, equals(originalSize));
      });

      test('handles zero size', () {
        const spec = RemixSpinnerSpec(size: 0.0);

        expect(spec.size, equals(0.0));
      });

      test('handles very large size', () {
        const spec = RemixSpinnerSpec(size: 1000.0);

        expect(spec.size, equals(1000.0));
      });

      test('handles zero duration', () {
        const spec = RemixSpinnerSpec(duration: Duration.zero);

        expect(spec.duration, equals(Duration.zero));
      });

      test('handles very long duration', () {
        const spec = RemixSpinnerSpec(duration: Duration(seconds: 60));

        expect(spec.duration, equals(const Duration(seconds: 60)));
      });
    });

    group('Default Values', () {
      test('all properties are nullable', () {
        const spec = RemixSpinnerSpec();

        expect(spec.size, isNull);
        expect(spec.strokeWidth, isNull);
        expect(spec.indicatorColor, isNull);
        expect(spec.trackColor, isNull);
        expect(spec.trackStrokeWidth, isNull);
        expect(spec.duration, isNull);
      });
    });
  });
}
