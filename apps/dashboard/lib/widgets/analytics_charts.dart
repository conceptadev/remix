import 'package:flutter/material.dart';
import 'package:mix_chart/mix_chart.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'chart_legend.dart';
import 'dashboard_chart_card.dart';

class AnalyticsCharts extends StatelessWidget {
  const AnalyticsCharts({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = resolveFortalChartPalette(context);
    final gap = MixScope.tokenOf(FortalTokens.space4, context);
    final chartInset = MixScope.tokenOf(FortalTokens.space2, context);
    final slices = _channelSlices();
    // Omit autoRows: Mix 1031 defaults implicit rows to content height.
    final GridBoxStyler gridStyle = .equalColumns(3)
        .gap(gap)
        .onConstraints(const .maxWidth(1119), .equalColumns(2).gap(gap))
        .onConstraints(const .maxWidth(719), .equalColumns(1).gap(gap));

    return GridBox(
      key: const ValueKey('overview-chart-grid'),
      style: gridStyle,
      children: [
        DashboardChartCard(
          title: 'Revenue trend',
          description: 'Seven-day net revenue',
          chartPadding: EdgeInsets.zero,
          chart: FortalLineChart(
            palette: palette,
            semanticsLabel: 'Seven-day net revenue',
            showMarkers: true,
            series: [_revenueSeries()],
            xAxis: ChartAxis.numeric(
              min: 0,
              max: 6,
              interval: 1,
              labelFormatter: _dayLabel,
            ),
            yAxis: ChartAxis.numeric(
              min: 0,
              max: 100,
              interval: 25,
              labelFormatter: _currencyLabel,
            ),
          ),
        ),
        DashboardChartCard(
          title: 'Order volume',
          description: 'Actual versus plan',
          chartPadding: EdgeInsets.zero,
          legend: ChartLegend(
            key: const ValueKey('overview-order-legend'),
            semanticLabel: 'Order volume series',
            items: [
              ChartLegendItem(id: 'actual', label: 'Actual', color: palette[0]),
              ChartLegendItem(
                id: 'plan',
                label: 'Plan',
                color: palette[1],
                pattern: .dashed,
              ),
            ],
          ),
          chart: FortalBarChart(
            key: const ValueKey('overview-order-chart'),
            palette: palette,
            semanticsLabel: 'Quarterly actual and planned orders',
            groups: _orderGroups(palette),
            xAxis: ChartAxis.numeric(
              min: 0,
              max: 3,
              interval: 1,
              labelFormatter: _quarterLabel,
            ),
            yAxis: ChartAxis.numeric(min: 0, max: 100, interval: 25),
          ),
        ),
        DashboardChartCard(
          title: 'Channel mix',
          description: 'Revenue contribution',
          chartPadding: EdgeInsets.symmetric(
            horizontal: chartInset,
            vertical: chartInset,
          ),
          chartPaddingKey: const ValueKey('overview-channel-chart-safe-area'),
          legend: ChartLegend(
            key: const ValueKey('overview-channel-legend'),
            semanticLabel: 'Revenue contribution legend',
            items: percentagePieLegendItems(slices: slices, palette: palette),
          ),
          chart: PieChart(
            style: fortalPieChartStyle(
              palette: palette,
              centerRadius: 44,
            ).slice(PieSliceStyler().radius(36)),
            semanticsLabel: 'Revenue contribution by channel',
            slices: slices,
            valueFormatter: (value) => '${value.toInt()}%',
          ),
        ),
      ],
    );
  }
}

LineSeries _revenueSeries() => LineSeries(
  id: 'revenue',
  label: 'Revenue',
  points: [
    ChartPoint(id: 'mon', x: 0, y: 42),
    ChartPoint(id: 'tue', x: 1, y: 54),
    ChartPoint(id: 'wed', x: 2, y: 48),
    ChartPoint(id: 'thu', x: 3, y: 66),
    ChartPoint(id: 'fri', x: 4, y: 62),
    ChartPoint(id: 'sat', x: 5, y: 78),
    ChartPoint(id: 'sun', x: 6, y: 84),
  ],
);

List<BarGroup> _orderGroups(List<Color> palette) => [
  _orderGroup('q1', 'Q1', 52, 48, palette),
  _orderGroup('q2', 'Q2', 68, 64, palette),
  _orderGroup('q3', 'Q3', 74, 78, palette),
  _orderGroup('q4', 'Q4', 88, 82, palette),
];

BarGroup _orderGroup(
  String id,
  String label,
  double actual,
  double plan,
  List<Color> palette,
) => BarGroup(
  id: id,
  label: label,
  bars: [
    BarValue(
      id: 'actual',
      label: 'Actual',
      toY: actual,
      style: BarStyler().color(palette[0]),
    ),
    BarValue(
      id: 'plan',
      label: 'Plan',
      toY: plan,
      style: BarStyler()
          .color(palette[1].withValues(alpha: 0.22))
          .border(BorderSide(color: palette[1], width: 2))
          .borderDashArray([4, 3]),
    ),
  ],
);

List<PieSlice> _channelSlices() => [
  PieSlice(id: 'direct', label: 'Direct', value: 46),
  PieSlice(id: 'partners', label: 'Partners', value: 31),
  PieSlice(id: 'marketplace', label: 'Marketplace', value: 23),
];

String _dayLabel(double value) {
  const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final index = value.round();
  return index >= 0 && index < labels.length ? labels[index] : '';
}

String _quarterLabel(double value) {
  const labels = ['Q1', 'Q2', 'Q3', 'Q4'];
  final index = value.round();
  return index >= 0 && index < labels.length ? labels[index] : '';
}

String _currencyLabel(double value) => '\$${value.toInt()}k';
