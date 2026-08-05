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
        expect(spec.checkboxItem, isNull);
        expect(spec.radioItem, isNull);
        expect(spec.submenuItem, isNull);
        expect(spec.divider, isA<StyleSpec<DividerSpec>>());
      });

      test('creates spec with provided parameters', () {
        final trigger = StyleSpec(spec: MenuTriggerSpec());
        final overlay = StyleSpec(spec: FlexBoxSpec());
        final item = StyleSpec(spec: MenuItemSpec());
        final checkboxItem = StyleSpec(
          spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 10))),
        );
        final radioItem = StyleSpec(
          spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 11))),
        );
        final submenuItem = StyleSpec(
          spec: MenuItemSpec(trailingIcon: StyleSpec(spec: IconSpec(size: 12))),
        );
        final divider = StyleSpec(spec: DividerSpec());

        final spec = MenuSpec(
          trigger: trigger,
          overlay: overlay,
          item: item,
          checkboxItem: checkboxItem,
          radioItem: radioItem,
          submenuItem: submenuItem,
          divider: divider,
        );

        expect(spec.trigger, equals(trigger));
        expect(spec.overlay, equals(overlay));
        expect(spec.item, equals(item));
        expect(spec.checkboxItem, equals(checkboxItem));
        expect(spec.radioItem, equals(radioItem));
        expect(spec.submenuItem, equals(submenuItem));
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
        final newCheckboxItem = StyleSpec(
          spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 10))),
        );
        final newRadioItem = StyleSpec(
          spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 11))),
        );
        final newSubmenuItem = StyleSpec(
          spec: MenuItemSpec(trailingIcon: StyleSpec(spec: IconSpec(size: 12))),
        );
        final newDivider = StyleSpec(spec: DividerSpec());

        final updatedSpec = originalSpec.copyWith(
          trigger: newTrigger,
          overlay: newOverlay,
          item: newItem,
          checkboxItem: newCheckboxItem,
          radioItem: newRadioItem,
          submenuItem: newSubmenuItem,
          divider: newDivider,
        );

        expect(updatedSpec.trigger, equals(newTrigger));
        expect(updatedSpec.overlay, equals(newOverlay));
        expect(updatedSpec.item, equals(newItem));
        expect(updatedSpec.checkboxItem, equals(newCheckboxItem));
        expect(updatedSpec.radioItem, equals(newRadioItem));
        expect(updatedSpec.submenuItem, equals(newSubmenuItem));
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
        final spec1 = MenuSpec(trigger: StyleSpec(spec: MenuTriggerSpec()));
        final spec2 = MenuSpec(trigger: StyleSpec(spec: MenuTriggerSpec()));

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.trigger, equals(spec1.trigger));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = MenuSpec(trigger: StyleSpec(spec: MenuTriggerSpec()));
        final spec2 = MenuSpec(trigger: StyleSpec(spec: MenuTriggerSpec()));

        final result = spec1.lerp(spec2, 1.0);

        expect(result, isNot(same(spec2)));
        expect(result.trigger, equals(spec2.trigger));
      });

      test('preserves nullable semantic styles at exact endpoints', () {
        const checkboxItem = StyleSpec(
          spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 10))),
        );
        const radioItem = StyleSpec(
          spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 11))),
        );
        const submenuItem = StyleSpec(
          spec: MenuItemSpec(trailingIcon: StyleSpec(spec: IconSpec(size: 12))),
        );
        const absent = MenuSpec();
        const present = MenuSpec(
          checkboxItem: checkboxItem,
          radioItem: radioItem,
          submenuItem: submenuItem,
        );

        List<StyleSpec<MenuItemSpec>?> semanticStyles(MenuSpec spec) => [
          spec.checkboxItem,
          spec.radioItem,
          spec.submenuItem,
        ];

        expect(semanticStyles(absent.lerp(present, 0)), [null, null, null]);
        expect(semanticStyles(absent.lerp(present, 1)), [
          checkboxItem,
          radioItem,
          submenuItem,
        ]);
        expect(semanticStyles(present.lerp(absent, 0)), [
          checkboxItem,
          radioItem,
          submenuItem,
        ]);
        expect(semanticStyles(present.lerp(absent, 1)), [null, null, null]);
      });

      test('extrapolates before zero using the item fallback', () {
        const start = MenuSpec(
          item: StyleSpec(
            spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 8))),
          ),
        );
        const end = MenuSpec(
          checkboxItem: StyleSpec(
            spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 16))),
          ),
        );

        final result = start.lerp(end, -0.5);

        expect(result.checkboxItem?.spec.indicator.spec.size, 4);
      });

      test('extrapolates beyond one using the item fallback', () {
        const start = MenuSpec(
          item: StyleSpec(
            spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 8))),
          ),
        );
        const end = MenuSpec(
          checkboxItem: StyleSpec(
            spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 16))),
          ),
        );

        final result = start.lerp(end, 1.5);

        expect(result.checkboxItem?.spec.indicator.spec.size, 20);
      });

      test('interpolates an absent semantic style from the item fallback', () {
        const start = MenuSpec(
          item: StyleSpec(
            spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 4))),
          ),
        );
        const end = MenuSpec(
          checkboxItem: StyleSpec(
            spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 20))),
          ),
        );

        final middle = start.lerp(end, 0.5);

        expect(middle.checkboxItem?.spec.indicator.spec.size, 12);
      });

      test('keeps both-null semantic styles absent while lerping', () {
        const start = MenuSpec();
        const end = MenuSpec();

        final middle = start.lerp(end, 0.5);

        expect(middle.checkboxItem, isNull);
        expect(middle.radioItem, isNull);
        expect(middle.submenuItem, isNull);
      });

      test('interpolates semantic styles when both endpoints define them', () {
        const start = MenuSpec(
          radioItem: StyleSpec(
            spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 4))),
          ),
        );
        const end = MenuSpec(
          radioItem: StyleSpec(
            spec: MenuItemSpec(indicator: StyleSpec(spec: IconSpec(size: 20))),
          ),
        );

        final middle = start.lerp(end, 0.5);

        expect(middle.radioItem?.spec.indicator.spec.size, 12);
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

        expect(spec.props, hasLength(8));
        expect(spec.props, contains(spec.trigger));
        expect(spec.props, contains(spec.overlay));
        expect(spec.props, contains(spec.item));
        expect(spec.props, contains(spec.checkboxItem));
        expect(spec.props, contains(spec.radioItem));
        expect(spec.props, contains(spec.submenuItem));
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
        expect(spec.indicator, isA<StyleSpec<IconSpec>>());
      });

      test('creates spec with provided parameters', () {
        final container = StyleSpec(spec: FlexBoxSpec());
        final label = StyleSpec(spec: TextSpec());
        final leadingIcon = StyleSpec(spec: IconSpec());
        final trailingIcon = StyleSpec(spec: IconSpec());
        final indicator = StyleSpec(spec: IconSpec());

        final spec = MenuItemSpec(
          container: container,
          label: label,
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
          indicator: indicator,
        );

        expect(spec.container, equals(container));
        expect(spec.label, equals(label));
        expect(spec.leadingIcon, equals(leadingIcon));
        expect(spec.trailingIcon, equals(trailingIcon));
        expect(spec.indicator, equals(indicator));
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
        final newIndicator = StyleSpec(spec: IconSpec());

        final updatedSpec = originalSpec.copyWith(
          container: newContainer,
          label: newLabel,
          leadingIcon: newLeadingIcon,
          trailingIcon: newTrailingIcon,
          indicator: newIndicator,
        );

        expect(updatedSpec.container, equals(newContainer));
        expect(updatedSpec.label, equals(newLabel));
        expect(updatedSpec.leadingIcon, equals(newLeadingIcon));
        expect(updatedSpec.trailingIcon, equals(newTrailingIcon));
        expect(updatedSpec.indicator, equals(newIndicator));
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
        final spec1 = MenuItemSpec(container: StyleSpec(spec: FlexBoxSpec()));
        final spec2 = MenuItemSpec(container: StyleSpec(spec: FlexBoxSpec()));

        final result = spec1.lerp(spec2, 0.0);

        expect(result, isNot(same(spec1)));
        expect(result.container, equals(spec1.container));
      });

      test('interpolates between two specs at t=1.0', () {
        final spec1 = MenuItemSpec(container: StyleSpec(spec: FlexBoxSpec()));
        final spec2 = MenuItemSpec(container: StyleSpec(spec: FlexBoxSpec()));

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

        expect(spec.props, hasLength(5));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.leadingIcon));
        expect(spec.props, contains(spec.trailingIcon));
        expect(spec.props, contains(spec.indicator));
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

      test('lerps indicator style', () {
        const start = MenuItemSpec(
          indicator: StyleSpec(spec: IconSpec(size: 8)),
        );
        const end = MenuItemSpec(
          indicator: StyleSpec(spec: IconSpec(size: 12)),
        );

        final middle = start.lerp(end, 0.5);

        expect(middle.indicator.spec.size, 10);
      });
    });
  });
}
