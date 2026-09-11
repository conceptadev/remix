import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets(
    'controlled visibility requests need acceptance and preserve trigger focus',
    (tester) async {
      final focus = FocusNode();
      final open = ValueNotifier(false);
      final requests = <bool>[];
      var dismissed = 0;
      addTearDown(focus.dispose);
      addTearDown(open.dispose);
      await tester.pumpWidget(
        MaterialApp(
          home: ValueListenableBuilder<bool>(
            valueListenable: open,
            builder: (context, value, _) => Actions(
              actions: {
                DismissIntent: CallbackAction<DismissIntent>(
                  onInvoke: (_) {
                    dismissed++;
                    return null;
                  },
                ),
              },
              child: RemixTooltip(
                open: value,
                onOpenChanged: requests.add,
                tooltipChild: const Text('Tooltip content'),
                child: RemixButton(
                  focusNode: focus,
                  label: 'Trigger',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      );
      focus.requestFocus();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 301));
      expect(requests, [true]);
      expect(find.text('Tooltip content'), findsNothing);
      open.value = true;
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Tooltip content'), findsOneWidget);
      expect(focus.hasFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      expect(requests, [true, false]);
      expect(dismissed, 0);
      open.value = false;
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Tooltip content'), findsNothing);
      expect(focus.hasFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      expect(dismissed, 1);
      expect(focus.hasFocus, isTrue);
    },
  );

  testWidgets(
    'closed controlled tooltip delegates Escape to the enclosing dismiss action',
    (tester) async {
      final focus = FocusNode();
      addTearDown(focus.dispose);
      var dismissed = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Actions(
            actions: {
              DismissIntent: CallbackAction<DismissIntent>(
                onInvoke: (_) {
                  dismissed++;
                  return null;
                },
              ),
            },
            child: RemixTooltip(
              open: false,
              tooltipChild: const Text('Tooltip content'),
              child: RemixButton(
                focusNode: focus,
                label: 'Trigger',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      focus.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      expect(dismissed, 1);
    },
  );
  testWidgets('closed tooltip delegates only unmodified Escape', (
    tester,
  ) async {
    final focus = FocusNode();
    addTearDown(focus.dispose);
    var dismissed = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Actions(
          actions: {
            DismissIntent: CallbackAction<DismissIntent>(
              onInvoke: (_) {
                dismissed++;
                return null;
              },
            ),
          },
          child: RemixTooltip(
            open: false,
            tooltipChild: const Text('Tooltip content'),
            child: RemixButton(
              focusNode: focus,
              label: 'Trigger',
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
    focus.requestFocus();
    await tester.pump();
    for (final modifier in [
      LogicalKeyboardKey.controlLeft,
      LogicalKeyboardKey.altLeft,
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.metaLeft,
    ]) {
      await tester.sendKeyDownEvent(modifier);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.sendKeyUpEvent(modifier);
      expect(dismissed, 0, reason: modifier.debugName);
    }
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    expect(dismissed, 1);
  });
}
