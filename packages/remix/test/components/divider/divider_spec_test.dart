import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('DividerSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = DividerSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
      });

      test('creates spec with custom container', () {
        final customContainer = StyleSpec(
          spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
        );

        final spec = DividerSpec(container: customContainer);

        expect(spec.container, equals(customContainer));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated container', () {
        const originalSpec = DividerSpec();
        final newContainer = StyleSpec(
          spec: BoxSpec(decoration: BoxDecoration(color: Colors.blue)),
        );

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
      });

      test(
        'returns new instance with no changes when no parameters provided',
        () {
          const originalSpec = DividerSpec();

          final updatedSpec = originalSpec.copyWith();

          expect(updatedSpec, isNot(same(originalSpec)));
          expect(updatedSpec.container, equals(originalSpec.container));
        },
      );

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = DividerSpec();
        final originalContainer = originalSpec.container;
        final newContainer = StyleSpec(
          spec: BoxSpec(decoration: BoxDecoration(color: Colors.green)),
        );

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(originalSpec.container, equals(originalContainer));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.container, isNot(same(originalContainer)));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = DividerSpec();
        const other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = DividerSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = DividerSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<DividerSpec>());
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = DividerSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = DividerSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<DividerSpec>());
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = DividerSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = DividerSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<DividerSpec>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = DividerSpec();
        const spec2 = DividerSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('specs with different properties are not equal', () {
        const spec1 = DividerSpec();
        final spec2 = DividerSpec(
          container: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = DividerSpec();

        expect(spec.props, hasLength(1));
        expect(spec.props, contains(spec.container));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = DividerSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = DividerSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('diagnostic properties are properly formatted', () {
        const spec = DividerSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties, hasLength(1));

        final propertyNames = properties.map((p) => p.name).toList();
        expect(propertyNames, contains('container'));
      });
    });

    group('Edge Cases', () {
      test('copyWith handles null parameter correctly', () {
        const spec = DividerSpec();
        final originalContainer = spec.container;

        final updatedSpec = spec.copyWith(container: null);

        expect(updatedSpec.container, equals(originalContainer));
      });
    });
  });
}
