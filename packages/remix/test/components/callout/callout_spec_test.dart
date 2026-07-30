import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixCalloutSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixCalloutSpec();

        expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.text, isA<StyleSpec<TextSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
        expect(spec.container.spec, isA<FlexBoxSpec>());
        expect(spec.text.spec, isA<TextSpec>());
        expect(spec.icon.spec, isA<IconSpec>());
      });

      test('creates spec with provided parameters', () {
        final containerSpec = StyleSpec(spec: FlexBoxSpec());
        final textSpec = StyleSpec(spec: TextSpec());
        final iconSpec = StyleSpec(spec: IconSpec());

        final spec = RemixCalloutSpec(
          container: containerSpec,
          text: textSpec,
          icon: iconSpec,
        );

        expect(spec.container, equals(containerSpec));
        expect(spec.text, equals(textSpec));
        expect(spec.icon, equals(iconSpec));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixCalloutSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());
        final newText = StyleSpec(spec: TextSpec());
        final newIcon = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          text: newText,
          icon: newIcon,
        );

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.text, equals(newText));
        expect(updatedSpec.icon, equals(newIcon));
      });

      test('returns new instance with single updated property', () {
        const originalSpec = RemixCalloutSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.text, equals(originalSpec.text));
        expect(updatedSpec.icon, equals(originalSpec.icon));
      });

      test('returns new instance with multiple updated properties', () {
        const originalSpec = RemixCalloutSpec();
        final newText = StyleSpec(spec: TextSpec());
        final newIcon = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(text: newText, icon: newIcon);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(originalSpec.container));
        expect(updatedSpec.text, equals(newText));
        expect(updatedSpec.icon, equals(newIcon));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixCalloutSpec();
        final originalContainer = originalSpec.container;
        final originalText = originalSpec.text;
        final originalIcon = originalSpec.icon;
        final newContainer = StyleSpec(spec: FlexBoxSpec());
        final newText = StyleSpec(spec: TextSpec());
        final newIcon = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          text: newText,
          icon: newIcon,
        );

        expect(originalSpec.container, equals(originalContainer));
        expect(originalSpec.text, equals(originalText));
        expect(originalSpec.icon, equals(originalIcon));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.text, equals(newText));
        expect(updatedSpec.icon, equals(newIcon));
        expect(updatedSpec.container, isNot(same(originalContainer)));
        expect(updatedSpec.text, isNot(same(originalText)));
        expect(updatedSpec.icon, isNot(same(originalIcon)));
      });

      test('copyWith with null parameters preserves original values', () {
        const originalSpec = RemixCalloutSpec();
        final originalContainer = originalSpec.container;
        final originalText = originalSpec.text;
        final originalIcon = originalSpec.icon;

        final updatedSpec = originalSpec.copyWith(
          container: null,
          text: null,
          icon: null,
        );

        expect(updatedSpec.container, equals(originalContainer));
        expect(updatedSpec.text, equals(originalText));
        expect(updatedSpec.icon, equals(originalIcon));
        expect(updatedSpec.container, same(originalContainer));
        expect(updatedSpec.text, same(originalText));
        expect(updatedSpec.icon, same(originalIcon));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = RemixCalloutSpec();
        const other = null;

        final result = spec.lerp(other, 0.5);
        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
        expect(result.text, equals(spec1.text));
        expect(result.icon, equals(spec1.icon));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
        expect(result.text, equals(spec2.text));
        expect(result.icon, equals(spec2.icon));
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<RemixCalloutSpec>());
      });

      test('lerp with different t values', () {
        final spec1 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );

        final result1 = spec1.lerp(spec2, 0.25);
        final result2 = spec1.lerp(spec2, 0.75);

        expect(result1, isNot(same(result2)));
        expect(result1, isA<RemixCalloutSpec>());
        expect(result2, isA<RemixCalloutSpec>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixCalloutSpec();
        const spec2 = RemixCalloutSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixCalloutSpec();
        final spec2 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );

        // Since both have default values, they should be equal
        expect(spec1, equals(spec2));
      });

      test('specs with same custom properties are equal', () {
        final containerSpec = StyleSpec(spec: FlexBoxSpec());
        final textSpec = StyleSpec(spec: TextSpec());
        final iconSpec = StyleSpec(spec: IconSpec());

        final spec1 = RemixCalloutSpec(
          container: containerSpec,
          text: textSpec,
          icon: iconSpec,
        );
        final spec2 = RemixCalloutSpec(
          container: containerSpec,
          text: textSpec,
          icon: iconSpec,
        );

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('specs with different custom properties are not equal', () {
        final containerSpec1 = StyleSpec(spec: FlexBoxSpec());
        final containerSpec2 = StyleSpec(spec: FlexBoxSpec());
        final textSpec = StyleSpec(spec: TextSpec());
        final iconSpec = StyleSpec(spec: IconSpec());

        final spec1 = RemixCalloutSpec(
          container: containerSpec1,
          text: textSpec,
          icon: iconSpec,
        );
        final spec2 = RemixCalloutSpec(
          container: containerSpec2,
          text: textSpec,
          icon: iconSpec,
        );

        // Since both have default values, they should be equal
        expect(spec1, equals(spec2));
      });

      test('props list contains all properties', () {
        const spec = RemixCalloutSpec();

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.text));
        expect(spec.props, contains(spec.icon));
      });

      test('props list with custom properties', () {
        final containerSpec = StyleSpec(spec: FlexBoxSpec());
        final textSpec = StyleSpec(spec: TextSpec());
        final iconSpec = StyleSpec(spec: IconSpec());

        final spec = RemixCalloutSpec(
          container: containerSpec,
          text: textSpec,
          icon: iconSpec,
        );

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(containerSpec));
        expect(spec.props, contains(textSpec));
        expect(spec.props, contains(iconSpec));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixCalloutSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('debugFillProperties with custom properties', () {
        final containerSpec = StyleSpec(spec: FlexBoxSpec());
        final textSpec = StyleSpec(spec: TextSpec());
        final iconSpec = StyleSpec(spec: IconSpec());

        final spec = RemixCalloutSpec(
          container: containerSpec,
          text: textSpec,
          icon: iconSpec,
        );

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixCalloutSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('toString includes all properties', () {
        const spec = RemixCalloutSpec();
        final stringRepresentation = spec.toString();

        expect(stringRepresentation, contains('container'));
        expect(stringRepresentation, contains('text'));
        expect(stringRepresentation, contains('icon'));
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixCalloutSpec();
        final originalContainer = spec.container;
        final originalText = spec.text;
        final originalIcon = spec.icon;

        final updatedSpec = spec.copyWith(
          container: null,
          text: null,
          icon: null,
        );

        expect(updatedSpec.container, equals(originalContainer));
        expect(updatedSpec.text, equals(originalText));
        expect(updatedSpec.icon, equals(originalIcon));
      });

      test('lerp handles edge t values', () {
        final spec1 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );
        final spec2 = RemixCalloutSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
          text: StyleSpec(spec: TextSpec()),
          icon: StyleSpec(spec: IconSpec()),
        );

        // Test t=0.0
        final result0 = spec1.lerp(spec2, 0.0);
        expect(result0, isA<RemixCalloutSpec>());

        // Test t=1.0
        final result1 = spec1.lerp(spec2, 1.0);
        expect(result1, isA<RemixCalloutSpec>());

        // Test t=0.0 and t=1.0 should be different
        expect(result0, isNot(same(result1)));
      });

      test('spec with complex StyleSpec properties', () {
        final complexContainerSpec = StyleSpec(spec: FlexBoxSpec());
        final complexTextSpec = StyleSpec(spec: TextSpec());
        final complexIconSpec = StyleSpec(spec: IconSpec());

        final spec = RemixCalloutSpec(
          container: complexContainerSpec,
          text: complexTextSpec,
          icon: complexIconSpec,
        );

        expect(spec.container, equals(complexContainerSpec));
        expect(spec.text, equals(complexTextSpec));
        expect(spec.icon, equals(complexIconSpec));
        expect(spec.props, hasLength(4));
      });

      test('spec equality with complex properties', () {
        final containerSpec = StyleSpec(spec: FlexBoxSpec());
        final textSpec = StyleSpec(spec: TextSpec());
        final iconSpec = StyleSpec(spec: IconSpec());

        final spec1 = RemixCalloutSpec(
          container: containerSpec,
          text: textSpec,
          icon: iconSpec,
        );
        final spec2 = RemixCalloutSpec(
          container: containerSpec,
          text: textSpec,
          icon: iconSpec,
        );

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });
    });
  });
}
