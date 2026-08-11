import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

/// A caller-supplied token, standing in for whatever theme package a host uses.
///
/// The point of these tests is that Remix needs no ambient `Overlay` or
/// `Navigator` of its own, and that whatever `MixScope` the caller installs
/// reaches overlay and route content. Neither claim is theme-specific, so this
/// suite deliberately depends on no theme package.
const _hostAccent = ColorToken('test.host.accent');
const _hostAccentValue = Color(0xFF3E63DD);

void main() {
  group('Remix host capabilities', () {
    testWidgets('ordinary widgets need no Overlay or Navigator', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetsHost(
          RemixButton(
            label: 'Continue',
            style: _buttonStyle(),
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Continue'), findsOneWidget);
      expect(find.byType(Overlay), findsNothing);
      expect(find.byType(Navigator), findsNothing);
    });

    group('caller-owned Overlay', () {
      testWidgets('opens a menu without a Navigator', (tester) async {
        await tester.pumpWidget(
          _overlayHost(
            RemixMenu<String>(
              trigger: const RemixMenuTrigger(label: 'Open menu'),
              items: const [RemixMenuItem(value: 'item', label: 'Menu item')],
            ),
          ),
        );

        await tester.tap(find.text('Open menu'));
        await tester.pumpAndSettle();

        _expectScopedOverlayContent(tester, find.text('Menu item'));
      });

      testWidgets('opens a select without a Navigator', (tester) async {
        await tester.pumpWidget(
          _overlayHost(
            RemixSelect<String>(
              trigger: const RemixSelectTrigger(placeholder: 'Open select'),
              items: const [
                RemixSelectItem(value: 'item', label: 'Select item'),
              ],
            ),
          ),
        );

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        _expectScopedOverlayContent(tester, find.text('Select item'));
      });

      testWidgets('opens a popover without a Navigator', (tester) async {
        await tester.pumpWidget(
          _overlayHost(
            const RemixPopover(
              popoverChild: Text('Popover content'),
              child: Text('Open popover'),
            ),
          ),
        );

        await tester.tap(find.text('Open popover'));
        await tester.pumpAndSettle();

        _expectScopedOverlayContent(tester, find.text('Popover content'));
      });

      testWidgets('opens a tooltip without a Navigator', (tester) async {
        await tester.pumpWidget(
          _overlayHost(
            const RemixTooltip(
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

        _expectScopedOverlayContent(tester, find.text('Tooltip content'));
      });
    });

    testWidgets('opens a dialog with a caller-owned Navigator', (tester) async {
      await tester.pumpWidget(
        _navigatorHost(
          Builder(
            builder: (context) => RemixButton(
              label: 'Open dialog',
              style: _buttonStyle(),
              onPressed: () => showRemixDialog<void>(
                context: context,
                transitionDuration: Duration.zero,
                builder: (context) =>
                    const Center(child: RemixDialog(title: 'Dialog title')),
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
      _expectScopeInheritance(tester, dialogTitle);
    });
  });
}

ButtonStyler _buttonStyle() => ButtonStyler()
    .color(_hostAccent())
    .padding(.horizontal(16))
    .padding(.vertical(8));

Widget _hostScope({required Widget child}) {
  return MixScope(tokens: {_hostAccent: _hostAccentValue}, child: child);
}

Widget _widgetsHost(Widget child) {
  return _hostScope(
    child: WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => Center(child: child),
    ),
  );
}

Widget _overlayHost(Widget child) {
  return _hostScope(
    child: WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => Overlay.wrap(child: Center(child: child)),
    ),
  );
}

Widget _navigatorHost(Widget child) {
  return _hostScope(
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

void _expectScopedOverlayContent(WidgetTester tester, Finder content) {
  expect(find.byType(Overlay), findsOneWidget);
  expect(find.byType(Navigator), findsNothing);
  expect(content, findsOneWidget);
  _expectScopeInheritance(tester, content);
}

void _expectScopeInheritance(WidgetTester tester, Finder content) {
  final context = tester.element(content);
  expect(MixScope.maybeOf(context), isNotNull);
  expect(MixScope.tokenOf(_hostAccent, context), _hostAccentValue);
}
