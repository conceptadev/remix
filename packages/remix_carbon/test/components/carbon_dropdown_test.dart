import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonDropdown exposes a concise item-based API', (
    tester,
  ) async {
    int? selected;
    await tester.pumpCarbonApp(
      CarbonDropdown<int>(
        titleText: 'Quantity',
        label: 'Choose quantity',
        items: const [
          CarbonSelectItem(value: 1, label: 'One'),
          CarbonSelectItem(value: 2, label: 'Two'),
        ],
        selectedItem: selected,
        onChanged: (value) => selected = value,
      ),
    );

    await tester.tap(find.text('Choose quantity'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Two'));
    await tester.pumpAndSettle();
    expect(selected, 2);
  });

  testWidgets('CarbonDropdown forwards validation and helper content', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      const CarbonDropdown<int>(
        titleText: 'Quantity',
        label: 'Choose quantity',
        helperText: 'Whole numbers only',
        errorText: 'Required',
        items: [CarbonSelectItem(value: 1, label: 'One')],
      ),
    );

    expect(find.text('Whole numbers only'), findsNothing);
    expect(find.text('Required'), findsOneWidget);
  });
}
