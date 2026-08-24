import 'dart:ui' show CheckedState, SemanticsRole;

import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show LogicalKeyboardKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/utilities/remix_path_icon.dart';

import '../../helpers/test_helpers.dart';

Widget _constMenuTriggerBuilder(
  BuildContext context,
  NakedMenuState state,
  Widget? child,
) {
  return child ?? const SizedBox.shrink();
}

void main() {
  group('RemixMenuTrigger', () {
    test('creates trigger with label', () {
      const trigger = RemixMenuTrigger(label: 'Options');

      expect(trigger.label, equals('Options'));
      expect(trigger.icon, isNull);
      expect(trigger.builder, isNull);
    });

    test('creates trigger with label and icon', () {
      const trigger = RemixMenuTrigger(label: 'Options', icon: Icons.more_vert);

      expect(trigger.label, equals('Options'));
      expect(trigger.icon, equals(Icons.more_vert));
      expect(trigger.builder, isNull);
    });

    test('creates const builder trigger with label and optional icon', () {
      const trigger = RemixMenuTrigger.builder(
        label: 'Account menu',
        icon: Icons.person,
        builder: _constMenuTriggerBuilder,
      );

      expect(trigger.label, equals('Account menu'));
      expect(trigger.icon, equals(Icons.person));
      expect(trigger.builder, same(_constMenuTriggerBuilder));
    });
  });

  group('RemixMenuTrigger.builder', () {
    testWidgets(
      'receives the styled default child and closed/open menu state',
      (tester) async {
        final openStates = <bool>[];
        Widget? receivedChild;

        await tester.pumpRemixApp(
          RemixMenu<String>(
            trigger: RemixMenuTrigger.builder(
              label: 'Options',
              icon: Icons.more_vert,
              builder: (context, state, child) {
                openStates.add(state.isOpen);
                receivedChild = child;
                return child!;
              },
            ),
            items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
          ),
        );
        await tester.pumpAndSettle();

        expect(openStates, isNotEmpty);
        expect(openStates.first, isFalse);
        expect(receivedChild, isA<RowBox>());
        expect(find.text('Options'), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);

        await tester.tap(find.text('Options'));
        await tester.pumpAndSettle();

        expect(openStates, contains(true));
        expect(find.text('Copy'), findsOneWidget);
      },
    );

    testWidgets(
      'can replace the default child and still open, select, and restore focus',
      (tester) async {
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);
        String? selected;

        await tester.pumpRemixApp(
          RemixMenu<String>(
            triggerFocusNode: focusNode,
            trigger: RemixMenuTrigger.builder(
              label: 'Account menu',
              builder: (context, state, child) => const Text('LF'),
            ),
            items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
            onSelected: (value) => selected = value,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('LF'), findsOneWidget);
        expect(find.text('Account menu'), findsNothing);

        focusNode.requestFocus();
        await tester.pump();
        expect(focusNode.hasFocus, isTrue);

        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();
        expect(find.text('Copy'), findsOneWidget);

        await tester.tap(find.text('Copy'));
        await tester.pumpAndSettle();

        expect(selected, 'copy');
        expect(find.text('Copy'), findsNothing);
        expect(focusNode.hasFocus, isTrue);
      },
    );
  });

  group('RemixMenuItem', () {
    test('creates menu item with value and label', () {
      const item = RemixMenuItem<String>(value: 'copy', label: 'Copy');

      expect(item.value, equals('copy'));
      expect(item.label, equals('Copy'));
      expect(item.leadingIcon, isNull);
      expect(item.trailingIcon, isNull);
      expect(item.enabled, isTrue);
      expect(item.closeOnActivate, isTrue);
    });

    test('creates menu item with all parameters', () {
      const item = RemixMenuItem<String>(
        value: 'delete',
        label: 'Delete',
        leadingIcon: Icons.delete,
        trailingIcon: Icons.chevron_right,
        enabled: false,
        closeOnActivate: false,
        semanticLabel: 'Delete item',
      );

      expect(item.value, equals('delete'));
      expect(item.label, equals('Delete'));
      expect(item.leadingIcon, equals(Icons.delete));
      expect(item.trailingIcon, equals(Icons.chevron_right));
      expect(item.enabled, isFalse);
      expect(item.closeOnActivate, isFalse);
      expect(item.semanticLabel, equals('Delete item'));
    });

    test('menu item extends RemixMenuItemData', () {
      const item = RemixMenuItem<String>(value: 'test', label: 'Test');

      expect(item, isA<RemixMenuItemData<String>>());
    });
  });

  group('RemixMenuDivider', () {
    test('creates divider', () {
      const divider = RemixMenuDivider<String>();

      expect(divider, isNotNull);
      expect(divider, isA<RemixMenuItemData<String>>());
    });
  });

  group('RemixMenu Basic Rendering', () {
    testWidgets('renders menu with minimal props', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
      expect(find.text('Options'), findsOneWidget);
    });

    testWidgets('renders menu with icon in trigger', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(
            label: 'Options',
            icon: Icons.more_vert,
          ),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Options'), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('renders menu with multiple items', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(value: 'copy', label: 'Copy'),
            RemixMenuItem<String>(value: 'paste', label: 'Paste'),
            RemixMenuItem<String>(value: 'delete', label: 'Delete'),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });

    testWidgets('renders menu with dividers', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(value: 'copy', label: 'Copy'),
            RemixMenuDivider<String>(),
            RemixMenuItem<String>(value: 'delete', label: 'Delete'),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });

    testWidgets('renders menu items with icons', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(
              value: 'copy',
              label: 'Copy',
              leadingIcon: Icons.copy,
            ),
            RemixMenuItem<String>(
              value: 'paste',
              label: 'Paste',
              leadingIcon: Icons.paste,
              trailingIcon: Icons.chevron_right,
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });
  });

  group('RemixMenu item identity', () {
    testWidgets('caller-owned keys reach every rendered item root', (
      tester,
    ) async {
      const ordinaryKey = ValueKey<String>('ordinary-root');
      const checkboxKey = ValueKey<String>('checkbox-root');
      const radioGroupKey = ValueKey<String>('radio-group-root');
      const radioItemKey = ValueKey<String>('radio-item-root');
      const submenuKey = ValueKey<String>('submenu-root');
      const dividerKey = ValueKey<String>('divider-root');
      final controller = MenuController();

      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: controller,
          trigger: const RemixMenuTrigger(label: 'Options'),
          onSelected: (_) {},
          items: const [
            RemixMenuItem(
              key: ordinaryKey,
              value: 'ordinary',
              label: 'Ordinary',
            ),
            RemixMenuCheckboxItem(
              key: checkboxKey,
              value: 'checkbox',
              label: 'Checkbox',
              checked: true,
            ),
            RemixMenuRadioGroup(
              key: radioGroupKey,
              value: 'radio',
              items: [
                RemixMenuRadioItem(
                  key: radioItemKey,
                  value: 'radio',
                  label: 'Radio',
                ),
              ],
            ),
            RemixMenuSubmenu(
              key: submenuKey,
              label: 'More',
              items: [RemixMenuItem(value: 'nested', label: 'Nested')],
            ),
            RemixMenuDivider(key: dividerKey),
          ],
        ),
      );

      controller.open();
      await tester.pump();

      expect(
        tester.widget(find.byKey(ordinaryKey)),
        isA<NakedMenuItem<String>>(),
      );
      expect(
        tester.widget(find.byKey(checkboxKey)),
        isA<NakedMenuCheckboxItem<String>>(),
      );
      expect(
        tester.widget(find.byKey(radioGroupKey)),
        isA<NakedMenuRadioGroup<String>>(),
      );
      expect(
        tester.widget(find.byKey(radioItemKey)),
        isA<NakedMenuRadioItem<String>>(),
      );
      expect(
        tester.widget(find.byKey(submenuKey)),
        isA<NakedMenuSubmenu<String>>(),
      );
      expect(
        tester.widget(find.byKey(dividerKey)),
        isA<StyleSpecBuilder<DividerSpec>>(),
      );
    });

    testWidgets('keyed open submenu retains state after sibling reorder', (
      tester,
    ) async {
      const alphaKey = ValueKey<String>('alpha-submenu');
      const betaKey = ValueKey<String>('beta-submenu');
      final controller = MenuController();
      late StateSetter reorder;
      var reordered = false;

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) {
            reorder = setState;
            final alpha = RemixMenuSubmenu<String>(
              key: alphaKey,
              label: 'Alpha',
              items: const [
                RemixMenuItem(value: 'alpha-child', label: 'Alpha child'),
              ],
            );
            final beta = RemixMenuSubmenu<String>(
              key: betaKey,
              label: 'Beta',
              items: const [
                RemixMenuItem(value: 'beta-child', label: 'Beta child'),
              ],
            );

            return RemixMenu<String>(
              controller: controller,
              trigger: const RemixMenuTrigger(label: 'Options'),
              items: reordered ? [beta, alpha] : [alpha, beta],
            );
          },
        ),
      );

      controller.open();
      await tester.pump();
      expect(
        tester.getTopLeft(find.text('Alpha')).dy,
        lessThan(tester.getTopLeft(find.text('Beta')).dy),
      );

      await tester.tap(find.text('Alpha'));
      await tester.pump();
      expect(find.text('Alpha child'), findsOneWidget);
      expect(find.text('Beta child'), findsNothing);

      reorder(() => reordered = true);
      await tester.pump();
      await tester.pump();

      expect(
        tester.getTopLeft(find.text('Beta')).dy,
        lessThan(tester.getTopLeft(find.text('Alpha')).dy),
      );
      expect(find.text('Alpha child'), findsOneWidget);
      expect(find.text('Beta child'), findsNothing);
    });
  });

  group('RemixMenu Interaction Tests', () {
    testWidgets('menu opens when trigger is tapped', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(value: 'copy', label: 'Copy'),
            RemixMenuItem<String>(value: 'paste', label: 'Paste'),
          ],
        ),
      );
      await tester.pumpAndSettle();

      // Tap the trigger
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      // Menu items should now be visible
      expect(find.text('Copy'), findsOneWidget);
      expect(find.text('Paste'), findsOneWidget);
    });

    testWidgets('onSelected callback fires when item is selected', (
      tester,
    ) async {
      String? selectedValue;

      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(value: 'copy', label: 'Copy'),
            RemixMenuItem<String>(value: 'paste', label: 'Paste'),
          ],
          onSelected: (value) => selectedValue = value,
        ),
      );
      await tester.pumpAndSettle();

      // Open the menu
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      // Tap an item
      await tester.tap(find.text('Copy'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('copy'));
    });

    testWidgets('onOpen callback fires when menu opens', (tester) async {
      int openCount = 0;

      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
          onOpen: () => openCount++,
        ),
      );
      await tester.pumpAndSettle();

      // Open the menu
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      expect(openCount, equals(1));
    });

    testWidgets('onClose callback fires when menu closes', (tester) async {
      int closeCount = 0;

      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
          onClose: () => closeCount++,
        ),
      );
      await tester.pumpAndSettle();

      // Open the menu
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      // Close by selecting an item
      await tester.tap(find.text('Copy'));
      await tester.pumpAndSettle();

      expect(closeCount, equals(1));
    });

    testWidgets('menu closes when item with closeOnActivate is selected', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(
              value: 'copy',
              label: 'Copy',
              closeOnActivate: true,
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      // Open the menu
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      expect(find.text('Copy'), findsOneWidget);

      // Select the item
      await tester.tap(find.text('Copy'));
      await tester.pumpAndSettle();

      expect(find.text('Copy'), findsNothing);
      expect(find.text('Options'), findsOneWidget);
    });

    testWidgets('disabled menu item does not trigger onSelected', (
      tester,
    ) async {
      String? selectedValue;

      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(value: 'copy', label: 'Copy', enabled: false),
          ],
          onSelected: (value) => selectedValue = value,
        ),
      );
      await tester.pumpAndSettle();

      // Open the menu
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      // Try to tap the disabled item
      await tester.tap(find.text('Copy'));
      await tester.pumpAndSettle();

      // onSelected should not have been called
      expect(selectedValue, isNull);
    });
  });

  group('RemixMenu Controller Tests', () {
    testWidgets('uses provided controller', (tester) async {
      final controller = MenuController();

      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: controller,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });

    testWidgets('creates default controller when not provided', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      // Menu should work without explicit controller
      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });
  });

  group('RemixMenu Focus Tests', () {
    testWidgets('uses provided focus node for trigger', (tester) async {
      final focusNode = FocusNode();
      addTearDown(() => focusNode.dispose());

      await tester.pumpRemixApp(
        RemixMenu<String>(
          triggerFocusNode: focusNode,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });
  });

  group('RemixMenu Styling Tests', () {
    testWidgets('item styling listens to the typed menu-item controller', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      final itemContext = tester.element(find.text('Copy'));
      final itemController = NakedMenuItemState.controllerOf<String>(
        itemContext,
      );
      final stylingListeners = tester
          .widgetList<ListenableBuilder>(
            find.ancestor(
              of: find.text('Copy'),
              matching: find.byType(ListenableBuilder),
            ),
          )
          .map((builder) => builder.listenable);

      expect(stylingListeners, contains(same(itemController)));
    });

    testWidgets('applies custom style to menu', (tester) async {
      final style = MenuStyler().trigger(
        MenuTriggerStyler().padding(EdgeInsetsGeometryMix.all(20.0)),
      );

      await tester.pumpRemixApp(
        RemixMenu<String>(
          style: style,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });

    testWidgets('applies custom style to menu items', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: [
            RemixMenuItem<String>(
              value: 'copy',
              label: 'Copy',
              style: MenuItemStyler().padding(EdgeInsetsGeometryMix.all(12.0)),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });

    testWidgets('applies menu-level default item style', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
          style: MenuStyler().item(
            MenuItemStyler().label(TextStyler().color(Colors.red)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      final itemText = tester.widget<Text>(find.text('Copy'));
      expect(itemText.style?.color, equals(Colors.red));
    });

    testWidgets('lets per-item style override menu-level item style', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: [
            RemixMenuItem<String>(
              value: 'copy',
              label: 'Copy',
              style: MenuItemStyler().label(TextStyler().color(Colors.blue)),
            ),
          ],
          style: MenuStyler().item(
            MenuItemStyler().label(TextStyler().color(Colors.red)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      final itemText = tester.widget<Text>(find.text('Copy'));
      expect(itemText.style?.color, equals(Colors.blue));
    });

    testWidgets('applies menu-level divider style', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(value: 'copy', label: 'Copy'),
            RemixMenuDivider<String>(),
            RemixMenuItem<String>(value: 'paste', label: 'Paste'),
          ],
          style: MenuStyler().divider(DividerStyler().color(Colors.purple)),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      final decorations = tester
          .widgetList<Box>(find.byType(Box))
          .map((box) => box.styleSpec?.spec.decoration);

      expect(
        decorations,
        contains(equals(const BoxDecoration(color: Colors.purple))),
      );
    });

    testWidgets('raw item styleSpec bypasses per-item fluent styles', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: [
            RemixMenuItem(
              value: 'copy',
              label: 'Copy',
              style: MenuItemStyler().label(TextStyler().color(Colors.green)),
            ),
          ],
          styleSpec: const MenuSpec(
            item: StyleSpec(
              spec: MenuItemSpec(
                label: StyleSpec(
                  spec: TextSpec(style: TextStyle(color: Colors.red)),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.text('Copy')).style?.color, Colors.red);
    });

    testWidgets(
      'menu-wide semantic item styles merge after the shared item style '
      'and before per-item styles',
      (tester) async {
        final style = MenuStyler()
            .item(
              MenuItemStyler().label(
                TextStyler().color(Colors.red).fontSize(13),
              ),
            )
            .checkboxItem(
              MenuItemStyler().label(TextStyler().color(Colors.green)),
            )
            .radioItem(MenuItemStyler().label(TextStyler().color(Colors.blue)))
            .submenuItem(
              MenuItemStyler().label(TextStyler().color(Colors.orange)),
            );

        final controller = MenuController();
        await tester.pumpRemixApp(
          RemixMenu<String>(
            controller: controller,
            trigger: const RemixMenuTrigger(label: 'Options'),
            style: style,
            items: [
              const RemixMenuItem(value: 'ordinary', label: 'Ordinary'),
              const RemixMenuCheckboxItem(
                value: 'checkbox',
                label: 'Checkbox',
                checked: true,
              ),
              RemixMenuRadioGroup(
                value: 'default-radio',
                onChanged: (_) {},
                items: [
                  const RemixMenuRadioItem(
                    value: 'default-radio',
                    label: 'Default radio',
                  ),
                  RemixMenuRadioItem(
                    value: 'local-radio',
                    label: 'Local radio',
                    style: MenuItemStyler().label(
                      TextStyler().color(Colors.purple),
                    ),
                  ),
                ],
              ),
              const RemixMenuSubmenu(
                label: 'Submenu',
                items: [
                  RemixMenuCheckboxItem(
                    value: 'nested-checkbox',
                    label: 'Nested checkbox',
                    checked: true,
                  ),
                ],
              ),
            ],
          ),
        );
        controller.open();
        await tester.pump();

        TextStyle? textStyle(String label) =>
            tester.widget<Text>(find.text(label)).style;

        expect(textStyle('Ordinary')?.color, Colors.red);
        expect(textStyle('Checkbox')?.color, Colors.green);
        expect(textStyle('Default radio')?.color, Colors.blue);
        expect(textStyle('Local radio')?.color, Colors.purple);
        expect(textStyle('Submenu')?.color, Colors.orange);
        for (final label in [
          'Ordinary',
          'Checkbox',
          'Default radio',
          'Local radio',
          'Submenu',
        ]) {
          expect(textStyle(label)?.fontSize, 13);
        }

        await tester.tap(find.text('Submenu'));
        await tester.pump();
        expect(textStyle('Nested checkbox')?.color, Colors.green);
        expect(textStyle('Nested checkbox')?.fontSize, 13);
      },
    );

    testWidgets(
      'raw semantic item specs replace the raw shared item spec while null '
      'semantic specs inherit it',
      (tester) async {
        final controller = MenuController();
        await tester.pumpRemixApp(
          RemixMenu<String>(
            controller: controller,
            trigger: const RemixMenuTrigger(label: 'Options'),
            styleSpec: const MenuSpec(
              item: StyleSpec(
                spec: MenuItemSpec(
                  label: StyleSpec(
                    spec: TextSpec(
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                ),
              ),
              radioItem: StyleSpec(
                spec: MenuItemSpec(
                  label: StyleSpec(
                    spec: TextSpec(style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ),
            ),
            items: [
              const RemixMenuCheckboxItem(
                value: 'checkbox',
                label: 'Checkbox',
                checked: true,
              ),
              RemixMenuRadioGroup(
                value: 'radio',
                onChanged: (_) {},
                items: [
                  RemixMenuRadioItem(
                    value: 'radio',
                    label: 'Radio',
                    style: MenuItemStyler().label(
                      TextStyler().color(Colors.purple).fontSize(20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        controller.open();
        await tester.pump();

        final checkbox = tester.widget<Text>(find.text('Checkbox')).style;
        final radio = tester.widget<Text>(find.text('Radio')).style;
        expect(checkbox?.color, Colors.red);
        expect(checkbox?.fontSize, 13);
        expect(radio?.color, Colors.blue);
        expect(radio?.fontSize, isNull);
      },
    );
  });

  group('RemixMenu Semantics and Accessibility', () {
    testWidgets('menu item has semantic label', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(
              value: 'copy',
              label: 'Copy',
              semanticLabel: 'Copy item',
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      final item = find.bySemanticsLabel('Copy item');
      final itemCount = item.evaluate().length;
      final itemSemantics = itemCount == 1 ? tester.getSemantics(item) : null;
      semantics.dispose();
      expect(itemCount, 1);
      expect(itemSemantics, isSemantics(label: 'Copy item'));
    });

    testWidgets('menu item uses label as default semantic label', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Options'));
      await tester.pumpAndSettle();

      final item = find.bySemanticsLabel('Copy');
      final itemCount = item.evaluate().length;
      final itemSemantics = itemCount == 1 ? tester.getSemantics(item) : null;
      semantics.dispose();
      expect(itemCount, 1);
      expect(itemSemantics, isSemantics(label: 'Copy'));
    });
  });

  group('RemixMenu Edge Cases', () {
    testWidgets('renders menu with empty items list', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
      expect(find.text('Options'), findsOneWidget);
    });

    testWidgets('renders menu with only dividers', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuDivider<String>(), RemixMenuDivider<String>()],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });

    testWidgets('handles multiple sequential dividers', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuItem<String>(value: 'copy', label: 'Copy'),
            RemixMenuDivider<String>(),
            RemixMenuDivider<String>(),
            RemixMenuItem<String>(value: 'paste', label: 'Paste'),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });
  });

  group('RemixMenu Positioning Tests', () {
    testWidgets('applies custom positioning config', (tester) async {
      const positioning = OverlayPositionConfig(
        side: OverlaySide.bottom,
        alignment: OverlayAlignment.start,
      );

      await tester.pumpRemixApp(
        RemixMenu<String>(
          positioning: positioning,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });
  });

  group('RemixMenu Configuration Tests', () {
    testWidgets('respects closeOnClickOutside flag', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          closeOnClickOutside: true,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });

    testWidgets('respects consumeOutsideTaps flag', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          consumeOutsideTaps: false,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });

    testWidgets('respects useRootOverlay flag', (tester) async {
      await tester.pumpRemixApp(
        RemixMenu<String>(
          useRootOverlay: true,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixMenu<String>), findsOneWidget);
    });
  });

  group('RemixMenu Type Safety', () {
    testWidgets('menu works with int type', (tester) async {
      int? selectedValue;

      await tester.pumpRemixApp(
        RemixMenu<int>(
          trigger: const RemixMenuTrigger(label: 'Numbers'),
          items: const [
            RemixMenuItem<int>(value: 1, label: 'One'),
            RemixMenuItem<int>(value: 2, label: 'Two'),
          ],
          onSelected: (value) => selectedValue = value,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Numbers'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('One'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals(1));
    });

    testWidgets('menu works with custom enum type', (tester) async {
      MenuAction? selectedValue;

      await tester.pumpRemixApp(
        RemixMenu<MenuAction>(
          trigger: const RemixMenuTrigger(label: 'Actions'),
          items: const [
            RemixMenuItem<MenuAction>(value: MenuAction.copy, label: 'Copy'),
            RemixMenuItem<MenuAction>(value: MenuAction.paste, label: 'Paste'),
          ],
          onSelected: (value) => selectedValue = value,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Actions'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Copy'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals(MenuAction.copy));
    });
  });

  group('RemixMenu compound data contract', () {
    test('constructors retain the complete immutable public surface', () {
      final checkboxChanged = <bool>[];
      final radioChanged = <String>[];
      final submenuController = MenuController();
      final submenuFocusNode = FocusNode();
      addTearDown(submenuFocusNode.dispose);

      final checkbox = RemixMenuCheckboxItem<String>(
        value: 'notifications',
        label: 'Notifications',
        checked: true,
        onChanged: checkboxChanged.add,
        leadingIcon: Icons.notifications,
        trailingIcon: Icons.keyboard_command_key,
        enabled: false,
        closeOnActivate: false,
        semanticLabel: 'Toggle notifications',
        style: MenuItemStyler().label(TextStyler().color(Colors.purple)),
      );
      final radioItem = RemixMenuRadioItem<String>(
        value: 'compact',
        label: 'Compact',
        leadingIcon: Icons.view_compact,
        trailingIcon: Icons.keyboard_command_key,
        enabled: false,
        closeOnActivate: false,
        semanticLabel: 'Compact density',
        style: MenuItemStyler().label(TextStyler().color(Colors.blue)),
      );
      final radioGroup = RemixMenuRadioGroup<String>(
        value: 'compact',
        items: [radioItem],
        onChanged: radioChanged.add,
        enabled: false,
      );
      final submenu = RemixMenuSubmenu<String>(
        label: 'More',
        items: const [RemixMenuItem(value: 'archive', label: 'Archive')],
        leadingIcon: Icons.more_horiz,
        trailingIcon: Icons.chevron_right,
        controller: submenuController,
        enabled: false,
        hoverDelay: const Duration(milliseconds: 250),
        positioning: const OverlayPositionConfig(
          side: OverlaySide.left,
          alignment: OverlayAlignment.end,
          sideOffset: 8,
        ),
        focusNode: submenuFocusNode,
        semanticLabel: 'More actions',
        onOpen: () {},
        onClose: () {},
        style: MenuItemStyler().label(TextStyler().color(Colors.green)),
      );

      expect(checkbox.value, 'notifications');
      expect(checkbox.checked, isTrue);
      expect(checkbox.onChanged, isNotNull);
      expect(checkbox.leadingIcon, Icons.notifications);
      expect(checkbox.trailingIcon, Icons.keyboard_command_key);
      expect(checkbox.enabled, isFalse);
      expect(checkbox.closeOnActivate, isFalse);
      expect(checkbox.semanticLabel, 'Toggle notifications');
      expect(checkbox, isA<RemixMenuItemData<String>>());
      expect(radioItem.value, 'compact');
      expect(radioItem.enabled, isFalse);
      expect(radioItem.closeOnActivate, isFalse);
      expect(radioGroup.value, 'compact');
      expect(radioGroup.items, [same(radioItem)]);
      expect(radioGroup.onChanged, isNotNull);
      expect(radioGroup.enabled, isFalse);
      expect(radioGroup, isA<RemixMenuItemData<String>>());
      expect(submenu.label, 'More');
      expect(submenu.items.single, isA<RemixMenuItem<String>>());
      expect(submenu.controller, same(submenuController));
      expect(submenu.hoverDelay, const Duration(milliseconds: 250));
      expect(submenu.positioning.side, OverlaySide.left);
      expect(submenu.focusNode, same(submenuFocusNode));
      expect(submenu, isA<RemixMenuItemData<String>>());
    });

    test('compound labels and semantic labels must not be empty', () {
      expect(
        () => RemixMenuCheckboxItem<String>(
          value: 'checkbox',
          label: '',
          checked: false,
        ),
        throwsAssertionError,
      );
      expect(
        () => RemixMenuRadioItem<String>(value: 'radio', label: ''),
        throwsAssertionError,
      );
      expect(
        () => RemixMenuSubmenu<String>(label: '', items: const []),
        throwsAssertionError,
      );
      expect(
        () => RemixMenuCheckboxItem<String>(
          value: 'checkbox',
          label: 'Checkbox',
          checked: false,
          semanticLabel: '',
        ),
        throwsAssertionError,
      );
      expect(
        () => RemixMenuRadioGroup<String?>(value: null, items: const []),
        throwsAssertionError,
      );
    });

    testWidgets('radio groups reject duplicate or missing controlled values', (
      tester,
    ) async {
      Future<Object?> openAndTakeException(
        RemixMenuRadioGroup<String> group,
      ) async {
        final controller = MenuController();
        await tester.pumpRemixApp(
          RemixMenu<String>(
            controller: controller,
            trigger: const RemixMenuTrigger(label: 'Options'),
            items: [group],
          ),
        );
        controller.open();
        await tester.pump();
        final exception = tester.takeException();
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        return exception;
      }

      expect(
        await openAndTakeException(
          const RemixMenuRadioGroup(
            value: 'missing',
            items: [RemixMenuRadioItem(value: 'present', label: 'Present')],
          ),
        ),
        isA<AssertionError>(),
      );
      expect(
        await openAndTakeException(
          const RemixMenuRadioGroup(
            value: 'duplicate',
            items: [
              RemixMenuRadioItem(value: 'duplicate', label: 'First'),
              RemixMenuRadioItem(value: 'duplicate', label: 'Second'),
            ],
          ),
        ),
        isA<AssertionError>(),
      );
    });
  });

  group('RemixMenu checkbox items', () {
    testWidgets('exposes role, checked state, callback order, and rebuild', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      var checked = false;
      final calls = <String>[];

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) => RemixMenu<String>(
            trigger: const RemixMenuTrigger(label: 'Options'),
            onSelected: (value) => calls.add('root:$value'),
            items: [
              RemixMenuCheckboxItem(
                value: 'notifications',
                label: 'Notifications',
                checked: checked,
                closeOnActivate: false,
                onChanged: (value) {
                  calls.add('item:$value');
                  setState(() => checked = value);
                },
              ),
            ],
          ),
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();

      var data = tester
          .getSemantics(find.text('Notifications'))
          .getSemanticsData();
      expect(data.role, SemanticsRole.menuItemCheckbox);
      expect(data.flagsCollection.isChecked, CheckedState.isFalse);

      await tester.tap(find.text('Notifications'));
      await tester.pump();

      expect(calls, ['root:notifications', 'item:true']);
      expect(checked, isTrue);
      data = tester.getSemantics(find.text('Notifications')).getSemanticsData();
      expect(data.flagsCollection.isChecked, CheckedState.isTrue);
      expect(find.text('Notifications'), findsOneWidget);
      semantics.dispose();
    });

    testWidgets('supports root-only and item-only callbacks', (tester) async {
      final calls = <String>[];
      final rootOnlyController = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: rootOnlyController,
          trigger: const RemixMenuTrigger(label: 'Options'),
          onSelected: (value) => calls.add('root:$value'),
          items: const [
            RemixMenuCheckboxItem(
              value: 'root',
              label: 'Root only',
              checked: false,
              closeOnActivate: false,
            ),
          ],
        ),
      );
      rootOnlyController.open();
      await tester.pump();
      await tester.tap(find.text('Root only'));
      await tester.pump();
      expect(calls, ['root:root']);

      final itemOnlyController = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: itemOnlyController,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: [
            RemixMenuCheckboxItem(
              value: 'item',
              label: 'Item only',
              checked: false,
              closeOnActivate: false,
              onChanged: (value) => calls.add('item:$value'),
            ),
          ],
        ),
      );
      await tester.pump();
      itemOnlyController.open();
      await tester.pump();
      await tester.tap(find.text('Item only'));
      await tester.pump();
      expect(calls, ['root:root', 'item:true']);
    });

    testWidgets('both-null and explicitly disabled items suppress activation', (
      tester,
    ) async {
      final calls = <String>[];
      final neitherController = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: neitherController,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuCheckboxItem(
              value: 'neither',
              label: 'Neither callback',
              checked: false,
            ),
          ],
        ),
      );
      await tester.pump();
      neitherController.open();
      await tester.pump();
      final neitherControllerState = NakedMenuItemState.controllerOf<String>(
        tester.element(find.text('Neither callback')),
      );
      expect(neitherControllerState.value, contains(WidgetState.disabled));
      await tester.tap(find.text('Neither callback'));
      await tester.pump();
      expect(find.text('Neither callback'), findsOneWidget);

      final disabledController = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: disabledController,
          trigger: const RemixMenuTrigger(label: 'Options'),
          onSelected: calls.add,
          items: [
            RemixMenuCheckboxItem(
              value: 'disabled',
              label: 'Explicitly disabled',
              checked: false,
              enabled: false,
              onChanged: (value) => calls.add('changed:$value'),
            ),
          ],
        ),
      );
      await tester.pump();
      disabledController.open();
      await tester.pump();
      await tester.tap(find.text('Explicitly disabled'));
      await tester.pump();
      expect(calls, isEmpty);
    });
  });

  group('RemixMenu radio groups', () {
    testWidgets('exposes exclusive roles and updates controlled selection', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      var value = 'compact';
      final calls = <String>[];

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) => RemixMenu<String>(
            trigger: const RemixMenuTrigger(label: 'Options'),
            onSelected: (next) => calls.add('root:$next'),
            items: [
              RemixMenuRadioGroup(
                value: value,
                onChanged: (next) {
                  calls.add('group:$next');
                  setState(() => value = next);
                },
                items: const [
                  RemixMenuRadioItem(
                    value: 'compact',
                    label: 'Compact',
                    closeOnActivate: false,
                  ),
                  RemixMenuRadioItem(
                    value: 'comfortable',
                    label: 'Comfortable',
                    closeOnActivate: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();

      final selected = tester
          .getSemantics(find.text('Compact'))
          .getSemanticsData();
      final unselected = tester
          .getSemantics(find.text('Comfortable'))
          .getSemanticsData();
      expect(selected.role, SemanticsRole.menuItemRadio);
      expect(selected.flagsCollection.isChecked, CheckedState.isTrue);
      expect(selected.flagsCollection.isInMutuallyExclusiveGroup, isTrue);
      expect(unselected.role, SemanticsRole.menuItemRadio);
      expect(unselected.flagsCollection.isChecked, CheckedState.isFalse);
      expect(unselected.flagsCollection.isInMutuallyExclusiveGroup, isTrue);

      await tester.tap(find.text('Comfortable'));
      await tester.pump();
      expect(value, 'comfortable');
      expect(calls, ['root:comfortable', 'group:comfortable']);
      expect(
        tester
            .getSemantics(find.text('Comfortable'))
            .getSemanticsData()
            .flagsCollection
            .isChecked,
        CheckedState.isTrue,
      );
      semantics.dispose();
    });

    testWidgets('re-emits the selected value through root then group', (
      tester,
    ) async {
      final calls = <String>[];
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          onSelected: (value) => calls.add('root:$value'),
          items: [
            RemixMenuRadioGroup(
              value: 'compact',
              onChanged: (value) => calls.add('group:$value'),
              items: const [
                RemixMenuRadioItem(
                  value: 'compact',
                  label: 'Compact',
                  closeOnActivate: false,
                ),
              ],
            ),
          ],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();
      await tester.tap(find.text('Compact'));
      await tester.pump();

      expect(calls, ['root:compact', 'group:compact']);
    });

    testWidgets('supports root-only and group-only callbacks', (tester) async {
      final calls = <String>[];
      final rootOnlyController = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: rootOnlyController,
          trigger: const RemixMenuTrigger(label: 'Options'),
          onSelected: (value) => calls.add('root:$value'),
          items: const [
            RemixMenuRadioGroup(
              value: 'root',
              items: [
                RemixMenuRadioItem(
                  value: 'root',
                  label: 'Root only',
                  closeOnActivate: false,
                ),
              ],
            ),
          ],
        ),
      );
      rootOnlyController.open();
      await tester.pump();
      await tester.tap(find.text('Root only'));
      await tester.pump();
      expect(calls, ['root:root']);

      final groupOnlyController = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: groupOnlyController,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: [
            RemixMenuRadioGroup(
              value: 'group',
              onChanged: (value) => calls.add('group:$value'),
              items: const [
                RemixMenuRadioItem(
                  value: 'group',
                  label: 'Group only',
                  closeOnActivate: false,
                ),
              ],
            ),
          ],
        ),
      );
      await tester.pump();
      groupOnlyController.open();
      await tester.pump();
      await tester.tap(find.text('Group only'));
      await tester.pump();
      expect(calls, ['root:root', 'group:group']);
    });

    testWidgets('both-null radio callbacks disable activation', (tester) async {
      final controller = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: controller,
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: const [
            RemixMenuRadioGroup(
              value: 'neither',
              items: [
                RemixMenuRadioItem(value: 'neither', label: 'Neither callback'),
              ],
            ),
          ],
        ),
      );
      controller.open();
      await tester.pump();

      final itemController = NakedMenuItemState.controllerOf<String>(
        tester.element(find.text('Neither callback')),
      );
      expect(itemController.value, contains(WidgetState.disabled));
      await tester.tap(find.text('Neither callback'));
      await tester.pump();
      expect(find.text('Neither callback'), findsOneWidget);
    });

    testWidgets('group and item disabled states suppress radio callbacks', (
      tester,
    ) async {
      final calls = <String>[];
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          onSelected: calls.add,
          items: [
            RemixMenuRadioGroup(
              value: 'selected',
              enabled: false,
              onChanged: calls.add,
              items: const [
                RemixMenuRadioItem(value: 'selected', label: 'Group disabled'),
              ],
            ),
            RemixMenuRadioGroup(
              value: 'selected',
              onChanged: calls.add,
              items: const [
                RemixMenuRadioItem(
                  value: 'selected',
                  label: 'Item disabled',
                  enabled: false,
                ),
              ],
            ),
          ],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();
      await tester.tap(find.text('Group disabled'));
      await tester.tap(find.text('Item disabled'));
      await tester.pump();

      expect(calls, isEmpty);
    });
  });

  group('RemixMenu submenus', () {
    testWidgets(
      'omitted submenu side follows direction and explicit right stays physical',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        Future<void> expectPlacement({
          required TextDirection direction,
          required OverlaySide expectedSide,
          bool explicitRight = false,
        }) async {
          final menuController = MenuController();
          final submenuController = MenuController();
          final submenu = explicitRight
              ? RemixMenuSubmenu<String>(
                  controller: submenuController,
                  label: 'More',
                  positioning: const OverlayPositionConfig(
                    side: OverlaySide.right,
                    alignment: OverlayAlignment.start,
                    sideOffset: 4,
                  ),
                  items: const [
                    RemixMenuItem(value: 'archive', label: 'Archive'),
                  ],
                )
              : RemixMenuSubmenu<String>(
                  controller: submenuController,
                  label: 'More',
                  items: const [
                    RemixMenuItem(value: 'archive', label: 'Archive'),
                  ],
                );

          await tester.pumpRemixApp(
            RemixMenu<String>(
              controller: menuController,
              trigger: const RemixMenuTrigger(label: 'Options'),
              items: [submenu],
            ),
            textDirection: direction,
          );
          menuController.open();
          await tester.pump();
          submenuController.open();
          await tester.pump();
          await tester.pump();

          final triggerRect = tester.getRect(find.text('More'));
          final childRect = tester.getRect(find.text('Archive'));
          final placement = OverlayPlacement.of(
            tester.element(find.text('Archive')),
          );

          expect(placement.side, expectedSide);
          expect(placement.wasFlipped, isFalse);
          if (expectedSide == OverlaySide.right) {
            expect(childRect.left, greaterThan(triggerRect.right));
          } else {
            expect(childRect.right, lessThan(triggerRect.left));
          }
        }

        await expectPlacement(
          direction: TextDirection.ltr,
          expectedSide: OverlaySide.right,
        );
        await expectPlacement(
          direction: TextDirection.rtl,
          expectedSide: OverlaySide.left,
        );
        await expectPlacement(
          direction: TextDirection.rtl,
          expectedSide: OverlaySide.right,
          explicitRight: true,
        );
      },
    );

    testWidgets('hover opens only after the configured 100 ms delay', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixMenu<String>(
          trigger: RemixMenuTrigger(label: 'Options'),
          items: [
            RemixMenuSubmenu(
              label: 'More',
              items: [RemixMenuItem(value: 'archive', label: 'Archive')],
            ),
          ],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: Offset.zero);
      addTearDown(mouse.removePointer);
      await mouse.moveTo(tester.getCenter(find.text('More')));

      await tester.pump(const Duration(milliseconds: 99));
      expect(find.text('Archive'), findsNothing);
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pump();
      expect(find.text('Archive'), findsOneWidget);
    });

    testWidgets('directional arrows and Escape restore submenu focus', (
      tester,
    ) async {
      for (final direction in TextDirection.values) {
        final focusNode = FocusNode();
        final controller = MenuController();
        await tester.pumpRemixApp(
          RemixMenu<String>(
            controller: controller,
            trigger: const RemixMenuTrigger(label: 'Options'),
            items: [
              RemixMenuSubmenu(
                label: 'More',
                focusNode: focusNode,
                items: const [
                  RemixMenuItem(value: 'archive', label: 'Archive'),
                ],
              ),
            ],
          ),
          textDirection: direction,
        );
        await tester.pump();
        controller.open();
        await tester.pump();
        focusNode.requestFocus();
        await tester.pump();

        await tester.sendKeyEvent(
          direction == TextDirection.ltr
              ? LogicalKeyboardKey.arrowRight
              : LogicalKeyboardKey.arrowLeft,
        );
        await tester.pump();
        await tester.pump();
        expect(find.text('Archive'), findsOneWidget);
        expect(Focus.of(tester.element(find.text('Archive'))).hasFocus, isTrue);

        await tester.sendKeyEvent(
          direction == TextDirection.ltr
              ? LogicalKeyboardKey.arrowLeft
              : LogicalKeyboardKey.arrowRight,
        );
        await tester.pump();
        await tester.pump();
        expect(find.text('Archive'), findsNothing);
        expect(focusNode.hasFocus, isTrue);

        await tester.sendKeyEvent(
          direction == TextDirection.ltr
              ? LogicalKeyboardKey.arrowRight
              : LogicalKeyboardKey.arrowLeft,
        );
        await tester.pump();
        await tester.pump();
        expect(find.text('Archive'), findsOneWidget);

        await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        await tester.pump();
        await tester.pump();
        expect(find.text('Archive'), findsNothing);
        expect(focusNode.hasFocus, isTrue);
        focusNode.dispose();
      }
    });

    testWidgets('controller callbacks, disabled trigger, and recursive close', (
      tester,
    ) async {
      final submenuController = MenuController();
      final calls = <String>[];
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          onSelected: (value) => calls.add('selected:$value'),
          items: [
            RemixMenuSubmenu(
              label: 'Disabled',
              enabled: false,
              items: const [RemixMenuItem(value: 'hidden', label: 'Hidden')],
            ),
            RemixMenuSubmenu(
              label: 'More',
              controller: submenuController,
              onOpen: () => calls.add('open'),
              onClose: () => calls.add('close'),
              items: const [
                RemixMenuSubmenu(
                  label: 'Even more',
                  items: [RemixMenuItem(value: 'archive', label: 'Archive')],
                ),
              ],
            ),
          ],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();
      await tester.tap(find.text('Disabled'));
      await tester.pump();
      expect(find.text('Hidden'), findsNothing);

      await tester.tap(find.text('More'));
      await tester.pump();
      expect(calls, contains('open'));
      await tester.tap(find.text('Even more'));
      await tester.pump();
      await tester.tap(find.text('Archive'));
      await tester.pump();
      await tester.pump();
      expect(calls, containsAllInOrder(['open', 'selected:archive', 'close']));
      expect(find.text('More'), findsNothing);
    });

    testWidgets('caller-owned focus nodes remain usable after unmount', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: [
            RemixMenuSubmenu(
              label: 'More',
              focusNode: focusNode,
              items: const [RemixMenuItem(value: 'archive', label: 'Archive')],
            ),
          ],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();
      await tester.pumpWidget(const SizedBox.shrink());

      expect(() => focusNode.requestFocus(), returnsNormally);
    });
  });

  group('RemixMenu compound rendering', () {
    testWidgets('vertical item styles remain shrink-wrapped and layout-safe', (
      tester,
    ) async {
      final controller = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: controller,
          trigger: const RemixMenuTrigger(label: 'Options'),
          style: MenuStyler().item(
            MenuItemStyler().direction(.vertical).mainAxisSize(.min),
          ),
          items: const [
            RemixMenuItem(
              value: 'vertical',
              label: 'Vertical item',
              trailingIcon: Icons.keyboard_command_key,
            ),
          ],
        ),
      );

      controller.open();
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Vertical item'), findsOneWidget);
    });

    testWidgets('overlay spacing applies between adjacent radio rows', (
      tester,
    ) async {
      final controller = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: controller,
          trigger: const RemixMenuTrigger(label: 'Options'),
          style: MenuStyler().overlay(FlexBoxStyler().spacing(12)),
          onSelected: (_) {},
          items: const [
            RemixMenuRadioGroup(
              value: 'first',
              items: [
                RemixMenuRadioItem(value: 'first', label: 'First radio'),
                RemixMenuRadioItem(value: 'second', label: 'Second radio'),
              ],
            ),
          ],
        ),
      );

      controller.open();
      await tester.pump();

      Finder rowFor(String label) => find
          .ancestor(of: find.text(label), matching: find.byType(FlexBox))
          .first;
      final first = tester.getRect(rowFor('First radio'));
      final second = tester.getRect(rowFor('Second radio'));

      expect(second.top - first.bottom, 12);
    });

    testWidgets('overlay vertical direction applies within radio groups', (
      tester,
    ) async {
      final controller = MenuController();
      await tester.pumpRemixApp(
        RemixMenu<String>(
          controller: controller,
          trigger: const RemixMenuTrigger(label: 'Options'),
          style: MenuStyler().overlay(FlexBoxStyler().verticalDirection(.up)),
          onSelected: (_) {},
          items: const [
            RemixMenuRadioGroup(
              value: 'first',
              items: [
                RemixMenuRadioItem(value: 'first', label: 'First radio'),
                RemixMenuRadioItem(value: 'second', label: 'Second radio'),
              ],
            ),
          ],
        ),
      );

      controller.open();
      await tester.pump();

      final first = tester.getTopLeft(find.text('First radio'));
      final second = tester.getTopLeft(find.text('Second radio'));

      expect(second.dy, lessThan(first.dy));
    });

    testWidgets(
      'radio wrapper preserves neighboring item and divider geometry',
      (tester) async {
        await tester.pumpRemixApp(
          const RemixMenu<String>(
            trigger: RemixMenuTrigger(label: 'Options'),
            items: [
              RemixMenuItem(value: 'before', label: 'Before'),
              RemixMenuDivider(),
              RemixMenuRadioGroup(
                value: 'radio',
                items: [RemixMenuRadioItem(value: 'radio', label: 'Radio')],
              ),
              RemixMenuDivider(),
              RemixMenuItem(value: 'after', label: 'After'),
            ],
          ),
        );
        await tester.tap(find.text('Options'));
        await tester.pump();

        final beforeRow = find
            .ancestor(of: find.text('Before'), matching: find.byType(FlexBox))
            .first;
        final radioRow = find
            .ancestor(of: find.text('Radio'), matching: find.byType(FlexBox))
            .first;
        final afterRow = find
            .ancestor(of: find.text('After'), matching: find.byType(FlexBox))
            .first;
        expect(
          tester.getSize(beforeRow).height,
          tester.getSize(radioRow).height,
        );
        expect(
          tester.getSize(afterRow).height,
          tester.getSize(radioRow).height,
        );
        expect(find.byType(RemixDivider), findsNWidgets(2));
      },
    );

    testWidgets('a mixed panel reserves one common choice slot', (
      tester,
    ) async {
      Future<double> ordinaryLabelX(
        List<RemixMenuItemData<String>> items,
      ) async {
        final controller = MenuController();
        await tester.pumpRemixApp(
          RemixMenu<String>(
            controller: controller,
            trigger: const RemixMenuTrigger(label: 'Options'),
            items: items,
          ),
        );
        await tester.pump();
        controller.open();
        await tester.pump();
        return tester.getTopLeft(find.text('Ordinary')).dx;
      }

      final ordinaryOnlyX = await ordinaryLabelX(const [
        RemixMenuItem(value: 'ordinary', label: 'Ordinary'),
      ]);
      final mixedOrdinaryX = await ordinaryLabelX(const [
        RemixMenuItem(value: 'ordinary', label: 'Ordinary'),
        RemixMenuCheckboxItem(
          value: 'checkbox',
          label: 'Checkbox',
          checked: true,
        ),
      ]);
      final checkboxX = tester.getTopLeft(find.text('Checkbox')).dx;

      expect(mixedOrdinaryX, greaterThan(ordinaryOnlyX));
      expect(checkboxX, mixedOrdinaryX);
    });

    testWidgets('nested panels decide choice slots independently', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixMenu<String>(
          trigger: RemixMenuTrigger(label: 'Options'),
          items: [
            RemixMenuCheckboxItem(
              value: 'checkbox',
              label: 'Checkbox',
              checked: true,
            ),
            RemixMenuSubmenu(
              label: 'More',
              items: [RemixMenuItem(value: 'ordinary', label: 'Nested')],
            ),
          ],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();
      await tester.tap(find.text('More'));
      await tester.pump();

      final rootRow = tester.widget<FlexBox>(
        find
            .ancestor(of: find.text('More'), matching: find.byType(FlexBox))
            .first,
      );
      final nestedRow = tester.widget<FlexBox>(
        find
            .ancestor(of: find.text('Nested'), matching: find.byType(FlexBox))
            .first,
      );
      expect(rootRow.children.first, isA<Visibility>());
      expect(nestedRow.children.first, isA<Expanded>());
    });

    testWidgets('default size-9 choice slots scale to 18 at 200%', (
      tester,
    ) async {
      final controller = MenuController();
      await tester.pumpRemixApp(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: RemixMenu<String>(
            controller: controller,
            trigger: const RemixMenuTrigger(label: 'Options'),
            style: MenuStyler().item(
              MenuItemStyler().indicator(IconStyler().applyTextScaling(true)),
            ),
            items: const [
              RemixMenuCheckboxItem(
                value: 'checked',
                label: 'Checked',
                checked: true,
              ),
              RemixMenuCheckboxItem(
                value: 'unchecked',
                label: 'Unchecked',
                checked: false,
              ),
            ],
          ),
        ),
      );

      controller.open();
      await tester.pump();

      Finder slotFor(String label) {
        final row = tester.widget<FlexBox>(
          find
              .ancestor(of: find.text(label), matching: find.byType(FlexBox))
              .first,
        );
        return find.byWidget(row.children.first);
      }

      final checkedIndicator = tester.widget<RemixPathIcon>(
        find.byKey(const ValueKey('remix-menu-indicator-Checked')),
      );
      expect(checkedIndicator.styleSpec.spec.size, 9);
      expect(tester.getSize(slotFor('Checked')), const Size.square(18));
      expect(tester.getSize(slotFor('Unchecked')), const Size.square(18));
    });

    testWidgets(
      'maintained choice slots remain excluded from duplicate semantics',
      (tester) async {
        final semantics = tester.ensureSemantics();
        final controller = MenuController();
        await tester.pumpRemixApp(
          RemixMenu<String>(
            controller: controller,
            trigger: const RemixMenuTrigger(label: 'Options'),
            items: const [
              RemixMenuCheckboxItem(
                value: 'checked',
                label: 'Checked',
                checked: true,
                semanticLabel: 'Checked choice',
              ),
              RemixMenuCheckboxItem(
                value: 'unchecked',
                label: 'Unchecked',
                checked: false,
                semanticLabel: 'Unchecked choice',
              ),
            ],
          ),
        );

        controller.open();
        await tester.pump();

        for (final (label, visible) in [
          ('Checked', true),
          ('Unchecked', false),
        ]) {
          final row = find
              .ancestor(of: find.text(label), matching: find.byType(FlexBox))
              .first;
          final slot = tester.widget<FlexBox>(row).children.first;

          expect(
            slot,
            isA<Visibility>()
                .having((slot) => slot.visible, 'visible', visible)
                .having((slot) => slot.maintainState, 'maintainState', isTrue)
                .having(
                  (slot) => slot.maintainAnimation,
                  'maintainAnimation',
                  isTrue,
                )
                .having((slot) => slot.maintainSize, 'maintainSize', isTrue)
                .having(
                  (slot) => slot.maintainSemantics,
                  'maintainSemantics',
                  isTrue,
                )
                .having(
                  (slot) => slot.maintainInteractivity,
                  'maintainInteractivity',
                  isTrue,
                )
                .having((slot) => slot.child, 'child', isA<RemixPathIcon>()),
          );
          expect(
            find.ancestor(of: row, matching: find.byType(ExcludeSemantics)),
            findsOneWidget,
          );
        }

        expect(find.bySemanticsLabel('Checked choice'), findsOneWidget);
        expect(find.bySemanticsLabel('Unchecked choice'), findsOneWidget);
        semantics.dispose();
      },
    );

    testWidgets('raw and fluent indicators stay size 13 at 200%', (
      tester,
    ) async {
      Future<Size> indicatorSize({required bool raw}) async {
        final controller = MenuController();
        await tester.pumpRemixApp(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: RemixMenu<String>(
              controller: controller,
              trigger: const RemixMenuTrigger(label: 'Options'),
              items: const [
                RemixMenuCheckboxItem(
                  value: 'notifications',
                  label: 'Notifications',
                  checked: true,
                ),
              ],
              style: raw
                  ? const MenuStyler.create()
                  : MenuStyler().item(
                      MenuItemStyler().indicator(
                        IconStyler().size(13).applyTextScaling(false),
                      ),
                    ),
              styleSpec: raw
                  ? const MenuSpec(
                      item: StyleSpec(
                        spec: MenuItemSpec(
                          indicator: StyleSpec(
                            spec: IconSpec(size: 13, applyTextScaling: false),
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        );
        await tester.pump();
        controller.open();
        await tester.pump();
        final indicator = find.byKey(
          const ValueKey('remix-menu-indicator-Notifications'),
        );
        expect(
          tester.widget<RemixPathIcon>(indicator).glyph,
          RemixPathGlyph.thickCheck,
        );
        expect(
          tester
              .widget<RemixPathIcon>(indicator)
              .styleSpec
              .spec
              .applyTextScaling,
          isFalse,
        );
        return tester.getSize(indicator);
      }

      expect(await indicatorSize(raw: false), const Size.square(13));
      expect(await indicatorSize(raw: true), const Size.square(13));
    });

    testWidgets('checked and radio indicators inherit item widget states', (
      tester,
    ) async {
      final hovered = MenuItemStyler().indicator(IconStyler().size(17));
      final itemStyle = MenuItemStyler()
          .indicator(IconStyler().size(9))
          .onHovered(hovered);
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          onSelected: (_) {},
          style: MenuStyler().checkboxItem(itemStyle).radioItem(itemStyle),
          items: const [
            RemixMenuCheckboxItem(
              value: 'notifications',
              label: 'Notifications',
              checked: true,
              closeOnActivate: false,
            ),
            RemixMenuRadioGroup(
              value: 'compact',
              items: [
                RemixMenuRadioItem(
                  value: 'compact',
                  label: 'Compact',
                  closeOnActivate: false,
                ),
              ],
            ),
          ],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();
      final checkboxIndicator = find.byKey(
        const ValueKey('remix-menu-indicator-Notifications'),
      );
      final radioIndicator = find.byKey(
        const ValueKey('remix-menu-indicator-Compact'),
      );
      expect(tester.getSize(checkboxIndicator), const Size.square(9));
      expect(tester.getSize(radioIndicator), const Size.square(9));

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: Offset.zero);
      addTearDown(mouse.removePointer);
      await mouse.moveTo(tester.getCenter(find.text('Notifications')));
      await tester.pump();
      await tester.pump();
      expect(
        WidgetStateProvider.of(tester.element(checkboxIndicator))?.hovered,
        isTrue,
      );
      expect(tester.getSize(checkboxIndicator), const Size.square(17));
      await mouse.moveTo(tester.getCenter(find.text('Compact')));
      await tester.pump();
      await tester.pump();
      expect(tester.getSize(radioIndicator), const Size.square(17));
    });

    testWidgets('trailing slots align to the directional panel end', (
      tester,
    ) async {
      for (final direction in TextDirection.values) {
        final controller = MenuController();
        await tester.pumpRemixApp(
          RemixMenu<String>(
            controller: controller,
            trigger: const RemixMenuTrigger(label: 'Options'),
            style: MenuStyler().item(
              MenuItemStyler()
                  .direction(.horizontal)
                  .mainAxisSize(.max)
                  .width(220)
                  .spacing(12),
            ),
            items: const [
              RemixMenuItem(
                value: 'short',
                label: 'Short',
                trailingIcon: Icons.keyboard_command_key,
              ),
              RemixMenuItem(
                value: 'long',
                label: 'A much longer label',
                trailingIcon: Icons.keyboard_command_key,
              ),
            ],
          ),
          textDirection: direction,
        );
        await tester.pump();
        controller.open();
        await tester.pump();
        final icons = find.byIcon(Icons.keyboard_command_key);
        final first = tester.getRect(icons.at(0));
        final second = tester.getRect(icons.at(1));
        if (direction == TextDirection.ltr) {
          expect(first.right, second.right);
          expect(
            first.left - tester.getRect(find.text('Short')).right,
            greaterThanOrEqualTo(12),
          );
        } else {
          expect(first.left, second.left);
          expect(
            tester.getRect(find.text('Short')).left - first.right,
            greaterThanOrEqualTo(12),
          );
        }
      }
    });

    testWidgets(
      'default submenu path is directional and custom trailing replaces it',
      (tester) async {
        for (final direction in TextDirection.values) {
          final controller = MenuController();
          await tester.pumpRemixApp(
            RemixMenu<String>(
              controller: controller,
              trigger: const RemixMenuTrigger(label: 'Options'),
              items: const [
                RemixMenuSubmenu(
                  label: 'Default',
                  items: [RemixMenuItem(value: 'child', label: 'Child')],
                ),
                RemixMenuSubmenu(
                  label: 'Custom',
                  trailingIcon: Icons.star,
                  items: [RemixMenuItem(value: 'other', label: 'Other')],
                ),
              ],
            ),
            textDirection: direction,
          );
          await tester.pump();
          controller.open();
          await tester.pump();

          expect(
            find.byKey(const ValueKey('remix-menu-submenu-chevron-Default')),
            findsOneWidget,
          );
          final chevron = tester.widget<RemixPathIcon>(
            find.byKey(const ValueKey('remix-menu-submenu-chevron-Default')),
          );
          expect(chevron.glyph, RemixPathGlyph.thickChevronRight);
          expect(chevron.matchTextDirection, isTrue);
          expect(
            find.byKey(const ValueKey('remix-menu-submenu-chevron-Custom')),
            findsNothing,
          );
          expect(find.byIcon(Icons.star), findsOneWidget);
        }
      },
    );

    testWidgets('open submenus resolve existing selected-state recipes', (
      tester,
    ) async {
      final itemStyle = MenuItemStyler()
          .label(TextStyler().color(Colors.red))
          .onSelected(MenuItemStyler().label(TextStyler().color(Colors.green)));
      await tester.pumpRemixApp(
        RemixMenu<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          style: MenuStyler().item(itemStyle),
          items: const [
            RemixMenuSubmenu(
              label: 'More',
              items: [RemixMenuItem(value: 'archive', label: 'Archive')],
            ),
          ],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();
      expect(tester.widget<Text>(find.text('More')).style?.color, Colors.red);
      await tester.tap(find.text('More'));
      await tester.pump();
      expect(tester.widget<Text>(find.text('More')).style?.color, Colors.green);
    });

    testWidgets('visual labels produce exactly one semantics node', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        const RemixMenu<String>(
          trigger: RemixMenuTrigger(label: 'Options'),
          items: [
            RemixMenuCheckboxItem(
              value: 'notifications',
              label: 'Notifications',
              checked: true,
              semanticLabel: 'Notification setting',
            ),
            RemixMenuRadioGroup(
              value: 'compact',
              items: [
                RemixMenuRadioItem(
                  value: 'compact',
                  label: 'Compact',
                  semanticLabel: 'Compact density',
                ),
              ],
            ),
            RemixMenuSubmenu(
              label: 'More',
              semanticLabel: 'More actions',
              items: [RemixMenuItem(value: 'archive', label: 'Archive')],
            ),
          ],
        ),
      );
      await tester.tap(find.text('Options'));
      await tester.pump();

      expect(find.bySemanticsLabel('Notification setting'), findsOneWidget);
      expect(find.bySemanticsLabel('Compact density'), findsOneWidget);
      expect(find.bySemanticsLabel('More actions'), findsOneWidget);
      semantics.dispose();
    });
  });
}

// Test enum for type safety testing
enum MenuAction { copy, paste, delete }
