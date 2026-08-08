import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// The Remix-side host contract (no ambient `Overlay`/`Navigator` required) is
/// covered by `packages/remix/test/host_capabilities_test.dart`. This suite only
/// checks that `FortalScope` is a working `MixScope` in the same positions.
void main() {
  group('FortalScope host capabilities', () {
    testWidgets('ordinary Fortal widgets need no Overlay or Navigator', (
      tester,
    ) async {
      await tester.pumpWidget(
        _fortalHost(FortalButton(label: 'Continue', onPressed: () {})),
      );

      expect(find.text('Continue'), findsOneWidget);
      expect(find.byType(Overlay), findsNothing);
      expect(find.byType(Navigator), findsNothing);
      _expectFortalInheritance(tester, find.text('Continue'));
    });

    testWidgets('reaches overlay content through a caller-owned Overlay', (
      tester,
    ) async {
      await tester.pumpWidget(
        _fortalOverlayHost(
          FortalMenu<String>(
            trigger: const RemixMenuTrigger(label: 'Open menu'),
            items: const [RemixMenuItem(value: 'item', label: 'Menu item')],
          ),
        ),
      );

      await tester.tap(find.text('Open menu'));
      await tester.pumpAndSettle();

      expect(find.byType(Overlay), findsOneWidget);
      expect(find.byType(Navigator), findsNothing);
      _expectFortalInheritance(tester, find.text('Menu item'));
    });
  });
}

Widget _fortalHost(Widget child) {
  return FortalScope(
    brightness: .light,
    child: WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => Center(child: child),
    ),
  );
}

Widget _fortalOverlayHost(Widget child) {
  return FortalScope(
    brightness: .light,
    child: WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => Overlay.wrap(child: Center(child: child)),
    ),
  );
}

void _expectFortalInheritance(WidgetTester tester, Finder content) {
  final context = tester.element(content);
  expect(FortalTheme.maybeOf(context), isNotNull);
  expect(MixScope.maybeOf(context), isNotNull);
  expect(MixScope.tokenOf(FortalTokens.accent9, context), isA<Color>());
}
