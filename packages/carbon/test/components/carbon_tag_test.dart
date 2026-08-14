import 'package:carbon/carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonTag renders status and filter variants', (tester) async {
    var removed = false;
    await tester.pumpCarbonApp(
      CarbonTag(
        label: 'Ready',
        kind: CarbonTagKind.green,
        onRemove: () => removed = true,
      ),
    );

    expect(find.text('Ready'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Remove Ready'));
    expect(removed, isTrue);
  });
}
