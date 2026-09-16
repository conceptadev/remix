import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'data_list.g.dart';

/// Radix Themes DataList size presets.
enum UiDataListSize { size1, size2, size3 }

/// Ui recipe for [RemixDataList].
@MixWidget(target: RemixDataList.new)
DataListStyler uiDataListStyle({
  UiDataListSize size = .size2,
  bool highContrast = false,
  DataListStyler style = const DataListStyler.create(),
}) {
  final metrics = _uiDataListMetrics(size);

  return DataListStyler()
      .label(
        TextStyler()
            .style(metrics.text.mix())
            .fontWeight(UiTokens.fontWeightRegular())
            .color(highContrast ? UiTokens.gray12() : UiTokens.grayA11()),
      )
      .value(
        TextStyler()
            .style(metrics.text.mix())
            .fontWeight(UiTokens.fontWeightRegular())
            .color(UiTokens.gray12()),
      )
      .rowSpacing(metrics.rowSpacing)
      .columnSpacing(metrics.rowSpacing)
      .labelValueSpacing(UiTokens.space1())
      .minLabelWidth(UiTokens.dataListLabelMinWidth())
      .merge(style);
}

({TextStyleToken text, double rowSpacing}) _uiDataListMetrics(
  UiDataListSize size,
) => switch (size) {
  .size1 => (text: UiTokens.text1, rowSpacing: UiTokens.space3()),
  .size2 => (text: UiTokens.text2, rowSpacing: UiTokens.space4()),
  .size3 => (text: UiTokens.text3, rowSpacing: UiTokens.dataListRowGap3()),
};
