import 'package:flutter/material.dart';
import 'package:mix_chart/mix_chart.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../widgets/chart_legend.dart';
import '../widgets/page_header.dart';
import '../widgets/typography.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = resolveFortalChartPalette(context);
    final pageGap = MixScope.tokenOf(FortalTokens.space6, context);
    final pagePadding = MediaQuery.sizeOf(context).width < 720
        ? MixScope.tokenOf(FortalTokens.space5, context)
        : pageGap;

    return KeyedSubtree(
      key: const ValueKey('charts-page'),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(pagePadding),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: pageGap,
          children: [
            const PageHeader(
              title: 'Charts',
              description:
                  'Fortal-native chart patterns for comparison, composition, interaction, and empty states.',
            ),
            _ChartSection(
              title: 'Line & area',
              description:
                  'Trends, comparisons, discontinuities, and scalable viewports.',
              cards: [
                _revenueMomentum(palette),
                _linePatterns(palette),
                _stepGaps(palette),
                _viewportLabels(palette),
              ],
            ),
            _ChartSection(
              title: 'Bar charts',
              description:
                  'Grouped, stacked, floating, and tracked quantitative comparisons.',
              cards: [
                _groupedBars(palette),
                _stackedBars(palette),
                _floatingBars(palette),
                _trackedBars(palette),
              ],
            ),
            _ChartSection(
              title: 'Pie & donut',
              description:
                  'Part-to-whole views with direct labels, legends, badges, and safe empty states.',
              cards: [
                _trafficPie(palette),
                _InteractiveProductMix(palette: palette),
                _badgePie(context, palette),
                _emptyPie(palette),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartSection extends StatelessWidget {
  const _ChartSection({
    required this.title,
    required this.description,
    required this.cards,
  });

  final String title;
  final String description;
  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    final gap = MixScope.tokenOf(FortalTokens.space4, context);
    final titleGap = MixScope.tokenOf(FortalTokens.space2, context);
    final cardHeight = 420 * FortalTheme.of(context).scaling.factor;
    final GridBoxStyler gridStyle = GridBoxStyler.equalColumns(2)
        .autoRows(GridTrack.fixed(cardHeight))
        .gap(gap)
        .onConstraints(
          const Breakpoint.maxWidth(860),
          GridBoxStyler.equalColumns(1).gap(gap),
        );

    return Column(
      crossAxisAlignment: .stretch,
      spacing: gap,
      children: [
        Column(
          crossAxisAlignment: .start,
          spacing: titleGap,
          children: [
            SectionLabel(title),
            StyledText(
              description,
              style: dashboardText(FortalTokens.text2, tone: .muted),
            ),
          ],
        ),
        GridBox(style: gridStyle, children: cards),
      ],
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.title,
    required this.description,
    required this.chart,
    this.legend,
    this.chartPadding,
  });

  final String title;
  final String description;
  final Widget chart;
  final Widget? legend;
  final EdgeInsets? chartPadding;

  @override
  Widget build(BuildContext context) {
    final gap = MixScope.tokenOf(FortalTokens.space4, context);
    final defaultInset = MixScope.tokenOf(FortalTokens.space2, context);

    return FortalCard(
      size: .size2,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          CardHeading(title: title, description: description),
          SizedBox(height: gap),
          Expanded(
            child: Padding(
              padding:
                  chartPadding ?? EdgeInsets.symmetric(vertical: defaultInset),
              child: chart,
            ),
          ),
          if (legend case final legend?) ...[SizedBox(height: gap), legend],
        ],
      ),
    );
  }
}

Widget _revenueMomentum(List<Color> palette) {
  final color = palette[0];
  return _ChartCard(
    title: 'Revenue momentum',
    description: 'Area fill and markers preserve exact point values.',
    chart: FortalLineChart(
      palette: palette,
      showMarkers: true,
      semanticsLabel: 'Weekly revenue momentum',
      series: [
        LineSeries(
          id: 'revenue',
          label: 'Revenue',
          points: _points('revenue', [18, 24, 22, 34, 31, 42, 48]),
          style: LineSeriesStyler().belowArea(
            ChartAreaStyler()
                .show(true)
                .gradient(
                  LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color.withValues(alpha: 0.28),
                      color.withValues(alpha: 0),
                    ],
                  ),
                ),
          ),
        ),
      ],
      xAxis: _weekdayAxis(),
      yAxis: _currencyAxis(max: 60),
    ),
    legend: ChartLegend(
      semanticLabel: 'Revenue series legend',
      items: [ChartLegendItem(id: 'revenue', label: 'Revenue', color: color)],
    ),
  );
}

Widget _linePatterns(List<Color> palette) => _ChartCard(
  title: 'Per-series patterns',
  description: 'Solid circles and dashed squares reinforce color differences.',
  chart: FortalLineChart(
    key: const ValueKey('charts-line-patterns'),
    palette: palette,
    showMarkers: true,
    semanticsLabel: 'Weekly actual and planned revenue',
    series: [
      LineSeries(
        id: 'actual',
        label: 'Actual',
        points: _points('actual', [18, 24, 22, 34, 31, 42, 48]),
      ),
      LineSeries(
        id: 'plan',
        label: 'Plan',
        points: _points('plan', [16, 20, 25, 28, 34, 37, 41]),
        style: LineSeriesStyler()
            .stroke(ChartStrokeStyler().dashArray([6, 4]).width(2.5))
            .marker(ChartMarkerStyler().show(true).shape(.square).radius(3.5)),
      ),
    ],
    xAxis: _weekdayAxis(),
    yAxis: _currencyAxis(max: 60),
  ),
  legend: ChartLegend(
    semanticLabel: 'Actual and plan line patterns',
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
);

Widget _stepGaps(List<Color> palette) => _ChartCard(
  title: 'Steps and gaps',
  description: 'Missing values remain honest gaps instead of invented data.',
  chart: FortalLineChart(
    palette: palette,
    showMarkers: true,
    semanticsLabel: 'Inventory levels with missing observations',
    series: [
      LineSeries(
        id: 'inventory',
        label: 'Inventory',
        points: [
          ChartPoint(id: 'inventory-0', x: 0, y: 32),
          ChartPoint(id: 'inventory-1', x: 1, y: 27),
          ChartPoint(id: 'inventory-2', x: 2, y: null),
          ChartPoint(id: 'inventory-3', x: 3, y: null),
          ChartPoint(id: 'inventory-4', x: 4, y: 19),
          ChartPoint(id: 'inventory-5', x: 5, y: 25),
          ChartPoint(id: 'inventory-6', x: 6, y: 22),
        ],
        style: LineSeriesStyler()
            .curve(.stepAfter)
            .marker(ChartMarkerStyler().show(true).shape(.square)),
      ),
    ],
    xAxis: _weekdayAxis(),
    yAxis: ChartAxis.numeric(min: 10, max: 35, interval: 5),
  ),
  legend: ChartLegend(
    semanticLabel: 'Inventory series legend',
    items: [
      ChartLegendItem(id: 'inventory', label: 'Inventory', color: palette[0]),
    ],
  ),
);

Widget _viewportLabels(List<Color> palette) => _ChartCard(
  title: 'Viewport labels',
  description:
      'Tokenized widget labels stay readable while panning and zooming.',
  chart: FortalLineChart(
    palette: palette,
    showMarkers: true,
    semanticsLabel: 'Revenue chart with scalable horizontal viewport',
    series: [
      LineSeries(
        id: 'viewport-revenue',
        label: 'Revenue',
        points: _points('viewport', [18, 24, 22, 34, 31, 42, 48]),
      ),
    ],
    viewport: ChartViewport(axis: .horizontal, maxScale: 3),
    xAxis: ChartAxis.numeric(
      min: 0,
      max: 6,
      interval: 1,
      labelFormatter: _weekdayLabel,
      labelBuilder: (_, label) => FortalBadge.soft(label: label.formattedValue),
    ),
    yAxis: ChartAxis.numeric(min: 0, max: 60, interval: 10),
  ),
  legend: ChartLegend(
    semanticLabel: 'Viewport revenue legend',
    items: [
      ChartLegendItem(
        id: 'viewport-revenue',
        label: 'Revenue',
        color: palette[0],
      ),
    ],
  ),
);

Widget _groupedBars(List<Color> palette) => _ChartCard(
  title: 'Actual versus plan',
  description: 'Solid and outlined bars remain distinct without color.',
  chart: FortalBarChart(
    key: const ValueKey('charts-bar-grouped'),
    palette: palette,
    semanticsLabel: 'Monthly actual and planned revenue',
    groups: _groupedRevenue(palette),
    yAxis: _currencyAxis(max: 70),
  ),
  legend: ChartLegend(
    semanticLabel: 'Actual and plan bar patterns',
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
);

Widget _stackedBars(List<Color> palette) => _ChartCard(
  title: 'Revenue mix',
  description: 'Stacked segments expose composition and totals together.',
  chart: FortalBarChart(
    palette: palette,
    semanticsLabel: 'Monthly product and services revenue',
    groups: _stackedRevenue(palette),
    yAxis: _currencyAxis(max: 70),
  ),
  legend: ChartLegend(
    semanticLabel: 'Revenue mix legend',
    items: [
      ChartLegendItem(id: 'product', label: 'Product', color: palette[0]),
      ChartLegendItem(id: 'services', label: 'Services', color: palette[1]),
    ],
  ),
);

Widget _floatingBars(List<Color> palette) => _ChartCard(
  title: 'Floating changes',
  description: 'Range bars encode gains and declines from a real baseline.',
  chart: FortalBarChart(
    palette: palette,
    semanticsLabel: 'Monthly floating inventory changes',
    groups: _floatingChanges(palette),
    yAxis: ChartAxis.numeric(min: 10, max: 35, interval: 5),
  ),
  legend: ChartLegend(
    semanticLabel: 'Floating changes legend',
    items: [
      ChartLegendItem(id: 'change', label: 'Change range', color: palette[2]),
    ],
  ),
);

Widget _trackedBars(List<Color> palette) => _ChartCard(
  title: 'Tracks and labels',
  description: 'Visible tracks provide scale context before interaction.',
  chart: FortalBarChart(
    palette: palette,
    semanticsLabel: 'Monthly revenue against full-scale tracks',
    groups: _trackedRevenue(palette),
    yAxis: ChartAxis.numeric(min: 0, max: 70, interval: 10),
  ),
  legend: ChartLegend(
    semanticLabel: 'Tracked revenue legend',
    items: [
      ChartLegendItem(id: 'tracked', label: 'Revenue', color: palette[0]),
    ],
  ),
);

Widget _trafficPie(List<Color> palette) {
  final slices = _channelSlices(palette);
  return _ChartCard(
    title: 'Traffic channels',
    description: 'Direct labels use the strongest readable foreground.',
    chartPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    chart: FortalPieChart(
      palette: palette,
      showLabels: true,
      semanticsLabel: 'Traffic share by device',
      slices: slices,
      valueFormatter: (value) => '${value.toInt()}%',
    ),
    legend: ChartLegend(
      semanticLabel: 'Traffic channel legend',
      items: [
        for (var index = 0; index < slices.length; index++)
          ChartLegendItem(
            id: slices[index].id.toString(),
            label: slices[index].label,
            value: '${slices[index].value.toInt()}%',
            color: palette[index],
            pattern: .dot,
          ),
      ],
    ),
  );
}

class _InteractiveProductMix extends StatefulWidget {
  const _InteractiveProductMix({required this.palette});

  final List<Color> palette;

  @override
  State<_InteractiveProductMix> createState() => _InteractiveProductMixState();
}

class _InteractiveProductMixState extends State<_InteractiveProductMix> {
  Object? _selected = 'core';

  @override
  Widget build(BuildContext context) {
    final slices = _productSlices();
    return _ChartCard(
      title: 'Interactive product mix',
      description: 'Selection expands one stable slice and preserves its ID.',
      chartPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      chart: FortalPieChart(
        palette: widget.palette,
        centerRadius: 52,
        semanticsLabel: 'Product mix',
        slices: slices,
        selectedSliceIds: {?_selected},
        onSliceTap: (hit) => setState(() => _selected = hit.sliceId),
        valueFormatter: (value) => '${value.toInt()}%',
      ),
      legend: ChartLegend(
        semanticLabel: 'Product mix legend',
        items: [
          for (var index = 0; index < slices.length; index++)
            ChartLegendItem(
              id: slices[index].id.toString(),
              label: slices[index].label,
              value: '${slices[index].value.toInt()}%',
              color: widget.palette[index],
              pattern: .dot,
            ),
        ],
      ),
    );
  }
}

Widget _badgePie(BuildContext context, List<Color> palette) {
  const icons = [Icons.phone_iphone, Icons.laptop_mac, Icons.tablet, Icons.tv];
  final panel = MixScope.tokenOf(FortalTokens.colorPanel, context);
  final border = MixScope.tokenOf(FortalTokens.grayStroke6, context);
  final iconColor = MixScope.tokenOf(FortalTokens.gray12, context);
  final base = _channelSlices(palette, showLabels: false);
  final slices = [
    for (var index = 0; index < base.length; index++)
      PieSlice(
        id: base[index].id,
        label: base[index].label,
        value: base[index].value,
        style: PieSliceStyler().radius(48).badgePosition(0.72),
        badge: Box(
          style: BoxStyler()
              .size(26, 26)
              .alignment(.center)
              .color(panel)
              .borderAll(color: border)
              .borderRounded(99),
          child: StyledIcon(
            icon: icons[index],
            style: IconStyler().size(14).color(iconColor),
          ),
        ),
      ),
  ];

  return _ChartCard(
    title: 'Badge markers',
    description: 'Ordinary tokenized widgets can annotate individual slices.',
    chartPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    chart: FortalPieChart(
      palette: palette,
      centerRadius: 34,
      semanticsLabel: 'Device traffic with badge markers',
      slices: slices,
      valueFormatter: (value) => '${value.toInt()}%',
    ),
    legend: ChartLegend(
      semanticLabel: 'Badge marker chart legend',
      items: [
        for (var index = 0; index < slices.length; index++)
          ChartLegendItem(
            id: slices[index].id.toString(),
            label: slices[index].label,
            value: '${slices[index].value.toInt()}%',
            color: palette[index],
            pattern: .dot,
          ),
      ],
    ),
  );
}

Widget _emptyPie(List<Color> palette) => _ChartCard(
  title: 'Safe empty state',
  description: 'Zero-value data produces an explicit, stable empty state.',
  chartPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  chart: Stack(
    alignment: .center,
    children: [
      FortalPieChart(
        palette: palette,
        centerRadius: 52,
        semanticsLabel: 'No channel data',
        slices: [PieSlice(id: 'empty', label: 'No data', value: 0)],
      ),
      Column(
        mainAxisSize: .min,
        spacing: 6,
        children: [
          StyledIcon(
            icon: Icons.inbox_outlined,
            style: IconStyler().size(20).color(FortalTokens.gray11()),
          ),
          StyledText(
            'No data yet',
            style: dashboardText(FortalTokens.text1, tone: .muted),
          ),
        ],
      ),
    ],
  ),
);

List<ChartPoint> _points(String id, List<double> values) => [
  for (final (index, value) in values.indexed)
    ChartPoint(id: '$id-$index', x: index.toDouble(), y: value),
];

ChartAxis _weekdayAxis() => ChartAxis.numeric(
  min: 0,
  max: 6,
  interval: 1,
  labelFormatter: _weekdayLabel,
);

ChartAxis _currencyAxis({required double max}) => ChartAxis.numeric(
  min: 0,
  max: max,
  interval: 10,
  labelFormatter: (value) => '\$${value.toInt()}k',
);

String _weekdayLabel(double value) {
  const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final index = value.round();
  return index >= 0 && index < labels.length ? labels[index] : '';
}

List<BarGroup> _groupedRevenue(List<Color> palette) {
  const actual = <double>[32, 41, 37, 52, 48, 59];
  const plan = <double>[29, 36, 40, 45, 50, 54];
  return [
    for (var index = 0; index < actual.length; index++)
      BarGroup(
        id: 'month-$index',
        label: _months[index],
        bars: [
          BarValue(
            id: 'actual',
            label: 'Actual',
            toY: actual[index],
            style: BarStyler().color(palette[0]),
          ),
          BarValue(
            id: 'plan',
            label: 'Plan',
            toY: plan[index],
            style: BarStyler()
                .color(palette[1].withValues(alpha: 0.22))
                .border(BorderSide(color: palette[1], width: 2))
                .borderDashArray([4, 3]),
          ),
        ],
      ),
  ];
}

List<BarGroup> _stackedRevenue(List<Color> palette) {
  const product = <double>[21, 28, 25, 34, 31, 38];
  const services = <double>[11, 13, 12, 18, 17, 21];
  return [
    for (var index = 0; index < product.length; index++)
      BarGroup(
        id: 'stack-$index',
        label: _months[index],
        bars: [
          BarValue(
            id: 'revenue',
            label: 'Revenue',
            toY: product[index] + services[index],
            segments: [
              BarSegment(
                id: 'product',
                label: 'Product',
                fromY: 0,
                toY: product[index],
                style: BarSegmentStyler().color(palette[0]),
              ),
              BarSegment(
                id: 'services',
                label: 'Services',
                fromY: product[index],
                toY: product[index] + services[index],
                style: BarSegmentStyler().color(palette[1]),
              ),
            ],
          ),
        ],
      ),
  ];
}

List<BarGroup> _floatingChanges(List<Color> palette) {
  const ranges = [
    (13.0, 18.0),
    (14.0, 18.0),
    (14.0, 22.0),
    (17.0, 22.0),
    (18.0, 25.0),
    (25.0, 31.0),
  ];
  return [
    for (var index = 0; index < ranges.length; index++)
      BarGroup(
        id: 'floating-$index',
        label: _months[index],
        bars: [
          BarValue(
            id: 'change',
            label: 'Change',
            fromY: ranges[index].$1,
            toY: ranges[index].$2,
            style: BarStyler().gradient(
              LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [palette[2], palette[5]],
              ),
            ),
          ),
        ],
      ),
  ];
}

List<BarGroup> _trackedRevenue(List<Color> palette) {
  const values = <double>[32, 41, 37, 52, 48, 59];
  return [
    for (var index = 0; index < values.length; index++)
      BarGroup(
        id: 'tracked-$index',
        label: _months[index],
        bars: [
          BarValue(
            id: 'tracked',
            label: 'Revenue',
            toY: values[index],
            style: BarStyler()
                .color(palette[0])
                .label(
                  TextStyler()
                      .style(FortalTokens.text1.mix())
                      .fontWeight(.w700)
                      .color(FortalTokens.gray12()),
                )
                .background(
                  BarBackgroundStyler()
                      .show(true)
                      .fromY(0)
                      .toY(70)
                      .color(FortalTokens.grayA3()),
                ),
          ),
        ],
      ),
  ];
}

List<PieSlice> _channelSlices(List<Color> palette, {bool showLabels = true}) {
  const source = [
    ('mobile', 'Mobile', 46.0),
    ('desktop', 'Desktop', 31.0),
    ('tablet', 'Tablet', 15.0),
    ('other', 'Other', 8.0),
  ];
  return [
    for (var index = 0; index < source.length; index++)
      PieSlice(
        id: source[index].$1,
        label: source[index].$2,
        value: source[index].$3,
        style: PieSliceStyler()
            .radius(72)
            .showLabel(showLabels)
            .labelPosition(0.62)
            .label(
              TextStyler()
                  .style(FortalTokens.text1.mix())
                  .fontWeight(.w700)
                  .color(_strongestForeground(palette[index])),
            ),
      ),
  ];
}

List<PieSlice> _productSlices() => [
  PieSlice(
    id: 'core',
    label: 'Core',
    value: 54,
    style: PieSliceStyler().radius(44),
  ),
  PieSlice(
    id: 'teams',
    label: 'Teams',
    value: 27,
    style: PieSliceStyler().radius(44),
  ),
  PieSlice(
    id: 'enterprise',
    label: 'Enterprise',
    value: 19,
    style: PieSliceStyler().radius(44),
  ),
];

Color _strongestForeground(Color background) {
  const light = Colors.white;
  const dark = Colors.black;
  return _contrastRatio(background, light) >= _contrastRatio(background, dark)
      ? light
      : dark;
}

double _contrastRatio(Color a, Color b) {
  final lighter = a.computeLuminance() >= b.computeLuminance() ? a : b;
  final darker = identical(lighter, a) ? b : a;
  return (lighter.computeLuminance() + 0.05) /
      (darker.computeLuminance() + 0.05);
}

const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
