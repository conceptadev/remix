import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  const trigger = RemixMenuTrigger(label: 'Options');
  const items = <RemixMenuItemData<String>>[
    RemixMenuItem(value: 'copy', label: 'Copy'),
    RemixMenuDivider<String>(),
    RemixMenuItem(value: 'paste', label: 'Paste'),
  ];

  group('canonical menu styler API', () {
    test('constructors, field factories, fluent methods, and merge work', () {
      const empty = MenuStyler.create();
      final fromFields = MenuStyler(
        trigger: MenuTriggerStyler().color(Colors.black),
        overlay: FlexBoxStyler(),
        item: MenuItemStyler().color(Colors.white),
        divider: RemixDividerStyler(),
      );
      final fromFactory = MenuStyler.trigger(MenuTriggerStyler());
      final fluent = MenuStyler()
          .trigger(MenuTriggerStyler().color(Colors.black))
          .overlay(FlexBoxStyler())
          .item(MenuItemStyler().color(Colors.white))
          .divider(RemixDividerStyler())
          .variants(const <VariantStyle<MenuSpec>>[]);

      expect(fromFields.merge(empty), isA<MenuStyler>());
      expect(fromFactory.$trigger, isNotNull);
      expect(fluent.$trigger, isNotNull);
      expect(fluent.$overlay, isNotNull);
      expect(fluent.$item, isNotNull);
      expect(fluent.$divider, isNotNull);
    });

    test('trigger and item stylers expose factories and variants', () {
      final triggerStyle = MenuTriggerStyler.color(Colors.black)
          .padding(EdgeInsetsGeometryMix.all(8))
          .variants(const <VariantStyle<MenuTriggerSpec>>[]);
      final itemStyle = MenuItemStyler.color(Colors.white)
          .onHovered(MenuItemStyler().color(Colors.blue))
          .variants(const <VariantStyle<MenuItemSpec>>[]);

      expect(triggerStyle, isA<MenuTriggerStyler>());
      expect(itemStyle, isA<MenuItemStyler>());
      expect(
        MenuTriggerStyler().flex(FlexStyler()),
        isA<MenuTriggerStyler>(),
      );
      expect(MenuItemStyler().flex(FlexStyler()), isA<MenuItemStyler>());
    });

    testWidgets('resolves to canonical specs', (tester) async {
      final style = MenuStyler()
          .trigger(MenuTriggerStyler().color(Colors.black))
          .item(MenuItemStyler().color(Colors.white));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final spec = style.resolve(context);

              expect(spec, isA<StyleSpec<MenuSpec>>());
              expect(spec.spec, isA<MenuSpec>());
              expect(spec.spec.trigger.spec, isA<MenuTriggerSpec>());
              expect(spec.spec.item.spec, isA<MenuItemSpec>());

              return const SizedBox();
            },
          ),
        ),
      );
    });

    test('callable widget helper builds a RemixMenu', () {
      final widget = MenuStyler().call<String>(trigger: trigger, items: items);

      expect(widget, isA<RemixMenu<String>>());
    });

    test('RemixMenu accepts MenuStyler and MenuSpec', () {
      final styled = RemixMenu<String>(
        trigger: trigger,
        items: items,
        style: MenuStyler().overlay(FlexBoxStyler()),
      );
      const raw = RemixMenu<String>(
        trigger: trigger,
        items: items,
        styleSpec: MenuSpec(),
      );

      expect(styled.style, isA<MenuStyler>());
      expect(raw.styleSpec, isA<MenuSpec>());
      expect(RemixMenu.styleFrom(), isA<MenuStyler>());
    });

    test('fortal recipes return canonical stylers', () {
      expect(fortalMenuStyle(), isA<MenuStyler>());
      expect(fortalMenuItemStyle(), isA<MenuItemStyler>());
    });
  });

  group('deprecated Remix* styler aliases', () {
    test('keeps RemixMenuStyler source-compatible during migration', () {
      // ignore: deprecated_member_use
      final RemixMenuStyler legacy = RemixMenuStyler().overlay(FlexBoxStyler());
      // ignore: deprecated_member_use
      const emptyLegacy = RemixMenuStyler.create();
      // ignore: deprecated_member_use
      final legacyFactory = RemixMenuStyler.trigger(MenuTriggerStyler());

      final MenuStyler canonical = legacy;
      final legacyWidget = RemixMenuStylerRemixHelpers(
        legacy,
      ).call<String>(trigger: trigger, items: items);

      expect(canonical, same(legacy));
      expect(legacy.merge(emptyLegacy), isA<MenuStyler>());
      expect(legacyFactory, isA<MenuStyler>());
      expect(legacyWidget, isA<RemixMenu<String>>());
      expect(legacy.runtimeType, MenuStyler);
    });

    test('keeps RemixMenuTriggerStyler source-compatible during migration', () {
      // ignore: deprecated_member_use
      final RemixMenuTriggerStyler legacy = RemixMenuTriggerStyler().color(
        Colors.black,
      );
      // ignore: deprecated_member_use
      const emptyLegacy = RemixMenuTriggerStyler.create();
      // ignore: deprecated_member_use
      final legacyFactory = RemixMenuTriggerStyler.color(Colors.blue);

      final MenuTriggerStyler canonical = legacy;
      final legacyFlex = RemixMenuTriggerStylerRemixHelpers(
        legacy,
      ).flex(FlexStyler());

      expect(canonical, same(legacy));
      expect(legacy.merge(emptyLegacy), isA<MenuTriggerStyler>());
      expect(legacyFactory, isA<MenuTriggerStyler>());
      expect(legacyFlex, isA<MenuTriggerStyler>());
      expect(legacy.runtimeType, MenuTriggerStyler);
    });

    test('keeps RemixMenuItemStyler source-compatible during migration', () {
      // ignore: deprecated_member_use
      final RemixMenuItemStyler legacy = RemixMenuItemStyler().color(
        Colors.white,
      );
      // ignore: deprecated_member_use
      const emptyLegacy = RemixMenuItemStyler.create();
      // ignore: deprecated_member_use
      final legacyFactory = RemixMenuItemStyler.color(Colors.blue);

      final MenuItemStyler canonical = legacy;
      final legacyFlex = RemixMenuItemStylerRemixHelpers(
        legacy,
      ).flex(FlexStyler());

      expect(canonical, same(legacy));
      expect(legacy.merge(emptyLegacy), isA<MenuItemStyler>());
      expect(legacyFactory, isA<MenuItemStyler>());
      expect(legacyFlex, isA<MenuItemStyler>());
      expect(legacy.runtimeType, MenuItemStyler);
    });

    test('legacy stylers are accepted by canonical surfaces', () {
      // ignore: deprecated_member_use
      final legacyItem = RemixMenuItemStyler().color(Colors.white);
      // ignore: deprecated_member_use
      final legacyTrigger = RemixMenuTriggerStyler().color(Colors.black);
      final style = MenuStyler().trigger(legacyTrigger).item(legacyItem);

      final menu = RemixMenu<String>(
        trigger: trigger,
        items: <RemixMenuItemData<String>>[
          RemixMenuItem(value: 'copy', label: 'Copy', style: legacyItem),
        ],
        style: style,
      );

      expect(menu.style, isA<MenuStyler>());
      expect(menu.items.first, isA<RemixMenuItem<String>>());
    });
  });

  group('legacy spec names', () {
    test('legacy and canonical spec names are assignable', () {
      const MenuSpec canonicalMenu = RemixMenuSpec();
      const RemixMenuSpec legacyMenu = MenuSpec();
      const MenuTriggerSpec canonicalTrigger = RemixMenuTriggerSpec();
      const RemixMenuTriggerSpec legacyTrigger = MenuTriggerSpec();
      const MenuItemSpec canonicalItem = RemixMenuItemSpec();
      const RemixMenuItemSpec legacyItem = MenuItemSpec();

      expect(canonicalMenu.runtimeType, MenuSpec);
      expect(legacyMenu.runtimeType, MenuSpec);
      expect(canonicalTrigger.runtimeType, MenuTriggerSpec);
      expect(legacyTrigger.runtimeType, MenuTriggerSpec);
      expect(canonicalItem.runtimeType, MenuItemSpec);
      expect(legacyItem.runtimeType, MenuItemSpec);
    });

    test('RemixMenu accepts a legacy spec name for styleSpec', () {
      const menu = RemixMenu<String>(
        trigger: trigger,
        items: items,
        styleSpec: RemixMenuSpec(),
      );

      expect(menu.styleSpec, isA<MenuSpec>());
    });
  });
}
