import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_chart/mix_chart.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonBarChart forwards grouped bars and selection', (
    tester,
  ) async {
    const selected = BarSelectionKey.bar(groupId: 'q1', barId: 'actual');
    await tester.pumpCarbonApp(
      SizedBox(
        width: 360,
        height: 180,
        child: CarbonBarChart(
          semanticsLabel: 'Quarterly orders',
          selectedItems: {selected},
          groups: [
            BarGroup(
              id: 'q1',
              label: 'Q1',
              bars: [BarValue(id: 'actual', label: 'Actual', toY: 42)],
            ),
          ],
        ),
      ),
    );

    expect(find.byType(BarChart), findsOneWidget);
    expect(find.bySemanticsLabel('Quarterly orders'), findsOneWidget);
    expect(
      tester.widget<CarbonBarChart>(find.byType(CarbonBarChart)).selectedItems,
      {selected},
    );
    expect(tester.takeException(), isNull);
  });
}
