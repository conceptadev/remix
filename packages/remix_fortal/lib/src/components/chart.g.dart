// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal presentation for a Mix line or area chart.
///
/// Generates [FortalLineChart] through `mix_generator`. The plot remains
/// transparent so callers can compose it inside any Fortal surface.
class FortalLineChart extends StatelessWidget {
  const FortalLineChart({
    super.key,
    this.highContrast = false,
    this.showMarkers = false,
    this.palette,
    this.style = const LineChartStyler.create(),
    required this.series,
    this.xAxis,
    this.yAxis,
    this.topAxis,
    this.rightAxis,
    this.viewport,
    this.dataTransition = ChartDataTransition.none,
    this.selectedPoints = const {},
    this.onPointHover,
    this.onPointTap,
    this.onPointLongPress,
    this.tooltipBuilder,
    this.hitTestRadius = 10,
    this.mouseCursorResolver,
    this.semanticsLabel,
    this.semanticsValue,
    this.excludeFromSemantics = false,
  });

  final bool highContrast;

  final bool showMarkers;

  final List<Color>? palette;

  final LineChartStyler style;

  final List<LineSeries> series;

  final ChartAxis? xAxis;

  final ChartAxis? yAxis;

  final ChartAxis? topAxis;

  final ChartAxis? rightAxis;

  final ChartViewport? viewport;

  final ChartDataTransition dataTransition;

  final Set<LinePointKey> selectedPoints;

  final ValueChanged<LineChartHit?>? onPointHover;

  final ValueChanged<LineChartHit>? onPointTap;

  final ValueChanged<LineChartHit>? onPointLongPress;

  final ChartTooltipBuilder? tooltipBuilder;

  final double hitTestRadius;

  final ChartMouseCursorResolver<LineChartHit>? mouseCursorResolver;

  final String? semanticsLabel;

  final String? semanticsValue;

  final bool excludeFromSemantics;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      key: this.key,
      style: fortalLineChartStyle(
        highContrast: this.highContrast,
        showMarkers: this.showMarkers,
        palette: this.palette,
        style: this.style,
      ),
      series: this.series,
      xAxis: this.xAxis,
      yAxis: this.yAxis,
      topAxis: this.topAxis,
      rightAxis: this.rightAxis,
      viewport: this.viewport,
      dataTransition: this.dataTransition,
      selectedPoints: this.selectedPoints,
      onPointHover: this.onPointHover,
      onPointTap: this.onPointTap,
      onPointLongPress: this.onPointLongPress,
      tooltipBuilder: this.tooltipBuilder,
      hitTestRadius: this.hitTestRadius,
      mouseCursorResolver: this.mouseCursorResolver,
      semanticsLabel: this.semanticsLabel,
      semanticsValue: this.semanticsValue,
      excludeFromSemantics: this.excludeFromSemantics,
    );
  }
}

/// Fortal presentation for a Mix grouped, stacked, or floating bar chart.
///
/// Generates [FortalBarChart] through `mix_generator`.
class FortalBarChart extends StatelessWidget {
  const FortalBarChart({
    super.key,
    this.highContrast = false,
    this.palette,
    this.style = const BarChartStyler.create(),
    required this.groups,
    this.xAxis,
    this.yAxis,
    this.topAxis,
    this.rightAxis,
    this.viewport,
    this.dataTransition = ChartDataTransition.none,
    this.selectedItems = const {},
    this.onBarHover,
    this.onBarTap,
    this.onBarLongPress,
    this.tooltipBuilder,
    this.hitTestPadding = const EdgeInsets.all(4),
    this.mouseCursorResolver,
    this.semanticsLabel,
    this.semanticsValue,
    this.excludeFromSemantics = false,
  });

  final bool highContrast;

  final List<Color>? palette;

  final BarChartStyler style;

  final List<BarGroup> groups;

  final ChartAxis? xAxis;

  final ChartAxis? yAxis;

  final ChartAxis? topAxis;

  final ChartAxis? rightAxis;

  final ChartViewport? viewport;

  final ChartDataTransition dataTransition;

  final Set<BarSelectionKey> selectedItems;

  final ValueChanged<BarChartHit?>? onBarHover;

  final ValueChanged<BarChartHit>? onBarTap;

  final ValueChanged<BarChartHit>? onBarLongPress;

  final ChartTooltipBuilder? tooltipBuilder;

  final EdgeInsets hitTestPadding;

  final ChartMouseCursorResolver<BarChartHit>? mouseCursorResolver;

  final String? semanticsLabel;

  final String? semanticsValue;

  final bool excludeFromSemantics;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      key: this.key,
      style: fortalBarChartStyle(
        highContrast: this.highContrast,
        palette: this.palette,
        style: this.style,
      ),
      groups: this.groups,
      xAxis: this.xAxis,
      yAxis: this.yAxis,
      topAxis: this.topAxis,
      rightAxis: this.rightAxis,
      viewport: this.viewport,
      dataTransition: this.dataTransition,
      selectedItems: this.selectedItems,
      onBarHover: this.onBarHover,
      onBarTap: this.onBarTap,
      onBarLongPress: this.onBarLongPress,
      tooltipBuilder: this.tooltipBuilder,
      hitTestPadding: this.hitTestPadding,
      mouseCursorResolver: this.mouseCursorResolver,
      semanticsLabel: this.semanticsLabel,
      semanticsValue: this.semanticsValue,
      excludeFromSemantics: this.excludeFromSemantics,
    );
  }
}

/// Fortal presentation for a Mix pie or donut chart.
///
/// A positive [centerRadius] renders a donut. Labels are hidden by default so
/// category names can be presented in a caller-owned legend without forcing
/// low-contrast text onto arbitrary categorical colors. Generates
/// [FortalPieChart] through `mix_generator`. For advanced chart-level geometry,
/// pass this recipe directly to [PieChart.style] and merge a [PieSliceStyler].
class FortalPieChart extends StatelessWidget {
  const FortalPieChart({
    super.key,
    this.highContrast = false,
    this.centerRadius = 0,
    this.showLabels = false,
    this.palette,
    this.style = const PieChartStyler.create(),
    required this.slices,
    this.dataTransition = ChartDataTransition.none,
    this.selectedSliceIds = const {},
    this.onSliceHover,
    this.onSliceTap,
    this.onSliceLongPress,
    this.tooltipBuilder,
    this.mouseCursorResolver,
    this.valueFormatter,
    this.semanticsLabel,
    this.semanticsValue,
    this.excludeFromSemantics = false,
  });

  final bool highContrast;

  final double centerRadius;

  final bool showLabels;

  final List<Color>? palette;

  final PieChartStyler style;

  final List<PieSlice> slices;

  final ChartDataTransition dataTransition;

  final Set<Object> selectedSliceIds;

  final ValueChanged<PieChartHit?>? onSliceHover;

  final ValueChanged<PieChartHit>? onSliceTap;

  final ValueChanged<PieChartHit>? onSliceLongPress;

  final ChartTooltipBuilder? tooltipBuilder;

  final ChartMouseCursorResolver<PieChartHit>? mouseCursorResolver;

  final ChartAxisLabelFormatter? valueFormatter;

  final String? semanticsLabel;

  final String? semanticsValue;

  final bool excludeFromSemantics;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      key: this.key,
      style: fortalPieChartStyle(
        highContrast: this.highContrast,
        centerRadius: this.centerRadius,
        showLabels: this.showLabels,
        palette: this.palette,
        style: this.style,
      ),
      slices: this.slices,
      dataTransition: this.dataTransition,
      selectedSliceIds: this.selectedSliceIds,
      onSliceHover: this.onSliceHover,
      onSliceTap: this.onSliceTap,
      onSliceLongPress: this.onSliceLongPress,
      tooltipBuilder: this.tooltipBuilder,
      mouseCursorResolver: this.mouseCursorResolver,
      valueFormatter: this.valueFormatter,
      semanticsLabel: this.semanticsLabel,
      semanticsValue: this.semanticsValue,
      excludeFromSemantics: this.excludeFromSemantics,
    );
  }
}
