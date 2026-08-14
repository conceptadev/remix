// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carbon_pie_chart.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Carbon pie/donut chart recipe generated over [PieChart].
class CarbonPieChart extends StatelessWidget {
  const CarbonPieChart({
    super.key,
    this.highContrast = false,
    this.centerRadius = 0,
    this.showLabels = false,
    this.palette,
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
      style: carbonPieChartStyle(
        highContrast: this.highContrast,
        centerRadius: this.centerRadius,
        showLabels: this.showLabels,
        palette: this.palette,
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
