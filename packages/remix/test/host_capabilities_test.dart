import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('Remix host capabilities', () {
    testWidgets('ordinary Fortal widgets need no Overlay or Navigator', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetsHost(FortalButton(label: 'Continue', onPressed: () {})),
      );

      expect(find.text('Continue'), findsOneWidget);
      expect(find.byType(Overlay), findsNothing);
      expect(find.byType(Navigator), findsNothing);
    });

    group('caller-owned Overlay', () {
      testWidgets('opens a Fortal menu without a Navigator', (tester) async {
        await tester.pumpWidget(
          _overlayHost(
            FortalMenu<String>(
              trigger: const RemixMenuTrigger(label: 'Open menu'),
              items: const [RemixMenuItem(value: 'item', label: 'Menu item')],
            ),
          ),
        );

        await tester.tap(find.text('Open menu'));
        await tester.pumpAndSettle();

        _expectThemedOverlayContent(tester, find.text('Menu item'));
      });

      testWidgets('opens a Fortal select without a Navigator', (tester) async {
        await tester.pumpWidget(
          _overlayHost(
            FortalSelect<String>(
              trigger: const RemixSelectTrigger(placeholder: 'Open select'),
              items: const [
                RemixSelectItem(value: 'item', label: 'Select item'),
              ],
            ),
          ),
        );

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        _expectThemedOverlayContent(tester, find.text('Select item'));
      });

      testWidgets('opens a Fortal popover without a Navigator', (tester) async {
        await tester.pumpWidget(
          _overlayHost(
            const FortalPopover(
              popoverChild: Text('Popover content'),
              child: Text('Open popover'),
            ),
          ),
        );

        await tester.tap(find.text('Open popover'));
        await tester.pumpAndSettle();

        _expectThemedOverlayContent(tester, find.text('Popover content'));
      });

      testWidgets('opens a Fortal tooltip without a Navigator', (tester) async {
        await tester.pumpWidget(
          _overlayHost(
            const FortalTooltip(
              tooltipChild: Text('Tooltip content'),
              child: Text('Hover target'),
            ),
          ),
        );

        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(location: Offset.zero);
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('Hover target')));
        await tester.pump(const Duration(milliseconds: 200));
        await tester.pumpAndSettle();

        _expectThemedOverlayContent(tester, find.text('Tooltip content'));
      });
    });

    testWidgets('opens a dialog with a caller-owned Navigator', (tester) async {
      await tester.pumpWidget(
        _navigatorHost(
          Builder(
            builder: (context) => FortalButton(
              label: 'Open dialog',
              onPressed: () => showRemixDialog<void>(
                context: context,
                transitionDuration: Duration.zero,
                builder: (context) =>
                    const Center(child: FortalDialog(title: 'Dialog title')),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Navigator), findsOneWidget);

      await tester.tap(find.text('Open dialog'));
      await tester.pump();
      await tester.pump();

      final dialogTitle = find.text('Dialog title');
      expect(dialogTitle, findsOneWidget);
      _expectFortalInheritance(tester, dialogTitle);
    });
  });
}

Widget _widgetsHost(Widget child) {
  return FortalScope(
    brightness: .light,
    child: WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => Center(child: child),
    ),
  );
}

Widget _overlayHost(Widget child) {
  return FortalScope(
    brightness: .light,
    child: WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => Overlay.wrap(child: Center(child: child)),
    ),
  );
}

Widget _navigatorHost(Widget child) {
  return FortalScope(
    brightness: .light,
    child: WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => Navigator(
        onGenerateRoute: (settings) => PageRouteBuilder<void>(
          settings: settings,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          pageBuilder: (_, _, _) => Center(child: child),
        ),
      ),
    ),
  );
}

void _expectThemedOverlayContent(WidgetTester tester, Finder content) {
  expect(find.byType(Overlay), findsOneWidget);
  expect(find.byType(Navigator), findsNothing);
  expect(content, findsOneWidget);
  _expectFortalInheritance(tester, content);
}

void _expectFortalInheritance(WidgetTester tester, Finder content) {
  final context = tester.element(content);
  expect(FortalTheme.maybeOf(context), isNotNull);
  expect(MixScope.maybeOf(context), isNotNull);
  expect(MixScope.tokenOf(FortalTokens.accent9, context), isA<Color>());
}
