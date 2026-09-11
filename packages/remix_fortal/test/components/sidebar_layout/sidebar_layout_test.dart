import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/remix_fortal.dart';

const _sidebarKey = ValueKey('sidebar');
const _bodyKey = ValueKey('body');
const _headerKey = ValueKey('header');

/// Pumps [layout] inside a resizable [width] harness with a real [Navigator]
/// (via [MaterialApp]) and [FortalScope], so `showRemixDialog` and Fortal
/// token resolution both work. [width] changes propagate through
/// [StatefulBuilder] so tests can cross the compact breakpoint mid-test.
Future<StateSetter> _pump(
  WidgetTester tester,
  Widget layout, {
  required double width,
  TextDirection textDirection = TextDirection.ltr,
}) async {
  late StateSetter setState;
  await tester.pumpWidget(
    FortalScope(
      child: MaterialApp(
        // `builder` wraps the Navigator itself, unlike `home`, which is only
        // the initial route's content. `showRemixDialog` pushes a sibling
        // route on the same Navigator, so the compact sheet only inherits a
        // Directionality declared here, not one nested inside `home`.
        builder: (context, child) =>
            Directionality(textDirection: textDirection, child: child!),
        home: StatefulBuilder(
          builder: (context, setter) {
            setState = setter;
            return Align(
              alignment: Alignment.topLeft,
              child: SizedBox(width: width, height: 600, child: layout),
            );
          },
        ),
      ),
    ),
  );
  return setState;
}

Widget _layout({
  bool collapsed = false,
  bool? compactOpen,
  ValueChanged<bool>? onCompactOpenChanged,
  double compactBreakpoint = 720,
}) {
  return FortalSidebarLayout(
    compactBreakpoint: compactBreakpoint,
    collapsed: collapsed,
    compactOpen: compactOpen,
    onCompactOpenChanged: onCompactOpenChanged,
    header: const SizedBox(key: _headerKey, height: 48),
    sidebar: const SizedBox(key: _sidebarKey, child: Text('Sidebar')),
    body: const SizedBox(key: _bodyKey, child: Text('Body')),
  );
}

void main() {
  testWidgets('renders the sidebar inline above the compact breakpoint', (
    tester,
  ) async {
    await _pump(tester, _layout(), width: 900);

    expect(find.byKey(_sidebarKey), findsOneWidget);
    expect(find.byKey(_bodyKey), findsOneWidget);
    expect(find.byKey(_headerKey), findsOneWidget);
  });

  testWidgets('hides the sidebar row below the compact breakpoint', (
    tester,
  ) async {
    await _pump(tester, _layout(), width: 500);

    expect(find.byKey(_sidebarKey), findsNothing);
    expect(find.byKey(_bodyKey), findsOneWidget);
    expect(find.byKey(_headerKey), findsOneWidget);
  });

  testWidgets('switches presentation when resized across the breakpoint', (
    tester,
  ) async {
    final width = ValueNotifier<double>(900);
    await tester.pumpWidget(
      FortalScope(
        child: MaterialApp(
          home: ValueListenableBuilder<double>(
            valueListenable: width,
            builder: (context, value, _) => Align(
              alignment: Alignment.topLeft,
              child: SizedBox(width: value, height: 600, child: _layout()),
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(_sidebarKey), findsOneWidget);

    width.value = 500;
    await tester.pumpAndSettle();

    expect(find.byKey(_sidebarKey), findsNothing);

    width.value = 900;
    await tester.pumpAndSettle();

    expect(find.byKey(_sidebarKey), findsOneWidget);
  });

  testWidgets('collapsed shrinks the wide-mode panel to collapsedWidth', (
    tester,
  ) async {
    final collapsed = ValueNotifier<bool>(false);
    await tester.pumpWidget(
      FortalScope(
        child: MaterialApp(
          home: ValueListenableBuilder<bool>(
            valueListenable: collapsed,
            builder: (context, value, _) => Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 900,
                height: 600,
                child: _layout(collapsed: value),
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byKey(_sidebarKey)).width, 256);

    collapsed.value = true;
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byKey(_sidebarKey)).width, 72);

    collapsed.value = false;
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byKey(_sidebarKey)).width, 256);
  });

  testWidgets('opens the compact sheet through the scope', (tester) async {
    late BuildContext scopeContext;
    await _pump(
      tester,
      FortalSidebarLayout(
        header: Builder(
          builder: (context) {
            scopeContext = context;
            return TextButton(
              onPressed: () =>
                  FortalSidebarLayoutScope.of(context).openCompact(),
              child: const Text('Open nav'),
            );
          },
        ),
        sidebar: const SizedBox(key: _sidebarKey, child: Text('Sidebar')),
        body: const SizedBox(key: _bodyKey, child: Text('Body')),
      ),
      width: 500,
    );

    expect(FortalSidebarLayoutScope.of(scopeContext).isCompact, isTrue);
    expect(find.byKey(_sidebarKey), findsNothing);

    await tester.tap(find.text('Open nav'));
    await tester.pumpAndSettle();

    expect(find.byKey(_sidebarKey), findsOneWidget);
  });

  testWidgets('closes the compact sheet through the scope', (tester) async {
    bool? lastOpen;
    await _pump(
      tester,
      _layout(
        compactOpen: true,
        onCompactOpenChanged: (value) => lastOpen = value,
      ),
      width: 500,
    );
    await tester.pumpAndSettle();
    expect(find.byKey(_sidebarKey), findsOneWidget);

    // The destination lives inside the sheet's own route, which is not a
    // descendant of the layout's main subtree. The scope must still resolve
    // there so a destination's onSelected can close the sheet after
    // navigating.
    FortalSidebarLayoutScope.of(
      tester.element(find.byKey(_sidebarKey)),
    ).closeCompact();
    await tester.pumpAndSettle();

    expect(lastOpen, isFalse);
  });

  testWidgets('Escape dismisses the compact sheet', (tester) async {
    bool? lastOpen;
    await _pump(
      tester,
      _layout(
        compactOpen: true,
        onCompactOpenChanged: (value) => lastOpen = value,
      ),
      width: 500,
    );
    await tester.pumpAndSettle();
    expect(find.byKey(_sidebarKey), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    expect(find.byKey(_sidebarKey), findsNothing);
    expect(lastOpen, isFalse);
  });

  testWidgets('tapping the barrier dismisses the compact sheet', (
    tester,
  ) async {
    await _pump(tester, _layout(compactOpen: true), width: 500);
    await tester.pumpAndSettle();
    expect(find.byKey(_sidebarKey), findsOneWidget);

    // The sheet is pinned to the start edge and only spans part of the
    // width; tap the far end, which is uncovered barrier.
    await tester.tapAt(const Offset(490, 300));
    await tester.pumpAndSettle();

    expect(find.byKey(_sidebarKey), findsNothing);
  });

  testWidgets('an uncontrolled layout manages its own compact-open state', (
    tester,
  ) async {
    bool? lastNotified;
    await _pump(
      tester,
      _layout(onCompactOpenChanged: (value) => lastNotified = value),
      width: 500,
    );

    final scopeContext = tester.element(find.byKey(_bodyKey));
    FortalSidebarLayoutScope.of(scopeContext).openCompact();
    await tester.pumpAndSettle();

    expect(find.byKey(_sidebarKey), findsOneWidget);
    expect(lastNotified, isTrue);
  });

  testWidgets('the compact sheet sits at the start edge in LTR', (
    tester,
  ) async {
    await _pump(
      tester,
      _layout(compactOpen: true),
      width: 500,
      textDirection: TextDirection.ltr,
    );
    await tester.pumpAndSettle();

    final rect = tester.getRect(find.byKey(_sidebarKey));
    expect(rect.left, 0);
  });

  testWidgets('the compact sheet sits at the start edge in RTL', (
    tester,
  ) async {
    await _pump(
      tester,
      _layout(compactOpen: true),
      width: 500,
      textDirection: TextDirection.rtl,
    );
    await tester.pumpAndSettle();

    final rect = tester.getRect(find.byKey(_sidebarKey));
    // The layout's own available width is 500 (the SizedBox), but the
    // dialog route renders relative to the full test surface; the sheet
    // must still hug whichever edge is the *start* edge, i.e. the surface's
    // right edge under RTL.
    final surfaceWidth =
        tester.view.physicalSize.width / tester.view.devicePixelRatio;
    expect(rect.right, surfaceWidth);
  });

  test('ships no Material import', () {
    final source = File(
      'lib/src/components/sidebar_layout.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('package:flutter/material.dart')));
    expect(source, isNot(contains("import 'package:flutter/material")));
  });
}
