import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:mix_chart/mix_chart.dart';

import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_chart_styles.dart';

part 'carbon_pie_chart.g.dart';

/// Carbon pie/donut chart recipe generated over [PieChart].
@MixWidget(target: PieChart.new)
PieChartStyler carbonPieChartStyle({
  bool highContrast = false,
  double centerRadius = 0,
  bool showLabels = false,
  List<Color>? palette,
}) {
  final style = PieChartStyler()
      .frame(carbonChartFrameStyle())
      .centerRadius(centerRadius)
      .centerColor(CarbonTokens.background())
      .sliceSpacing(1)
      .selectedSliceRadiusOffset(CarbonTokens.spacing03())
      .slice(
        PieSliceStyler()
            .showLabel(showLabels)
            .cornerRadius(0)
            .label(
              TextStyler()
                  .style(CarbonTokens.label01.mix())
                  .fontWeight(.w600)
                  .color(CarbonTokens.textOnColor()),
            ),
      )
      .tooltip(carbonChartTooltipStyle());

  return style.merge(
    PieChartStyler.create(
      palette: carbonChartPaletteProp(
        highContrast: highContrast,
        palette: palette,
      ),
    ),
  );
}
