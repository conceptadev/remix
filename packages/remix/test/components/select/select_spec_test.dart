import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixSelectSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixSelectSpec();

        expect(spec.trigger, isA<StyleSpec<RemixSelectTriggerSpec>>());
        expect(spec.menuContainer, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.item, isA<StyleSpec<RemixSelectMenuItemSpec>>());
      });

      test('creates spec with provided parameters', () {
        final trigger = StyleSpec(spec: const RemixSelectTriggerSpec());
        final menuContainer = StyleSpec(spec: FlexBoxSpec());
        final item = StyleSpec(spec: const RemixSelectMenuItemSpec());

        final spec = RemixSelectSpec(
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
        const originalSpec = RemixSelectSpec();
        final newTrigger = StyleSpec(spec: const RemixSelectTriggerSpec());

        final updatedSpec = originalSpec.copyWith(trigger: newTrigger);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.trigger, equals(newTrigger));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixSelectSpec();
        final originalTrigger = originalSpec.trigger;
        final newTrigger = StyleSpec(spec: const RemixSelectTriggerSpec());

        final updatedSpec = originalSpec.copyWith(trigger: newTrigger);

        expect(originalSpec.trigger, equals(originalTrigger));
        expect(updatedSpec.trigger, equals(newTrigger));
        expect(updatedSpec.trigger, isNot(same(originalTrigger)));
      });

      test('returns new instance with all properties updated', () {
        const originalSpec = RemixSelectSpec();
        final newTrigger = StyleSpec(spec: const RemixSelectTriggerSpec());
        final newMenuContainer = StyleSpec(spec: FlexBoxSpec());
        final newItem = StyleSpec(spec: const RemixSelectMenuItemSpec());

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
        const spec = RemixSelectSpec();
        const RemixSelectSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixSelectSpec(
          trigger: StyleSpec(spec: const RemixSelectTriggerSpec()),
        );
        final spec2 = RemixSelectSpec(
          trigger: StyleSpec(spec: const RemixSelectTriggerSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.trigger, equals(spec1.trigger));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixSelectSpec(
          trigger: StyleSpec(spec: const RemixSelectTriggerSpec()),
        );
        final spec2 = RemixSelectSpec(
          trigger: StyleSpec(spec: const RemixSelectTriggerSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.trigger, equals(spec2.trigger));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixSelectSpec();
        const spec2 = RemixSelectSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixSelectSpec();
        final spec2 = RemixSelectSpec(
          trigger: StyleSpec(
            spec: const RemixSelectTriggerSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = RemixSelectSpec();

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(spec.trigger));
        expect(spec.props, contains(spec.menuContainer));
        expect(spec.props, contains(spec.item));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixSelectSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixSelectSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = RemixSelectSpec();
        final originalTrigger = spec.trigger;

        final updatedSpec = spec.copyWith(trigger: null);

        expect(updatedSpec.trigger, equals(originalTrigger));
      });
    });
  });

  group('RemixSelectTriggerSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixSelectTriggerSpec();

        expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.label, isA<StyleSpec<TextSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
      });

      test('creates spec with provided parameters', () {
        final container = StyleSpec(spec: FlexBoxSpec());
        final label = StyleSpec(spec: TextSpec());
        final icon = StyleSpec(spec: IconSpec());

        final spec = RemixSelectTriggerSpec(
          container: container,
          label: label,
          icon: icon,
        );

        expect(spec.container, equals(container));
        expect(spec.label, equals(label));
        expect(spec.icon, equals(icon));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = RemixSelectTriggerSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixSelectTriggerSpec();
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
        const spec = RemixSelectTriggerSpec();
        const RemixSelectTriggerSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixSelectTriggerSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = RemixSelectTriggerSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixSelectTriggerSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = RemixSelectTriggerSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixSelectTriggerSpec();
        const spec2 = RemixSelectTriggerSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixSelectTriggerSpec();
        final spec2 = RemixSelectTriggerSpec(
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
        const spec = RemixSelectTriggerSpec();

        expect(spec.props, hasLength(8));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.icon));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixSelectTriggerSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixSelectTriggerSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });
  });

  group('RemixSelectMenuItemSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = RemixSelectMenuItemSpec();

        expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.text, isA<StyleSpec<TextSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
      });

      test('creates spec with provided parameters', () {
        final container = StyleSpec(spec: FlexBoxSpec());
        final text = StyleSpec(spec: TextSpec());
        final icon = StyleSpec(spec: IconSpec());

        final spec = RemixSelectMenuItemSpec(
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
        const originalSpec = RemixSelectMenuItemSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = RemixSelectMenuItemSpec();
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
        const spec = RemixSelectMenuItemSpec();
        const RemixSelectMenuItemSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = RemixSelectMenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = RemixSelectMenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = RemixSelectMenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = RemixSelectMenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixSelectMenuItemSpec();
        const spec2 = RemixSelectMenuItemSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixSelectMenuItemSpec();
        final spec2 = RemixSelectMenuItemSpec(
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
        const spec = RemixSelectMenuItemSpec();

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.text));
        expect(spec.props, contains(spec.icon));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = RemixSelectMenuItemSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = RemixSelectMenuItemSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });
  });
}
