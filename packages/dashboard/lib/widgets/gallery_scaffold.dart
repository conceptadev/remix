import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import 'page_header.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({
    super.key,
    required this.title,
    required this.intro,
    required this.sections,
  });

  final String title;
  final String intro;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(32),
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: 20,
      children: [
        PageHeader(title: title, description: intro),
        ...sections,
      ],
    ),
  );
}

class GallerySection extends StatelessWidget {
  const GallerySection({
    super.key,
    required this.label,
    required this.description,
    required this.child,
  });

  final String label;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) => FortalCard(
    size: .size2,
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: 14,
      children: [
        SectionLabel(label),
        StyledText(
          description,
          style: TextStyler(
            style: FortalTokens.text2.mix(),
          ).color(FortalTokens.gray11()),
        ),
        child,
      ],
    ),
  );
}

class GalleryMatrix extends StatelessWidget {
  const GalleryMatrix({
    super.key,
    required this.rows,
    required this.columns,
    required this.cellBuilder,
    this.cellWidth = 200,
  });

  final List<String> rows;
  final List<String> columns;
  final Widget Function(BuildContext context, int row, int column) cellBuilder;
  final double cellWidth;

  @override
  Widget build(BuildContext context) {
    final border = MixScope.tokenOf(FortalTokens.grayA5, context);
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: border),
          borderRadius: BorderRadius.all(
            MixScope.tokenOf(FortalTokens.radius3, context),
          ),
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            _MatrixRow(
              border: border,
              label: '',
              cells: [for (final column in columns) _MatrixLabel(column)],
              cellWidth: cellWidth,
            ),
            for (final (rowIndex, row) in rows.indexed)
              _MatrixRow(
                border: border,
                label: row,
                cells: [
                  for (var column = 0; column < columns.length; column++)
                    cellBuilder(context, rowIndex, column),
                ],
                cellWidth: cellWidth,
              ),
          ],
        ),
      ),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({
    required this.border,
    required this.label,
    required this.cells,
    required this.cellWidth,
  });

  final Color border;
  final String label;
  final List<Widget> cells;
  final double cellWidth;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: border)),
    ),
    child: Row(
      children: [
        SizedBox(width: 112, child: _MatrixLabel(label)),
        for (final cell in cells)
          Container(
            width: cellWidth,
            constraints: const BoxConstraints(minHeight: 64),
            padding: const EdgeInsets.all(10),
            alignment: .center,
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: border)),
            ),
            child: cell,
          ),
      ],
    ),
  );
}

class _MatrixLabel extends StatelessWidget {
  const _MatrixLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(10),
    child: StyledText(
      label,
      style: TextStyler(
        style: FortalTokens.text1.mix(),
      ).fontWeight(.w600).color(FortalTokens.gray11()),
    ),
  );
}

String galleryLabel(Enum value) {
  final name = value.name.replaceAllMapped(
    RegExp('([A-Z])'),
    (match) => ' ${match.group(1)!.toLowerCase()}',
  );
  return '${name[0].toUpperCase()}${name.substring(1)}';
}
