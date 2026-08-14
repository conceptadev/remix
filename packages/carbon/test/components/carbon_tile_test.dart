import 'package:carbon/carbon.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonClickableTile supports keyboard activation', (
    tester,
  ) async {
    var pressed = false;
    await tester.pumpCarbonApp(
      CarbonClickableTile(
        semanticLabel: 'Open analytics',
        onPressed: () => pressed = true,
        child: const Text('Analytics'),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Open analytics'));
    expect(pressed, isTrue);
    pressed = false;
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(pressed, isTrue);
  });

  testWidgets('CarbonSelectableTile reports selected state', (tester) async {
    await tester.pumpCarbonApp(
      const CarbonSelectableTile(
        selected: true,
        semanticLabel: 'Starter plan',
        child: Text('Starter'),
      ),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Starter plan')),
      isSemantics(isSelected: true, hasSelectedState: true),
    );
  });

  testWidgets('CarbonExpandableTile owns uncontrolled disclosure state', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      const CarbonExpandableTile(
        title: 'Details',
        child: Text('Hidden details'),
      ),
    );

    expect(find.text('Hidden details'), findsNothing);
    await tester.tap(find.bySemanticsLabel('Details'));
    await tester.pump();
    expect(find.text('Hidden details'), findsOneWidget);
  });
}
