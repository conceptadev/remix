import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playground/ui/ui.dart';

/// Covers the compact behavior of the application-owned sidebar layout.
///
/// This is the only default-preset component that opens a route, owns a
/// breakpoint, and has a controlled/uncontrolled contract, so it is the one
/// whose behavior an analyzer cannot vouch for. Nothing outside `lib/ui/`
/// imports the installed mirror, so before this it was never built.
/// The compact sheet's own barrier, matched by the label the layout gives it.
///
/// `ModalBarrier` alone will not do: the host route MaterialApp pushes for
/// `home` always has one, so a bare type finder reports a sheet that is not
/// there.
final _sheetBarrier = find.byWidgetPredicate(
  (widget) =>
      widget is ModalBarrier && widget.semanticsLabel == 'Close navigation',
);

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  Size size = const Size(1000, 800),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  // MaterialApp, not WidgetsApp: the compact sheet is a pushed route, so this
  // needs a Navigator and an Overlay above the layout.
  await tester.pumpWidget(
    MaterialApp(
      home: PlaygroundThemeScope(
        data: const PlaygroundThemeData.light(),
        child: child,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a wide layout shows the panel beside the body', (tester) async {
    await _pump(
      tester,
      const PlaygroundSidebarLayout(
        sidebar: Text('nav'),
        body: Text('content'),
      ),
    );

    expect(find.text('nav'), findsOneWidget);
    expect(find.text('content'), findsOneWidget);
    // The panel is in the row, so nothing was pushed over the body.
    expect(_sheetBarrier, findsNothing);
  });

  testWidgets('a compact layout drops the panel until it is opened', (
    tester,
  ) async {
    await _pump(
      tester,
      const PlaygroundSidebarLayout(
        sidebar: Text('nav'),
        body: Text('content'),
      ),
      // Below the 720 logical-pixel default breakpoint.
      size: const Size(500, 800),
    );

    expect(find.text('content'), findsOneWidget);
    expect(find.text('nav'), findsNothing);
  });

  testWidgets('a controlled compact sheet opens and closes with its host', (
    tester,
  ) async {
    Widget build({required bool open}) => PlaygroundSidebarLayout(
      compactOpen: open,
      sidebar: const Text('nav'),
      body: const Text('content'),
    );

    await _pump(tester, build(open: false), size: const Size(500, 800));
    expect(find.text('nav'), findsNothing);

    await tester.pumpWidget(
      MaterialApp(
        home: PlaygroundThemeScope(
          data: const PlaygroundThemeData.light(),
          child: build(open: true),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('nav'), findsOneWidget);
    expect(_sheetBarrier, findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        home: PlaygroundThemeScope(
          data: const PlaygroundThemeData.light(),
          child: build(open: false),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('nav'), findsNothing);
    expect(_sheetBarrier, findsNothing);
  });

  testWidgets('growing past the breakpoint retires the open sheet', (
    tester,
  ) async {
    final requests = <bool>[];
    Widget build() => PlaygroundSidebarLayout(
      compactOpen: true,
      onCompactOpenChanged: requests.add,
      sidebar: const Text('nav'),
      body: const Text('content'),
    );

    await _pump(tester, build(), size: const Size(500, 800));
    expect(find.text('nav'), findsOneWidget);
    requests.clear();

    tester.view.physicalSize = const Size(1000, 800);
    await tester.pumpAndSettle();

    // The panel is back in the row and not also left behind in a sheet, and the
    // layout told its host the open state it is still being handed is stale.
    expect(find.text('nav'), findsOneWidget);
    expect(_sheetBarrier, findsNothing);
    expect(requests, contains(false));
  });
}
