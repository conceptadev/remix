import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:mix_chart/mix_chart.dart';
import 'package:remix/remix.dart';

import '../theme/radix_colors.dart'
    show amber, blue, cyan, green, orange, ruby, violet;
import '../theme/theme.dart';

part 'chart.g.dart';

final _standardPaletteToken = ContextToken<List<Color>>(
  _resolveStandardPalette,
);
final _highContrastPaletteToken = ContextToken<List<Color>>(
  _resolveHighContrastPalette,
);
final _tooltipBorderToken = ContextToken<BorderSide>(_resolveTooltipBorder);
final _tooltipRadiusToken = ContextToken<BorderRadius>(_resolveTooltipRadius);
final _tooltipPaddingToken = ContextToken<EdgeInsets>(_resolveTooltipPadding);
final _barRadiusToken = ContextToken<BorderRadius>(_resolveBarRadius);
final _lineWidthToken = ContextToken<double>(_resolveLineWidth);
final _highContrastLineWidthToken = ContextToken<double>(
  _resolveHighContrastLineWidth,
);

/// Returns the categorical palette used by Fortal charts in the current scope.
///
/// The first entry follows the configured Fortal accent. Remaining entries use
/// Radix color families selected for clear categorical separation. Set
/// [highContrast] to use step 12 instead of the standard solid-color step 9.
List<Color> resolveFortalChartPalette(
  BuildContext context, {
  bool highContrast = false,
}) {
  final theme = FortalTheme.of(context);
  final colors = resolveFortalTokens(theme);
  final step = highContrast ? 12 : 9;
  final candidates = <Color>[
    colors.accent.scale.step(step),
    for (final family in [cyan, orange, ruby, green, violet, amber, blue])
      (theme.isDark ? family.dark : family.light).scale.step(step),
  ];

  return List<Color>.unmodifiable(candidates.toSet());
}

/// Fortal presentation for a Mix line or area chart.
///
/// Generates [FortalLineChart] through `mix_generator`. The plot remains
/// transparent so callers can compose it inside any Fortal surface.
@MixWidget(target: LineChart.new)
LineChartStyler fortalLineChartStyle({
  bool highContrast = false,
  bool showMarkers = false,
  List<Color>? palette,
}) {
  final style = LineChartStyler()
      .frame(_fortalFrameStyle())
      .axis(_fortalAxisStyle())
      .topAxis(_hiddenAxisStyle())
      .rightAxis(_hiddenAxisStyle())
      .grid(_fortalGridStyle())
      .series(
        LineSeriesStyler()
            .curve(.curved)
            .smoothness(0.18)
            .preventCurveOvershooting(true)
            .roundStrokeCap(true)
            .roundStrokeJoin(true)
            .stroke(
              ChartStrokeStyler().width(
                highContrast
                    ? _highContrastLineWidthToken()
                    : _lineWidthToken(),
              ),
            )
            .marker(
              ChartMarkerStyler()
                  .show(showMarkers)
                  .radius(FortalTokens.space1())
                  .borderColor(FortalTokens.colorPanel())
                  .borderWidth(FortalTokens.borderWidth2()),
            ),
      )
      .tooltip(_fortalTooltipStyle());

  return style.merge(
    LineChartStyler.create(
      palette: _paletteProp(highContrast: highContrast, palette: palette),
    ),
  );
}

/// Fortal presentation for a Mix grouped, stacked, or floating bar chart.
///
/// Generates [FortalBarChart] through `mix_generator`.
@MixWidget(target: BarChart.new)
BarChartStyler fortalBarChartStyle({
  bool highContrast = false,
  List<Color>? palette,
}) {
  final bar = BarStyler.create(
    borderRadius: Prop.token(_barRadiusToken),
  ).width(FortalTokens.space4());
  final style = BarChartStyler()
      .frame(_fortalFrameStyle())
      .axis(_fortalAxisStyle())
      .topAxis(_hiddenAxisStyle())
      .rightAxis(_hiddenAxisStyle())
      .grid(_fortalGridStyle())
      .bar(bar)
      .groupSpacing(FortalTokens.space4())
      .barSpacing(FortalTokens.space2())
      .tooltip(_fortalTooltipStyle());

  return style.merge(
    BarChartStyler.create(
      palette: _paletteProp(highContrast: highContrast, palette: palette),
    ),
  );
}

/// Fortal presentation for a Mix pie or donut chart.
///
/// A positive [centerRadius] renders a donut. Labels are hidden by default so
/// category names can be presented in a caller-owned legend without forcing
/// low-contrast text onto arbitrary categorical colors. Generates
/// [FortalPieChart] through `mix_generator`. For advanced chart-level geometry,
/// pass this recipe directly to [PieChart.style] and merge a [PieSliceStyler].
@MixWidget(target: PieChart.new)
PieChartStyler fortalPieChartStyle({
  bool highContrast = false,
  double centerRadius = 0,
  bool showLabels = false,
  List<Color>? palette,
}) {
  final style = PieChartStyler()
      .frame(_fortalFrameStyle())
      .centerRadius(centerRadius)
      .centerColor(FortalTokens.colorPanel())
      .sliceSpacing(FortalTokens.borderWidth2())
      .selectedSliceRadiusOffset(FortalTokens.space2())
      .slice(
        PieSliceStyler()
            .showLabel(showLabels)
            .cornerRadius(FortalTokens.borderWidth2())
            .label(
              TextStyler()
                  .style(FortalTokens.text1.mix())
                  .fontWeight(.w600)
                  .color(FortalTokens.accentContrast()),
            ),
      )
      .tooltip(_fortalTooltipStyle());

  return style.merge(
    PieChartStyler.create(
      palette: _paletteProp(highContrast: highContrast, palette: palette),
    ),
  );
}

Prop<List<Color>> _paletteProp({
  required bool highContrast,
  required List<Color>? palette,
}) {
  if (palette != null) return Prop.value(List<Color>.unmodifiable(palette));

  return Prop.token(
    highContrast ? _highContrastPaletteToken : _standardPaletteToken,
  );
}

ChartFrameStyler _fortalFrameStyle() => ChartFrameStyler()
    .backgroundColor(MixColors.transparent)
    .showBorder(false)
    .clip(true);

ChartAxisStyler _fortalAxisStyle() => ChartAxisStyler()
    .showLabels(true)
    .label(
      TextStyler().style(FortalTokens.text1.mix()).color(FortalTokens.gray11()),
    )
    .labelSpace(FortalTokens.space2())
    .fitInside(true)
    .fitInsideDistance(FortalTokens.space1())
    .drawBelowEverything(true);

ChartAxisStyler _hiddenAxisStyle() => ChartAxisStyler().showLabels(false);

ChartGridStyler _fortalGridStyle() => ChartGridStyler()
    .show(true)
    .showHorizontal(true)
    .showVertical(false)
    .stroke(
      ChartStrokeStyler()
          .color(FortalTokens.grayA5())
          .width(FortalTokens.borderWidth1()),
    );

ChartTooltipStyler _fortalTooltipStyle() =>
    ChartTooltipStyler.create(
          border: Prop.token(_tooltipBorderToken),
          borderRadius: Prop.token(_tooltipRadiusToken),
          padding: Prop.token(_tooltipPaddingToken),
        )
        .backgroundColor(FortalTokens.colorPanel())
        .margin(FortalTokens.space2())
        .maxWidth(280)
        .fitHorizontally(true)
        .fitVertically(true)
        .text(
          TextStyler()
              .style(FortalTokens.text1.mix())
              .fontWeight(.w500)
              .color(FortalTokens.gray12()),
        );

List<Color> _resolveStandardPalette(BuildContext context) =>
    resolveFortalChartPalette(context);

List<Color> _resolveHighContrastPalette(BuildContext context) =>
    resolveFortalChartPalette(context, highContrast: true);

BorderSide _resolveTooltipBorder(BuildContext context) => BorderSide(
  color: FortalTokens.grayStroke6.resolve(context),
  width: FortalTokens.borderWidth1.resolve(context),
);

BorderRadius _resolveTooltipRadius(BuildContext context) =>
    BorderRadius.all(FortalTokens.radius3.resolve(context));

EdgeInsets _resolveTooltipPadding(BuildContext context) => EdgeInsets.symmetric(
  horizontal: FortalTokens.space3.resolve(context),
  vertical: FortalTokens.space2.resolve(context),
);

BorderRadius _resolveBarRadius(BuildContext context) =>
    BorderRadius.all(FortalTokens.radius2.resolve(context));

double _resolveLineWidth(BuildContext context) =>
    2 * FortalTheme.of(context).scaling.factor;

double _resolveHighContrastLineWidth(BuildContext context) =>
    3 * FortalTheme.of(context).scaling.factor;
