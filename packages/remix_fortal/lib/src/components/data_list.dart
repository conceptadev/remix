import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'data_list.g.dart';

/// Radix Themes DataList size presets.
enum FortalDataListSize { size1, size2, size3 }

/// Fortal recipe for [RemixDataList].
@MixWidget(target: RemixDataList.new)
DataListStyler fortalDataListStyle({
  FortalDataListSize size = .size2,
  bool highContrast = false,
}) {
  final metrics = _fortalDataListMetrics(size);

  return DataListStyler()
      .label(
        TextStyler()
            .style(metrics.text.mix())
            .fontWeight(FortalTokens.fontWeightRegular())
            .color(
              highContrast ? FortalTokens.gray12() : FortalTokens.grayA11(),
            ),
      )
      .value(
        TextStyler()
            .style(metrics.text.mix())
            .fontWeight(FortalTokens.fontWeightRegular())
            .color(FortalTokens.gray12()),
      )
      .rowSpacing(metrics.rowSpacing)
      .columnSpacing(metrics.rowSpacing)
      .labelValueSpacing(FortalTokens.space1())
      .minLabelWidth(FortalTokens.dataListLabelMinWidth());
}

({TextStyleToken text, double rowSpacing}) _fortalDataListMetrics(
  FortalDataListSize size,
) => switch (size) {
  .size1 => (text: FortalTokens.text1, rowSpacing: FortalTokens.space3()),
  .size2 => (text: FortalTokens.text2, rowSpacing: FortalTokens.space4()),
  .size3 => (
    text: FortalTokens.text3,
    rowSpacing: FortalTokens.dataListRowGap3(),
  ),
};
