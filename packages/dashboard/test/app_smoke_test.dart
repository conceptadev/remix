import 'package:dashboard/main.dart';
import 'package:dashboard/shell/dashboard_shell.dart';
import 'package:dashboard/theme/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets('renders the dashboard inside one app and one shell', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(FortalScope), findsOneWidget);
    expect(find.text('Overview'), findsWidgets);
  });

  testWidgets('compact layout uses a drawer without rendering overflows', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DashboardApp());

    expect(find.byKey(const ValueKey('dashboard-menu')), findsWidgets);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byIcon(Icons.menu));
    for (var frame = 0; frame < 5; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(
      tester.state<ScaffoldState>(find.byType(Scaffold)).isDrawerOpen,
      isTrue,
    );

    await tester.tap(find.byKey(const ValueKey('nav-galleryForms')).first);
    for (var frame = 0; frame < 5; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(
      find.text(
        'Production-ready fields and selection controls in every preset.',
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('customers page renders an interactive paginated grid', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    await tester.tap(find.byKey(const ValueKey('nav-customers')).first);
    await tester.pump();

    expect(find.byKey(const ValueKey('data-grid-customers')), findsOneWidget);
    expect(find.text('1–10 of 24'), findsOneWidget);
  });

  testWidgets('overview presents metrics, activity, and recent orders', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    expect(find.text('\$84,420'), findsOneWidget);
    expect(find.text('Recent activity'), findsOneWidget);
    expect(find.text('Recent orders'), findsOneWidget);
    expect(find.text('View all'), findsOneWidget);
  });

  testWidgets('settings exposes the complete live theme controls', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    await tester.tap(find.byKey(const ValueKey('nav-settings')).first);
    await tester.pump();

    expect(find.byKey(const ValueKey('theme-panel')), findsOneWidget);
    expect(find.text('Accent color'), findsOneWidget);
    expect(find.text('Gray color'), findsOneWidget);
    expect(find.text('Radius'), findsOneWidget);
    expect(find.text('Scaling'), findsOneWidget);
  });

  testWidgets('component gallery pages expose every Fortal family', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    await tester.tap(find.byKey(const ValueKey('nav-galleryActions')).first);
    await tester.pump();

    expect(find.text('Button'), findsWidgets);
    expect(find.text('Icon button'), findsOneWidget);
    expect(find.text('Toggle'), findsOneWidget);
  });

  testWidgets('every sidebar destination renders without replacing the shell', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    const destinations = <String, String>{
      'overview': 'A snapshot of your workspace performance.',
      'customers': 'Manage customer access, plans, and account status.',
      'orders': 'Review transactions and fulfillment status.',
      'settings': 'Manage your profile, preferences, and workspace.',
      'galleryActions':
          'Interactive actions across every Fortal variant and size.',
      'galleryForms':
          'Production-ready fields and selection controls in every preset.',
      'galleryDisplay':
          'Rich surfaces and status components for product interfaces.',
      'galleryOverlays':
          'Real dialog, popover, tooltip, and menu triggers for every recipe.',
      'galleryNavigation':
          'Tabs and disclosure patterns for organizing dense interfaces.',
    };

    for (final entry in destinations.entries) {
      final nav = find.byKey(ValueKey('nav-${entry.key}')).first;
      await tester.ensureVisible(nav);
      await tester.tap(nav);
      await tester.pump();

      expect(find.byType(DashboardShell), findsOneWidget);
      expect(find.text(entry.value), findsOneWidget);
    }
  });

  testWidgets(
    'quick toggle keeps Material and Fortal brightness synchronized',
    (tester) async {
      await tester.pumpWidget(const DashboardApp());
      final shell = tester.element(find.byType(DashboardShell));

      expect(Theme.of(shell).brightness, FortalTheme.of(shell).brightness);
      final before = FortalTheme.of(shell).isDark;

      await tester.tap(find.byKey(const ValueKey('theme-quick-toggle')).first);
      await tester.pump();

      final updatedShell = tester.element(find.byType(DashboardShell));
      expect(FortalTheme.of(updatedShell).isDark, isNot(before));
      expect(
        Theme.of(updatedShell).brightness,
        FortalTheme.of(updatedShell).brightness,
      );
    },
  );

  testWidgets('supports an explicit dark initial theme', (tester) async {
    await tester.pumpWidget(
      const DashboardApp(initialSettings: ThemeSettings(appearance: .dark)),
    );

    final shell = tester.element(find.byType(DashboardShell));
    expect(FortalTheme.of(shell).isDark, isTrue);
    expect(Theme.of(shell).brightness, Brightness.dark);
  });

  testWidgets('theme panel changes the resolved accent live', (tester) async {
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('nav-settings')).first);
    await tester.pump();

    final grass = find.byKey(const ValueKey('accent-grass'));
    await tester.ensureVisible(grass);
    await tester.tap(grass);
    await tester.pump();

    final shell = tester.element(find.byType(DashboardShell));
    expect(FortalTheme.of(shell).accentColor, FortalAccentColor.grass);
  });

  testWidgets('grid sorts, selects the page, and paginates', (tester) async {
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('nav-customers')).first);
    await tester.pump();

    final sortName = find.byKey(const ValueKey('sort-name')).first;
    await tester.tap(sortName);
    await tester.pump();
    await tester.tap(sortName);
    await tester.pump();
    expect(find.text('Sofia Young'), findsOneWidget);

    final selectAll = find.byKey(const ValueKey('grid-select-all')).first;
    await tester.tap(selectAll);
    await tester.pump();
    expect(find.text('10 selected'), findsOneWidget);

    final next = find.byKey(const ValueKey('grid-next')).first;
    await tester.ensureVisible(next);
    await tester.tap(next);
    await tester.pump();
    expect(find.text('11–20 of 24'), findsOneWidget);
  });

  testWidgets('top bar search filters the active data page', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('nav-customers')).first);
    await tester.pump();

    final search = find.byKey(const ValueKey('global-search'));
    expect(search, findsWidgets);
    await tester.enterText(
      find.descendant(of: search, matching: find.byType(EditableText)),
      'northstar',
    );
    await tester.pump();

    expect(find.text('1–1 of 1'), findsOneWidget);
    expect(find.text('Olivia Martin'), findsOneWidget);
  });
}
