import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('FortalPopover supplies the themed overlay style', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      const FortalPopover(
        popoverChild: Text('Fortal content'),
        child: Text('Open Fortal popover'),
      ),
    );

    await tester.tap(find.text('Open Fortal popover'));
    await tester.pumpAndSettle();

    expect(find.text('Fortal content'), findsOneWidget);
  });
}
