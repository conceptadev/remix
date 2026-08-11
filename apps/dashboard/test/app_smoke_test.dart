import 'dart:ui' as ui;

import 'package:dashboard/main.dart';
import 'package:dashboard/shell/dashboard_shell.dart';
import 'package:dashboard/theme/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('renders the dashboard inside one app and one shell', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(
      find.byKey(const ValueKey('dashboard-fortal-scope')),
      findsOneWidget,
    );
    expect(find.text('Overview'), findsWidgets);
  });

  testWidgets('account surfaces preserve their avatar and profile triggers', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    expect(
      find.byKey(const ValueKey('sidebar-account-trigger')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('topbar-account-trigger')),
      findsOneWidget,
    );
    expect(find.text('Account actions'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('sidebar-account-trigger')));
    await tester.pump();

    expect(find.text('View profile'), findsOneWidget);
    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('Sign out'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('customer rows retain compact kebab actions', (tester) async {
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('nav-customers')).first);
    await tester.pump();

    final trigger = find.byKey(const ValueKey('customer-actions-cus_024'));
    expect(trigger, findsOneWidget);
    expect(tester.getSize(trigger).width, lessThanOrEqualTo(46));

    await tester.ensureVisible(trigger);
    await tester.tap(trigger);
    await tester.pump();

    expect(find.text('View profile'), findsOneWidget);
    expect(find.text('Send email'), findsOneWidget);
    expect(find.text('Archive'), findsOneWidget);
    expect(tester.takeException(), isNull);
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

  testWidgets('compact settings render without horizontal overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byIcon(Icons.menu));
    for (var frame = 0; frame < 5; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    await tester.tap(find.byKey(const ValueKey('nav-settings')).first);
    for (var frame = 0; frame < 5; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(find.byKey(const ValueKey('theme-panel')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sidebar destinations expose one accessible name', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(const DashboardApp());

    final overviewSemantics = find
        .descendant(
          of: find.byKey(const ValueKey('nav-overview')).first,
          matching: find.byType(Semantics),
        )
        .first;
    final overviewNode = tester.getSemantics(overviewSemantics);
    expect(overviewNode.label, 'Overview');

    // A destination is one of a mutually exclusive set, so it must announce
    // `selected` — not the toggled on/off state RemixToggle emits by default.
    final data = overviewNode.getSemanticsData();
    expect(data.hasAction(ui.SemanticsAction.tap), isTrue);
    expect(data.flagsCollection.isSelected, ui.Tristate.isTrue);
    expect(data.flagsCollection.isToggled, ui.Tristate.none);
    semantics.dispose();
  });

  testWidgets('customers page renders an interactive paginated grid', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    await tester.tap(find.byKey(const ValueKey('nav-customers')).first);
    await tester.pump();

    // The generated Fortal wrapper forwards the key to the Remix widget it
    // builds, so the key matches both.
    expect(find.byKey(const ValueKey('data-grid-customers')), findsWidgets);
    expect(find.text('1–10 of 24'), findsOneWidget);
  });

  testWidgets(
    'overview presents metrics, charts, activity, and recent orders',
    (tester) async {
      await tester.pumpWidget(const DashboardApp());

      expect(find.text('\$84,420'), findsOneWidget);
      expect(find.text('Revenue trend'), findsOneWidget);
      expect(find.text('Order volume'), findsOneWidget);
      expect(find.text('Channel mix'), findsOneWidget);
      expect(find.byType(FortalLineChart), findsOneWidget);
      expect(find.byType(FortalBarChart), findsOneWidget);
      expect(find.byType(FortalPieChart), findsOneWidget);
      expect(find.text('Recent activity'), findsOneWidget);
      expect(find.text('Recent orders'), findsOneWidget);
      expect(find.text('View all'), findsOneWidget);
    },
  );

  testWidgets('a status reads the same on every page that shows it', (
    tester,
  ) async {
    // ORD-1045 is refunded and appears in the overview's five-row preview, so
    // an overview-local status mapping would disagree with the orders page.
    await tester.pumpWidget(const DashboardApp());
    expect(find.text('Refunded'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('nav-orders')).first);
    await tester.pump();

    // The filter offers "Refunded" too, so the badge is the second match.
    expect(find.text('Refunded'), findsNWidgets(2));
  });

  testWidgets('settings exposes every live Fortal theme parameter', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    await tester.tap(find.byKey(const ValueKey('nav-settings')).first);
    await tester.pump();

    final panel = find.byKey(const ValueKey('theme-panel'));
    expect(panel, findsOneWidget);
    for (final control in const [
      'Appearance',
      'Accent color',
      'Gray color',
      'Panel background',
      'Radius',
      'Scaling',
    ]) {
      expect(
        find.descendant(of: panel, matching: find.text(control)),
        findsOneWidget,
        reason: control,
      );
    }
  });

  testWidgets('the panel background control reaches the Fortal scope', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('nav-settings')).first);
    await tester.pump();

    final translucent = find.text('Translucent');
    await tester.ensureVisible(translucent);
    await tester.tap(translucent);
    await tester.pump();

    expect(
      FortalTheme.of(
        tester.element(find.byType(DashboardShell)),
      ).panelBackground,
      FortalPanelBackground.translucent,
    );
  });

  testWidgets('the forms gallery covers every Fortal input recipe', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('nav-galleryForms')).first);
    await tester.pump();

    expect(find.byType(FortalTextArea), findsWidgets);
    expect(find.byType(FortalSegmentedControl<String>), findsWidgets);
    expect(find.byType(RemixCheckboxGroupItem<String>), findsNWidgets(3));
    expect(find.text('Labelled'), findsOneWidget);
  });

  testWidgets('the display gallery covers the data list and skeleton', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('nav-galleryDisplay')).first);
    await tester.pump();

    expect(find.byType(FortalDataList), findsWidgets);
    expect(find.byType(FortalSkeleton), findsNWidgets(2));

    await tester.tap(find.text('Show content'));
    await tester.pump();
    expect(
      find.text('Loaded content replaces the placeholder.'),
      findsOneWidget,
    );
  });

  testWidgets('the overlays gallery exposes the compound menu items', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());
    final nav = find.byKey(const ValueKey('nav-galleryOverlays')).first;
    await tester.ensureVisible(nav);
    await tester.tap(nav);
    await tester.pump();

    final trigger = find.text('Open menu').first;
    await tester.ensureVisible(trigger);
    await tester.tap(trigger);
    await tester.pump();

    expect(find.text('Show archived'), findsOneWidget);
    expect(find.text('Newest'), findsOneWidget);
    expect(find.text('Share'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('actions gallery exposes button, icon button, and toggle', (
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
      'charts':
          'Fortal-native chart patterns for comparison, composition, interaction, and empty states.',
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
    expect(FortalTheme.of(shell).accent, FortalAccentColor.grass);
  });

  testWidgets('grid sorts, selects the page, and paginates', (tester) async {
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('nav-customers')).first);
    await tester.pump();

    final sortName = find.text('Customer').first;
    await tester.tap(sortName);
    await tester.pump();
    await tester.tap(sortName);
    await tester.pump();
    expect(find.text('Sofia Young'), findsOneWidget);

    final selectAll = find
        .byKey(const ValueKey('remix-data-table-select-all'))
        .first;
    await tester.tap(selectAll);
    await tester.pump();
    expect(find.text('10 selected'), findsOneWidget);

    final next = find.byKey(const ValueKey('remix-data-table-next-page')).first;
    await tester.ensureVisible(next);
    await tester.tap(next);
    await tester.pump();
    expect(find.text('11–20 of 24'), findsOneWidget);
  });

  testWidgets('grid checkboxes fill their cell around a 14 square', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.byKey(const ValueKey('nav-customers')).first);
    await tester.pump();

    final selectAll = find
        .byKey(const ValueKey('remix-data-table-select-all'))
        .first;
    // The header checkbox comes first, so the next one belongs to row one.
    final rowCheckbox = find.byType(RemixCheckbox).at(1);

    // The interaction target is the selection cell: the 48px column by the
    // Radix size-2 row height, rather than a fixed square that would inflate
    // the row.
    expect(tester.getSize(selectAll), const Size(48, 44));
    expect(tester.getSize(rowCheckbox), const Size(48, 44));
    expect(
      tester.getSize(
        find
            .descendant(of: selectAll, matching: find.byType(DecoratedBox))
            .first,
      ),
      const Size.square(14),
    );
    expect(
      tester.getSize(
        find
            .descendant(of: rowCheckbox, matching: find.byType(DecoratedBox))
            .first,
      ),
      const Size.square(14),
    );
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
