import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:mix_chart/mix_chart.dart';

import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_chart_styles.dart';

part 'carbon_bar_chart.g.dart';

/// Carbon grouped, stacked, or floating bar chart recipe.
@MixWidget(target: BarChart.new)
BarChartStyler carbonBarChartStyle({
  bool highContrast = false,
  List<Color>? palette,
}) {
  final style = BarChartStyler()
      .frame(carbonChartFrameStyle())
      .axis(carbonChartAxisStyle())
      .topAxis(carbonHiddenChartAxisStyle())
      .rightAxis(carbonHiddenChartAxisStyle())
      .grid(carbonChartGridStyle())
      .bar(
        BarStyler.create(
          borderRadius: Prop.value(BorderRadius.zero),
        ).width(CarbonTokens.spacing05()),
      )
      .groupSpacing(CarbonTokens.spacing05())
      .barSpacing(CarbonTokens.spacing03())
      .tooltip(carbonChartTooltipStyle());

  return style.merge(
    BarChartStyler.create(
      palette: carbonChartPaletteProp(
        highContrast: highContrast,
        palette: palette,
      ),
    ),
  );
}
