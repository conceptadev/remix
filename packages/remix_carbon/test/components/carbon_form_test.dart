import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonForm and CarbonFormGroup expose structural semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonForm(
        semanticLabel: 'Account form',
        children: [
          CarbonFormGroup(
            label: 'Identity',
            helperText: 'Public details',
            children: [CarbonTextInput(label: 'Name')],
          ),
        ],
      ),
    );

    final form = tester.semantics.simulatedAccessibilityTraversal().singleWhere(
      (node) => node.role == SemanticsRole.form,
    );
    expect(form.label, 'Account form');
    expect(find.text('Identity'), findsOneWidget);
    expect(find.text('Public details'), findsOneWidget);
    semantics.dispose();
  });
}
