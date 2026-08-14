// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carbon_bar_chart.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Carbon grouped, stacked, or floating bar chart recipe.
class CarbonBarChart extends StatelessWidget {
  const CarbonBarChart({
    super.key,
    this.highContrast = false,
    this.palette,
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
      style: carbonBarChartStyle(
        highContrast: this.highContrast,
        palette: this.palette,
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
