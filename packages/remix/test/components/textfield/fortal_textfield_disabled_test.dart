import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

/// Collects every resolved [BoxDecoration] color painted for [finder]'s subtree.
///
/// Behavioral counterpart to grepping the source file: it inspects the styles
/// actually resolved onto the render tree instead of matching raw source text.
List<Color> _renderedDecorationColors(WidgetTester tester, Finder finder) {
  return tester
      .widgetList<DecoratedBox>(
        find.descendant(of: finder, matching: find.byType(DecoratedBox)),
      )
      .map((box) => box.decoration)
      .whereType<BoxDecoration>()
      .map((decoration) => decoration.color)
      .whereType<Color>()
      .toList();
}

List<Color> _renderedSurfaceColors(WidgetTester tester, Finder finder) {
  return tester
      .widgetList<RemixSurface>(
        find.descendant(of: finder, matching: find.byType(RemixSurface)),
      )
      .map((surface) => surface.spec.color)
      .whereType<Color>()
      .toList();
}

void main() {
  testWidgets('fortal textfield factories build real stylers per variant', (
    tester,
  ) async {
    // Drive the real factories rather than asserting on their source text.
    final surface = fortalTextFieldStyler(variant: .surface);
    final soft = fortalTextFieldStyler(variant: .soft);
    expect(surface, isA<RemixTextFieldStyler>());
    expect(soft, isA<RemixTextFieldStyler>());
    expect(soft, isNot(equals(surface)));
  });

  testWidgets(
    'disabled soft textfield resolves a background and never the debug red',
    (tester) async {
      await tester.pumpRemixApp(
        FortalTextField(
          variant: .soft,
          enabled: false,
          controller: TextEditingController(text: 'disabled'),
        ),
      );
      await tester.pumpAndSettle();

      final finder = find.byType(FortalTextField);
      expect(finder, findsOneWidget);

      final colors = [
        ..._renderedDecorationColors(tester, finder),
        ..._renderedSurfaceColors(tester, finder),
      ];

      // The disabled soft variant paints its onDisabled background
      // (FortalTokens.accentA3) — the resolved style tree must carry a color.
      expect(colors, isNotEmpty);

      // Regression guard: the debug `Colors.red` background that once shipped in
      // the disabled soft styling must never resolve onto the tree.
      expect(colors, isNot(contains(Colors.red)));
    },
  );

  testWidgets('fortal textfield disabled soft renders under FortalScope', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      FortalScope(
        child: FortalTextField(
          variant: .soft,
          enabled: false,
          controller: TextEditingController(text: 'disabled'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(FortalTextField), findsOneWidget);
    expect(find.byType(RemixTextField), findsOneWidget);
  });
}
