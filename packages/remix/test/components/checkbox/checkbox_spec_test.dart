import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixCheckboxSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixCheckboxSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
        expect(spec.indicator, isA<StyleSpec<IconSpec>>());
        expect(spec.container.spec, isA<BoxSpec>());
        expect(spec.indicator.spec, isA<IconSpec>());
      });

      test('creates spec with provided parameters', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final indicatorSpec = StyleSpec(spec: IconSpec());

        final spec = RemixCheckboxSpec(
          container: containerSpec,
          indicator: indicatorSpec,
        );

        expect(spec.container, equals(containerSpec));
        expect(spec.indicator, equals(indicatorSpec));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixCheckboxSpec();
        final newContainer = StyleSpec(spec: BoxSpec());
        final newIndicator = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          indicator: newIndicator,
        );

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.indicator, equals(newIndicator));
      });

      test('returns new instance with single updated property', () {
        const originalSpec = RemixCheckboxSpec();
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.indicator, equals(originalSpec.indicator));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixCheckboxSpec();
        final originalContainer = originalSpec.container;
        final originalIndicator = originalSpec.indicator;
        final newContainer = StyleSpec(spec: BoxSpec());
        final newIndicator = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          indicator: newIndicator,
        );

        expect(originalSpec.container, equals(originalContainer));
        expect(originalSpec.indicator, equals(originalIndicator));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.indicator, equals(newIndicator));
        expect(updatedSpec.container, isNot(same(originalContainer)));
        expect(updatedSpec.indicator, isNot(same(originalIndicator)));
      });

      test('copyWith with null parameters preserves original values', () {
        const originalSpec = RemixCheckboxSpec();
        final originalContainer = originalSpec.container;
        final originalIndicator = originalSpec.indicator;

        final updatedSpec = originalSpec.copyWith(
          container: null,
          indicator: null,
        );

        expect(updatedSpec.container, equals(originalContainer));
        expect(updatedSpec.indicator, equals(originalIndicator));
        expect(updatedSpec.container, same(originalContainer));
        expect(updatedSpec.indicator, same(originalIndicator));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = RemixCheckboxSpec();
        const other = null;

        final result = spec.lerp(other, 0.5);
        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
        expect(result.indicator, equals(spec1.indicator));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
        expect(result.indicator, equals(spec2.indicator));
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<RemixCheckboxSpec>());
      });

      test('lerp with different t values', () {
        final spec1 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );

        final result1 = spec1.lerp(spec2, 0.25);
        final result2 = spec1.lerp(spec2, 0.75);

        expect(result1, isNot(same(result2)));
        expect(result1, isA<RemixCheckboxSpec>());
        expect(result2, isA<RemixCheckboxSpec>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixCheckboxSpec();
        const spec2 = RemixCheckboxSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixCheckboxSpec();
        final spec2 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );

        // Since both have default values, they should be equal
        expect(spec1, equals(spec2));
      });

      test('specs with same custom properties are equal', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final indicatorSpec = StyleSpec(spec: IconSpec());

        final spec1 = RemixCheckboxSpec(
          container: containerSpec,
          indicator: indicatorSpec,
        );
        final spec2 = RemixCheckboxSpec(
          container: containerSpec,
          indicator: indicatorSpec,
        );

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('props list contains all properties', () {
        const spec = RemixCheckboxSpec();

        expect(spec.props, hasLength(3));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.indicator));
      });

      test('props list with custom properties', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final indicatorSpec = StyleSpec(spec: IconSpec());

        final spec = RemixCheckboxSpec(
          container: containerSpec,
          indicator: indicatorSpec,
        );

        expect(spec.props, hasLength(3));
        expect(spec.props, contains(containerSpec));
        expect(spec.props, contains(indicatorSpec));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixCheckboxSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('debugFillProperties with custom properties', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final indicatorSpec = StyleSpec(spec: IconSpec());

        final spec = RemixCheckboxSpec(
          container: containerSpec,
          indicator: indicatorSpec,
        );

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixCheckboxSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('toString includes all properties', () {
        const spec = RemixCheckboxSpec();
        final stringRepresentation = spec.toString();

        expect(stringRepresentation, contains('container'));
        expect(stringRepresentation, contains('indicator'));
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixCheckboxSpec();
        final originalContainer = spec.container;
        final originalIndicator = spec.indicator;

        final updatedSpec = spec.copyWith(container: null, indicator: null);

        expect(updatedSpec.container, equals(originalContainer));
        expect(updatedSpec.indicator, equals(originalIndicator));
      });

      test('lerp handles edge t values', () {
        final spec1 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCheckboxSpec(
          container: StyleSpec(spec: BoxSpec()),
          indicator: StyleSpec(spec: IconSpec()),
        );

        // Test t=0.0
        final result0 = spec1.lerp(spec2, 0.0);
        expect(result0, isA<RemixCheckboxSpec>());

        // Test t=1.0
        final result1 = spec1.lerp(spec2, 1.0);
        expect(result1, isA<RemixCheckboxSpec>());

        // Test t=0.0 and t=1.0 should be different
        expect(result0, isNot(same(result1)));
      });

      test('spec with complex StyleSpec properties', () {
        final complexContainerSpec = StyleSpec(spec: BoxSpec());
        final complexIndicatorSpec = StyleSpec(spec: IconSpec());

        final spec = RemixCheckboxSpec(
          container: complexContainerSpec,
          indicator: complexIndicatorSpec,
        );

        expect(spec.container, equals(complexContainerSpec));
        expect(spec.indicator, equals(complexIndicatorSpec));
        expect(spec.props, hasLength(3));
      });
    });
  });
}
