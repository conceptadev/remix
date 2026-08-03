import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:remix/remix.dart';

void main() {
  group('AvatarSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = AvatarSpec();

        expect(spec.container, isA<StyleSpec<BoxSpec>>());
        expect(spec.label, isA<StyleSpec<TextSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = AvatarSpec();
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.label, equals(originalSpec.label));
        expect(updatedSpec.icon, equals(originalSpec.icon));
      });

      test('returns new instance with updated text property', () {
        const originalSpec = AvatarSpec();
        final newText = StyleSpec(spec: TextSpec());

        final updatedSpec = originalSpec.copyWith(label: newText);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(originalSpec.container));
        expect(updatedSpec.label, equals(newText));
        expect(updatedSpec.icon, equals(originalSpec.icon));
      });

      test('returns new instance with updated icon property', () {
        const originalSpec = AvatarSpec();
        final newIcon = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(icon: newIcon);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(originalSpec.container));
        expect(updatedSpec.label, equals(originalSpec.label));
        expect(updatedSpec.icon, equals(newIcon));
      });

      test('returns new instance with multiple updated properties', () {
        const originalSpec = AvatarSpec();
        final newContainer = StyleSpec(spec: BoxSpec());
        final newText = StyleSpec(spec: TextSpec());
        final newIcon = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          label: newText,
          icon: newIcon,
        );

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.label, equals(newText));
        expect(updatedSpec.icon, equals(newIcon));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = AvatarSpec();
        final originalContainer = originalSpec.container;
        final originalText = originalSpec.label;
        final originalIcon = originalSpec.icon;
        final newContainer = StyleSpec(spec: BoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(originalSpec.container, equals(originalContainer));
        expect(originalSpec.label, equals(originalText));
        expect(originalSpec.icon, equals(originalIcon));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.container, isNot(same(originalContainer)));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = AvatarSpec();
        const other = null;

        final result = spec.lerp(other, 0.5);
        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final containerSpec1 = StyleSpec(spec: BoxSpec());
        final textSpec1 = StyleSpec(spec: TextSpec());
        final iconSpec1 = StyleSpec(spec: IconSpec());

        final containerSpec2 = StyleSpec(spec: BoxSpec());
        final textSpec2 = StyleSpec(spec: TextSpec());
        final iconSpec2 = StyleSpec(spec: IconSpec());

        final spec1 = AvatarSpec(
          container: containerSpec1,
          label: textSpec1,
          icon: iconSpec1,
        );
        final spec2 = AvatarSpec(
          container: containerSpec2,
          label: textSpec2,
          icon: iconSpec2,
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
        expect(result.label, equals(spec1.label));
        expect(result.icon, equals(spec1.icon));
      });

      test('interpolates between two specs at t=1.0', () {
        final containerSpec1 = StyleSpec(spec: BoxSpec());
        final textSpec1 = StyleSpec(spec: TextSpec());
        final iconSpec1 = StyleSpec(spec: IconSpec());

        final containerSpec2 = StyleSpec(spec: BoxSpec());
        final textSpec2 = StyleSpec(spec: TextSpec());
        final iconSpec2 = StyleSpec(spec: IconSpec());

        final spec1 = AvatarSpec(
          container: containerSpec1,
          label: textSpec1,
          icon: iconSpec1,
        );
        final spec2 = AvatarSpec(
          container: containerSpec2,
          label: textSpec2,
          icon: iconSpec2,
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
        expect(result.label, equals(spec2.label));
        expect(result.icon, equals(spec2.icon));
      });

      test('interpolates between two specs at t=0.5', () {
        final containerSpec1 = StyleSpec(spec: BoxSpec());
        final textSpec1 = StyleSpec(spec: TextSpec());
        final iconSpec1 = StyleSpec(spec: IconSpec());

        final containerSpec2 = StyleSpec(spec: BoxSpec());
        final textSpec2 = StyleSpec(spec: TextSpec());
        final iconSpec2 = StyleSpec(spec: IconSpec());

        final spec1 = AvatarSpec(
          container: containerSpec1,
          label: textSpec1,
          icon: iconSpec1,
        );
        final spec2 = AvatarSpec(
          container: containerSpec2,
          label: textSpec2,
          icon: iconSpec2,
        );

        final result = spec1.lerp(spec2, 0.5);

        expect(result, isNot(same(spec1)));
        expect(result, isNot(same(spec2)));
        expect(result, isA<AvatarSpec>());
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = AvatarSpec();
        const spec2 = AvatarSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        final textSpec1 = StyleSpec(spec: TextSpec());
        final textSpec2 = StyleSpec(
          spec: TextSpec(style: TextStyle(fontSize: 16)),
        );

        final spec1 = AvatarSpec(label: textSpec1);
        final spec2 = AvatarSpec(label: textSpec2);

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = AvatarSpec();

        expect(spec.props, hasLength(3));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.icon));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = AvatarSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('debugFillProperties includes all properties', () {
        const spec = AvatarSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties, hasLength(3));

        // Check that all expected properties are included
        final propertyNames = properties.map((p) => p.name).toSet();
        expect(propertyNames, contains('container'));
        expect(propertyNames, contains('label'));
        expect(propertyNames, contains('icon'));
      });

      test('can be converted to string for debugging', () {
        const spec = AvatarSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });

      test('toString includes class name', () {
        const spec = AvatarSpec();

        expect(spec.toString(), contains('AvatarSpec'));
      });
    });
  });
}
