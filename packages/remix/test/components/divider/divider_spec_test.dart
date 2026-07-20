import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixDividerSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixDividerSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
        expect(spec.thickness, isNull);
      });

      test('creates spec with custom container', () {
        final customContainer = StyleSpec(
          spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
        );

        final spec = RemixDividerSpec(container: customContainer);

        expect(spec.container, equals(customContainer));
      });

      test('creates spec with custom thickness', () {
        const spec = RemixDividerSpec(thickness: 2);

        expect(spec.thickness, 2);
      });
    });

    group('copyWith', () {
      test('returns new instance with updated container', () {
        const originalSpec = RemixDividerSpec();
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
          const originalSpec = RemixDividerSpec();

          final updatedSpec = originalSpec.copyWith();

          expect(updatedSpec, isNot(same(originalSpec)));
          expect(updatedSpec.container, equals(originalSpec.container));
        },
      );

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixDividerSpec();
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
        const spec = RemixDividerSpec();
        const other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixDividerSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = RemixDividerSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<RemixDividerSpec>());
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixDividerSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = RemixDividerSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<RemixDividerSpec>());
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = RemixDividerSpec(
          container: StyleSpec(spec: BoxSpec()),
          thickness: 1,
        );
        final spec2 = RemixDividerSpec(
          container: StyleSpec(spec: BoxSpec()),
          thickness: 3,
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<RemixDividerSpec>());
        expect(result.thickness, 2);
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixDividerSpec();
        const spec2 = RemixDividerSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('specs with different properties are not equal', () {
        const spec1 = RemixDividerSpec();
        final spec2 = RemixDividerSpec(
          container: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = RemixDividerSpec();

        expect(spec.props, [spec.container, spec.thickness]);
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixDividerSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixDividerSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('diagnostic properties are properly formatted', () {
        const spec = RemixDividerSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties, hasLength(2));

        final propertyNames = properties.map((p) => p.name).toList();
        expect(propertyNames, contains('container'));
        expect(propertyNames, contains('thickness'));
      });
    });

    group('Edge Cases', () {
      test('copyWith handles null parameter correctly', () {
        const spec = RemixDividerSpec();
        final originalContainer = spec.container;

        final updatedSpec = spec.copyWith(container: null);

        expect(updatedSpec.container, equals(originalContainer));
      });
    });
  });
}
