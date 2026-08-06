import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

/// Compact single-line cell text for a [RemixDataTable] body cell.
///
/// [primary] switches between the emphasized (`gray-12`, medium weight) and
/// muted (`gray-11`, regular weight) roles shared by the dashboard's data
/// table pages.
class DataTableCellText extends StatelessWidget {
  const DataTableCellText(this.text, {super.key, this.primary = false});

  final String text;
  final bool primary;

  @override
  Widget build(BuildContext context) => StyledText(
    text,
    style: TextStyler(style: FortalTokens.text2.mix())
        .fontWeight(primary ? .w500 : .w400)
        .color(primary ? FortalTokens.gray12() : FortalTokens.gray11())
        .maxLines(1)
        .overflow(.ellipsis),
  );
}
