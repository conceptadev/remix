import 'package:dashboard/main.dart';
import 'package:dashboard/pages/overview_page.dart';
import 'package:dashboard/pages/settings_page.dart';
import 'package:dashboard/shell/dashboard_shell_layout.dart';
import 'package:dashboard/shell/top_bar.dart';
import 'package:dashboard/theme/theme_scope.dart';
import 'package:dashboard/theme/theme_settings.dart';
import 'package:dashboard/widgets/analytics_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('shell switches to the drawer strictly below 720 pixels', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    tester.view.physicalSize = const Size(720, 800);
    await tester.pumpWidget(const DashboardApp());
    expect(tester.widget<Scaffold>(find.byType(Scaffold)).drawer, isNull);
    expect(find.byKey(const ValueKey('dashboard-menu')), findsNothing);

    tester.view.physicalSize = const Size(719, 800);
    await tester.pumpWidget(const DashboardApp());
    expect(tester.widget<Scaffold>(find.byType(Scaffold)).drawer, isNotNull);
    expect(find.byKey(const ValueKey('dashboard-menu')), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shell headers align in the sidebar and compact drawer', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    void expectAligned() {
      final brand = tester.getRect(
        find.byKey(const ValueKey('dashboard-brand')),
      );
      final topBar = tester.getRect(find.byType(TopBar));

      expect(brand.height, dashboardShellHeaderHeight);
      expect(topBar.height, dashboardShellHeaderHeight);
      expect(brand.top, closeTo(topBar.top, 0.01));
      expect(brand.bottom, closeTo(topBar.bottom, 0.01));
    }

    tester.view.physicalSize = const Size(1000, 800);
    await tester.pumpWidget(const DashboardApp());
    expectAligned();

    tester.view.physicalSize = const Size(390, 844);
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('dashboard-menu')).first);
    for (var frame = 0; frame < 5; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expectAligned();
  });

  testWidgets('overview metrics collapse 4 to 2 to 1 and stretch in-row', (
    tester,
  ) async {
    final wide = await _pumpOverview(tester, width: 1200);
    expect(wide[1].top, closeTo(wide[0].top, 0.5));
    expect(wide[2].top, closeTo(wide[0].top, 0.5));
    expect(wide[3].top, closeTo(wide[0].top, 0.5));
    expect(wide[0].height, closeTo(wide[3].height, 0.5));

    final medium = await _pumpOverview(tester, width: 800);
    expect(medium[1].top, closeTo(medium[0].top, 0.5));
    expect(medium[2].top, greaterThan(medium[0].bottom));
    expect(medium[3].top, closeTo(medium[2].top, 0.5));
    expect(medium[2].height, closeTo(medium[3].height, 0.5));
    expect(medium[3].height, greaterThan(medium[0].height));

    final compact = await _pumpOverview(tester, width: 500);
    expect(compact[1].top, greaterThan(compact[0].bottom));
    expect(compact[2].top, greaterThan(compact[1].bottom));
    expect(compact[3].top, greaterThan(compact[2].bottom));
    expect(compact[3].height, greaterThan(compact[0].height));
    expect(tester.takeException(), isNull);
  });

  testWidgets('activity and recent orders sit side-by-side then stack', (
    tester,
  ) async {
    await _pumpOverview(tester, width: 1050);
    final wideActivity = _cardAround(tester, find.text('Recent activity'));
    final wideOrders = _cardAround(tester, find.text('Recent orders'));
    expect(wideOrders.top, closeTo(wideActivity.top, 0.5));
    expect(wideOrders.height, closeTo(wideActivity.height, 0.5));
    expect(wideOrders.left, greaterThan(wideActivity.right));

    await _pumpOverview(tester, width: 1049);
    final stackedActivity = _cardAround(tester, find.text('Recent activity'));
    final stackedOrders = _cardAround(tester, find.text('Recent orders'));
    expect(stackedOrders.top, greaterThan(stackedActivity.bottom));
    expect(stackedOrders.left, closeTo(stackedActivity.left, 0.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('settings profile fields sit side-by-side then stack', (
    tester,
  ) async {
    Rect field(String label) => tester.getRect(
      find
          .ancestor(
            of: find.text(label),
            matching: find.byType(FortalTextField),
          )
          .first,
    );

    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ThemeScope(
        settings: const ThemeSettings(),
        onChanged: (_) {},
        child: const FortalScope(child: MaterialApp(home: SettingsPage())),
      ),
    );
    final wideName = field('Name');
    final wideEmail = field('Email');
    expect(wideEmail.top, closeTo(wideName.top, 0.5));
    expect(wideEmail.left, greaterThan(wideName.right));

    tester.view.physicalSize = const Size(500, 1600);
    await tester.pumpWidget(
      ThemeScope(
        settings: const ThemeSettings(),
        onChanged: (_) {},
        child: const FortalScope(child: MaterialApp(home: SettingsPage())),
      ),
    );
    final stackedName = field('Name');
    final stackedEmail = field('Email');
    expect(stackedEmail.top, greaterThan(stackedName.bottom));
    expect(stackedEmail.left, closeTo(stackedName.left, 0.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'overview chart cells stretch in a row and size rows to content',
    (tester) async {
      tester.view.physicalSize = const Size(1400, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      Future<List<Rect>> pumpAt(double width) async {
        await tester.pumpWidget(
          FortalScope(
            child: MaterialApp(
              home: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(width: width, child: const AnalyticsCharts()),
              ),
            ),
          ),
        );
        return [
          _cardAround(tester, find.text('Revenue trend')),
          _cardAround(tester, find.text('Order volume')),
          _cardAround(tester, find.text('Channel mix')),
        ];
      }

      final wide = await pumpAt(1200);
      expect(wide[1].top, closeTo(wide[0].top, 0.5));
      expect(wide[2].top, closeTo(wide[0].top, 0.5));
      expect(wide[1].height, closeTo(wide[0].height, 0.5));
      expect(wide[2].height, closeTo(wide[0].height, 0.5));

      final compact = await pumpAt(700);
      expect(compact[1].top, greaterThan(compact[0].bottom));
      expect(compact[2].top, greaterThan(compact[1].bottom));
      expect(compact[1].height, greaterThan(compact[0].height));
      expect(tester.takeException(), isNull);
    },
  );
}

Future<List<Rect>> _pumpOverview(
  WidgetTester tester, {
  required double width,
}) async {
  tester.view.physicalSize = Size(width, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    FortalScope(
      child: MaterialApp(home: OverviewPage(onViewOrders: () {})),
    ),
  );
  return [
    _cardAround(tester, find.text('Revenue')),
    _cardAround(tester, find.text('Active customers')),
    _cardAround(tester, find.text('Open orders')),
    _cardAround(tester, find.text('Fulfillment')),
  ];
}

Rect _cardAround(WidgetTester tester, Finder label) {
  return tester.getRect(
    find.ancestor(of: label, matching: find.byType(FortalCard)).first,
  );
}
