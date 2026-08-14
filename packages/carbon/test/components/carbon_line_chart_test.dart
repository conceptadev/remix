import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_chart/mix_chart.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonLineChart renders with Carbon palette and semantics', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      SizedBox(
        width: 360,
        height: 180,
        child: CarbonLineChart(
          semanticsLabel: 'Revenue trend',
          semanticsValue: '18 to 31',
          showMarkers: true,
          series: [
            LineSeries(
              id: 'revenue',
              label: 'Revenue',
              points: [
                ChartPoint(id: 'monday', x: 0, y: 18),
                ChartPoint(id: 'tuesday', x: 1, y: 31),
              ],
            ),
          ],
        ),
      ),
    );

    expect(find.byType(LineChart), findsOneWidget);
    expect(find.bySemanticsLabel('Revenue trend'), findsOneWidget);
    expect(carbonChartPalette, hasLength(greaterThanOrEqualTo(8)));
    expect(tester.takeException(), isNull);
  });
}
