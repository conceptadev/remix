import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:mix_chart/mix_chart.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_palette.g.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

typedef CarbonChartPoint = ChartPoint;
typedef CarbonLineSeries = LineSeries;
typedef CarbonChartAxis = ChartAxis;
typedef CarbonChartViewport = ChartViewport;
typedef CarbonChartDataTransition = ChartDataTransition;
typedef CarbonLinePointKey = LinePointKey;
typedef CarbonLineChartHit = LineChartHit;
typedef CarbonBarGroup = BarGroup;
typedef CarbonBarValue = BarValue;
typedef CarbonBarSegment = BarSegment;
typedef CarbonBarSelectionKey = BarSelectionKey;
typedef CarbonBarChartHit = BarChartHit;
typedef CarbonPieSlice = PieSlice;
typedef CarbonPieChartHit = PieChartHit;

/// Carbon's categorical data-visualization palette.
const carbonChartPalette = [
  CarbonPalette.purple70,
  CarbonPalette.cyan50,
  CarbonPalette.teal70,
  CarbonPalette.magenta70,
  CarbonPalette.red50,
  CarbonPalette.red90,
  CarbonPalette.green60,
  CarbonPalette.blue80,
  CarbonPalette.magenta50,
  CarbonPalette.purple50,
  CarbonPalette.teal50,
  CarbonPalette.cyan90,
  CarbonPalette.blue50,
  CarbonPalette.green90,
];

const carbonChartHighContrastPalette = [
  CarbonPalette.purple60,
  CarbonPalette.cyan40,
  CarbonPalette.teal50,
  CarbonPalette.magenta50,
  CarbonPalette.red60,
  CarbonPalette.green50,
  CarbonPalette.blue60,
  CarbonPalette.orange50,
];

const _carbonChartTooltipBackground = ContextToken(_resolveTooltipBackground);
const _carbonChartTooltipBorder = ContextToken(_resolveTooltipBorder);

Color _resolveTooltipBackground(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

BorderSide _resolveTooltipBorder(BuildContext context) => .new(
  color: CarbonLayer.of(context).color(.borderSubtle).resolve(context),
  width: 1,
);

Prop<List<Color>> carbonChartPaletteProp({
  required bool highContrast,
  required List<Color>? palette,
}) => Prop.value(
  List<Color>.unmodifiable(
    palette ??
        (highContrast ? carbonChartHighContrastPalette : carbonChartPalette),
  ),
);

ChartFrameStyler carbonChartFrameStyle() =>
    .new().backgroundColor(MixColors.transparent).showBorder(false).clip(true);

ChartAxisStyler carbonChartAxisStyle() => .new()
    .showLabels(true)
    .label(
      TextStyler()
          .style(CarbonTokens.label01.mix())
          .color(CarbonTokens.textSecondary()),
    )
    .labelSpace(CarbonTokens.spacing03())
    .fitInside(true)
    .fitInsideDistance(CarbonTokens.spacing02())
    .drawBelowEverything(true);

ChartAxisStyler carbonHiddenChartAxisStyle() => .new().showLabels(false);

ChartGridStyler carbonChartGridStyle() => .new()
    .show(true)
    .showHorizontal(true)
    .showVertical(false)
    .stroke(ChartStrokeStyler().color(CarbonTokens.borderSubtle01()).width(1));

ChartTooltipStyler carbonChartTooltipStyle() =>
    .create(
          border: Prop.token(_carbonChartTooltipBorder),
          borderRadius: Prop.value(BorderRadius.zero),
          padding: Prop.value(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        )
        .backgroundColor(_carbonChartTooltipBackground())
        .margin(CarbonTokens.spacing03())
        .maxWidth(280)
        .fitHorizontally(true)
        .fitVertically(true)
        .text(
          TextStyler()
              .style(CarbonTokens.bodyCompact01.mix())
              .color(CarbonTokens.textPrimary()),
        );
