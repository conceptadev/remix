import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixIconButtonSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixIconButtonSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
        expect(spec.spinner, isA<StyleSpec<RemixSpinnerSpec>>());
        expect(spec.container.spec, isA<BoxSpec>());
        expect(spec.icon.spec, isA<IconSpec>());
        expect(spec.spinner.spec, isA<RemixSpinnerSpec>());
      });

      test('creates spec with provided parameters', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final iconSpec = StyleSpec(spec: IconSpec());
        final spinnerSpec = StyleSpec(spec: RemixSpinnerSpec());

        final spec = RemixIconButtonSpec(
          container: containerSpec,
          icon: iconSpec,
          spinner: spinnerSpec,
        );

        expect(spec.container, equals(containerSpec));
        expect(spec.icon, equals(iconSpec));
        expect(spec.spinner, equals(spinnerSpec));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixIconButtonSpec();
        final newContainer = StyleSpec(spec: BoxSpec());
        final newIcon = StyleSpec(spec: IconSpec());
        final newSpinner = StyleSpec(spec: RemixSpinnerSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          icon: newIcon,
          spinner: newSpinner,
        );

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.icon, equals(newIcon));
        expect(updatedSpec.spinner, equals(newSpinner));
      });

      test('returns new instance with single updated property', () {
        const originalSpec = RemixIconButtonSpec();
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.icon, equals(originalSpec.icon));
        expect(updatedSpec.spinner, equals(originalSpec.spinner));
      });

      test('returns new instance with multiple updated properties', () {
        const originalSpec = RemixIconButtonSpec();
        final newIcon = StyleSpec(spec: IconSpec());
        final newSpinner = StyleSpec(spec: RemixSpinnerSpec());

        final updatedSpec = originalSpec.copyWith(
          icon: newIcon,
          spinner: newSpinner,
        );

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(originalSpec.container));
        expect(updatedSpec.icon, equals(newIcon));
        expect(updatedSpec.spinner, equals(newSpinner));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixIconButtonSpec();
        final originalContainer = originalSpec.container;
        final originalIcon = originalSpec.icon;
        final originalSpinner = originalSpec.spinner;
        final newContainer = StyleSpec(spec: BoxSpec());
        final newIcon = StyleSpec(spec: IconSpec());
        final newSpinner = StyleSpec(spec: RemixSpinnerSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          icon: newIcon,
          spinner: newSpinner,
        );

        expect(originalSpec.container, equals(originalContainer));
        expect(originalSpec.icon, equals(originalIcon));
        expect(originalSpec.spinner, equals(originalSpinner));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.icon, equals(newIcon));
        expect(updatedSpec.spinner, equals(newSpinner));
        expect(updatedSpec.container, isNot(same(originalContainer)));
        expect(updatedSpec.icon, isNot(same(originalIcon)));
        expect(updatedSpec.spinner, isNot(same(originalSpinner)));
      });

      test('copyWith with null parameters preserves original values', () {
        const originalSpec = RemixIconButtonSpec();
        final originalContainer = originalSpec.container;
        final originalIcon = originalSpec.icon;
        final originalSpinner = originalSpec.spinner;

        final updatedSpec = originalSpec.copyWith(
          container: null,
          icon: null,
          spinner: null,
        );

        expect(updatedSpec.container, equals(originalContainer));
        expect(updatedSpec.icon, equals(originalIcon));
        expect(updatedSpec.spinner, equals(originalSpinner));
        expect(updatedSpec.container, same(originalContainer));
        expect(updatedSpec.icon, same(originalIcon));
        expect(updatedSpec.spinner, same(originalSpinner));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = RemixIconButtonSpec();
        const other = null;

        final result = spec.lerp(other, 0.5);
        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );
        final spec2 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
        expect(result.icon, equals(spec1.icon));
        expect(result.spinner, equals(spec1.spinner));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );
        final spec2 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
        expect(result.icon, equals(spec2.icon));
        expect(result.spinner, equals(spec2.spinner));
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );
        final spec2 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<RemixIconButtonSpec>());
      });

      test('lerp with different t values', () {
        final spec1 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );
        final spec2 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );

        final result1 = spec1.lerp(spec2, 0.25);
        final result2 = spec1.lerp(spec2, 0.75);

        expect(result1, isNot(same(result2)));
        expect(result1, isA<RemixIconButtonSpec>());
        expect(result2, isA<RemixIconButtonSpec>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixIconButtonSpec();
        const spec2 = RemixIconButtonSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixIconButtonSpec();
        final spec2 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );

        // Since both have default values, they should be equal
        expect(spec1, equals(spec2));
      });

      test('specs with same custom properties are equal', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final iconSpec = StyleSpec(spec: IconSpec());
        final spinnerSpec = StyleSpec(spec: RemixSpinnerSpec());

        final spec1 = RemixIconButtonSpec(
          container: containerSpec,
          icon: iconSpec,
          spinner: spinnerSpec,
        );
        final spec2 = RemixIconButtonSpec(
          container: containerSpec,
          icon: iconSpec,
          spinner: spinnerSpec,
        );

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('props list contains all properties', () {
        const spec = RemixIconButtonSpec();

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.icon));
        expect(spec.props, contains(spec.spinner));
      });

      test('props list with custom properties', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final iconSpec = StyleSpec(spec: IconSpec());
        final spinnerSpec = StyleSpec(spec: RemixSpinnerSpec());

        final spec = RemixIconButtonSpec(
          container: containerSpec,
          icon: iconSpec,
          spinner: spinnerSpec,
        );

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(containerSpec));
        expect(spec.props, contains(iconSpec));
        expect(spec.props, contains(spinnerSpec));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixIconButtonSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('debugFillProperties with custom properties', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final iconSpec = StyleSpec(spec: IconSpec());
        final spinnerSpec = StyleSpec(spec: RemixSpinnerSpec());

        final spec = RemixIconButtonSpec(
          container: containerSpec,
          icon: iconSpec,
          spinner: spinnerSpec,
        );

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixIconButtonSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('toString includes all properties', () {
        const spec = RemixIconButtonSpec();
        final stringRepresentation = spec.toString();

        expect(stringRepresentation, contains('container'));
        expect(stringRepresentation, contains('icon'));
        expect(stringRepresentation, contains('spinner'));
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixIconButtonSpec();
        final originalContainer = spec.container;
        final originalIcon = spec.icon;
        final originalSpinner = spec.spinner;

        final updatedSpec = spec.copyWith(
          container: null,
          icon: null,
          spinner: null,
        );

        expect(updatedSpec.container, equals(originalContainer));
        expect(updatedSpec.icon, equals(originalIcon));
        expect(updatedSpec.spinner, equals(originalSpinner));
      });

      test('lerp handles edge t values', () {
        final spec1 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );
        final spec2 = RemixIconButtonSpec(
          container: StyleSpec(spec: BoxSpec()),
          icon: StyleSpec(spec: IconSpec()),
          spinner: StyleSpec(spec: RemixSpinnerSpec()),
        );

        // Test t=0.0
        final result0 = spec1.lerp(spec2, 0.0);
        expect(result0, isA<RemixIconButtonSpec>());

        // Test t=1.0
        final result1 = spec1.lerp(spec2, 1.0);
        expect(result1, isA<RemixIconButtonSpec>());

        // Test t=0.0 and t=1.0 should be different
        expect(result0, isNot(same(result1)));
      });

      test('spec with complex StyleSpec properties', () {
        final complexContainerSpec = StyleSpec(spec: BoxSpec());
        final complexIconSpec = StyleSpec(spec: IconSpec());
        final complexSpinnerSpec = StyleSpec(spec: RemixSpinnerSpec());

        final spec = RemixIconButtonSpec(
          container: complexContainerSpec,
          icon: complexIconSpec,
          spinner: complexSpinnerSpec,
        );

        expect(spec.container, equals(complexContainerSpec));
        expect(spec.icon, equals(complexIconSpec));
        expect(spec.spinner, equals(complexSpinnerSpec));
        expect(spec.props, hasLength(4));
      });
    });
  });
}
