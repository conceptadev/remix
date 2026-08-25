import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../utils/text.dart';
import 'page_header.dart';
import 'typography.dart';

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
        CardHeading(title: label, description: description),
        child,
      ],
    ),
  );
}

/// A typed Mix Grid whose axis values label and build every comparison cell.
class GalleryMatrix<R, C> extends StatelessWidget {
  const GalleryMatrix({
    super.key,
    required this.rows,
    required this.columns,
    required this.rowLabelBuilder,
    required this.columnLabelBuilder,
    required this.cellBuilder,
    this.cellWidth = 200,
  });

  final List<R> rows;
  final List<C> columns;
  final String Function(R value) rowLabelBuilder;
  final String Function(C value) columnLabelBuilder;
  final Widget Function(BuildContext context, R row, C column) cellBuilder;
  final double cellWidth;

  @override
  Widget build(BuildContext context) {
    final divider = BorderSideMix(color: FortalTokens.grayA5(), width: 1);
    final borderRadius = BorderRadiusMix.all(FortalTokens.radius3());
    final GridBoxStyler gridStyle = .columns([
      const .fixed(112),
      for (final _ in columns) .fixed(cellWidth),
    ]);

    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Box(
        style: BoxStyler()
            .borderRadius(borderRadius)
            .clipBehavior(.antiAlias)
            .foregroundDecoration(
              BoxDecorationMix(
                border: BoxBorderMix.all(divider),
                borderRadius: borderRadius,
              ),
            ),
        child: GridBox(
          style: gridStyle,
          children: [
            _MatrixCell(
              divider: divider,
              alignment: .centerLeft,
              child: const _MatrixLabel(''),
            ),
            for (final column in columns)
              _MatrixCell(
                divider: divider,
                hasLeadingDivider: true,
                child: _MatrixLabel(columnLabelBuilder(column)),
              ),
            for (final row in rows) ...[
              _MatrixCell(
                divider: divider,
                hasTopDivider: true,
                alignment: .centerLeft,
                child: _MatrixLabel(rowLabelBuilder(row)),
              ),
              for (final column in columns)
                _MatrixCell(
                  divider: divider,
                  hasLeadingDivider: true,
                  hasTopDivider: true,
                  child: cellBuilder(context, row, column),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MatrixCell extends StatelessWidget {
  const _MatrixCell({
    required this.child,
    required this.divider,
    this.hasLeadingDivider = false,
    this.hasTopDivider = false,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final BorderSideMix divider;
  final bool hasLeadingDivider;
  final bool hasTopDivider;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    var style = BoxStyler()
        .minHeight(64)
        .padding(.all(10))
        .alignment(alignment);
    if (hasLeadingDivider || hasTopDivider) {
      style = style.foregroundDecoration(
        BoxDecorationMix(
          border: BorderMix(
            left: hasLeadingDivider ? divider : null,
            top: hasTopDivider ? divider : null,
          ),
        ),
      );
    }

    return Box(style: style, child: child);
  }
}

/// A comparison matrix whose labels come directly from its enum axes.
class GalleryEnumMatrix<R extends Enum, C extends Enum>
    extends GalleryMatrix<R, C> {
  const GalleryEnumMatrix({
    super.key,
    required super.rows,
    required super.columns,
    required super.cellBuilder,
    super.cellWidth,
  }) : super(rowLabelBuilder: enumLabel, columnLabelBuilder: enumLabel);
}

class _MatrixLabel extends StatelessWidget {
  const _MatrixLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => StyledText(
    label,
    style: dashboardText(.size1, weight: .medium, tone: .muted),
  );
}
