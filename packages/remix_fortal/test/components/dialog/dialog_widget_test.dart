import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('default style constrains the dialog to 600 pixels', (
    tester,
  ) async {
    final resolved = await resolveInFortalScope(
      tester,
      (context) => fortalDialogStyle().build(context),
    );

    expect(
      resolved.spec.container.spec.constraints,
      const BoxConstraints(maxWidth: 600),
    );
  });

  test('public contract has the pinned align order and default', () {
    const dialog = FortalDialog(title: 'Defaults');

    expect(FortalDialogAlign.values, const [
      FortalDialogAlign.start,
      FortalDialogAlign.center,
    ]);
    expect(dialog.align, FortalDialogAlign.center);
  });

  testWidgets('default alignment centers the rendered surface', (tester) async {
    await tester.pumpRemixApp(
      const SizedBox.expand(child: FortalDialog(title: 'Centered')),
    );
    await tester.pumpAndSettle();

    final align = find.descendant(
      of: find.byType(RemixDialog),
      matching: find.byType(Align),
    );
    expect(align, findsOneWidget);
    expect(tester.widget<Align>(align).alignment, Alignment.center);
  });

  testWidgets('start alignment places the rendered surface at the top', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      const SizedBox.expand(
        child: FortalDialog(
          align: FortalDialogAlign.start,
          title: 'Start aligned',
        ),
      ),
    );
    await tester.pumpAndSettle();

    final align = find.descendant(
      of: find.byType(RemixDialog),
      matching: find.byType(Align),
    );
    expect(align, findsOneWidget);
    expect(tester.widget<Align>(align).alignment, Alignment.topCenter);
  });

  testWidgets('bounded large-text structured content does not overflow', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final bodyFocus = FocusNode(debugLabel: 'final environment variable');
    final actionFocus = FocusNode(debugLabel: 'save environment');
    addTearDown(bodyFocus.dispose);
    addTearDown(actionFocus.dispose);

    try {
      await tester.pumpRemixApp(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: SizedBox(
            width: 400,
            height: 320,
            child: FortalDialog(
              title: 'Environment',
              description: 'Variables available to this workspace.',
              scrollable: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  8,
                  (index) => index == 7
                      ? TextButton(
                          focusNode: bodyFocus,
                          onPressed: () {},
                          child: const Text('Environment variable 8'),
                        )
                      : Text('Environment variable ${index + 1}'),
                ),
              ),
              actions: [
                IconButton(
                  key: const ValueKey('save-environment-action'),
                  focusNode: actionFocus,
                  tooltip: 'Save environment',
                  onPressed: () {},
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(
        tester.widget<FortalDialog>(find.byType(FortalDialog)).scrollable,
        isTrue,
      );
      expect(
        tester.widget<RemixDialog>(find.byType(RemixDialog)).scrollable,
        isTrue,
      );

      final scrollView = find.byType(SingleChildScrollView);
      final action = find.byKey(const ValueKey('save-environment-action'));
      expect(scrollView, findsOneWidget);
      expect(
        find.descendant(of: scrollView, matching: find.text('Environment')),
        findsNothing,
      );
      expect(find.descendant(of: scrollView, matching: action), findsNothing);

      final scrollable = find.descendant(
        of: scrollView,
        matching: find.byType(Scrollable),
      );
      final position = tester.state<ScrollableState>(scrollable).position;
      final actionY = tester.getTopLeft(action).dy;
      expect(position.maxScrollExtent, greaterThan(0));

      await tester.drag(scrollView, const Offset(0, -1000));
      await tester.pumpAndSettle();

      expect(position.pixels, greaterThan(0));
      expect(tester.getTopLeft(action).dy, closeTo(actionY, 0.01));
      expect(find.bySemanticsLabel('Environment variable 8'), findsOneWidget);
      expect(
        tester.getSemantics(action),
        isSemantics(
          tooltip: 'Save environment',
          isButton: true,
          hasTapAction: true,
        ),
      );

      bodyFocus.requestFocus();
      await tester.pumpAndSettle();
      expect(bodyFocus.hasFocus, isTrue);

      for (var attempt = 0; attempt < 2 && !actionFocus.hasFocus; attempt++) {
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pumpAndSettle();
      }
      expect(actionFocus.hasFocus, isTrue);
    } finally {
      semantics.dispose();
    }
  });
}
