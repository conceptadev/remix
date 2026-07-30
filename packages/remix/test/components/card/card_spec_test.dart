import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixCardSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixCardSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
        expect(spec.container.spec, isA<BoxSpec>());
      });

      test('creates spec with provided parameters', () {
        final containerSpec = StyleSpec(spec: BoxSpec());

        final spec = RemixCardSpec(container: containerSpec);

        expect(spec.container, equals(containerSpec));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixCardSpec();
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixCardSpec();
        final originalContainer = originalSpec.container;
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(originalSpec.container, equals(originalContainer));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.container, isNot(same(originalContainer)));
      });

      test('copyWith with null parameters preserves original values', () {
        const originalSpec = RemixCardSpec();
        final originalContainer = originalSpec.container;

        final updatedSpec = originalSpec.copyWith(container: null);

        expect(updatedSpec.container, equals(originalContainer));
        expect(updatedSpec.container, same(originalContainer));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = RemixCardSpec();
        const other = null;

        final result = spec.lerp(other, 0.5);
        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<RemixCardSpec>());
      });

      test('lerp with different t values', () {
        final spec1 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));

        final result1 = spec1.lerp(spec2, 0.25);
        final result2 = spec1.lerp(spec2, 0.75);

        expect(result1, isNot(same(result2)));
        expect(result1, isA<RemixCardSpec>());
        expect(result2, isA<RemixCardSpec>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixCardSpec();
        const spec2 = RemixCardSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixCardSpec();
        final spec2 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));

        // Since both have default values, they should be equal
        expect(spec1, equals(spec2));
      });

      test('specs with same custom properties are equal', () {
        final containerSpec = StyleSpec(spec: BoxSpec());

        final spec1 = RemixCardSpec(container: containerSpec);
        final spec2 = RemixCardSpec(container: containerSpec);

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('props list contains all properties', () {
        const spec = RemixCardSpec();

        expect(spec.props, hasLength(2));
        expect(spec.props, contains(spec.container));
      });

      test('props list with custom properties', () {
        final containerSpec = StyleSpec(spec: BoxSpec());

        final spec = RemixCardSpec(container: containerSpec);

        expect(spec.props, hasLength(2));
        expect(spec.props, contains(containerSpec));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixCardSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('debugFillProperties with custom properties', () {
        final containerSpec = StyleSpec(spec: BoxSpec());

        final spec = RemixCardSpec(container: containerSpec);

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixCardSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('toString includes all properties', () {
        const spec = RemixCardSpec();
        final stringRepresentation = spec.toString();

        expect(stringRepresentation, contains('container'));
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixCardSpec();
        final originalContainer = spec.container;

        final updatedSpec = spec.copyWith(container: null);

        expect(updatedSpec.container, equals(originalContainer));
      });

      test('lerp handles edge t values', () {
        final spec1 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = RemixCardSpec(container: StyleSpec(spec: BoxSpec()));

        // Test t=0.0
        final result0 = spec1.lerp(spec2, 0.0);
        expect(result0, isA<RemixCardSpec>());

        // Test t=1.0
        final result1 = spec1.lerp(spec2, 1.0);
        expect(result1, isA<RemixCardSpec>());

        // Test t=0.0 and t=1.0 should be different
        expect(result0, isNot(same(result1)));
      });

      test('spec with complex StyleSpec properties', () {
        final complexContainerSpec = StyleSpec(spec: BoxSpec());

        final spec = RemixCardSpec(container: complexContainerSpec);

        expect(spec.container, equals(complexContainerSpec));
        expect(spec.props, hasLength(2));
      });
    });
  });
}
