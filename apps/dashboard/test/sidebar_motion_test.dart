import 'dart:io';
import 'dart:ui' as ui;

import 'package:dashboard/main.dart';
import 'package:dashboard/shell/sidebar.dart';
import 'package:dashboard/shell/top_bar.dart';
import 'package:dashboard/theme/theme_settings.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

final _captureKey = GlobalKey();

void main() {
  Future<void> mount(
    WidgetTester tester, {
    Size size = const Size(1280, 900),
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      RepaintBoundary(key: _captureKey, child: const DashboardApp()),
    );
    await tester.pump(const Duration(seconds: 1));
  }

  final toggle = find.byKey(const ValueKey('dashboard-sidebar-toggle')).first;
  double width(WidgetTester tester) =>
      tester.getSize(find.byType(Sidebar)).width;

  testWidgets(
    'toolbar actions stay at the trailing edge with usable navigation targets',
    (tester) async {
      await mount(tester);
      for (final collapsed in [false, true]) {
        if (collapsed) {
          await tester.tap(toggle);
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 216));
        }
        final bar = tester.getRect(find.byType(TopBar));
        final account = tester.getRect(
          find.byKey(const ValueKey('topbar-account-trigger')),
        );
        expect(account.right, closeTo(bar.right - 24, .01));
        // The bottom divider consumes one pixel of the 64px header.
        expect(account.center.dy, closeTo(bar.center.dy - .5, .01));
        expect(tester.getSize(toggle).width, greaterThanOrEqualTo(40));
        expect(tester.getSize(toggle).height, greaterThanOrEqualTo(40));
      }
      tester.view.physicalSize = const Size(390, 844);
      await tester.pump();
      final menu = find.byKey(const ValueKey('dashboard-menu')).first;
      expect(tester.getSize(menu).width, greaterThanOrEqualTo(40));
      expect(
        tester
            .getRect(find.byKey(const ValueKey('topbar-account-trigger')))
            .right,
        closeTo(390 - 12, .01),
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('collapsed account avatar stays centered across theme scales', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    for (final scaling in FortalScaling.values) {
      await tester.pumpWidget(
        DashboardApp(
          key: ValueKey(scaling),
          initialSettings: ThemeSettings(scaling: scaling),
        ),
      );
      await tester.tap(toggle);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 216));
      final trigger = find.byKey(const ValueKey('sidebar-account-trigger'));
      final avatar = find.descendant(
        of: trigger,
        matching: find.byType(FortalAvatar),
      );
      expect(
        tester.getCenter(avatar).dx,
        closeTo(tester.getCenter(trigger).dx, .01),
      );
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets(
    'desktop animates in both directions with usable targets and stable focus',
    (tester) async {
      await mount(tester);
      expect(width(tester), 256);
      final iconFocus = Focus.of(
        tester.element(
          find.descendant(of: toggle, matching: find.byType(Icon)).first,
        ),
      );
      final buttonFocus = iconFocus.canRequestFocus
          ? iconFocus
          : iconFocus.ancestors.firstWhere((node) => node.canRequestFocus);
      buttonFocus.requestFocus();
      await tester.pump();
      await _capture(tester, 'desktop-expanded');
      for (final collapsed in [true, false]) {
        await tester.tap(toggle);
        await tester.pump();
        await tester.pump();
        final focused = FocusManager.instance.primaryFocus;
        var elapsed = 0;
        var previous = width(tester);
        for (final time in [16, 50, 100, 150, 199, 200, 216]) {
          await tester.pump(Duration(milliseconds: time - elapsed));
          elapsed = time;
          final current = width(tester);
          expect(current, inInclusiveRange(72.0, 256.0));
          expect(
            current,
            collapsed
                ? lessThanOrEqualTo(previous)
                : greaterThanOrEqualTo(previous),
          );
          final panel = tester.getRect(find.byType(Sidebar));
          expect(
            tester.getRect(find.byType(TopBar)).left,
            closeTo(panel.right, .01),
          );
          expect(FocusManager.instance.primaryFocus, same(focused));
          final account = tester.getRect(
            find.byKey(const ValueKey('sidebar-account-trigger')),
          );
          expect(account.width, greaterThanOrEqualTo(48));
          expect(account.height, greaterThanOrEqualTo(48));
          expect(tester.takeException(), isNull);
          if (time == 100) {
            await _capture(
              tester,
              collapsed ? 'collapse-middle' : 'expand-middle',
            );
          }
          previous = current;
        }
        expect(width(tester), collapsed ? 72 : 256);
        if (collapsed) {
          expect(find.text('leo@remix.dev'), findsNothing);
          await _capture(tester, 'desktop-collapsed');
        }
      }
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 216));
      expect(width(tester), 72);
    },
  );

  testWidgets(
    'collapsed account actions and page selection remain functional',
    (tester) async {
      await mount(tester);
      await tester.tap(toggle);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pump(const Duration(milliseconds: 250));
      await tester.tap(find.byKey(const ValueKey('sidebar-account-trigger')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.text('View profile'), findsOneWidget);
      await _capture(tester, 'collapsed-account');
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      await tester.tap(
        find.descendant(
          of: find.byType(Sidebar),
          matching: find.byIcon(Icons.people_outline),
        ),
      );
      await tester.pump();
      expect(tester.widget<TopBar>(find.byType(TopBar)).page.name, 'customers');
      expect(width(tester), 72);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'breakpoint interruptions use an expanded drawer and restore desktop preference',
    (tester) async {
      await mount(tester);
      await tester.tap(toggle);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      tester.view.physicalSize = const Size(719, 900);
      await tester.pump();
      expect(
        find.byKey(const ValueKey('dashboard-sidebar-toggle')),
        findsNothing,
      );
      final menu = find.byKey(const ValueKey('dashboard-menu'));
      await tester.tap(menu.first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(width(tester), 256);
      await _capture(tester, 'mobile-drawer');
      await tester.tap(find.text('Customers').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(
        tester.state<ScaffoldState>(find.byType(Scaffold)).isDrawerOpen,
        isFalse,
      );
      for (final breakpoint in [720.0, 721.0]) {
        tester.view.physicalSize = Size(breakpoint, 900);
        await tester.pump();
        expect(width(tester), 72);
        expect(toggle, findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    },
  );

  testWidgets(
    'short-viewport collapse preserves scroll position within valid extent',
    (tester) async {
      await mount(tester, size: const Size(1100, 500));
      final scroll = find.descendant(
        of: find.byType(Sidebar),
        matching: find.byType(Scrollable),
      );
      await tester.drag(scroll, const Offset(0, -230));
      await tester.pump(const Duration(milliseconds: 200));
      final position = tester.state<ScrollableState>(scroll).position;
      final before = position.pixels;
      expect(before, greaterThan(0));
      await tester.tap(toggle);
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 216));
      expect(
        position.pixels,
        closeTo(
          before.clamp(position.minScrollExtent, position.maxScrollExtent),
          .1,
        ),
      );
      expect(tester.takeException(), isNull);
    },
  );
}

Future<void> _capture(WidgetTester tester, String name) async {
  final path = Platform.environment['SIDEBAR_CAPTURE_DIR'];
  if (path == null) return;
  final boundary =
      _captureKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage();
    try {
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      await Directory(path).create(recursive: true);
      await File('$path/$name.png').writeAsBytes(bytes!.buffer.asUint8List());
    } finally {
      image.dispose();
    }
  });
}
