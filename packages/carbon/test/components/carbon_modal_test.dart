import 'dart:ui' show SemanticsRole;

import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonModal preserves content and dialog semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonModal(
        title: 'Delete project',
        description: 'This cannot be undone.',
        child: Text('Project Phoenix'),
      ),
    );

    expect(find.text('Project Phoenix'), findsOneWidget);
    expect(
      tester.getSemantics(find.byType(CarbonModal)).role,
      SemanticsRole.dialog,
    );
    semantics.dispose();
  });

  testWidgets('showCarbonModal returns a route result', (tester) async {
    await tester.pumpCarbonApp(
      Builder(
        builder: (context) => CarbonButton(
          label: 'Open modal',
          onPressed: () async {
            await showCarbonModal<String>(
              context: context,
              builder: (context) => CarbonModal(
                title: 'Confirm',
                actions: [
                  CarbonButton(
                    label: 'Done',
                    onPressed: () => Navigator.pop(context, 'done'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open modal'));
    await tester.pumpAndSettle();
    expect(find.text('Confirm'), findsOneWidget);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.text('Confirm'), findsNothing);
  });
}
