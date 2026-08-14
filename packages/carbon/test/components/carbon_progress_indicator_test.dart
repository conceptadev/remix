import 'dart:ui' show SemanticsRole;

import 'package:carbon/carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonProgressIndicator derives ordered step states', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonProgressIndicator(
        currentIndex: 1,
        steps: [
          CarbonProgressStep(label: 'Account'),
          CarbonProgressStep(label: 'Profile'),
          CarbonProgressStep(label: 'Confirm'),
        ],
      ),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Account, complete')).role,
      SemanticsRole.listItem,
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Profile, current')),
      isSemantics(isSelected: true, hasSelectedState: true),
    );
    semantics.dispose();
  });
}
