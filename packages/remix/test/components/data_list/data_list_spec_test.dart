import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('DataListSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = DataListSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
        expect(spec.labelContainer, isA<StyleSpec<BoxSpec>>());
        expect(spec.valueContainer, isA<StyleSpec<BoxSpec>>());
        expect(spec.label, isA<StyleSpec<TextSpec>>());
        expect(spec.value, isA<StyleSpec<TextSpec>>());
        expect(spec.rowSpacing, isNull);
        expect(spec.columnSpacing, isNull);
        expect(spec.labelValueSpacing, isNull);
        expect(spec.minLabelWidth, isNull);
      });

      test('creates spec with custom slots and metrics', () {
        final container = StyleSpec(
          spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
        );
        final labelContainer = StyleSpec(
          spec: BoxSpec(padding: const EdgeInsets.all(2)),
        );
        final valueContainer = StyleSpec(
          spec: BoxSpec(padding: const EdgeInsets.all(4)),
        );
        const label = StyleSpec(spec: TextSpec(maxLines: 1));
        const value = StyleSpec(spec: TextSpec(maxLines: 3));

        final spec = DataListSpec(
          container: container,
          labelContainer: labelContainer,
          valueContainer: valueContainer,
          label: label,
          value: value,
          rowSpacing: 12.0,
          columnSpacing: 24.0,
          labelValueSpacing: 4.0,
          minLabelWidth: 120.0,
        );

        expect(spec.container, equals(container));
        expect(spec.labelContainer, equals(labelContainer));
        expect(spec.valueContainer, equals(valueContainer));
        expect(spec.label, equals(label));
        expect(spec.value, equals(value));
        expect(spec.rowSpacing, equals(12.0));
        expect(spec.columnSpacing, equals(24.0));
        expect(spec.labelValueSpacing, equals(4.0));
        expect(spec.minLabelWidth, equals(120.0));
      });

      test('retains negative metrics for the renderer to reject', () {
        const spec = DataListSpec(rowSpacing: -1.0);

        expect(spec.rowSpacing, equals(-1.0));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated slots', () {
        const originalSpec = DataListSpec();
        final newContainer = StyleSpec(
          spec: BoxSpec(decoration: BoxDecoration(color: Colors.blue)),
        );
        final newLabelContainer = StyleSpec(
          spec: BoxSpec(padding: const EdgeInsets.all(6)),
        );
        final newValueContainer = StyleSpec(
          spec: BoxSpec(padding: const EdgeInsets.all(8)),
        );
        const newLabel = StyleSpec(spec: TextSpec(maxLines: 2));
        const newValue = StyleSpec(spec: TextSpec(maxLines: 4));

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          labelContainer: newLabelContainer,
          valueContainer: newValueContainer,
          label: newLabel,
          value: newValue,
        );

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.labelContainer, equals(newLabelContainer));
        expect(updatedSpec.valueContainer, equals(newValueContainer));
        expect(updatedSpec.label, equals(newLabel));
        expect(updatedSpec.value, equals(newValue));
      });

      test('returns new instance with updated metrics', () {
        const originalSpec = DataListSpec();

        final updatedSpec = originalSpec.copyWith(
          rowSpacing: 10.0,
          columnSpacing: 20.0,
          labelValueSpacing: 2.0,
          minLabelWidth: 96.0,
        );

        expect(updatedSpec.rowSpacing, equals(10.0));
        expect(updatedSpec.columnSpacing, equals(20.0));
        expect(updatedSpec.labelValueSpacing, equals(2.0));
        expect(updatedSpec.minLabelWidth, equals(96.0));
      });

      test(
        'returns new instance with no changes when no parameters provided',
        () {
          const originalSpec = DataListSpec(rowSpacing: 8.0);

          final updatedSpec = originalSpec.copyWith();

          expect(updatedSpec, isNot(same(originalSpec)));
          expect(updatedSpec, equals(originalSpec));
        },
      );

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = DataListSpec(minLabelWidth: 50.0);

        final updatedSpec = originalSpec.copyWith(minLabelWidth: 90.0);

        expect(originalSpec.minLabelWidth, equals(50.0));
        expect(updatedSpec.minLabelWidth, equals(90.0));
      });
    });

    group('lerp', () {
      test('keeps slots and eases scalars toward zero when other is null', () {
        const spec = DataListSpec(rowSpacing: 8.0, columnSpacing: 16.0);

        final result = spec.lerp(null, 0.5);

        expect(result.container, equals(spec.container));
        expect(result.label, equals(spec.label));
        expect(result.value, equals(spec.value));
        // Generated MixOps.lerp treats an absent scalar endpoint as zero.
        expect(result.rowSpacing, equals(4.0));
        expect(result.columnSpacing, equals(8.0));
      });

      test('interpolates every metric at t=0.5', () {
        const spec1 = DataListSpec(
          rowSpacing: 0.0,
          columnSpacing: 10.0,
          labelValueSpacing: 2.0,
          minLabelWidth: 100.0,
        );
        const spec2 = DataListSpec(
          rowSpacing: 10.0,
          columnSpacing: 30.0,
          labelValueSpacing: 6.0,
          minLabelWidth: 140.0,
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result.rowSpacing, equals(5.0));
        expect(result.columnSpacing, equals(20.0));
        expect(result.labelValueSpacing, equals(4.0));
        expect(result.minLabelWidth, equals(120.0));
      });

      test('returns start and end values at t=0.0 and t=1.0', () {
        const spec1 = DataListSpec(rowSpacing: 4.0);
        const spec2 = DataListSpec(rowSpacing: 12.0);

        expect(spec1.lerp(spec2, 0.0).rowSpacing, equals(4.0));
        expect(spec1.lerp(spec2, 1.0).rowSpacing, equals(12.0));
      });

      test('interpolates nested slots', () {
        final spec1 = DataListSpec(container: StyleSpec(spec: BoxSpec()));
        final spec2 = DataListSpec(container: StyleSpec(spec: BoxSpec()));

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isA<DataListSpec>());
        expect(result.container, isA<StyleSpec<BoxSpec>>());
        expect(result.label, isA<StyleSpec<TextSpec>>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = DataListSpec(rowSpacing: 8.0);
        const spec2 = DataListSpec(rowSpacing: 8.0);

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('specs with different slots are not equal', () {
        const spec1 = DataListSpec();
        final spec2 = DataListSpec(
          labelContainer: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('specs with different metrics are not equal', () {
        const spec1 = DataListSpec(minLabelWidth: 100.0);
        const spec2 = DataListSpec(minLabelWidth: 120.0);

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = DataListSpec();

        expect(spec.props, hasLength(9));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.labelContainer));
        expect(spec.props, contains(spec.valueContainer));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.value));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = DataListSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = DataListSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('diagnostic properties are properly formatted', () {
        const spec = DataListSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final propertyNames = builder.properties.map((p) => p.name).toList();
        expect(
          propertyNames,
          containsAll([
            'container',
            'labelContainer',
            'valueContainer',
            'label',
            'value',
            'rowSpacing',
            'columnSpacing',
            'labelValueSpacing',
            'minLabelWidth',
          ]),
        );
      });
    });

    group('Edge Cases', () {
      test('copyWith handles null parameters correctly', () {
        const spec = DataListSpec(rowSpacing: 8.0);

        final updatedSpec = spec.copyWith(rowSpacing: null);

        expect(updatedSpec.rowSpacing, equals(8.0));
      });
    });
  });
}
