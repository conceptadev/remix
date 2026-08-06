part of 'data_table.dart';

/// Resolved visual values for a [RemixDataTable].
///
/// ## Region model
///
/// [headerRow] and [bodyRow] are row *visuals* that are applied to every cell
/// of a row rather than to a single row widget. Flutter's [Table] has no
/// widget between the table and its cells, and Radix models the same thing the
/// same way: `.rt-TableCell` carries `--table-row-background-color` and the
/// `inset 0 -1px` divider, not the `<tr>`. Painting per cell therefore matches
/// upstream and keeps the divider continuous across columns.
///
/// [headerCell], [bodyCell], and [selectionCell] are the inner boxes that own
/// padding and per-cell decoration inside that row chrome.
///
/// ## Widget states
///
/// Row and cell regions are re-resolved inside each row's own widget-state
/// scope, so `onHovered` / `onSelected` / `onPressed` variants on [bodyRow],
/// [bodyCell], [selectionCell], [headerRow], [headerCell], [headerLabel], and
/// [sortIcon] evaluate against that row (or that sortable header) instead of
/// the table as a whole. That is why there is no separate `selectedBodyRow`
/// region: `bodyRow(BoxStyler().onSelected(...))` already expresses it, and it
/// additionally composes with hover, focus, and press.
///
/// ## Composed controls
///
/// [selectionCheckbox], [pageButton], and [pageSizeSelect] deliberately hold
/// *unresolved* styles, which the renderer hands to the composed control
/// through Mix's own `StyleProvider` inheritance. The checkbox, icon button,
/// and select own their interaction state machines, so their styles have to
/// resolve against their own widget states; resolving them here would freeze
/// them in the table's state and, for example, drop a checked checkbox's
/// `onSelected` appearance. Because they are plain values rather than `Mix`
/// values, assigning one replaces the previous style instead of merging.
///
/// Geometry scalars stay null here and default to zero at render time; the
/// unopinionated Remix renderer carries no Radix metrics.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class DataTableSpec with _$DataTableSpec {
  /// Outer surface: panel background, border, radius, and clipping.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  /// Layered fills, strokes, and backdrop blur painted with [container].
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  /// Row chrome painted behind every header cell.
  @override
  final StyleSpec<BoxSpec> headerRow;

  /// Row chrome painted behind every body cell.
  @override
  final StyleSpec<BoxSpec> bodyRow;

  /// Overrides merged over [bodyRow] for the final body row.
  ///
  /// Null keeps the last row identical to the others. Radix's surface variant
  /// is the one real consumer: it drops the trailing divider so the last row
  /// does not double up with the panel border.
  ///
  /// On the styler path the override merges over [bodyRow]; a raw
  /// [RemixDataTable.styleSpec] carries resolved specs, which cannot merge,
  /// so there a non-null value replaces [bodyRow] wholesale and must be
  /// pre-composed by the caller.
  @override
  final StyleSpec<BoxSpec>? lastBodyRow;

  /// Inner box of a header cell.
  @override
  final StyleSpec<BoxSpec> headerCell;

  /// Inner box of a body cell.
  @override
  final StyleSpec<BoxSpec> bodyCell;

  /// Inner box of the optional selection column's header and body cells.
  @override
  final StyleSpec<BoxSpec> selectionCell;

  /// Pagination footer container, including its inter-control spacing.
  @override
  final StyleSpec<FlexBoxSpec> footer;

  /// Typography of built-in column header labels.
  ///
  /// Custom [RemixDataTableColumn.header] widgets inherit it as their default
  /// text style without losing their own semantics or interaction.
  @override
  final StyleSpec<TextSpec> headerLabel;

  /// Default typography inherited by caller-supplied cell content.
  ///
  /// Radix sets `color: var(--gray-12)` on the row and lets cell markup
  /// cascade from it; this is the Flutter equivalent, so a plain `Text` in a
  /// cell picks it up while a styled descendant still wins.
  @override
  final StyleSpec<TextSpec> cellText;

  /// Typography of the footer's built-in labels and page range.
  @override
  final StyleSpec<TextSpec> footerLabel;

  /// Sort direction indicator shown in sortable column headers.
  @override
  final StyleSpec<IconSpec> sortIcon;

  /// Unresolved style inherited by the composed selection checkboxes.
  @override
  final Style<CheckboxSpec>? selectionCheckbox;

  /// Unresolved style inherited by the composed previous/next page buttons.
  @override
  final Style<IconButtonSpec>? pageButton;

  /// Unresolved style inherited by the composed page-size select.
  @override
  final Style<SelectSpec>? pageSizeSelect;

  /// Minimum height of the header row.
  @override
  final double? headerMinHeight;

  /// Minimum height of every body row.
  @override
  final double? rowMinHeight;

  /// Width of the optional leading selection column.
  @override
  final double? selectionColumnWidth;

  /// Gap between a header label and its sort indicator.
  @override
  final double? sortIconSpacing;

  const DataTableSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? headerRow,
    StyleSpec<BoxSpec>? bodyRow,
    this.lastBodyRow,
    StyleSpec<BoxSpec>? headerCell,
    StyleSpec<BoxSpec>? bodyCell,
    StyleSpec<BoxSpec>? selectionCell,
    StyleSpec<FlexBoxSpec>? footer,
    StyleSpec<TextSpec>? headerLabel,
    StyleSpec<TextSpec>? cellText,
    StyleSpec<TextSpec>? footerLabel,
    StyleSpec<IconSpec>? sortIcon,
    this.selectionCheckbox,
    this.pageButton,
    this.pageSizeSelect,
    this.headerMinHeight,
    this.rowMinHeight,
    this.selectionColumnWidth,
    this.sortIconSpacing,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       headerRow = headerRow ?? const StyleSpec(spec: BoxSpec()),
       bodyRow = bodyRow ?? const StyleSpec(spec: BoxSpec()),
       headerCell = headerCell ?? const StyleSpec(spec: BoxSpec()),
       bodyCell = bodyCell ?? const StyleSpec(spec: BoxSpec()),
       selectionCell = selectionCell ?? const StyleSpec(spec: BoxSpec()),
       footer = footer ?? const StyleSpec(spec: FlexBoxSpec()),
       headerLabel = headerLabel ?? const StyleSpec(spec: TextSpec()),
       cellText = cellText ?? const StyleSpec(spec: TextSpec()),
       footerLabel = footerLabel ?? const StyleSpec(spec: TextSpec()),
       sortIcon = sortIcon ?? const StyleSpec(spec: IconSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  DataTableSpec lerp(DataTableSpec? other, double t) {
    if (other == null) return this;
    final generated = super.lerp(other, t);

    return generated.copyWith(
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
    );
  }
}
