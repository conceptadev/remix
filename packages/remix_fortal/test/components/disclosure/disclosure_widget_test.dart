import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('shows collapsed and expanded states', (tester) async {
    await tester.pumpRemixApp(
      FortalDisclosure(
        trigger: const Text('Static trigger'),
        content: const Text('Panel content'),
        triggerBuilder: (context, state, child) {
          return Text(state.isExpanded ? 'Hide details' : 'Show details');
        },
      ),
    );

    expect(find.text('Show details'), findsOneWidget);
    expect(find.text('Panel content'), findsNothing);

    await tester.tap(find.text('Show details'));
    await tester.pumpAndSettle();

    expect(find.text('Hide details'), findsOneWidget);
    expect(find.text('Panel content'), findsOneWidget);
  });

  testWidgets('the container wraps both trigger and expanded content', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      const FortalDisclosure(
        defaultExpanded: true,
        trigger: Text('Show details'),
        content: Text('Panel content'),
      ),
    );
    await tester.pumpAndSettle();

    final spec = tester.resolvedSpecOf<DisclosureSpec>(
      find.text('Show details'),
    );
    final decoration = spec.container.spec.decoration as BoxDecoration;
    final container = find.byWidgetPredicate(
      (widget) => widget is DecoratedBox && widget.decoration == decoration,
    );

    expect(container, findsOneWidget);
    expect(
      find.descendant(of: container, matching: find.text('Show details')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: container, matching: find.text('Panel content')),
      findsOneWidget,
    );
  });
}
