import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixRadioSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixRadioSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
        expect(spec.indicator, isA<StyleSpec<BoxSpec>>());
      });

      test('creates spec with provided parameters', () {
        final container = StyleSpec(spec: BoxSpec());
        final indicator = StyleSpec(spec: BoxSpec());

        final spec = RemixRadioSpec(container: container, indicator: indicator);

        expect(spec.container, equals(container));
        expect(spec.indicator, equals(indicator));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixRadioSpec();
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixRadioSpec();
        final originalContainer = originalSpec.container;
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(originalSpec.container, equals(originalContainer));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.container, isNot(same(originalContainer)));
      });

      test('returns new instance with all properties updated', () {
        const originalSpec = RemixRadioSpec();
        final newContainer = StyleSpec(spec: BoxSpec());
        final newIndicator = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          indicator: newIndicator,
        );

        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.indicator, equals(newIndicator));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = RemixRadioSpec();
        const RemixRadioSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixRadioSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = RemixRadioSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixRadioSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = RemixRadioSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixRadioSpec();
        const spec2 = RemixRadioSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixRadioSpec();
        final spec2 = RemixRadioSpec(
          container: StyleSpec(
            spec: const BoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = RemixRadioSpec();

        expect(spec.props, hasLength(3));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.indicator));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixRadioSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixRadioSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixRadioSpec();
        final originalContainer = spec.container;

        final updatedSpec = spec.copyWith(container: null);

        expect(updatedSpec.container, equals(originalContainer));
      });
    });
  });
}
