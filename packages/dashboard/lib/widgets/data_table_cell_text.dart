import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'typography.dart';

/// Compact single-line cell text for a [RemixDataTable] body cell.
///
/// [primary] switches between the emphasized and muted roles shared by every
/// data table in the dashboard.
class DataTableCellText extends StatelessWidget {
  const DataTableCellText(this.text, {super.key, this.primary = false});

  // Only two styles exist, and a table renders one per cell per build.
  static final _primary = dashboardTextLine(
    FortalTokens.text2,
    weight: FontWeight.w500,
  );
  static final _secondary = dashboardTextLine(
    FortalTokens.text2,
    weight: FontWeight.w400,
    tone: TextTone.muted,
  );

  final String text;
  final bool primary;

  @override
  Widget build(BuildContext context) =>
      StyledText(text, style: primary ? _primary : _secondary);
}
