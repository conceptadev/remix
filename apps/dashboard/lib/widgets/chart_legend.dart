import 'package:flutter/material.dart';
import 'package:mix_chart/mix_chart.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'typography.dart';

enum ChartLegendPattern { solid, dashed, outlined, dot }

@immutable
final class ChartLegendItem {
  const ChartLegendItem({
    required this.id,
    required this.label,
    required this.color,
    this.value,
    this.pattern = .solid,
  });

  final String id;
  final String label;
  final String? value;
  final Color color;
  final ChartLegendPattern pattern;

  String get displayLabel => value == null ? label : '$label $value';
}

List<ChartLegendItem> percentagePieLegendItems({
  required List<PieSlice> slices,
  required List<Color> palette,
  ChartLegendPattern pattern = .dot,
}) {
  assert(
    palette.length >= slices.length,
    'The palette must provide a color for every pie slice.',
  );

  return List.unmodifiable([
    for (final (index, slice) in slices.indexed)
      ChartLegendItem(
        id: slice.id.toString(),
        label: slice.label,
        value: '${slice.value.toInt()}%',
        color: palette[index],
        pattern: pattern,
      ),
  ]);
}

class ChartLegend extends StatelessWidget {
  const ChartLegend({
    super.key,
    required this.items,
    required this.semanticLabel,
  });

  final List<ChartLegendItem> items;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final itemGap = MixScope.tokenOf(FortalTokens.space2, context);
    final groupGap = MixScope.tokenOf(FortalTokens.space4, context);

    return Semantics(
      container: true,
      label: semanticLabel,
      child: ExcludeSemantics(
        child: WrapBox(
          style: WrapBoxStyler().spacing(groupGap).runSpacing(itemGap),
          children: [
            for (final item in items)
              RowBox(
                style: FlexBoxStyler()
                    .spacing(itemGap)
                    .mainAxisSize(.min)
                    .crossAxisAlignment(.center),
                children: [
                  _LegendMark(item),
                  StyledText(
                    item.displayLabel,
                    style: dashboardText(.size1, weight: .medium, tone: .muted),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _LegendMark extends StatelessWidget {
  const _LegendMark(this.item);

  final ChartLegendItem item;

  @override
  Widget build(BuildContext context) {
    final radius = MixScope.tokenOf(FortalTokens.radius2, context).x;
    final key = ValueKey('legend-pattern-${item.id}-${item.pattern.name}');

    return switch (item.pattern) {
      .solid => Box(
        key: key,
        style: BoxStyler()
            .size(18, 4)
            .color(item.color)
            .borderRadius(.circular(radius)),
      ),
      .dashed => RowBox(
        key: key,
        style: FlexBoxStyler().spacing(3).crossAxisAlignment(.center),
        children: [
          for (var index = 0; index < 2; index++)
            Box(
              style: BoxStyler()
                  .size(7, 4)
                  .color(item.color)
                  .borderRadius(.circular(radius)),
            ),
        ],
      ),
      .outlined => Box(
        key: key,
        style: BoxStyler()
            .size(14, 14)
            .border(.color(item.color).width(2))
            .borderRadius(.circular(radius)),
      ),
      .dot => Box(
        key: key,
        style: BoxStyler()
            .size(10, 10)
            .color(item.color)
            .borderRadius(.circular(99)),
      ),
    };
  }
}
