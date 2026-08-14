import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart'
    show RenderTable, SemanticsConfiguration;
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../icons/icons.dart';
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
  Widget build(BuildContext context) {
    final selection = !header && (onPressed != null || selected);

    return _StructuredListLayout(
      semanticLabel: null,
      columnWidths: _columnWidths(context, selection: selection),
      children: [_tableRow(context, showSelectionIndicator: selection)],
    );
  }

  Map<int, TableColumnWidth> _columnWidths(
    BuildContext context, {
    required bool selection,
  }) => {
    if (selection) 0: FixedColumnWidth(CarbonTokens.spacing09.resolve(context)),
    for (final (index, cell) in cells.indexed)
      index + (selection ? 1 : 0): FlexColumnWidth(cell.flex.toDouble()),
  };

  TableRow _tableRow(
    BuildContext context, {
    required bool showSelectionIndicator,
  }) => .new(
    children: [
      if (showSelectionIndicator) _selectionCell(context),
      for (var index = 0; index < cells.length; index++)
        _cell(context, cells[index], index),
    ],
  );

  Widget _cellChrome(BuildContext context, Widget child) {
    final layer = CarbonLayer.of(context);
    final background = switch ((header, selected)) {
      (true, _) => layer.color(.layerAccent).resolve(context),
      (false, true) => layer.color(.layerSelected).resolve(context),
      (false, false) => layer.color(.layer).resolve(context),
    };

    return Box(
      style: BoxStyler()
          .minHeight(header ? 40 : 48)
          .color(background)
          .border(
            BoxBorderMix.bottom(
              BorderSideMix(
                color: layer.color(.borderSubtle).resolve(context),
                width: 1,
              ),
            ),
          )
          .alignment(.centerLeft),
      child: child,
    );
  }

  Widget _selectionCell(BuildContext context) {
    final icon = switch ((header, selected)) {
      (true, _) => null,
      (false, true) => CarbonIcons.radioButtonChecked,
      (false, false) => CarbonIcons.radioButton,
    };
    final content = _cellChrome(
      context,
      Padding(
        padding: EdgeInsetsDirectional.only(
          start: CarbonTokens.spacing05.resolve(context),
        ),
        child: icon == null
            ? const SizedBox.shrink()
            : ExcludeSemantics(
                child: Icon(
                  icon,
                  size: CarbonTokens.iconSize01.resolve(context),
                  color:
                      (enabled
                              ? CarbonTokens.iconPrimary
                              : CarbonTokens.iconDisabled)
                          .resolve(context),
                ),
              ),
      ),
    );
    if (onPressed == null || !enabled) return content;

    return GestureDetector(
      behavior: .opaque,
      excludeFromSemantics: true,
      onTap: onPressed,
      child: content,
    );
  }

  Widget _cell(BuildContext context, CarbonStructuredListCell cell, int index) {
    final content = _cellChrome(context, cell._content(context));
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
    final selection = rows.any(
      (row) => !row.header && (row.onPressed != null || row.selected),
    );

    return _StructuredListLayout(
      semanticLabel: semanticLabel,
      columnWidths: firstRow._columnWidths(context, selection: selection),
      children: [
        for (final row in rows)
          row._tableRow(context, showSelectionIndicator: selection),
      ],
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
