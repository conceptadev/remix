import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixBadgeSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixBadgeSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
        expect(spec.label, isA<StyleSpec<TextSpec>>());
        expect(spec.container.spec, isA<BoxSpec>());
        expect(spec.label.spec, isA<TextSpec>());
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixBadgeSpec();
        final newContainer = StyleSpec(spec: BoxSpec());
        final newText = StyleSpec(spec: TextSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          label: newText,
        );

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.label, equals(newText));
      });

      test('returns new instance with single updated property', () {
        const originalSpec = RemixBadgeSpec();
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.label, equals(originalSpec.label));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixBadgeSpec();
        final originalContainer = originalSpec.container;
        final originalText = originalSpec.label;
        final newContainer = StyleSpec(spec: BoxSpec());
        final newText = StyleSpec(spec: TextSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          label: newText,
        );

        expect(originalSpec.container, equals(originalContainer));
        expect(originalSpec.label, equals(originalText));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.label, equals(newText));
        expect(updatedSpec.container, isNot(same(originalContainer)));
        expect(updatedSpec.label, isNot(same(originalText)));
      });

      test('copyWith with null parameters preserves original values', () {
        const originalSpec = RemixBadgeSpec();
        final originalContainer = originalSpec.container;
        final originalText = originalSpec.label;

        final updatedSpec = originalSpec.copyWith(container: null, label: null);

        expect(updatedSpec.container, equals(originalContainer));
        expect(updatedSpec.label, equals(originalText));
        expect(updatedSpec.container, same(originalContainer));
        expect(updatedSpec.label, same(originalText));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = RemixBadgeSpec();
        const other = null;

        final result = spec.lerp(other, 0.5);
        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
        expect(result.label, equals(spec1.label));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
        expect(result.label, equals(spec2.label));
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<RemixBadgeSpec>());
      });

      test('lerp with different t values', () {
        final spec1 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        final result1 = spec1.lerp(spec2, 0.25);
        final result2 = spec1.lerp(spec2, 0.75);

        expect(result1, isNot(same(result2)));
        expect(result1, isA<RemixBadgeSpec>());
        expect(result2, isA<RemixBadgeSpec>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixBadgeSpec();
        const spec2 = RemixBadgeSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixBadgeSpec();
        final spec2 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        // Since both have default values, they should be equal
        expect(spec1, equals(spec2));
      });

      test('specs with same custom properties are equal', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final textSpec = StyleSpec(spec: TextSpec());

        final spec1 = RemixBadgeSpec(container: containerSpec, label: textSpec);
        final spec2 = RemixBadgeSpec(container: containerSpec, label: textSpec);

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('props list contains all properties', () {
        const spec = RemixBadgeSpec();

        expect(spec.props, hasLength(3));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
      });

      test('props list with custom properties', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final textSpec = StyleSpec(spec: TextSpec());

        final spec = RemixBadgeSpec(container: containerSpec, label: textSpec);

        expect(spec.props, hasLength(3));
        expect(spec.props, contains(containerSpec));
        expect(spec.props, contains(textSpec));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixBadgeSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('debugFillProperties with custom properties', () {
        final containerSpec = StyleSpec(spec: BoxSpec());
        final textSpec = StyleSpec(spec: TextSpec());

        final spec = RemixBadgeSpec(container: containerSpec, label: textSpec);

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixBadgeSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('toString includes all properties', () {
        const spec = RemixBadgeSpec();
        final stringRepresentation = spec.toString();

        expect(stringRepresentation, contains('container'));
        expect(stringRepresentation, contains('label'));
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixBadgeSpec();
        final originalContainer = spec.container;
        final originalText = spec.label;

        final updatedSpec = spec.copyWith(container: null, label: null);

        expect(updatedSpec.container, equals(originalContainer));
        expect(updatedSpec.label, equals(originalText));
      });

      test('lerp handles edge t values', () {
        final spec1 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );
        final spec2 = RemixBadgeSpec(
          container: StyleSpec(spec: BoxSpec()),
          label: StyleSpec(spec: TextSpec()),
        );

        // Test t=0.0
        final result0 = spec1.lerp(spec2, 0.0);
        expect(result0, isA<RemixBadgeSpec>());

        // Test t=1.0
        final result1 = spec1.lerp(spec2, 1.0);
        expect(result1, isA<RemixBadgeSpec>());

        // Test t=0.0 and t=1.0 should be different
        expect(result0, isNot(same(result1)));
      });

      test('spec with complex StyleSpec properties', () {
        final complexContainerSpec = StyleSpec(spec: BoxSpec());
        final complexTextSpec = StyleSpec(spec: TextSpec());

        final spec = RemixBadgeSpec(
          container: complexContainerSpec,
          label: complexTextSpec,
        );

        expect(spec.container, equals(complexContainerSpec));
        expect(spec.label, equals(complexTextSpec));
        expect(spec.props, hasLength(3));
      });
    });
  });
}
