import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart'
    show RenderTable, SemanticsConfiguration;
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_action_surface.dart';

/// A cell in a [CarbonStructuredListRow].
class CarbonStructuredListCell extends StatelessWidget {
  const CarbonStructuredListCell({
    super.key,
    required this.child,
    this.header = false,
    this.flex = 1,
    this.semanticLabel,
  }) : assert(flex > 0);

  final Widget child;
  final bool header;
  final int flex;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => _content(context);

  Widget _content(BuildContext context) => Semantics(
    label: semanticLabel,
    child: Padding(
      padding: .symmetric(
        horizontal: CarbonTokens.spacing05.resolve(context),
        vertical: CarbonTokens.spacing04.resolve(context),
      ),
      child: DefaultTextStyle.merge(
        style: header
            ? CarbonTokens.headingCompact01.resolve(context)
            : CarbonTokens.bodyCompact01.resolve(context),
        child: child,
      ),
    ),
  );
}

/// One header or body row in [CarbonStructuredList].
class CarbonStructuredListRow extends StatelessWidget {
  const CarbonStructuredListRow({
    super.key,
    required this.cells,
    this.header = false,
    this.selected = false,
    this.onPressed,
    this.enabled = true,
    this.semanticLabel,
  });

  final List<CarbonStructuredListCell> cells;
  final bool header;
  final bool selected;
  final VoidCallback? onPressed;
  final bool enabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => _StructuredListLayout(
    semanticLabel: null,
    children: [_tableRow(context)],
  );

  TableRow _tableRow(BuildContext context) => .new(
    children: [
      for (var index = 0; index < cells.length; index++)
        _cell(context, cells[index], index),
    ],
  );

  Widget _cell(BuildContext context, CarbonStructuredListCell cell, int index) {
    final layer = CarbonLayer.of(context);
    final content = Box(
      style: BoxStyler()
          .minHeight(header ? 40 : 48)
          .color(
            header
                ? layer.color(.layerAccent).resolve(context)
                : selected
                ? layer.color(.layerSelected).resolve(context)
                : layer.color(.layer).resolve(context),
          )
          .border(
            BoxBorderMix.bottom(
              BorderSideMix(
                color: layer.color(.borderSubtle).resolve(context),
                width: 1,
              ),
            ),
          )
          .alignment(.centerLeft),
      child: cell._content(context),
    );
    if (index == 0 && semanticLabel != null) {
      return CarbonActionSurface(
        semanticLabel: semanticLabel!,
        selected: selected,
        enabled: enabled,
        onPressed: onPressed,
        builder: (context, focused, hovered, pressed) => content,
      );
    }
    if (onPressed == null || !enabled) return content;

    return GestureDetector(
      behavior: .opaque,
      excludeFromSemantics: true,
      onTap: onPressed,
      child: content,
    );
  }
}

/// Carbon's metadata-oriented, optionally selectable structured list.
class CarbonStructuredList extends StatelessWidget {
  const CarbonStructuredList({
    super.key,
    required this.rows,
    this.semanticLabel,
  });

  final List<CarbonStructuredListRow> rows;
  final String? semanticLabel;

  bool _debugRowsAreValid() {
    final firstRow = rows.firstOrNull;
    assert(firstRow != null, 'CarbonStructuredList.rows cannot be empty.');
    if (firstRow == null) return false;
    final columns = firstRow.cells.length;
    assert(columns > 0, 'CarbonStructuredList rows cannot be empty.');
    assert(
      rows.every((row) => row.cells.length == columns),
      'CarbonStructuredList rows must have the same number of cells.',
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugRowsAreValid());
    final firstRow = rows.firstOrNull;
    if (firstRow == null) return const SizedBox.shrink();

    return _StructuredListLayout(
      semanticLabel: semanticLabel,
      columnWidths: {
        for (final (index, cell) in firstRow.cells.indexed)
          index: FlexColumnWidth(cell.flex.toDouble()),
      },
      children: [for (final row in rows) row._tableRow(context)],
    );
  }
}

class _StructuredListLayout extends Table {
  _StructuredListLayout({
    required this.semanticLabel,
    required super.children,
    super.columnWidths,
  }) : super(defaultVerticalAlignment: .intrinsicHeight);

  final String? semanticLabel;

  @override
  RenderTable createRenderObject(BuildContext context) => _RenderStructuredList(
    columns: children.firstOrNull?.children.length ?? 0,
    rows: children.length,
    columnWidths: columnWidths,
    defaultColumnWidth: defaultColumnWidth,
    textDirection: textDirection ?? Directionality.of(context),
    border: border,
    configuration: createLocalImageConfiguration(context),
    defaultVerticalAlignment: defaultVerticalAlignment,
    textBaseline: textBaseline,
  )..semanticLabel = semanticLabel;

  @override
  void updateRenderObject(BuildContext context, RenderTable renderObject) {
    super.updateRenderObject(context, renderObject);
    (renderObject as _RenderStructuredList).semanticLabel = semanticLabel;
  }
}

class _RenderStructuredList extends RenderTable {
  _RenderStructuredList({
    super.columns,
    super.rows,
    super.columnWidths,
    super.defaultColumnWidth,
    required super.textDirection,
    super.border,
    super.configuration,
    super.defaultVerticalAlignment,
    super.textBaseline,
  });

  String? _semanticLabel;

  set semanticLabel(String? value) {
    if (_semanticLabel == value) return;
    _semanticLabel = value;
    markNeedsSemanticsUpdate();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    final label = _semanticLabel;
    if (label != null) {
      config
        ..label = label
        ..textDirection = textDirection;
    }
  }
}
