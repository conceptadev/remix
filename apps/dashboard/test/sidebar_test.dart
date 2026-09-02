import 'dart:ui' as ui;

import 'package:dashboard/shell/dashboard_page.dart';
import 'package:dashboard/shell/sidebar.dart';
import 'package:dashboard/shell/sidebar_sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

const _sections = <RemixSidebarSection<DashboardPage>>[
  RemixSidebarSection(
    label: 'Workspace',
    destinations: [
      RemixSidebarDestination(
        value: DashboardPage.overview,
        label: 'Overview',
        icon: Icons.space_dashboard_outlined,
      ),
    ],
  ),
  RemixSidebarSection(
    label: 'Data',
    destinations: [
      RemixSidebarDestination(
        value: DashboardPage.customers,
        label: 'Customers',
        icon: Icons.people_outline,
      ),
      RemixSidebarDestination(
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
      dashboardSidebarSections,
      isA<List<RemixSidebarSection<DashboardPage>>>(),
    );
    expect(
      dashboardSidebarSections.expand((section) => section.destinations).length,
      DashboardPage.values.length,
    );
    expect(
      () => dashboardSidebarSections.add(
        const RemixSidebarSection(destinations: []),
      ),
      throwsUnsupportedError,
    );
  });

  testWidgets('activation emits unselected and selected destinations once', (
    tester,
  ) async {
    final emitted = <DashboardPage>[];
    await _pumpSidebar(tester, onSelected: emitted.add);

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
    await _pumpSidebar(tester, onSelected: emitted.add);

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
    await _pumpSidebar(
      tester,
      sections: const [
        ..._sections,
        RemixSidebarSection(label: 'Empty', destinations: []),
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
    await _pumpSidebar(tester);

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
    await _pumpSidebar(tester, onSelected: emitted.add);

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

  testWidgets('the shell panel paints under device insets', (tester) async {
    const insets = EdgeInsets.only(top: 44, bottom: 34);
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(padding: insets),
          child: FortalScope(
            child: Row(
              children: [
                Sidebar(selected: DashboardPage.overview, onSelected: (_) {}),
              ],
            ),
          ),
        ),
      ),
    );

    final panel = tester.getRect(find.byType(Sidebar));
    final brand = tester.getRect(find.byKey(const ValueKey('dashboard-brand')));

    // The painted panel reaches the display edge while its content clears the
    // top inset.
    expect(brand.top, closeTo(panel.top + insets.top, 0.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('builds in scrolling and fixed-height column hosts', (
    tester,
  ) async {
    FortalSidebar<DashboardPage> buildPanel() => FortalSidebar(
      sections: _sections,
      selectedValue: DashboardPage.overview,
      onSelected: (_) {},
    );

    await _pumpPage(tester, SingleChildScrollView(child: buildPanel()));
    expect(tester.takeException(), isNull);
    expect(
      find.descendant(
        of: find.byType(RemixSidebar<DashboardPage>),
        matching: find.byType(Scrollable),
      ),
      findsNothing,
    );

    await _pumpPage(
      tester,
      SizedBox(height: 320, child: Column(children: [buildPanel()])),
    );
    expect(tester.takeException(), isNull);
    expect(
      find.descendant(
        of: find.byType(RemixSidebar<DashboardPage>),
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
            child: FortalSidebar<DashboardPage>(
              sections: const [
                RemixSidebarSection(
                  label: 'Workspace',
                  destinations: [
                    RemixSidebarDestination(
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
          child: FortalSidebar<DashboardPage>(
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
    await _pumpSidebar(tester, selectedValue: null);

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

Future<void> _pumpSidebar(
  WidgetTester tester, {
  List<RemixSidebarSection<DashboardPage>> sections = _sections,
  DashboardPage? selectedValue = DashboardPage.overview,
  ValueChanged<DashboardPage>? onSelected,
}) {
  return _pumpPage(
    tester,
    FortalSidebar<DashboardPage>(
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
