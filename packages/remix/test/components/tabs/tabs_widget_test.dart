import 'dart:ui' show PointerDeviceKind, SemanticsRole, Tristate;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('controlled tabs select by tap and show the matching panel', (
    tester,
  ) async {
    var selected = 'one';
    await tester.pumpRemixApp(
      StatefulBuilder(
        builder: (context, setState) => RemixTabs(
          selectedTabId: selected,
          onChanged: (value) => setState(() => selected = value),
          child: const Column(
            children: [
              RemixTabBar(
                children: [
                  RemixTab(tabId: 'one', label: 'One'),
                  RemixTab(tabId: 'two', label: 'Two'),
                ],
              ),
              RemixTabView(tabId: 'one', child: Text('First panel')),
              RemixTabView(tabId: 'two', child: Text('Second panel')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('First panel'), findsOneWidget);
    expect(find.text('Second panel'), findsNothing);
    await tester.tap(find.text('Two'));
    await tester.pump();
    expect(selected, 'two');
    expect(find.text('Second panel'), findsOneWidget);
  });

  testWidgets('controller changes rebuild selected state', (tester) async {
    final controller = NakedTabController(selectedTabId: 'one');
    addTearDown(controller.dispose);
    await tester.pumpRemixApp(
      RemixTabs(
        controller: controller,
        child: const Column(
          children: [
            RemixTabBar(
              children: [
                RemixTab(tabId: 'one', label: 'One'),
                RemixTab(tabId: 'two', label: 'Two'),
              ],
            ),
            RemixTabView(tabId: 'one', child: Text('First panel')),
            RemixTabView(tabId: 'two', child: Text('Second panel')),
          ],
        ),
      ),
    );

    controller.selectTab('two');
    await tester.pump();
    expect(find.text('Second panel'), findsOneWidget);
  });

  testWidgets('disabled root and disabled tabs cannot change selection', (
    tester,
  ) async {
    var changes = 0;
    await tester.pumpRemixApp(
      RemixTabs(
        selectedTabId: 'one',
        onChanged: (_) => changes++,
        enabled: false,
        child: const RemixTabBar(
          children: [
            RemixTab(tabId: 'one', label: 'One'),
            RemixTab(tabId: 'two', label: 'Two'),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Two'));
    await tester.pump();
    expect(changes, 0);
  });

  testWidgets('arrow focus automatically activates on the current contract', (
    tester,
  ) async {
    var selected = 'one';
    await tester.pumpRemixApp(
      StatefulBuilder(
        builder: (context, setState) => RemixTabs(
          selectedTabId: selected,
          onChanged: (value) => setState(() => selected = value),
          child: const RemixTabBar(
            children: [
              RemixTab(tabId: 'one', label: 'One', autofocus: true),
              RemixTab(tabId: 'two', label: 'Two'),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(selected, 'two');
  });

  testWidgets('manual activation moves focus without selecting', (
    tester,
  ) async {
    var selected = 'one';
    await tester.pumpRemixApp(
      StatefulBuilder(
        builder: (context, setState) => RemixTabs(
          selectedTabId: selected,
          activationMode: NakedTabActivationMode.manual,
          onChanged: (value) => setState(() => selected = value),
          child: const RemixTabBar(
            children: [
              RemixTab(tabId: 'one', label: 'One', autofocus: true),
              RemixTab(tabId: 'two', label: 'Two'),
            ],
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(selected, 'one');

    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pump();
    expect(selected, 'two');
  });

  testWidgets('RTL horizontal arrows follow visual direction', (tester) async {
    var selected = 'one';
    await tester.pumpRemixApp(
      StatefulBuilder(
        builder: (context, setState) => RemixTabs(
          selectedTabId: selected,
          onChanged: (value) => setState(() => selected = value),
          child: const RemixTabBar(
            children: [
              RemixTab(tabId: 'one', label: 'One', autofocus: true),
              RemixTab(tabId: 'two', label: 'Two'),
            ],
          ),
        ),
      ),
      textDirection: TextDirection.rtl,
    );

    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pump();
    expect(selected, 'two');
  });

  testWidgets('tab builder exposes hovered pressed and focused states', (
    tester,
  ) async {
    const tabContentKey = ValueKey('stateful-tab-content');
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);
    final stateLog = <Set<WidgetState>>[];
    final focusLog = <bool>[];
    final hoverLog = <bool>[];
    final pressLog = <bool>[];
    await tester.pumpRemixApp(
      RemixTabs(
        selectedTabId: 'one',
        onChanged: (_) {},
        child: RemixTabBar(
          children: [
            RemixTab(
              tabId: 'one',
              focusNode: focusNode,
              onFocusChange: focusLog.add,
              onHoverChange: hoverLog.add,
              onPressChange: pressLog.add,
              builder: (context, state, child) {
                stateLog.add(state.states.toSet());
                return child!;
              },
              child: const ColoredBox(
                key: tabContentKey,
                color: Colors.transparent,
                child: SizedBox(width: 100, height: 40),
              ),
            ),
          ],
        ),
      ),
    );

    focusNode.requestFocus();
    await tester.pump();
    expect(focusLog, contains(true));
    expect(
      stateLog.any((states) => states.contains(WidgetState.focused)),
      isTrue,
    );

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(mouse.removePointer);
    await mouse.addPointer(location: const Offset(799, 599));
    await mouse.moveTo(tester.getCenter(find.byKey(tabContentKey)));
    await tester.pumpAndSettle();
    expect(hoverLog, contains(true));
    expect(
      stateLog.any((states) => states.contains(WidgetState.hovered)),
      isTrue,
    );

    await mouse.down(tester.getCenter(find.byKey(tabContentKey)));
    await tester.pump();
    expect(pressLog, contains(true));
    expect(
      stateLog.any((states) => states.contains(WidgetState.pressed)),
      isTrue,
    );
    await mouse.up();
  });

  testWidgets('maintainState false removes an inactive panel', (tester) async {
    await tester.pumpRemixApp(
      const RemixTabs(
        selectedTabId: 'one',
        child: Column(
          children: [
            RemixTabBar(
              children: [RemixTab(tabId: 'one', label: 'One')],
            ),
            RemixTabView(
              tabId: 'two',
              maintainState: false,
              child: Text('Removed panel'),
            ),
          ],
        ),
      ),
    );

    expect(find.text('Removed panel'), findsNothing);
  });

  testWidgets('tab semantics expose bar, tab, selection, and panel roles', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    try {
      await tester.pumpRemixApp(
        const RemixTabs(
          selectedTabId: 'one',
          child: Column(
            children: [
              RemixTabBar(
                children: [RemixTab(tabId: 'one', label: 'One')],
              ),
              RemixTabView(tabId: 'one', child: Text('First panel')),
            ],
          ),
        ),
      );

      expect(
        _semanticsRoleWithin(find.byType(NakedTabBar), SemanticsRole.tabBar),
        findsOneWidget,
      );
      expect(
        _semanticsRoleWithin(find.byType(NakedTab), SemanticsRole.tab),
        findsOneWidget,
      );
      expect(
        _semanticsRoleWithin(find.byType(NakedTabView), SemanticsRole.tabPanel),
        findsOneWidget,
      );
      expect(
        tester.getSemantics(find.text('One')).flagsCollection.isSelected,
        Tristate.isTrue,
      );
    } finally {
      handle.dispose();
    }
  });

  testWidgets('custom child and state builder are both supported', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      RemixTabs(
        selectedTabId: 'one',
        child: RemixTabBar(
          children: [
            RemixTab(
              tabId: 'one',
              child: const Text('Custom child'),
              builder: (context, state, child) => DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );

    expect(find.text('Custom child'), findsOneWidget);
    expect(find.byType(DecoratedBox), findsOneWidget);
  });

  testWidgets('Fortal size controls exact tab height', (tester) async {
    Future<double> heightFor(FortalTabsSize size) async {
      await tester.pumpRemixApp(
        RemixTabs(
          selectedTabId: 'one',
          child: FortalTabBar(
            size: size,
            children: const [FortalTab(tabId: 'one', label: 'One')],
          ),
        ),
      );
      return tester.getSize(find.byType(RemixTab)).height;
    }

    expect(await heightFor(FortalTabsSize.size1), 32);
    expect(await heightFor(FortalTabsSize.size2), 40);
  });

  testWidgets('Fortal label width stays stable when selection changes', (
    tester,
  ) async {
    var selected = 'one';
    const firstKey = ValueKey('first-tab');

    await tester.pumpRemixApp(
      StatefulBuilder(
        builder: (context, setState) => RemixTabs(
          selectedTabId: selected,
          onChanged: (value) => setState(() => selected = value),
          child: const FortalTabBar(
            children: [
              FortalTab(key: firstKey, tabId: 'one', label: 'MMMMMM'),
              FortalTab(tabId: 'two', label: 'MMMMMM'),
            ],
          ),
        ),
      ),
    );

    final selectedWidth = tester.getSize(find.byKey(firstKey).last).width;
    await tester.tap(find.text('MMMMMM').last);
    await tester.pump();
    final inactiveWidth = tester.getSize(find.byKey(firstKey).last).width;

    expect(inactiveWidth, closeTo(selectedWidth, 0.001));
  });
}

Finder _semanticsRoleWithin(Finder ancestor, SemanticsRole role) {
  return find.descendant(
    of: ancestor,
    matching: find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.role == role,
    ),
  );
}
