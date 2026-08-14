// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carbon_line_chart.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Carbon line/area chart recipe generated over [LineChart].
class CarbonLineChart extends StatelessWidget {
  const CarbonLineChart({
    super.key,
    this.highContrast = false,
    this.showMarkers = false,
    this.smooth = false,
    this.palette,
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

  final bool smooth;

  final List<Color>? palette;

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
      style: carbonLineChartStyle(
        highContrast: this.highContrast,
        showMarkers: this.showMarkers,
        smooth: this.smooth,
        palette: this.palette,
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
