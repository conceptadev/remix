import 'dart:ui' as ui;

import 'package:dashboard/shell/dashboard_page.dart';
import 'package:dashboard/shell/navigation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

const _sections = <RemixNavigationSection<DashboardPage>>[
  RemixNavigationSection(
    label: 'Workspace',
    destinations: [
      RemixNavigationDestination(
        value: DashboardPage.overview,
        label: 'Overview',
        icon: Icons.space_dashboard_outlined,
      ),
    ],
  ),
  RemixNavigationSection(
    label: 'Data',
    destinations: [
      RemixNavigationDestination(
        value: DashboardPage.customers,
        label: 'Customers',
        icon: Icons.people_outline,
      ),
      RemixNavigationDestination(
        value: DashboardPage.orders,
        label: 'Orders',
        icon: Icons.receipt_long_outlined,
      ),
    ],
  ),
];

void main() {
  test('dashboard data uses the public immutable navigation records', () {
    expect(
      dashboardNavSections,
      isA<List<RemixNavigationSection<DashboardPage>>>(),
    );
    expect(
      dashboardNavSections.expand((section) => section.destinations).length,
      DashboardPage.values.length,
    );
    expect(
      () => dashboardNavSections.add(
        const RemixNavigationSection(destinations: []),
      ),
      throwsUnsupportedError,
    );
  });

  testWidgets('activation emits unselected and selected destinations once', (
    tester,
  ) async {
    final emitted = <DashboardPage>[];
    await _pumpNavigationList(tester, onSelected: emitted.add);

    await tester.tap(find.byKey(const ValueKey(DashboardPage.customers)));
    await tester.pump();
    expect(emitted, [DashboardPage.customers]);

    await tester.tap(find.byKey(const ValueKey(DashboardPage.overview)));
    await tester.pump();
    expect(emitted, [DashboardPage.customers, DashboardPage.overview]);
  });

  testWidgets('pointer and semantics tap routes each emit exactly once', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    final emitted = <DashboardPage>[];
    await _pumpNavigationList(tester, onSelected: emitted.add);

    await tester.tap(find.byKey(const ValueKey(DashboardPage.overview)));
    await tester.pump();
    expect(emitted, [DashboardPage.overview]);

    tester.semantics.performAction(
      find.semantics.byLabel('Customers'),
      ui.SemanticsAction.tap,
    );
    await tester.pump();
    expect(emitted, [DashboardPage.overview, DashboardPage.customers]);
    handle.dispose();
  });

  testWidgets('navigation and section semantics remain separate', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await _pumpNavigationList(
      tester,
      sections: const [
        ..._sections,
        RemixNavigationSection(label: 'Empty', destinations: []),
      ],
    );

    expect(
      tester
          .getSemantics(find.bySemanticsLabel('Dashboard navigation'))
          .getSemanticsData()
          .role,
      ui.SemanticsRole.navigation,
    );

    final header = find.semantics.byLabel('Workspace');
    expect(header, findsOne);
    expect(
      header.evaluate().single,
      isSemantics(label: 'Workspace', isHeader: true),
    );

    final destination = find.semantics.byLabel('Overview');
    expect(destination, findsOne);
    expect(
      destination.evaluate().single,
      isSemantics(label: 'Overview', isHeader: false),
    );
    expect(find.semantics.byLabel('Empty'), findsNothing);
    handle.dispose();
  });

  testWidgets('selected destination has one selected-button node', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await _pumpNavigationList(tester);

    final destination = find.semantics.byLabel('Overview');
    expect(destination, findsOne);

    final data = destination.evaluate().single.getSemanticsData();
    expect(data.label, 'Overview');
    expect(data.flagsCollection.isButton, isTrue);
    expect(data.flagsCollection.isSelected, ui.Tristate.isTrue);
    expect(data.flagsCollection.isToggled, ui.Tristate.none);
    handle.dispose();
  });

  testWidgets('Tab follows visual order and Enter and Space activate', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    final emitted = <DashboardPage>[];
    await _pumpNavigationList(tester, onSelected: emitted.add);

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(
      _destinationData('Overview').flagsCollection.isFocused,
      ui.Tristate.isTrue,
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(
      _destinationData('Customers').flagsCollection.isFocused,
      ui.Tristate.isTrue,
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(
      _destinationData('Orders').flagsCollection.isFocused,
      ui.Tristate.isTrue,
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pump();

    expect(emitted, [DashboardPage.orders, DashboardPage.orders]);
    handle.dispose();
  });

  testWidgets('builds in scrolling and fixed-height column hosts', (
    tester,
  ) async {
    FortalNavigationList<DashboardPage> buildList() => FortalNavigationList(
      sections: _sections,
      selectedValue: DashboardPage.overview,
      onSelected: (_) {},
    );

    await _pumpPage(tester, SingleChildScrollView(child: buildList()));
    expect(tester.takeException(), isNull);
    expect(
      find.descendant(
        of: find.byType(RemixNavigationList<DashboardPage>),
        matching: find.byType(Scrollable),
      ),
      findsNothing,
    );

    await _pumpPage(
      tester,
      SizedBox(height: 320, child: Column(children: [buildList()])),
    );
    expect(tester.takeException(), isNull);
    expect(
      find.descendant(
        of: find.byType(RemixNavigationList<DashboardPage>),
        matching: find.byType(Scrollable),
      ),
      findsNothing,
    );
  });

  testWidgets('long labels scale inside a 256-wide host without overflow', (
    tester,
  ) async {
    await _pumpPage(
      tester,
      Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(2)),
          child: SizedBox(
            width: 256,
            child: FortalNavigationList<DashboardPage>(
              sections: const [
                RemixNavigationSection(
                  label: 'Workspace',
                  destinations: [
                    RemixNavigationDestination(
                      value: DashboardPage.overview,
                      label:
                          'Overview of every active workspace and its status',
                      icon: Icons.space_dashboard_outlined,
                    ),
                  ],
                ),
              ],
              selectedValue: DashboardPage.overview,
              onSelected: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('renders in right-to-left direction without exceptions', (
    tester,
  ) async {
    await _pumpPage(
      tester,
      Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          width: 256,
          child: FortalNavigationList<DashboardPage>(
            sections: _sections,
            selectedValue: DashboardPage.overview,
            onSelected: (_) {},
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('null selection leaves every destination unselected', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await _pumpNavigationList(tester, selectedValue: null);

    for (final section in _sections) {
      for (final destination in section.destinations) {
        expect(
          _destinationData(destination.label).flagsCollection.isSelected,
          ui.Tristate.isFalse,
          reason: destination.label,
        );
      }
    }
    handle.dispose();
  });
}

Future<void> _pumpNavigationList(
  WidgetTester tester, {
  List<RemixNavigationSection<DashboardPage>> sections = _sections,
  DashboardPage? selectedValue = DashboardPage.overview,
  ValueChanged<DashboardPage>? onSelected,
}) {
  return _pumpPage(
    tester,
    FortalNavigationList<DashboardPage>(
      sections: sections,
      selectedValue: selectedValue,
      onSelected: onSelected ?? (_) {},
      semanticLabel: 'Dashboard navigation',
    ),
  );
}

Future<void> _pumpPage(WidgetTester tester, Widget page) {
  return tester.pumpWidget(
    MaterialApp(
      builder: (context, child) => FortalScope(child: child!),
      home: Scaffold(body: page),
    ),
  );
}

SemanticsData _destinationData(String label) {
  return find.semantics.byLabel(label).evaluate().single.getSemanticsData();
}
