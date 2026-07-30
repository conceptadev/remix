import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixButtonSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixButtonSpec();

        expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.label, isA<StyleSpec<TextSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
        expect(spec.spinner, isA<StyleSpec<RemixSpinnerSpec>>());
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixButtonSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());
        final newLabel = StyleSpec(spec: TextSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          label: newLabel,
        );

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.label, equals(newLabel));
        expect(updatedSpec.icon, equals(originalSpec.icon));
        expect(updatedSpec.spinner, equals(originalSpec.spinner));
      });

      test(
        'returns new instance with no changes when no parameters provided',
        () {
          const originalSpec = RemixButtonSpec();

          final updatedSpec = originalSpec.copyWith();

          expect(updatedSpec, isNot(same(originalSpec)));
          expect(updatedSpec.container, equals(originalSpec.container));
          expect(updatedSpec.label, equals(originalSpec.label));
          expect(updatedSpec.icon, equals(originalSpec.icon));
          expect(updatedSpec.spinner, equals(originalSpec.spinner));
        },
      );

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixButtonSpec();
        final originalContainer = originalSpec.container;
        final newContainer = StyleSpec(spec: FlexBoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(originalSpec.container, equals(originalContainer));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.container, isNot(same(originalContainer)));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = RemixButtonSpec();
        const other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixButtonSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = RemixButtonSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        // At t=0.0, should return spec1
        expect(result.container, equals(spec1.container));
        expect(result.label, equals(spec1.label));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixButtonSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = RemixButtonSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        // At t=1.0, should return spec2
        expect(result.container, equals(spec2.container));
        expect(result.label, equals(spec2.label));
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = RemixButtonSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = RemixButtonSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<RemixButtonSpec>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixButtonSpec();
        const spec2 = RemixButtonSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('specs with same properties are equal', () {
        final customContainer = StyleSpec(
          spec: FlexBoxSpec(
            box: StyleSpec(
              spec: BoxSpec(
                decoration: BoxDecoration(
                  color: const Color(0xFF123456),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF654321), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x22000000),
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        final spec1 = RemixButtonSpec(container: customContainer);
        final spec2 = RemixButtonSpec(container: customContainer);

        // Both specs use default values, so they should be equal
        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('props list contains all properties', () {
        const spec = RemixButtonSpec();

        expect(spec.props, hasLength(6));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.icon));
        expect(spec.props, contains(spec.spinner));
        expect(spec.props, contains(spec.iconAlignment));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixButtonSpec();

        // Verify that debugFillProperties doesn't throw
        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixButtonSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('diagnostic properties are properly formatted', () {
        const spec = RemixButtonSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties, hasLength(6));

        // Check that all expected properties are present
        final propertyNames = properties.map((p) => p.name).toList();
        expect(propertyNames, contains('container'));
        expect(propertyNames, contains('label'));
        expect(propertyNames, contains('icon'));
        expect(propertyNames, contains('spinner'));
        expect(propertyNames, contains('iconAlignment'));
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixButtonSpec();
        final originalContainer = spec.container;

        final updatedSpec = spec.copyWith(container: null);

        expect(updatedSpec.container, equals(originalContainer));
      });
    });
  });
}
