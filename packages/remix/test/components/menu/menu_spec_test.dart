import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('MenuTriggerSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = MenuTriggerSpec();

        expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.label, isA<StyleSpec<TextSpec>>());
        expect(spec.icon, isA<StyleSpec<IconSpec>>());
      });

      test('creates spec with provided parameters', () {
        final container = StyleSpec(spec: FlexBoxSpec());
        final label = StyleSpec(spec: TextSpec());
        final icon = StyleSpec(spec: IconSpec());

        final spec = MenuTriggerSpec(
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
        const originalSpec = MenuTriggerSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = MenuTriggerSpec();
        final originalContainer = originalSpec.container;
        final newContainer = StyleSpec(spec: FlexBoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(originalSpec.container, equals(originalContainer));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.container, isNot(same(originalContainer)));
      });

      test('returns new instance with all properties updated', () {
        const originalSpec = MenuTriggerSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());
        final newLabel = StyleSpec(spec: TextSpec());
        final newIcon = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          label: newLabel,
          icon: newIcon,
        );

        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.label, equals(newLabel));
        expect(updatedSpec.icon, equals(newIcon));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = MenuTriggerSpec();
        const MenuTriggerSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = MenuTriggerSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = MenuTriggerSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = MenuTriggerSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = MenuTriggerSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = MenuTriggerSpec();
        const spec2 = MenuTriggerSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = MenuTriggerSpec();
        final spec2 = MenuTriggerSpec(
          container: StyleSpec(
            spec: const FlexBoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = MenuTriggerSpec();

        expect(spec.props, hasLength(3));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.icon));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = MenuTriggerSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = MenuTriggerSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });
  });

  group('MenuSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = MenuSpec();

        expect(spec.trigger, isA<StyleSpec<MenuTriggerSpec>>());
        expect(spec.overlay, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.item, isA<StyleSpec<MenuItemSpec>>());
        expect(spec.divider, isA<StyleSpec<RemixDividerSpec>>());
      });

      test('creates spec with provided parameters', () {
        final trigger = StyleSpec(spec: MenuTriggerSpec());
        final overlay = StyleSpec(spec: FlexBoxSpec());
        final item = StyleSpec(spec: MenuItemSpec());
        final divider = StyleSpec(spec: RemixDividerSpec());

        final spec = MenuSpec(
          trigger: trigger,
          overlay: overlay,
          item: item,
          divider: divider,
        );

        expect(spec.trigger, equals(trigger));
        expect(spec.overlay, equals(overlay));
        expect(spec.item, equals(item));
        expect(spec.divider, equals(divider));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = MenuSpec();
        final newTrigger = StyleSpec(spec: MenuTriggerSpec());

        final updatedSpec = originalSpec.copyWith(trigger: newTrigger);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.trigger, equals(newTrigger));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = MenuSpec();
        final originalTrigger = originalSpec.trigger;
        final newTrigger = StyleSpec(spec: MenuTriggerSpec());

        final updatedSpec = originalSpec.copyWith(trigger: newTrigger);

        expect(originalSpec.trigger, equals(originalTrigger));
        expect(updatedSpec.trigger, equals(newTrigger));
        expect(updatedSpec.trigger, isNot(same(originalTrigger)));
      });

      test('returns new instance with all properties updated', () {
        const originalSpec = MenuSpec();
        final newTrigger = StyleSpec(spec: MenuTriggerSpec());
        final newOverlay = StyleSpec(spec: FlexBoxSpec());
        final newItem = StyleSpec(spec: MenuItemSpec());
        final newDivider = StyleSpec(spec: RemixDividerSpec());

        final updatedSpec = originalSpec.copyWith(
          trigger: newTrigger,
          overlay: newOverlay,
          item: newItem,
          divider: newDivider,
        );

        expect(updatedSpec.trigger, equals(newTrigger));
        expect(updatedSpec.overlay, equals(newOverlay));
        expect(updatedSpec.item, equals(newItem));
        expect(updatedSpec.divider, equals(newDivider));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = MenuSpec();
        const MenuSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = MenuSpec(
          trigger: StyleSpec(spec: MenuTriggerSpec()),
        );
        final spec2 = MenuSpec(
          trigger: StyleSpec(spec: MenuTriggerSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.trigger, equals(spec1.trigger));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = MenuSpec(
          trigger: StyleSpec(spec: MenuTriggerSpec()),
        );
        final spec2 = MenuSpec(
          trigger: StyleSpec(spec: MenuTriggerSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.trigger, equals(spec2.trigger));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = MenuSpec();
        const spec2 = MenuSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = MenuSpec();
        final spec2 = MenuSpec(
          trigger: StyleSpec(
            spec: const MenuTriggerSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = MenuSpec();

        expect(spec.props, hasLength(5));
        expect(spec.props, contains(spec.trigger));
        expect(spec.props, contains(spec.overlay));
        expect(spec.props, contains(spec.item));
        expect(spec.props, contains(spec.divider));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = MenuSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = MenuSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });
  });

  group('MenuItemSpec', () {
    group('Constructor', () {
      test('creates spec with default values when no parameters provided', () {
        const spec = MenuItemSpec();

        expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
        expect(spec.label, isA<StyleSpec<TextSpec>>());
        expect(spec.leadingIcon, isA<StyleSpec<IconSpec>>());
        expect(spec.trailingIcon, isA<StyleSpec<IconSpec>>());
      });

      test('creates spec with provided parameters', () {
        final container = StyleSpec(spec: FlexBoxSpec());
        final label = StyleSpec(spec: TextSpec());
        final leadingIcon = StyleSpec(spec: IconSpec());
        final trailingIcon = StyleSpec(spec: IconSpec());

        final spec = MenuItemSpec(
          container: container,
          label: label,
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
        );

        expect(spec.container, equals(container));
        expect(spec.label, equals(label));
        expect(spec.leadingIcon, equals(leadingIcon));
        expect(spec.trailingIcon, equals(trailingIcon));
      });
    });

    group('copyWith', () {
      test('returns new instance with updated properties', () {
        const originalSpec = MenuItemSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(updatedSpec, isNot(same(originalSpec)));
        expect(updatedSpec.container, equals(newContainer));
      });

      test('preserves immutability - original spec unchanged', () {
        const originalSpec = MenuItemSpec();
        final originalContainer = originalSpec.container;
        final newContainer = StyleSpec(spec: FlexBoxSpec());

        final updatedSpec = originalSpec.copyWith(container: newContainer);

        expect(originalSpec.container, equals(originalContainer));
        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.container, isNot(same(originalContainer)));
      });

      test('returns new instance with all properties updated', () {
        const originalSpec = MenuItemSpec();
        final newContainer = StyleSpec(spec: FlexBoxSpec());
        final newLabel = StyleSpec(spec: TextSpec());
        final newLeadingIcon = StyleSpec(spec: IconSpec());
        final newTrailingIcon = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          label: newLabel,
          leadingIcon: newLeadingIcon,
          trailingIcon: newTrailingIcon,
        );

        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.label, equals(newLabel));
        expect(updatedSpec.leadingIcon, equals(newLeadingIcon));
        expect(updatedSpec.trailingIcon, equals(newTrailingIcon));
      });
    });

    group('lerp', () {
      test('returns spec equal to this when other is null', () {
        const spec = MenuItemSpec();
        const MenuItemSpec? other = null;

        final result = spec.lerp(other, 0.5);

        expect(result, equals(spec));
      });

      test('interpolates between two specs at t=0.0', () {
        final spec1 = MenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = MenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = MenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );
        final spec2 = MenuItemSpec(
          container: StyleSpec(spec: FlexBoxSpec()),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.container, equals(spec2.container));
      });
    });

    group('Equality and Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = MenuItemSpec();
        const spec2 = MenuItemSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = MenuItemSpec();
        final spec2 = MenuItemSpec(
          container: StyleSpec(
            spec: const FlexBoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props list contains all properties', () {
        const spec = MenuItemSpec();

        expect(spec.props, hasLength(4));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.leadingIcon));
        expect(spec.props, contains(spec.trailingIcon));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties works without throwing', () {
        const spec = MenuItemSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
      });

      test('can be converted to string for debugging', () {
        const spec = MenuItemSpec();

        expect(spec.toString(), isA<String>());
        expect(spec.toString(), isNotEmpty);
      });
    });

    group('Edge Cases and Error Handling', () {
      test('copyWith handles null parameters correctly', () {
        const spec = MenuItemSpec();
        final originalContainer = spec.container;

        final updatedSpec = spec.copyWith(container: null);

        expect(updatedSpec.container, equals(originalContainer));
      });
    });
  });
}
