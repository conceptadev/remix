import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('SelectSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = SelectSpec();

        expect(spec.trigger, isA<StyleSpec<SelectTriggerSpec>>());
        expect(spec.menuContainer, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.item, isA<StyleSpec<SelectMenuItemSpec>>());
      });

      test('creates spec with provided parameters', () {
        final trigger = StyleSpec(spec: const SelectTriggerSpec());
        final menuContainer = StyleSpec(spec: FlexBoxSpec());
        final item = StyleSpec(spec: const SelectMenuItemSpec());

        final spec = SelectSpec(
          trigger: trigger,
          menuContainer: menuContainer,
          item: item,
        );

        expect(spec.trigger, equals(trigger));
        expect(spec.menuContainer, equals(menuContainer));
        expect(spec.item, equals(item));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = SelectSpec();
        final newTrigger = StyleSpec(spec: const SelectTriggerSpec());

        final updatedSpec = originalSpec.copyWith(trigger: newTrigger);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.trigger, equals(newTrigger));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = SelectSpec();
        final originalTrigger = originalSpec.trigger;
        final newTrigger = StyleSpec(spec: const SelectTriggerSpec());

        final updatedSpec = originalSpec.copyWith(trigger: newTrigger);

        expect(originalSpec.trigger, equals(originalTrigger));
        expect(updatedSpec.trigger, equals(newTrigger));
        expect(updatedSpec.trigger, isNot(same(originalTrigger)));
      });

      test('returns new instance with all properties updated', () {
        const originalSpec = SelectSpec();
        final newTrigger = StyleSpec(spec: const SelectTriggerSpec());
        final newMenuContainer = StyleSpec(spec: FlexBoxSpec());
        final newItem = StyleSpec(spec: const SelectMenuItemSpec());

        final updatedSpec = originalSpec.copyWith(
          trigger: newTrigger,
          menuContainer: newMenuContainer,
          item: newItem,
        );

        expect(updatedSpec.trigger, equals(newTrigger));
        expect(updatedSpec.menuContainer, equals(newMenuContainer));
        expect(updatedSpec.item, equals(newItem));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = SelectSpec();
        const SelectSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = SelectSpec(
          trigger: StyleSpec(spec: const SelectTriggerSpec()),
        );
        final spec2 = SelectSpec(
          trigger: StyleSpec(spec: const SelectTriggerSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.trigger, equals(spec1.trigger));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = SelectSpec(
          trigger: StyleSpec(spec: const SelectTriggerSpec()),
        );
        final spec2 = SelectSpec(
          trigger: StyleSpec(spec: const SelectTriggerSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.trigger, equals(spec2.trigger));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = SelectSpec();
        const spec2 = SelectSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = SelectSpec();
        final spec2 = SelectSpec(
          trigger: StyleSpec(
            spec: const SelectTriggerSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = SelectSpec();

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(spec.trigger));
        expect(spec.props, contains(spec.menuContainer));
        expect(spec.props, contains(spec.item));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = SelectSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = SelectSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = SelectSpec();
        final originalTrigger = spec.trigger;

        final updatedSpec = spec.copyWith(trigger: null);

        expect(updatedSpec.trigger, equals(originalTrigger));
      });
    });
  });

  group('SelectTriggerSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = SelectTriggerSpec();

        expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.label, isA<StyleSpec<TextSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
        expect(spec.indicator, isA<StyleSpec<IconSpec>>());
      });

      test('creates spec with provided parameters', () {
        final container = StyleSpec(spec: FlexBoxSpec());
        final label = StyleSpec(spec: TextSpec());
        final icon = StyleSpec(spec: IconSpec());
        final indicator = StyleSpec(spec: IconSpec());

        final spec = SelectTriggerSpec(
          container: container,
          label: label,
          icon: icon,
          indicator: indicator,
          indicatorOpacity: 0.5,
        );

        expect(spec.container, equals(container));
        expect(spec.label, equals(label));
        expect(spec.icon, equals(icon));
        expect(spec.indicator, equals(indicator));
        expect(spec.indicatorOpacity, 0.5);
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = SelectTriggerSpec();
        final newIndicator = StyleSpec(
          spec: IconSpec(color: const Color(0xFF0000FF), size: 18),
        );

        final updatedSpec = originalSpec.copyWith(
          indicator: newIndicator,
          indicatorOpacity: 0.5,
        );

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.indicator, equals(newIndicator));
        expect(updatedSpec.indicatorOpacity, 0.5);
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = SelectTriggerSpec();
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
        const spec = SelectTriggerSpec();
        const SelectTriggerSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = SelectTriggerSpec(
          indicator: StyleSpec(spec: IconSpec(color: const Color(0xFF0000FF))),
          indicatorOpacity: 0,
        );
        final spec2 = SelectTriggerSpec(
          indicator: StyleSpec(spec: IconSpec(color: const Color(0xFFFF0000))),
          indicatorOpacity: 1,
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.indicator, equals(spec1.indicator));
        expect(result.indicatorOpacity, spec1.indicatorOpacity);
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = SelectTriggerSpec(
          indicator: StyleSpec(spec: IconSpec(color: const Color(0xFF0000FF))),
          indicatorOpacity: 0,
        );
        final spec2 = SelectTriggerSpec(
          indicator: StyleSpec(spec: IconSpec(color: const Color(0xFFFF0000))),
          indicatorOpacity: 1,
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.indicator, equals(spec2.indicator));
        expect(result.indicatorOpacity, spec2.indicatorOpacity);
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = SelectTriggerSpec();
        const spec2 = SelectTriggerSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = SelectTriggerSpec();
        const spec2 = SelectTriggerSpec(indicatorOpacity: 0.5);

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = SelectTriggerSpec();

        expect(spec.props, hasLength(8));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.icon));
        expect(spec.props, contains(spec.indicator));
        expect(spec.props, contains(spec.indicatorOpacity));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = SelectTriggerSpec(indicatorOpacity: 0.5);
        final properties = DiagnosticPropertiesBuilder();

        expect(() => spec.debugFillProperties(properties), returnsNormally);
        expect(
          properties.properties.map((property) => property.name),
          containsAll(['indicator', 'indicatorOpacity']),
        );
      });

      test('can be converted to string for debugging', () {
        const spec = SelectTriggerSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });
  });

  group('SelectMenuItemSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = SelectMenuItemSpec();

        expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.text, isA<StyleSpec<TextSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
      });

      test('creates spec with provided parameters', () {
        final container = StyleSpec(spec: FlexBoxSpec());
        final text = StyleSpec(spec: TextSpec());
        final icon = StyleSpec(spec: IconSpec());

        final spec = SelectMenuItemSpec(
          container: container,
          text: text,
          icon: icon,
        );

        expect(spec.container, equals(container));
        expect(spec.text, equals(text));
        expect(spec.icon, equals(icon));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = SelectMenuItemSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = SelectMenuItemSpec();
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
        const spec = SelectMenuItemSpec();
        const SelectMenuItemSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = SelectMenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = SelectMenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = SelectMenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = SelectMenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = SelectMenuItemSpec();
        const spec2 = SelectMenuItemSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = SelectMenuItemSpec();
        final spec2 = SelectMenuItemSpec(
          container: StyleSpec(
            spec: FlexBoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = SelectMenuItemSpec();

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.text));
        expect(spec.props, contains(spec.icon));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = SelectMenuItemSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = SelectMenuItemSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });
  });
}
