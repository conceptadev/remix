import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonContainedList exposes list semantics and item actions', (
    tester,
  ) async {
    var pressed = false;
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      CarbonContainedList(
        label: 'Repositories',
        items: [
          CarbonContainedListItem(
            label: 'remix',
            onPressed: () => pressed = true,
          ),
          const CarbonContainedListItem(label: 'carbon'),
        ],
      ),
    );

    await tester.tap(find.bySemanticsLabel('remix'));
    expect(pressed, isTrue);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Repositories')).role,
      SemanticsRole.list,
    );
    semantics.dispose();
  });
}
