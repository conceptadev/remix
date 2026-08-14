import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:mix_chart/mix_chart.dart';

import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_chart_styles.dart';

part 'carbon_line_chart.g.dart';

/// Carbon line/area chart recipe generated over [LineChart].
@MixWidget(target: LineChart.new)
LineChartStyler carbonLineChartStyle({
  bool highContrast = false,
  bool showMarkers = false,
  bool smooth = false,
  List<Color>? palette,
}) {
  final style = LineChartStyler()
      .frame(carbonChartFrameStyle())
      .axis(carbonChartAxisStyle())
      .topAxis(carbonHiddenChartAxisStyle())
      .rightAxis(carbonHiddenChartAxisStyle())
      .grid(carbonChartGridStyle())
      .series(
        LineSeriesStyler()
            .curve(smooth ? .curved : .straight)
            .smoothness(0.18)
            .preventCurveOvershooting(true)
            .stroke(ChartStrokeStyler().width(highContrast ? 3 : 2))
            .marker(
              ChartMarkerStyler()
                  .show(showMarkers)
                  .radius(4)
                  .borderColor(CarbonTokens.background())
                  .borderWidth(1),
            ),
      )
      .tooltip(carbonChartTooltipStyle());

  return style.merge(
    LineChartStyler.create(
      palette: carbonChartPaletteProp(
        highContrast: highContrast,
        palette: palette,
      ),
    ),
  );
}
