part of 'data_list.dart';

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

class _FortalDataListMetrics {
  const _FortalDataListMetrics({required this.text, required this.rowSpacing});

  final TextStyleToken text;
  final double rowSpacing;
}

_FortalDataListMetrics _fortalDataListMetrics(FortalDataListSize size) =>
    switch (size) {
      .size1 => _FortalDataListMetrics(
        text: FortalTokens.text1,
        rowSpacing: FortalTokens.space3(),
      ),
      .size2 => _FortalDataListMetrics(
        text: FortalTokens.text2,
        rowSpacing: FortalTokens.space4(),
      ),
      .size3 => _FortalDataListMetrics(
        text: FortalTokens.text3,
        rowSpacing: FortalTokens.dataListRowGap3(),
      ),
    };
