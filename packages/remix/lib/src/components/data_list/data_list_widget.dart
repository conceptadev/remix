part of 'data_list.dart';

/// How a [RemixDataListItem] aligns its label and value against each other.
enum RemixDataListItemAlignment { start, center, end, baseline, stretch }

/// One label/value pair displayed by a [RemixDataList].
///
/// Exactly one of [value] or [child] must be provided. This data-driven item
/// model is deliberately narrower than Radix's compositional
/// Root/Item/Label/Value children: it keeps the shared label column and the
/// one-node-per-row semantics deterministic while still admitting one custom
/// [child] widget as the value.
@immutable
class RemixDataListItem {
  const RemixDataListItem({
    this.key,
    required this.label,
    this.value,
    this.child,
    this.semanticValue,
    this.alignment = RemixDataListItemAlignment.baseline,
  }) : assert(
         (value == null) != (child == null),
         'Provide exactly one of value or child to RemixDataListItem.',
       ),
       assert(label != '', 'RemixDataListItem.label must be nonempty.'),
       assert(
         value != '',
         'RemixDataListItem.value must be nonempty when provided.',
       ),
       assert(
         semanticValue == null || child != null,
         'RemixDataListItem.semanticValue is only valid together with child.',
       ),
       assert(
         semanticValue != '',
         'RemixDataListItem.semanticValue must be nonempty when provided.',
       );

  /// Stable identity for this row across list mutations.
  ///
  /// Without a key, rows are matched by position, so a stateful [child]
  /// keeps its state at the old position after a reorder and can end up
  /// attached to the wrong label. Provide a key whenever items with custom
  /// children are reordered, inserted, or removed.
  final LocalKey? key;

  /// Visible label text, also announced as the row's semantic label.
  ///
  /// Must be nonempty and not whitespace-only: the const constructor rejects
  /// the empty string, and the renderer additionally rejects trimmed-blank
  /// text in debug builds. The text itself is never trimmed.
  final String label;

  /// String value rendered with the data list's value typography.
  ///
  /// When provided, must be nonempty and not whitespace-only; it is
  /// announced as the row's accessible value verbatim.
  final String? value;

  /// Custom value widget that keeps its own semantics unless [semanticValue]
  /// summarizes it.
  final Widget? child;

  /// Opt-in noninteractive summary announced instead of [child]'s semantics.
  ///
  /// Only for display-only children: it excludes the child's semantics
  /// entirely, so an interactive child must omit it to keep its actions
  /// reachable. When provided, must be nonempty and not whitespace-only.
  final String? semanticValue;

  /// Cross-cell alignment for this row.
  ///
  /// [RemixDataListItemAlignment.baseline] is meaningful for string values,
  /// where both cells expose a text baseline. A [child] row requesting
  /// baseline deterministically maps to top/start, and vertical orientation
  /// maps baseline to start; both adaptations are documented Radix deltas.
  final RemixDataListItemAlignment alignment;
}

/// A semantic label/value list with a shared horizontal label column or a
/// stacked vertical layout.
///
/// Horizontal orientation lays every row out in one two-column [Table], so
/// labels align across all items exactly like Radix's shared `auto 1fr` grid
/// columns. Vertical orientation stacks label above value per item.
///
/// ## Layout contract
///
/// In a bounded horizontal list, textual values can shrink to their widest
/// grapheme cluster and break long tokens only between grapheme clusters.
/// Their announced value remains the caller's original string. Custom value
/// widgets keep their normal minimum intrinsic width instead. The narrowest
/// supported width is therefore the resolved label column minimum (the greater
/// of `minLabelWidth` and every label's minimum intrinsic width), plus
/// `columnSpacing`, plus the greatest value minimum for the rows. Below that
/// structural bound content can overflow; the renderer never switches
/// orientation on its own, so rebuild with [orientation] set to [Axis.vertical]
/// when the available width is below the minimum.
///
/// ## Example
///
/// ```dart
/// RemixDataList(
///   items: const [
///     RemixDataListItem(label: 'Name', value: 'Leo Farias'),
///     RemixDataListItem(label: 'Email', value: 'leo@example.com'),
///   ],
/// )
/// ```
// Deliberate: Radix DataList is display-only (`dl`/`dt`/`dd`) with no
// interaction behavior, so there is no Naked primitive to headlessly
// coordinate and this widget composes Flutter primitives directly. A Flutter
// `Table` is reused as the horizontal layout because it is the one primitive
// that negotiates a single shared label-column width across every row;
// independent per-item Rows would let the columns drift.
class RemixDataList extends StyleWidget<DataListSpec> {
  /// Creates a data list from [items].
  const RemixDataList({
    super.key,
    required this.items,
    this.orientation = Axis.horizontal,
    this.semanticLabel,
    this.excludeSemantics = false,
    super.style = const DataListStyler.create(),
    super.styleSpec,
  });

  static final styleFrom = DataListStyler.new;

  /// The rows to display. May be empty.
  ///
  /// The list is retained as supplied — a const constructor cannot copy — so
  /// callers must not mutate it during build. Each build reads one immutable
  /// snapshot of the current contents.
  final List<RemixDataListItem> items;

  /// Layout axis. The constructor always wins over styles; orientation is
  /// intentionally absent from [DataListSpec].
  final Axis orientation;

  /// Optional accessible name for the list itself.
  ///
  /// When provided, must not be whitespace-only (asserted in debug builds).
  final String? semanticLabel;

  /// Whether to remove the entire list, rows included, from semantics.
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context, DataListSpec spec) {
    // One immutable snapshot per build enforces the no-mutation-during-build
    // contract for everything rendered below.
    final rows = List<RemixDataListItem>.unmodifiable(items);
    assert(_debugItemsHaveAccessibleText(rows));
    assert(
      semanticLabel == null || semanticLabel!.trim().isNotEmpty,
      'RemixDataList.semanticLabel must not be blank when provided: it '
      'becomes the accessible name of the list.',
    );

    final metrics = _DataListMetrics.resolve(spec);

    final Widget layout = orientation == Axis.horizontal
        ? _HorizontalDataListLayout(items: rows, spec: spec, metrics: metrics)
        : _VerticalDataListLayout(items: rows, spec: spec, metrics: metrics);

    final content = Semantics(
      role: SemanticsRole.list,
      container: true,
      explicitChildNodes: true,
      label: semanticLabel,
      child: Box(styleSpec: spec.container, child: layout),
    );

    return excludeSemantics ? ExcludeSemantics(child: content) : content;
  }
}

/// Debug guard for accessible names: [RemixDataListItem.label],
/// [RemixDataListItem.value], and [RemixDataListItem.semanticValue] are
/// announced by assistive technology, so a whitespace-only string would
/// produce a silently unlabeled row. The const item constructor can only
/// reject exactly empty strings (trimming is not constant-evaluable), so the
/// renderer rejects trimmed-blank strings here. Displayed caller text is
/// never trimmed or rewritten.
bool _debugItemsHaveAccessibleText(List<RemixDataListItem> items) {
  for (final item in items) {
    assert(
      item.label.trim().isNotEmpty,
      'RemixDataListItem.label must not be blank: it is announced as the '
      'accessible row label.',
    );
    final value = item.value;
    assert(
      value == null || value.trim().isNotEmpty,
      'RemixDataListItem.value must not be blank when provided: it is '
      'announced as the accessible row value.',
    );
    final semanticValue = item.semanticValue;
    assert(
      semanticValue == null || semanticValue.trim().isNotEmpty,
      'RemixDataListItem.semanticValue must not be blank when provided: it '
      'replaces the announcement of the child.',
    );
  }

  return true;
}

/// Resolved non-negative geometry, defaulting every absent scalar to zero.
class _DataListMetrics {
  const _DataListMetrics({
    required this.rowSpacing,
    required this.columnSpacing,
    required this.labelValueSpacing,
    required this.minLabelWidth,
  });

  factory _DataListMetrics.resolve(DataListSpec spec) {
    final metrics = _DataListMetrics(
      rowSpacing: spec.rowSpacing ?? 0.0,
      columnSpacing: spec.columnSpacing ?? 0.0,
      labelValueSpacing: spec.labelValueSpacing ?? 0.0,
      minLabelWidth: spec.minLabelWidth ?? 0.0,
    );
    assert(
      metrics.rowSpacing >= 0,
      'DataList rowSpacing must resolve to a non-negative value.',
    );
    assert(
      metrics.columnSpacing >= 0,
      'DataList columnSpacing must resolve to a non-negative value.',
    );
    assert(
      metrics.labelValueSpacing >= 0,
      'DataList labelValueSpacing must resolve to a non-negative value.',
    );
    assert(
      metrics.minLabelWidth >= 0,
      'DataList minLabelWidth must resolve to a non-negative value.',
    );

    return metrics;
  }

  final double rowSpacing;
  final double columnSpacing;
  final double labelValueSpacing;
  final double minLabelWidth;
}

/// The visual label of every row form: the row's semantics node carries the
/// label text, so the visible label is always excluded to avoid a second
/// announcement.
Widget _labelCell(RemixDataListItem item, DataListSpec spec) {
  return ExcludeSemantics(
    child: Box(
      styleSpec: spec.labelContainer,
      child: StyledText(item.label, styleSpec: spec.label),
    ),
  );
}

Widget _valueCell(
  RemixDataListItem item,
  DataListSpec spec, {
  bool alignChildStart = false,
}) {
  final value = item.value;
  Widget content;
  if (value != null) {
    // String values keep the full column width and expose a grapheme-level
    // minimum intrinsic width so unbroken identifiers can wrap.
    content = _BreakableDataListValue(
      child: StyledText(value, styleSpec: spec.value),
    );
  } else {
    // Arbitrary children inherit the resolved value typography the same way
    // Radix cascades `dd` styles onto custom markup.
    content = RemixDefaultContentStyle(text: spec.value, child: item.child!);
    if (alignChildStart) {
      // In the horizontal table the cell width is tight; without this a
      // custom child would stretch across the whole value column instead of
      // sitting inline at the start like Radix `dd` content.
      content = Align(
        alignment: AlignmentDirectional.topStart,
        heightFactor: 1.0,
        child: content,
      );
    }
  }

  return Box(styleSpec: spec.valueContainer, child: content);
}

/// One list-item semantics node per vertical row.
///
/// A string value or a [RemixDataListItem.semanticValue] summary collapses
/// the row to a single label/value node and excludes the visible descendants.
/// A custom child without a summary keeps its own semantics — including
/// actions — as explicit child nodes of the row.
///
/// Horizontal rows use [_HorizontalRowSemantics] instead: a [Table] offers no
/// shared widget ancestor spanning both cells of a row, so the row node is
/// attached to the value cell and its bounds are expanded at the render level
/// to cover the full row.
class _RowSemantics extends StatelessWidget {
  const _RowSemantics({required this.item, required this.child});

  final RemixDataListItem item;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final summary = item.value ?? item.semanticValue;

    return Semantics(
      role: SemanticsRole.listItem,
      container: true,
      explicitChildNodes: summary == null,
      excludeSemantics: summary != null,
      label: item.label,
      value: summary,
      child: child,
    );
  }
}

class _HorizontalDataListLayout extends StatelessWidget {
  const _HorizontalDataListLayout({
    required this.items,
    required this.spec,
    required this.metrics,
  });

  final List<RemixDataListItem> items;
  final DataListSpec spec;
  final _DataListMetrics metrics;

  static TableCellVerticalAlignment _cellAlignment(RemixDataListItem item) {
    switch (item.alignment) {
      case RemixDataListItemAlignment.start:
        return TableCellVerticalAlignment.top;
      case RemixDataListItemAlignment.center:
        return TableCellVerticalAlignment.middle;
      case RemixDataListItemAlignment.end:
        return TableCellVerticalAlignment.bottom;
      case RemixDataListItemAlignment.stretch:
        // Deliberate: `fill` on every cell of a row leaves RenderTable no
        // height source and collapses the row to zero height, so stretch maps
        // to intrinsicHeight, which sizes both cells to the tallest cell.
        return TableCellVerticalAlignment.intrinsicHeight;
      case RemixDataListItemAlignment.baseline:
        // Deliberate: an arbitrary child may expose no text baseline, so a
        // custom-child baseline row maps to top instead of relying on
        // RenderTable's silent per-cell fallback.
        return item.child == null
            ? TableCellVerticalAlignment.baseline
            : TableCellVerticalAlignment.top;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rows = <TableRow>[];
    for (var index = 0; index < items.length; index += 1) {
      final item = items[index];
      final alignment = _cellAlignment(item);
      final rowGap = index == items.length - 1 ? 0.0 : metrics.rowSpacing;

      final summarized = item.value != null || item.semanticValue != null;
      final valueCell = _valueCell(item, spec, alignChildStart: true);

      rows.add(
        TableRow(
          key: item.key,
          children: [
            _DataListCellAlignment(
              verticalAlignment: alignment,
              child: Padding(
                padding: EdgeInsets.only(bottom: rowGap),
                child: _labelCell(item, spec),
              ),
            ),
            _DataListCellAlignment(
              verticalAlignment: alignment,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: metrics.columnSpacing,
                  bottom: rowGap,
                ),
                child: _HorizontalRowSemantics(
                  item: item,
                  child: summarized
                      ? ExcludeSemantics(child: valueCell)
                      : valueCell,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return _DataListTable(
      columnWidths: <int, TableColumnWidth>{
        0: MaxColumnWidth(
          FixedColumnWidth(metrics.minLabelWidth),
          const IntrinsicColumnWidth(),
        ),
        // Intrinsic sizing preserves natural width under an unbounded parent;
        // flex fills a finite parent. Text values report one grapheme cluster
        // as their minimum while custom children retain their own minimum.
        1: const IntrinsicColumnWidth(flex: 1.0),
      },
      textDirection: Directionality.of(context),
      textBaseline: TextBaseline.alphabetic,
      children: rows,
    );
  }
}

/// Lets a textual value shrink to its widest grapheme cluster.
///
/// Flutter's paragraph layout already performs emergency line breaks only at
/// grapheme boundaries. Its minimum intrinsic width is word-based, though,
/// which prevents a table column from becoming narrow enough to use those
/// breaks for an identifier without spaces. This render proxy changes only
/// that intrinsic-width signal; layout, painting, baselines, and semantics
/// continue to come from the original [StyledText].
class _BreakableDataListValue extends SingleChildRenderObjectWidget {
  const _BreakableDataListValue({required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderBreakableDataListValue();
  }
}

class _RenderBreakableDataListValue extends RenderProxyBox {
  @override
  double computeMinIntrinsicWidth(double height) {
    final paragraph = _findParagraph(child);
    if (paragraph == null) return super.computeMinIntrinsicWidth(height);

    final plainText = paragraph.text.toPlainText(
      includeSemanticsLabels: false,
      includePlaceholders: false,
    );
    if (plainText.isEmpty) return 0.0;

    final painter = TextPainter(
      text: paragraph.text,
      textAlign: paragraph.textAlign,
      textDirection: paragraph.textDirection,
      textScaler: paragraph.textScaler,
      locale: paragraph.locale,
      strutStyle: paragraph.strutStyle,
      textWidthBasis: paragraph.textWidthBasis,
      textHeightBehavior: paragraph.textHeightBehavior,
    )..layout();

    var widestCluster = 0.0;
    var offset = 0;
    for (final cluster in plainText.characters) {
      final end = offset + cluster.length;
      final boxes = painter.getBoxesForSelection(
        TextSelection(baseOffset: offset, extentOffset: end),
      );
      final width = boxes.fold<double>(
        0.0,
        (total, box) => total + box.right - box.left,
      );
      if (width > widestCluster) widestCluster = width;
      offset = end;
    }
    painter.dispose();

    return widestCluster;
  }

  static RenderParagraph? _findParagraph(RenderObject? root) {
    if (root == null) return null;
    if (root is RenderParagraph) return root;

    RenderParagraph? paragraph;
    root.visitChildren((child) {
      paragraph ??= _findParagraph(child);
    });

    return paragraph;
  }
}

/// A [Table] that reuses [RenderTable]'s shared-column layout but contributes
/// no semantics of its own.
///
/// Deliberate: Flutter's [Table] and [TableCell] hard-code `table`/`row`/
/// `cell` semantics roles. A data list is a definition list, not a data
/// table — its contract is one `list` node with one `listItem` node per row,
/// and the framework rejects a `listItem` whose parent is not a `list`. This
/// subclass keeps the layout contract (one negotiated label column across
/// every row) while restoring the render-object default of exposing no
/// semantics structure.
class _DataListTable extends Table {
  _DataListTable({
    super.children,
    super.columnWidths,
    super.textDirection,
    super.textBaseline,
  });

  @override
  RenderTable createRenderObject(BuildContext context) {
    assert(debugCheckHasDirectionality(context));

    return _RenderDataListTable(
      columns: children.isNotEmpty ? children[0].children.length : 0,
      rows: children.length,
      columnWidths: columnWidths,
      defaultColumnWidth: defaultColumnWidth,
      textDirection: textDirection ?? Directionality.of(context),
      border: border,
      configuration: createLocalImageConfiguration(context),
      defaultVerticalAlignment: defaultVerticalAlignment,
      textBaseline: textBaseline,
    );
  }
}

class _RenderDataListTable extends RenderTable {
  _RenderDataListTable({
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

  // ignore: must_call_super
  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    // Intentionally skip RenderTable's table-role annotation: even a reset
    // configuration stays flagged as annotated and forms an empty node
    // between the list and its rows. The RenderObject default contributes
    // nothing, which is exactly what this presentation-only table needs.
  }

  @override
  void assembleSemanticsNode(
    SemanticsNode node,
    SemanticsConfiguration config,
    Iterable<SemanticsNode> children,
  ) {
    // RenderObject's default assembly; RenderTable's override would
    // synthesize row/cell nodes.
    node.updateWith(
      config: config,
      childrenInInversePaintOrder: children.toList(),
    );
  }
}

/// Announces one list-item node per horizontal row, bounded to the full row.
///
/// Same announcement contract as [_RowSemantics]; summarized rows exclude
/// their visible value content at the widget layer, so this widget only
/// carries the row node itself.
class _HorizontalRowSemantics extends SingleChildRenderObjectWidget {
  const _HorizontalRowSemantics({required this.item, super.child});

  final RemixDataListItem item;

  @override
  _RenderDataListRowSemantics createRenderObject(BuildContext context) {
    return _RenderDataListRowSemantics(
      label: item.label,
      summary: item.value ?? item.semanticValue,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderDataListRowSemantics renderObject,
  ) {
    renderObject
      ..label = item.label
      ..summary = item.value ?? item.semanticValue
      ..textDirection = Directionality.of(context);
  }
}

/// The render side of [_HorizontalRowSemantics]: a semantics boundary with
/// the listItem role whose bounds expand from the value cell to the full
/// table row.
///
/// The visible label cell is excluded from semantics, so without the
/// expansion, touch exploration over the label would fall outside the row's
/// semantic rect. Expanding [semanticBounds] in this node's own coordinate
/// space leaves every descendant transform untouched, so nested interactive
/// value semantics keep their true geometry.
class _RenderDataListRowSemantics extends RenderProxyBox {
  _RenderDataListRowSemantics({
    required String label,
    required String? summary,
    required TextDirection textDirection,
  }) : _label = label,
       _summary = summary,
       _textDirection = textDirection;

  String _label;
  set label(String value) {
    if (value == _label) return;
    _label = value;
    markNeedsSemanticsUpdate();
  }

  String? _summary;
  set summary(String? value) {
    if (value == _summary) return;
    _summary = value;
    markNeedsSemanticsUpdate();
  }

  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (value == _textDirection) return;
    _textDirection = value;
    markNeedsSemanticsUpdate();
  }

  @override
  Rect get semanticBounds {
    // Translate the enclosing table row's box into this node's coordinate
    // space by accumulating the parent-data offsets up to the table cell.
    var offset = Offset.zero;
    RenderObject? node = this;
    while (node != null) {
      final parentData = node.parentData;
      final parent = node.parent;
      if (parentData is TableCellParentData && parent is RenderTable) {
        offset += parentData.offset;
        final rowBox = parent.getRowBox(parentData.y!);

        return Rect.fromLTRB(
          -offset.dx,
          rowBox.top - offset.dy,
          rowBox.width - offset.dx,
          rowBox.bottom - offset.dy,
        );
      }
      if (parentData is BoxParentData) {
        offset += parentData.offset;
        node = parent;
        continue;
      }
      break;
    }

    return super.semanticBounds;
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isSemanticBoundary = true
      ..explicitChildNodes = true
      ..role = SemanticsRole.listItem
      ..textDirection = _textDirection
      ..label = _label;
    final summary = _summary;
    if (summary != null) {
      config.value = summary;
    }
  }
}

/// Applies per-cell vertical alignment without [TableCell]'s built-in
/// `cell`-role [Semantics] wrapper.
class _DataListCellAlignment extends ParentDataWidget<TableCellParentData> {
  const _DataListCellAlignment({
    required this.verticalAlignment,
    required super.child,
  });

  final TableCellVerticalAlignment verticalAlignment;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData! as TableCellParentData;
    if (parentData.verticalAlignment != verticalAlignment) {
      parentData.verticalAlignment = verticalAlignment;
      renderObject.parent?.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Table;
}

class _VerticalDataListLayout extends StatelessWidget {
  const _VerticalDataListLayout({
    required this.items,
    required this.spec,
    required this.metrics,
  });

  final List<RemixDataListItem> items;
  final DataListSpec spec;
  final _DataListMetrics metrics;

  static CrossAxisAlignment _itemAlignment(RemixDataListItem item) {
    switch (item.alignment) {
      case RemixDataListItemAlignment.start:
        return CrossAxisAlignment.start;
      case RemixDataListItemAlignment.center:
        return CrossAxisAlignment.center;
      case RemixDataListItemAlignment.end:
        return CrossAxisAlignment.end;
      case RemixDataListItemAlignment.stretch:
        return CrossAxisAlignment.stretch;
      case RemixDataListItemAlignment.baseline:
        // Deliberate: stacked label/value share no horizontal text baseline,
        // so vertical baseline maps to start.
        return CrossAxisAlignment.start;
    }
  }

  Widget _row(RemixDataListItem item) {
    final row = _RowSemantics(
      item: item,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: _itemAlignment(item),
        spacing: metrics.labelValueSpacing,
        children: [_labelCell(item, spec), _valueCell(item, spec)],
      ),
    );
    final key = item.key;

    return key == null ? row : KeyedSubtree(key: key, child: row);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: metrics.rowSpacing,
      children: [for (final item in items) _row(item)],
    );
  }
}
