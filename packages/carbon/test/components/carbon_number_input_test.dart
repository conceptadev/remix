import 'dart:ui' show SemanticsAction;

import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonNumberInput clamps stepper changes to its range', (
    tester,
  ) async {
    num value = 9;
    await tester.pumpCarbonApp(
      StatefulBuilder(
        builder: (context, setState) => CarbonNumberInput(
          value: value,
          min: 0,
          max: 10,
          step: 2,
          label: 'Guests',
          onChanged: (next) => setState(() => value = next),
        ),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Increase Guests'));
    await tester.pump();
    expect(value, 10);
    await tester.tap(find.bySemanticsLabel('Decrease Guests'));
    expect(value, 8);
  });

  testWidgets('CarbonNumberInput exposes adjustable-value semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      CarbonNumberInput(
        value: 3,
        min: 0,
        max: 5,
        label: 'Guests',
        onChanged: (_) {},
      ),
    );

    final node = tester.semantics.simulatedAccessibilityTraversal().singleWhere(
      (item) =>
          item.getSemanticsData().label == 'Guests' &&
          item.getSemanticsData().hasAction(SemanticsAction.increase),
    );
    expect(node.getSemanticsData().label, 'Guests');
    expect(node.getSemanticsData().value, '3');
    expect(node.getSemanticsData().hasAction(SemanticsAction.increase), isTrue);
    expect(node.getSemanticsData().hasAction(SemanticsAction.decrease), isTrue);
    semantics.dispose();
  });
}
