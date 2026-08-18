import 'package:flutter/material.dart';

/// A labelled matrix for reviewing every enum combination of a Fortal preset
/// at once.
///
/// The knob use cases answer "what does this look like with these settings";
/// this answers "do all the settings still agree with each other", which is the
/// question a size or variant change actually puts at risk. Cells are addressed
/// by index rather than by a generic enum bound so that one widget serves the
/// size-only presets, the variant-only presets, and the full matrices without a
/// type parameter per axis.
///
/// Laid out as fixed-width cells in nested rows rather than as a [Table]:
/// `IntrinsicColumnWidth` measures its children, and presets that build a
/// `LayoutBuilder` internally — Toggle among them — cannot answer an intrinsic
/// query. A pinned [cellWidth] buys the same column alignment without ever
/// asking.
class CatalogMatrix extends StatelessWidget {
  const CatalogMatrix({
    super.key,
    required this.columns,
    required this.rows,
    required this.cell,
    this.cellWidth = 168,
  });

  /// Labels across the top, conventionally the sizes.
  final List<String> columns;

  /// Labels down the side, conventionally the variants. Pass [noRowAxis] for a
  /// preset that has no second axis.
  final List<String> rows;

  final Widget Function(int row, int column) cell;

  /// Widen this for presets whose cells are wider than the default, so the
  /// columns stay aligned instead of overflowing into each other.
  final double cellWidth;

  static const _rowLabelWidth = 84.0;

  @override
  Widget build(BuildContext context) {
    final labelStyle = DefaultTextStyle.of(
      context,
    ).style.copyWith(fontSize: 11, color: Colors.grey);
    final showRowLabels = rows.any((label) => label.isNotEmpty);

    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showRowLabels) const SizedBox(width: _rowLabelWidth),
                    for (final column in columns)
                      SizedBox(
                        width: cellWidth,
                        child: Text(column, style: labelStyle),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                for (var row = 0; row < rows.length; row += 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (showRowLabels)
                          SizedBox(
                            width: _rowLabelWidth,
                            child: Text(rows[row], style: labelStyle),
                          ),
                        for (
                          var column = 0;
                          column < columns.length;
                          column += 1
                        )
                          SizedBox(
                            width: cellWidth,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: cell(row, column),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The enum's `name` values, ready to label a [CatalogMatrix] axis.
List<String> labelsOf(List<Enum> values) => [
  for (final value in values) value.name,
];

/// The single unlabelled row a preset with no variant axis needs.
const noRowAxis = <String>[''];
