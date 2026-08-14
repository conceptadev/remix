import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonSearch edits and clears controlled text', (tester) async {
    final controller = TextEditingController(text: 'carbon');
    addTearDown(controller.dispose);
    var cleared = false;
    await tester.pumpCarbonApp(
      CarbonSearch(
        controller: controller,
        labelText: 'Search components',
        onClear: () => cleared = true,
      ),
    );

    await tester.tap(find.bySemanticsLabel('Clear search'));
    await tester.pump();
    expect(controller.text, isEmpty);
    expect(cleared, isTrue);
  });

  testWidgets('CarbonSearch exposes labeled text-field semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonSearch(labelText: 'Search components'),
    );

    final node = tester.semantics.simulatedAccessibilityTraversal().singleWhere(
      (item) => item.getSemanticsData().flagsCollection.isTextField,
    );
    expect(node.getSemanticsData().label, 'Search components');
    semantics.dispose();
  });
}
