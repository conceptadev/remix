import 'dart:ui' show CheckedState, SemanticsRole, Tristate;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('arbitrary trigger opens ordered compositional items', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      RemixMenu<String>(
        trigger: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.more_horiz), Text('Actions')],
        ),
        items: const [
          RemixMenuLabel(child: Text('Edit')),
          RemixMenuAction(value: 'copy', child: Text('Copy')),
          RemixMenuSeparator(),
          RemixMenuAction(value: 'delete', child: Text('Delete')),
        ],
      ),
    );

    expect(find.text('Edit'), findsNothing);
    await tester.tap(find.text('Actions'));
    await tester.pumpAndSettle();

    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Copy'), findsOneWidget);
    expect(find.byType(RemixDivider), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Copy')).dy,
      lessThan(tester.getTopLeft(find.text('Delete')).dy),
    );
  });

  testWidgets('action reports its typed value, closes, and restores focus', (
    tester,
  ) async {
    final controller = MenuController();
    final triggerFocus = FocusNode();
    addTearDown(triggerFocus.dispose);
    String? selected;

    await tester.pumpRemixApp(
      RemixMenu<String>(
        controller: controller,
        triggerFocusNode: triggerFocus,
        trigger: const Text('Open'),
        items: const [RemixMenuAction(value: 'copy', child: Text('Copy'))],
        onSelected: (value) => selected = value,
      ),
    );
    triggerFocus.requestFocus();
    controller.open();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copy'));
    await tester.pumpAndSettle();

    expect(selected, 'copy');
    expect(controller.isOpen, isFalse);
    expect(find.text('Copy'), findsNothing);
    expect(triggerFocus.hasFocus, isTrue);
  });

  testWidgets('group and label preserve semantic boundaries', (tester) async {
    final semantics = tester.ensureSemantics();
    final controller = MenuController();
    await tester.pumpRemixApp(
      RemixMenu<String>(
        controller: controller,
        trigger: const Text('Open'),
        items: const [
          RemixMenuGroup(
            semanticLabel: 'Editing actions',
            children: [
              RemixMenuLabel(
                semanticLabel: 'Edit section',
                child: Text('Edit'),
              ),
              RemixMenuAction(value: 'copy', child: Text('Copy')),
            ],
          ),
        ],
      ),
    );
    controller.open();
    await tester.pumpAndSettle();

    final label = tester.getSemantics(find.text('Edit')).getSemanticsData();
    expect(label.label, 'Edit section');
    expect(label.flagsCollection.isHeader, isTrue);
    expect(find.text('Copy'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('checkbox and radio items expose correct roles and callbacks', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final controller = MenuController();
    bool? checked;
    String? radio;

    await tester.pumpRemixApp(
      RemixMenu<String>(
        controller: controller,
        trigger: const Text('Open'),
        items: [
          RemixMenuCheckboxItem(
            value: 'notifications',
            checked: true,
            closeOnActivate: false,
            onChanged: (value) => checked = value,
            child: const Text('Notifications'),
          ),
          RemixMenuRadioGroup<String>(
            value: 'compact',
            onChanged: (value) => radio = value,
            children: const [
              RemixMenuRadioItem(
                value: 'compact',
                closeOnActivate: false,
                child: Text('Compact'),
              ),
              RemixMenuRadioItem(
                value: 'comfortable',
                closeOnActivate: false,
                child: Text('Comfortable'),
              ),
            ],
          ),
        ],
      ),
    );
    controller.open();
    await tester.pumpAndSettle();

    final checkbox = tester
        .getSemantics(find.text('Notifications'))
        .getSemanticsData();
    final selectedRadio = tester
        .getSemantics(find.text('Compact'))
        .getSemanticsData();
    final unselectedRadio = tester
        .getSemantics(find.text('Comfortable'))
        .getSemanticsData();
    expect(checkbox.role, SemanticsRole.menuItemCheckbox);
    expect(checkbox.flagsCollection.isChecked, CheckedState.isTrue);
    expect(selectedRadio.role, SemanticsRole.menuItemRadio);
    expect(selectedRadio.flagsCollection.isChecked, CheckedState.isTrue);
    expect(selectedRadio.flagsCollection.isInMutuallyExclusiveGroup, isTrue);
    expect(unselectedRadio.role, SemanticsRole.menuItemRadio);
    expect(unselectedRadio.flagsCollection.isChecked, CheckedState.isFalse);

    await tester.tap(find.text('Notifications'));
    await tester.tap(find.text('Comfortable'));
    expect(checked, isFalse);
    expect(radio, 'comfortable');
    expect(controller.isOpen, isTrue);
    semantics.dispose();
  });

  testWidgets('submenu hover waits 100 ms and nested action closes the root', (
    tester,
  ) async {
    final controller = MenuController();
    String? selected;
    await tester.pumpRemixApp(
      RemixMenu<String>(
        controller: controller,
        trigger: const Text('Open'),
        onSelected: (value) => selected = value,
        items: const [
          RemixMenuSubmenu<String>(
            child: SizedBox(width: 120, child: Text('More')),
            items: [RemixMenuAction(value: 'child', child: Text('Child item'))],
          ),
        ],
      ),
    );
    controller.open();
    await tester.pumpAndSettle();

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: Offset.zero);
    addTearDown(mouse.removePointer);
    await mouse.moveTo(tester.getCenter(find.text('More')));
    await tester.pump(const Duration(milliseconds: 99));
    expect(find.text('Child item'), findsNothing);
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump();
    expect(find.text('Child item'), findsOneWidget);

    await tester.tap(find.text('Child item'));
    await tester.pumpAndSettle();
    expect(selected, 'child');
    expect(controller.isOpen, isFalse);
  });

  testWidgets('submenu keyboard handoff follows LTR and restores focus', (
    tester,
  ) async {
    final controller = MenuController();
    final submenuFocus = FocusNode();
    addTearDown(submenuFocus.dispose);
    await tester.pumpRemixApp(
      RemixMenu<String>(
        controller: controller,
        trigger: const Text('Open'),
        items: [
          RemixMenuSubmenu<String>(
            focusNode: submenuFocus,
            child: const SizedBox(width: 120, child: Text('More')),
            items: const [
              RemixMenuAction(value: 'child', child: Text('Child item')),
            ],
          ),
        ],
      ),
    );
    controller.open();
    await tester.pumpAndSettle();
    submenuFocus.requestFocus();
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pumpAndSettle();
    expect(find.text('Child item'), findsOneWidget);
    expect(
      tester.getCenter(find.text('Child item')).dx,
      greaterThan(tester.getCenter(find.text('More')).dx),
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.text('Child item'), findsNothing);
    expect(submenuFocus.hasFocus, isTrue);
  });

  testWidgets('submenu keyboard handoff reverses in RTL', (tester) async {
    final controller = MenuController();
    final submenuFocus = FocusNode();
    addTearDown(submenuFocus.dispose);
    await tester.pumpRemixApp(
      RemixMenu<String>(
        controller: controller,
        trigger: const Text('Open'),
        items: [
          RemixMenuSubmenu<String>(
            focusNode: submenuFocus,
            child: const SizedBox(width: 120, child: Text('More')),
            items: const [
              RemixMenuAction(value: 'child', child: Text('Child item')),
            ],
          ),
        ],
      ),
      textDirection: TextDirection.rtl,
    );
    controller.open();
    await tester.pumpAndSettle();
    submenuFocus.requestFocus();
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pumpAndSettle();
    expect(find.text('Child item'), findsOneWidget);
    expect(
      tester.getCenter(find.text('Child item')).dx,
      lessThan(tester.getCenter(find.text('More')).dx),
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pumpAndSettle();
    expect(find.text('Child item'), findsNothing);
    expect(submenuFocus.hasFocus, isTrue);
  });

  testWidgets('Fortal submenu defaults to the leading side in RTL', (
    tester,
  ) async {
    final controller = MenuController();
    await tester.pumpRemixApp(
      FortalMenu<String>(
        controller: controller,
        trigger: const Text('Open'),
        items: const [
          RemixMenuSubmenu<String>(
            child: SizedBox(width: 120, child: Text('More')),
            items: [RemixMenuAction(value: 'child', child: Text('Child item'))],
          ),
        ],
      ),
      textDirection: TextDirection.rtl,
    );
    controller.open();
    await tester.pumpAndSettle();
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    expect(find.text('Child item'), findsOneWidget);
    expect(
      tester.getCenter(find.text('Child item')).dx,
      lessThan(tester.getCenter(find.text('More')).dx),
    );
  });

  testWidgets('explicit submenu positioning overrides RTL defaults', (
    tester,
  ) async {
    final controller = MenuController();
    await tester.pumpRemixApp(
      RemixMenu<String>(
        controller: controller,
        submenuPositioning: const OverlayPositionConfig(
          side: OverlaySide.right,
          alignment: OverlayAlignment.start,
          sideOffset: 1,
          alignmentOffset: -8,
          collisionPadding: EdgeInsets.all(10),
        ),
        trigger: const Text('Open'),
        items: const [
          RemixMenuSubmenu<String>(
            child: SizedBox(width: 120, child: Text('More')),
            items: [RemixMenuAction(value: 'child', child: Text('Child item'))],
          ),
        ],
      ),
      textDirection: TextDirection.rtl,
    );
    controller.open();
    await tester.pumpAndSettle();
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    expect(find.text('Child item'), findsOneWidget);
    expect(
      tester.getCenter(find.text('Child item')).dx,
      greaterThan(tester.getCenter(find.text('More')).dx),
    );
  });

  testWidgets('Fortal preserves explicit submenu positioning in RTL', (
    tester,
  ) async {
    final controller = MenuController();
    await tester.pumpRemixApp(
      FortalMenu<String>(
        controller: controller,
        submenuPositioning: const OverlayPositionConfig(
          side: OverlaySide.right,
          alignment: OverlayAlignment.start,
          sideOffset: 1,
          alignmentOffset: -8,
          collisionPadding: EdgeInsets.all(10),
        ),
        trigger: const Text('Open'),
        items: const [
          RemixMenuSubmenu<String>(
            child: SizedBox(width: 120, child: Text('More')),
            items: [RemixMenuAction(value: 'child', child: Text('Child item'))],
          ),
        ],
      ),
      textDirection: TextDirection.rtl,
    );
    controller.open();
    await tester.pumpAndSettle();
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    expect(find.text('Child item'), findsOneWidget);
    expect(
      tester.getCenter(find.text('Child item')).dx,
      greaterThan(tester.getCenter(find.text('More')).dx),
    );
  });

  testWidgets('submenu trigger exposes expandable menu-item semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final controller = MenuController();
    await tester.pumpRemixApp(
      RemixMenu<String>(
        controller: controller,
        trigger: const Text('Open'),
        items: const [
          RemixMenuSubmenu<String>(
            semanticLabel: 'More options',
            child: Text('More'),
            items: [RemixMenuAction(value: 'child', child: Text('Child'))],
          ),
        ],
      ),
    );
    controller.open();
    await tester.pumpAndSettle();

    final data = tester.getSemantics(find.text('More')).getSemanticsData();
    expect(data.role, SemanticsRole.menuItem);
    expect(data.label, 'More options');
    expect(data.flagsCollection.isExpanded, Tristate.isFalse);
    semantics.dispose();
  });

  testWidgets('disabled action does not select or close', (tester) async {
    final controller = MenuController();
    String? selected;
    await tester.pumpRemixApp(
      RemixMenu<String>(
        controller: controller,
        trigger: const Text('Open'),
        onSelected: (value) => selected = value,
        items: const [
          RemixMenuAction(
            value: 'disabled',
            enabled: false,
            child: Text('Disabled'),
          ),
        ],
      ),
    );
    controller.open();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Disabled'));
    await tester.pump();

    expect(selected, isNull);
    expect(controller.isOpen, isTrue);
  });
}
