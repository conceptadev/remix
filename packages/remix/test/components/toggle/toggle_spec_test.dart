import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('ToggleSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = ToggleSpec();

        expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.label, isA<StyleSpec<TextSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = ToggleSpec();
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
      });

      test(
        'returns new instance with no changes when no parameters provided',
        () {
          const originalSpec = ToggleSpec();

          final updatedSpec = originalSpec.copyWith();

          expect(updatedSpec, isNot(same(originalSpec)));
          expect(updatedSpec.container, equals(originalSpec.container));
          expect(updatedSpec.label, equals(originalSpec.label));
          expect(updatedSpec.icon, equals(originalSpec.icon));
        },
      );

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = ToggleSpec();
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
        const spec = ToggleSpec();
        const ToggleSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = ToggleSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = ToggleSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec1.container));
        expect(result.label, equals(spec1.label));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = ToggleSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = ToggleSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
        expect(result.label, equals(spec2.label));
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = ToggleSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = ToggleSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<ToggleSpec>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = ToggleSpec();
        const spec2 = ToggleSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        final spec1 = ToggleSpec(
          container: StyleSpec(
            spec: const FlexBoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );
        final spec2 = ToggleSpec(
          container: StyleSpec(
            spec: const FlexBoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 200),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = ToggleSpec();

        expect(spec.props, hasLength(3));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.icon));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = ToggleSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = ToggleSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('diagnostic properties are properly formatted', () {
        const spec = ToggleSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties, hasLength(3));

        final propertyNames = properties.map((p) => p.name).toList();
        expect(propertyNames, contains('container'));
        expect(propertyNames, contains('label'));
        expect(propertyNames, contains('icon'));
      });
    });

    group('Edge Cases', () {
      test('copyWith handles null parameters correctly', () {
        const spec = ToggleSpec();
        final originalContainer = spec.container;

        final updatedSpec = spec.copyWith(container: null);

        expect(updatedSpec.container, equals(originalContainer));
      });
    });
  });
}
