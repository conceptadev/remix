import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_chart/mix_chart.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonPieChart supports donut geometry and labels', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      SizedBox(
        width: 240,
        height: 240,
        child: CarbonPieChart(
          semanticsLabel: 'Device mix',
          centerRadius: 48,
          showLabels: true,
          slices: [
            PieSlice(id: 'mobile', label: 'Mobile', value: 64),
            PieSlice(id: 'desktop', label: 'Desktop', value: 36),
          ],
        ),
      ),
    );

    expect(find.byType(PieChart), findsOneWidget);
    expect(find.bySemanticsLabel('Device mix'), findsOneWidget);
    final chart = tester.widget<CarbonPieChart>(find.byType(CarbonPieChart));
    expect(chart.centerRadius, 48);
    expect(chart.showLabels, isTrue);
    expect(tester.takeException(), isNull);
  });
}
