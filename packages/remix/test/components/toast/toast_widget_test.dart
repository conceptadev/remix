import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixToast', () {
    testWidgets('renders title, description, and icon', (tester) async {
      await tester.pumpRemixApp(
        const RemixToast(
          title: 'Draft saved',
          description: 'Stored on this device.',
          icon: Icons.check,
        ),
      );

      expect(find.text('Draft saved'), findsOneWidget);
      expect(find.text('Stored on this device.'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byType(RemixButton), findsNothing);
      expect(find.byType(RemixIconButton), findsNothing);
    });

    testWidgets('composes the action and close button', (tester) async {
      var undone = 0;
      var dismissed = 0;
      await tester.pumpRemixApp(
        RemixToast(
          title: 'Draft saved',
          action: RemixToastAction(label: 'Undo', onPressed: () => undone++),
          onDismiss: () => dismissed++,
          dismissLabel: 'Dismiss notification',
        ),
      );

      await tester.tap(find.widgetWithText(RemixButton, 'Undo'));
      await tester.tap(find.byType(RemixIconButton));

      expect(undone, 1);
      expect(dismissed, 1);
      expect(
        tester
            .widget<RemixIconButton>(find.byType(RemixIconButton))
            .semanticLabel,
        'Dismiss notification',
      );
    });

    testWidgets('keeps a short message at its intrinsic width', (tester) async {
      await tester.pumpRemixApp(const RemixToast(title: 'Saved'));

      expect(
        tester.getSize(find.byType(RemixToast)).width,
        lessThan(tester.getSize(find.byType(Scaffold)).width),
      );
    });

    testWidgets('announces its text unless message semantics are excluded', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(const RemixToast(title: 'Draft saved'));
      expect(find.semantics.byLabel('Draft saved'), findsOne);

      await tester.pumpRemixApp(
        const RemixToast(title: 'Draft saved', excludeMessageSemantics: true),
      );
      expect(find.semantics.byLabel('Draft saved'), findsNothing);
      semantics.dispose();
    });

    testWidgets('passes composed control styles through StyleProvider', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixToast(
          title: 'Draft saved',
          action: RemixToastAction(label: 'Undo', onPressed: () {}),
          style: ToastStyler().action(ButtonStyler().height(44)),
        ),
      );

      expect(tester.getSize(find.byType(RemixButton)).height, 44);
    });

    test('requires a dismiss label with onDismiss', () {
      expect(
        () => RemixToast(title: 'Saved', onDismiss: () {}),
        throwsAssertionError,
      );
    });
  });
}
