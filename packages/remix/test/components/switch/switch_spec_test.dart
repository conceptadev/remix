import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixSwitchSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixSwitchSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
        expect(spec.thumb, isA<StyleSpec<BoxSpec>>());
      });

      test('creates spec with provided parameters', () {
        final container = StyleSpec(spec: BoxSpec());
        final thumb = StyleSpec(spec: BoxSpec());

        final spec = RemixSwitchSpec(container: container, thumb: thumb);

        expect(spec.container, equals(container));
        expect(spec.thumb, equals(thumb));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixSwitchSpec();
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixSwitchSpec();
        final originalContainer = originalSpec.container;
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(originalSpec.container, equals(originalContainer));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.container, isNot(same(originalContainer)));
      });

      test('returns new instance with all properties updated', () {
        const originalSpec = RemixSwitchSpec();
        final newContainer = StyleSpec(spec: BoxSpec());
        final newThumb = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          thumb: newThumb,
        );

        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.thumb, equals(newThumb));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = RemixSwitchSpec();
        const RemixSwitchSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixSwitchSpec(
          container: StyleSpec(spec: BoxSpec()),
          thumb: StyleSpec(spec: BoxSpec()),
        );
        final spec2 = RemixSwitchSpec(
          container: StyleSpec(spec: BoxSpec()),
          thumb: StyleSpec(spec: BoxSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
        expect(result.thumb, equals(spec1.thumb));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixSwitchSpec(
          container: StyleSpec(spec: BoxSpec()),
          thumb: StyleSpec(spec: BoxSpec()),
        );
        final spec2 = RemixSwitchSpec(
          container: StyleSpec(spec: BoxSpec()),
          thumb: StyleSpec(spec: BoxSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
        expect(result.thumb, equals(spec2.thumb));
      });

      test('interpolates between two specs at t=0.5', () {
        final spec1 = RemixSwitchSpec(
          container: StyleSpec(spec: BoxSpec()),
          thumb: StyleSpec(spec: BoxSpec()),
        );
        final spec2 = RemixSwitchSpec(
          container: StyleSpec(spec: BoxSpec()),
          thumb: StyleSpec(spec: BoxSpec()),
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNotNull);
        expect(result.container, isNotNull);
        expect(result.thumb, isNotNull);
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixSwitchSpec();
        const spec2 = RemixSwitchSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        final spec1 = RemixSwitchSpec(
          container: StyleSpec(
            spec: const BoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );
        final spec2 = RemixSwitchSpec(
          container: StyleSpec(
            spec: const BoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 200),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = RemixSwitchSpec();

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.thumb));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixSwitchSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixSwitchSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixSwitchSpec();
        final originalContainer = spec.container;

        final updatedSpec = spec.copyWith(container: null);

        expect(updatedSpec.container, equals(originalContainer));
      });

      test('handles empty StyleSpec', () {
        const spec = RemixSwitchSpec(
          container: StyleSpec(spec: BoxSpec()),
          thumb: StyleSpec(spec: BoxSpec()),
        );

        expect(spec.container, isNotNull);
        expect(spec.thumb, isNotNull);
      });
    });

    group('Default Values', () {
      test('provides default values for all properties', () {
        const spec = RemixSwitchSpec();

        expect(spec.container, isNotNull);
        expect(spec.thumb, isNotNull);
      });
    });
  });
}
