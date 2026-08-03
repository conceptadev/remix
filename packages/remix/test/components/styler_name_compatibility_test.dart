import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

/// Proves that every `Remix*Styler` name kept for source compatibility still
/// resolves through `package:remix/remix.dart`, constructs, and is the same
/// type as its canonical unprefixed counterpart.
///
/// Component-specific behavior lives in the per-component compatibility tests;
/// this file is the exhaustive name-level contract for the migration.
void main() {
  group('deprecated Remix*Styler aliases', () {
    test('RemixAccordionStyler aliases AccordionStyler', () {
      // ignore: deprecated_member_use
      final RemixAccordionStyler legacy = RemixAccordionStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixAccordionStyler.create();

      final AccordionStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, AccordionStyler);
      expect(legacy.merge(emptyLegacy), isA<AccordionStyler>());
    });

    test('RemixAvatarStyler aliases AvatarStyler', () {
      // ignore: deprecated_member_use
      final RemixAvatarStyler legacy = RemixAvatarStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixAvatarStyler.create();

      final AvatarStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, AvatarStyler);
      expect(legacy.merge(emptyLegacy), isA<AvatarStyler>());
    });

    test('RemixBadgeStyler aliases BadgeStyler', () {
      // ignore: deprecated_member_use
      final RemixBadgeStyler legacy = RemixBadgeStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixBadgeStyler.create();

      final BadgeStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, BadgeStyler);
      expect(legacy.merge(emptyLegacy), isA<BadgeStyler>());
    });

    test('RemixButtonStyler aliases ButtonStyler', () {
      // ignore: deprecated_member_use
      final RemixButtonStyler legacy = RemixButtonStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixButtonStyler.create();

      final ButtonStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, ButtonStyler);
      expect(legacy.merge(emptyLegacy), isA<ButtonStyler>());
    });

    test('RemixCalloutStyler aliases CalloutStyler', () {
      // ignore: deprecated_member_use
      final RemixCalloutStyler legacy = RemixCalloutStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixCalloutStyler.create();

      final CalloutStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, CalloutStyler);
      expect(legacy.merge(emptyLegacy), isA<CalloutStyler>());
    });

    test('RemixCardStyler aliases CardStyler', () {
      // ignore: deprecated_member_use
      final RemixCardStyler legacy = RemixCardStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixCardStyler.create();

      final CardStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, CardStyler);
      expect(legacy.merge(emptyLegacy), isA<CardStyler>());
    });

    test('RemixCheckboxStyler aliases CheckboxStyler', () {
      // ignore: deprecated_member_use
      final RemixCheckboxStyler legacy = RemixCheckboxStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixCheckboxStyler.create();

      final CheckboxStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, CheckboxStyler);
      expect(legacy.merge(emptyLegacy), isA<CheckboxStyler>());
    });

    test('RemixDialogStyler aliases DialogStyler', () {
      // ignore: deprecated_member_use
      final RemixDialogStyler legacy = RemixDialogStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixDialogStyler.create();

      final DialogStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, DialogStyler);
      expect(legacy.merge(emptyLegacy), isA<DialogStyler>());
    });

    test('RemixDividerStyler aliases DividerStyler', () {
      // ignore: deprecated_member_use
      final RemixDividerStyler legacy = RemixDividerStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixDividerStyler.create();

      final DividerStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, DividerStyler);
      expect(legacy.merge(emptyLegacy), isA<DividerStyler>());
    });

    test('RemixIconButtonStyler aliases IconButtonStyler', () {
      // ignore: deprecated_member_use
      final RemixIconButtonStyler legacy = RemixIconButtonStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixIconButtonStyler.create();

      final IconButtonStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, IconButtonStyler);
      expect(legacy.merge(emptyLegacy), isA<IconButtonStyler>());
    });

    test('RemixMenuStyler aliases MenuStyler', () {
      // ignore: deprecated_member_use
      final RemixMenuStyler legacy = RemixMenuStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixMenuStyler.create();

      final MenuStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, MenuStyler);
      expect(legacy.merge(emptyLegacy), isA<MenuStyler>());
    });

    test('RemixMenuTriggerStyler aliases MenuTriggerStyler', () {
      // ignore: deprecated_member_use
      final RemixMenuTriggerStyler legacy = RemixMenuTriggerStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixMenuTriggerStyler.create();

      final MenuTriggerStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, MenuTriggerStyler);
      expect(legacy.merge(emptyLegacy), isA<MenuTriggerStyler>());
    });

    test('RemixMenuItemStyler aliases MenuItemStyler', () {
      // ignore: deprecated_member_use
      final RemixMenuItemStyler legacy = RemixMenuItemStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixMenuItemStyler.create();

      final MenuItemStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, MenuItemStyler);
      expect(legacy.merge(emptyLegacy), isA<MenuItemStyler>());
    });

    test('RemixPopoverStyler aliases PopoverStyler', () {
      // ignore: deprecated_member_use
      final RemixPopoverStyler legacy = RemixPopoverStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixPopoverStyler.create();

      final PopoverStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, PopoverStyler);
      expect(legacy.merge(emptyLegacy), isA<PopoverStyler>());
    });

    test('RemixProgressStyler aliases ProgressStyler', () {
      // ignore: deprecated_member_use
      final RemixProgressStyler legacy = RemixProgressStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixProgressStyler.create();

      final ProgressStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, ProgressStyler);
      expect(legacy.merge(emptyLegacy), isA<ProgressStyler>());
    });

    test('RemixRadioStyler aliases RadioStyler', () {
      // ignore: deprecated_member_use
      final RemixRadioStyler legacy = RemixRadioStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixRadioStyler.create();

      final RadioStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, RadioStyler);
      expect(legacy.merge(emptyLegacy), isA<RadioStyler>());
    });

    test('RemixSelectStyler aliases SelectStyler', () {
      // ignore: deprecated_member_use
      final RemixSelectStyler legacy = RemixSelectStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixSelectStyler.create();

      final SelectStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, SelectStyler);
      expect(legacy.merge(emptyLegacy), isA<SelectStyler>());
    });

    test('RemixSelectTriggerStyler aliases SelectTriggerStyler', () {
      // ignore: deprecated_member_use
      final RemixSelectTriggerStyler legacy = RemixSelectTriggerStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixSelectTriggerStyler.create();

      final SelectTriggerStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, SelectTriggerStyler);
      expect(legacy.merge(emptyLegacy), isA<SelectTriggerStyler>());
    });

    test('RemixSelectContentStyler aliases SelectContentStyler', () {
      // ignore: deprecated_member_use
      final RemixSelectContentStyler legacy = RemixSelectContentStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixSelectContentStyler.create();

      final SelectContentStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, SelectContentStyler);
      expect(legacy.merge(emptyLegacy), isA<SelectContentStyler>());
    });

    test('RemixSelectMenuItemStyler aliases SelectMenuItemStyler', () {
      // ignore: deprecated_member_use
      final RemixSelectMenuItemStyler legacy = RemixSelectMenuItemStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixSelectMenuItemStyler.create();

      final SelectMenuItemStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, SelectMenuItemStyler);
      expect(legacy.merge(emptyLegacy), isA<SelectMenuItemStyler>());
    });

    test('RemixSliderStyler aliases SliderStyler', () {
      // ignore: deprecated_member_use
      final RemixSliderStyler legacy = RemixSliderStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixSliderStyler.create();

      final SliderStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, SliderStyler);
      expect(legacy.merge(emptyLegacy), isA<SliderStyler>());
    });

    test('RemixSpinnerStyler aliases SpinnerStyler', () {
      // ignore: deprecated_member_use
      final RemixSpinnerStyler legacy = RemixSpinnerStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixSpinnerStyler.create();

      final SpinnerStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, SpinnerStyler);
      expect(legacy.merge(emptyLegacy), isA<SpinnerStyler>());
    });

    test('RemixSwitchStyler aliases SwitchStyler', () {
      // ignore: deprecated_member_use
      final RemixSwitchStyler legacy = RemixSwitchStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixSwitchStyler.create();

      final SwitchStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, SwitchStyler);
      expect(legacy.merge(emptyLegacy), isA<SwitchStyler>());
    });

    test('RemixTabBarStyler aliases TabBarStyler', () {
      // ignore: deprecated_member_use
      final RemixTabBarStyler legacy = RemixTabBarStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixTabBarStyler.create();

      final TabBarStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, TabBarStyler);
      expect(legacy.merge(emptyLegacy), isA<TabBarStyler>());
    });

    test('RemixTabStyler aliases TabStyler', () {
      // ignore: deprecated_member_use
      final RemixTabStyler legacy = RemixTabStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixTabStyler.create();

      final TabStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, TabStyler);
      expect(legacy.merge(emptyLegacy), isA<TabStyler>());
    });

    test('RemixTabViewStyler aliases TabViewStyler', () {
      // ignore: deprecated_member_use
      final RemixTabViewStyler legacy = RemixTabViewStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixTabViewStyler.create();

      final TabViewStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, TabViewStyler);
      expect(legacy.merge(emptyLegacy), isA<TabViewStyler>());
    });

    test('RemixTextFieldStyler aliases TextFieldStyler', () {
      // ignore: deprecated_member_use
      final RemixTextFieldStyler legacy = RemixTextFieldStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixTextFieldStyler.create();

      final TextFieldStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, TextFieldStyler);
      expect(legacy.merge(emptyLegacy), isA<TextFieldStyler>());
    });

    test('RemixToggleStyler aliases ToggleStyler', () {
      // ignore: deprecated_member_use
      final RemixToggleStyler legacy = RemixToggleStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixToggleStyler.create();

      final ToggleStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, ToggleStyler);
      expect(legacy.merge(emptyLegacy), isA<ToggleStyler>());
    });

    test('RemixToggleGroupStyler aliases ToggleGroupStyler', () {
      // ignore: deprecated_member_use
      final RemixToggleGroupStyler legacy = RemixToggleGroupStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixToggleGroupStyler.create();

      final ToggleGroupStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, ToggleGroupStyler);
      expect(legacy.merge(emptyLegacy), isA<ToggleGroupStyler>());
    });

    test('RemixToggleGroupItemStyler aliases ToggleGroupItemStyler', () {
      // ignore: deprecated_member_use
      final RemixToggleGroupItemStyler legacy = RemixToggleGroupItemStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixToggleGroupItemStyler.create();

      final ToggleGroupItemStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, ToggleGroupItemStyler);
      expect(legacy.merge(emptyLegacy), isA<ToggleGroupItemStyler>());
    });

    test('RemixTooltipStyler aliases TooltipStyler', () {
      // ignore: deprecated_member_use
      final RemixTooltipStyler legacy = RemixTooltipStyler();
      // ignore: deprecated_member_use
      const emptyLegacy = RemixTooltipStyler.create();

      final TooltipStyler canonical = legacy;

      expect(canonical, same(legacy));
      expect(legacy.runtimeType, TooltipStyler);
      expect(legacy.merge(emptyLegacy), isA<TooltipStyler>());
    });
  });

  group('legacy Remix*Spec typedefs', () {
    test('RemixAccordionSpec aliases AccordionSpec', () {
      expect(RemixAccordionSpec, AccordionSpec);
    });

    test('RemixAvatarSpec aliases AvatarSpec', () {
      expect(RemixAvatarSpec, AvatarSpec);
    });

    test('RemixBadgeSpec aliases BadgeSpec', () {
      expect(RemixBadgeSpec, BadgeSpec);
    });

    test('RemixButtonSpec aliases ButtonSpec', () {
      expect(RemixButtonSpec, ButtonSpec);
    });

    test('RemixCalloutSpec aliases CalloutSpec', () {
      expect(RemixCalloutSpec, CalloutSpec);
    });

    test('RemixCardSpec aliases CardSpec', () {
      expect(RemixCardSpec, CardSpec);
    });

    test('RemixCheckboxSpec aliases CheckboxSpec', () {
      expect(RemixCheckboxSpec, CheckboxSpec);
    });

    test('RemixDialogSpec aliases DialogSpec', () {
      expect(RemixDialogSpec, DialogSpec);
    });

    test('RemixDividerSpec aliases DividerSpec', () {
      expect(RemixDividerSpec, DividerSpec);
    });

    test('RemixIconButtonSpec aliases IconButtonSpec', () {
      expect(RemixIconButtonSpec, IconButtonSpec);
    });

    test('RemixMenuSpec aliases MenuSpec', () {
      expect(RemixMenuSpec, MenuSpec);
    });

    test('RemixMenuTriggerSpec aliases MenuTriggerSpec', () {
      expect(RemixMenuTriggerSpec, MenuTriggerSpec);
    });

    test('RemixMenuItemSpec aliases MenuItemSpec', () {
      expect(RemixMenuItemSpec, MenuItemSpec);
    });

    test('RemixPopoverSpec aliases PopoverSpec', () {
      expect(RemixPopoverSpec, PopoverSpec);
    });

    test('RemixProgressSpec aliases ProgressSpec', () {
      expect(RemixProgressSpec, ProgressSpec);
    });

    test('RemixRadioSpec aliases RadioSpec', () {
      expect(RemixRadioSpec, RadioSpec);
    });

    test('RemixSelectSpec aliases SelectSpec', () {
      expect(RemixSelectSpec, SelectSpec);
    });

    test('RemixSelectTriggerSpec aliases SelectTriggerSpec', () {
      expect(RemixSelectTriggerSpec, SelectTriggerSpec);
    });

    test('RemixSelectContentSpec aliases SelectContentSpec', () {
      expect(RemixSelectContentSpec, SelectContentSpec);
    });

    test('RemixSelectMenuItemSpec aliases SelectMenuItemSpec', () {
      expect(RemixSelectMenuItemSpec, SelectMenuItemSpec);
    });

    test('RemixSliderSpec aliases SliderSpec', () {
      expect(RemixSliderSpec, SliderSpec);
    });

    test('RemixSpinnerSpec aliases SpinnerSpec', () {
      expect(RemixSpinnerSpec, SpinnerSpec);
    });

    test('RemixSwitchSpec aliases SwitchSpec', () {
      expect(RemixSwitchSpec, SwitchSpec);
    });

    test('RemixTabBarSpec aliases TabBarSpec', () {
      expect(RemixTabBarSpec, TabBarSpec);
    });

    test('RemixTabSpec aliases TabSpec', () {
      expect(RemixTabSpec, TabSpec);
    });

    test('RemixTabViewSpec aliases TabViewSpec', () {
      expect(RemixTabViewSpec, TabViewSpec);
    });

    test('RemixTextFieldSpec aliases TextFieldSpec', () {
      expect(RemixTextFieldSpec, TextFieldSpec);
    });

    test('RemixToggleSpec aliases ToggleSpec', () {
      expect(RemixToggleSpec, ToggleSpec);
    });

    test('RemixToggleGroupSpec aliases ToggleGroupSpec', () {
      expect(RemixToggleGroupSpec, ToggleGroupSpec);
    });

    test('RemixToggleGroupItemSpec aliases ToggleGroupItemSpec', () {
      expect(RemixToggleGroupItemSpec, ToggleGroupItemSpec);
    });

    test('RemixTooltipSpec aliases TooltipSpec', () {
      expect(RemixTooltipSpec, TooltipSpec);
    });
  });
}
