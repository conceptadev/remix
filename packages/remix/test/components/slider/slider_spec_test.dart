import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixSliderSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        final spec = RemixSliderSpec();

        expect(spec.thumb, isA<StyleSpec<BoxSpec>>());
        expect(spec.trackColor, isA<Color>());
        expect(spec.trackWidth, isA<double>());
        expect(spec.rangeColor, isA<Color>());
        expect(spec.rangeWidth, isA<double>());
      });

      test('creates spec with provided parameters', () {
        final thumb = StyleSpec(spec: BoxSpec());
        const trackColor = Color(0xFF0000FF);
        const trackWidth = 10.0;
        const rangeColor = Color(0xFFFF0000);
        const rangeWidth = 5.0;

        final spec = RemixSliderSpec(
          thumb: thumb,
          trackColor: trackColor,
          trackWidth: trackWidth,
          rangeColor: rangeColor,
          rangeWidth: rangeWidth,
        );

        expect(spec.thumb, equals(thumb));
        expect(spec.trackColor, equals(trackColor));
        expect(spec.trackWidth, equals(trackWidth));
        expect(spec.rangeColor, equals(rangeColor));
        expect(spec.rangeWidth, equals(rangeWidth));
      });

      test('trackThickness returns max of trackWidth and rangeWidth', () {
        final spec1 = RemixSliderSpec(trackWidth: 10.0, rangeWidth: 5.0);
        expect(spec1.trackThickness, equals(10.0));

        final spec2 = RemixSliderSpec(trackWidth: 5.0, rangeWidth: 10.0);
        expect(spec2.trackThickness, equals(10.0));

        final spec3 = RemixSliderSpec(trackWidth: 8.0, rangeWidth: 8.0);
        expect(spec3.trackThickness, equals(8.0));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        final originalSpec = RemixSliderSpec();
        final newThumb = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(thumb: newThumb);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.thumb, equals(newThumb));
      });

      test('preserves immutability - original spec unchanged', () {
        final originalSpec = RemixSliderSpec();
        final originalThumb = originalSpec.thumb;
        final newThumb = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(thumb: newThumb);

        expect(originalSpec.thumb, equals(originalThumb));
        expect(updatedSpec.thumb, equals(newThumb));
        expect(updatedSpec.thumb, isNot(same(originalThumb)));
      });

      test('returns new instance with all properties updated', () {
        final originalSpec = RemixSliderSpec();
        final newThumb = StyleSpec(spec: BoxSpec());
        const newTrackColor = Colors.blue;
        const newTrackWidth = 10.0;
        const newRangeColor = Colors.red;
        const newRangeWidth = 5.0;

        final updatedSpec = originalSpec.copyWith(
          thumb: newThumb,
          trackColor: newTrackColor,
          trackWidth: newTrackWidth,
          rangeColor: newRangeColor,
          rangeWidth: newRangeWidth,
        );

        expect(updatedSpec.thumb, equals(newThumb));
        expect(updatedSpec.trackColor, equals(newTrackColor));
        expect(updatedSpec.trackWidth, equals(newTrackWidth));
        expect(updatedSpec.rangeColor, equals(newRangeColor));
        expect(updatedSpec.rangeWidth, equals(newRangeWidth));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        final spec = RemixSliderSpec();
        const RemixSliderSpec? other = null;

        final result = spec.lerp(other, 0.5);

        // StyleSpec fields should be preserved
        expect(result.thumb, equals(spec.thumb));
      });

      test('interpolates between two specs at t=0.0', () {
        const color1 = Color(0xFF0000FF);
        const color2 = Color(0xFF00FF00);
        final spec1 = RemixSliderSpec(
          thumb: StyleSpec(spec: BoxSpec()),
          trackColor: color1,
          trackWidth: 10.0,
          rangeColor: color1,
          rangeWidth: 5.0,
        );
        final spec2 = RemixSliderSpec(
          thumb: StyleSpec(spec: BoxSpec()),
          trackColor: color2,
          trackWidth: 20.0,
          rangeColor: color2,
          rangeWidth: 10.0,
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.thumb, equals(spec1.thumb));
        expect(result.trackColor, equals(spec1.trackColor));
        expect(result.trackWidth, equals(spec1.trackWidth));
        expect(result.rangeColor, equals(spec1.rangeColor));
        expect(result.rangeWidth, equals(spec1.rangeWidth));
      });

      test('interpolates between two specs at t=1.0', () {
        const color1 = Color(0xFF0000FF);
        const color2 = Color(0xFF00FF00);
        final spec1 = RemixSliderSpec(
          thumb: StyleSpec(spec: BoxSpec()),
          trackColor: color1,
          trackWidth: 10.0,
          rangeColor: color1,
          rangeWidth: 5.0,
        );
        final spec2 = RemixSliderSpec(
          thumb: StyleSpec(spec: BoxSpec()),
          trackColor: color2,
          trackWidth: 20.0,
          rangeColor: color2,
          rangeWidth: 10.0,
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.thumb, equals(spec2.thumb));
        expect(result.trackColor, equals(spec2.trackColor));
        expect(result.trackWidth, equals(spec2.trackWidth));
        expect(result.rangeColor, equals(spec2.rangeColor));
        expect(result.rangeWidth, equals(spec2.rangeWidth));
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = RemixSliderSpec(trackWidth: 10.0, rangeWidth: 5.0);
        final spec2 = RemixSliderSpec(trackWidth: 20.0, rangeWidth: 15.0);

        final result = spec1.lerp(spec2, 0.5);

        expect(result.trackWidth, equals(15.0));
        expect(result.rangeWidth, equals(10.0));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        final spec1 = RemixSliderSpec();
        final spec2 = RemixSliderSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        final spec1 = RemixSliderSpec(trackColor: Colors.blue);
        final spec2 = RemixSliderSpec(trackColor: Colors.red);

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        final spec = RemixSliderSpec();

        expect(spec.props, hasLength(12));
        expect(spec.props, contains(spec.thumb));
        expect(spec.props, contains(spec.trackColor));
        expect(spec.props, contains(spec.trackWidth));
        expect(spec.props, contains(spec.rangeColor));
        expect(spec.props, contains(spec.rangeWidth));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        final spec = RemixSliderSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        final spec = RemixSliderSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        final spec = RemixSliderSpec();
        final originalThumb = spec.thumb;

        final updatedSpec = spec.copyWith(thumb: null);

        expect(updatedSpec.thumb, equals(originalThumb));
      });

      test('handles zero width values', () {
        final spec = RemixSliderSpec(trackWidth: 0.0, rangeWidth: 0.0);

        expect(spec.trackWidth, equals(0.0));
        expect(spec.rangeWidth, equals(0.0));
        expect(spec.trackThickness, equals(0.0));
      });

      test('handles very large width values', () {
        final spec = RemixSliderSpec(trackWidth: 1000.0, rangeWidth: 2000.0);

        expect(spec.trackWidth, equals(1000.0));
        expect(spec.rangeWidth, equals(2000.0));
        expect(spec.trackThickness, equals(2000.0));
      });
    });

    group('Default Values', () {
      test('uses correct default values', () {
        final spec = RemixSliderSpec();

        expect(spec.thumb, isNotNull);
        expect(spec.trackColor, isNotNull);
        expect(spec.trackWidth, isNotNull);
        expect(spec.rangeColor, isNotNull);
        expect(spec.rangeWidth, isNotNull);
      });
    });
  });
}
