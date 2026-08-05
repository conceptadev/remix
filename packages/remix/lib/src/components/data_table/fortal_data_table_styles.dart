part of 'data_table.dart';

/// Radix Themes Table size presets.
enum FortalDataTableSize { size1, size2, size3 }

/// Radix Themes Table variants.
enum FortalDataTableVariant { surface, ghost }

/// Resolved Radix `table.css` metrics for one size step.
typedef _FortalDataTableMetrics = ({
  double paddingX,
  double paddingY,
  double minHeight,
  double sortIconSize,
  Radius radius,
  TextStyleToken text,
});

/// Fortal recipe for [RemixDataTable].
///
/// Sizes and variants map `@radix-ui/themes@3.3.0` `table.css` exactly: cell
/// padding, minimum cell height, typography, radius, the `gray-a5` row
/// divider, bold column headers, the surface panel/border, the `gray-a2`
/// header background, and the suppressed divider under a surface table's last
/// row.
///
/// Sorting, selection, pagination, and row hover have no Radix counterpart —
/// Radix's Table is a passive layout. They are Fortal extensions built from
/// existing accent/gray control tokens and are recorded as extensions in the
/// parity manifest.
@MixWidget(target: RemixDataTable.new)
DataTableStyler fortalDataTableStyle({
  FortalDataTableSize size = .size2,
  FortalDataTableVariant variant = .ghost,
}) {
  final metrics = _fortalDataTableMetrics(size);
  final base = DataTableStyler()
      .cellText(
        TextStyler(style: metrics.text.mix()).color(FortalTokens.gray12()),
      )
      .headerLabel(
        TextStyler(style: metrics.text.mix())
            .fontWeight(FortalTokens.fontWeightBold())
            .color(FortalTokens.gray12()),
      )
      .footerLabel(
        TextStyler(style: FortalTokens.text1.mix())
            .fontWeight(FortalTokens.fontWeightRegular())
            .color(FortalTokens.gray11()),
      )
      .headerCell(_fortalDataTableCell(metrics))
      .bodyCell(_fortalDataTableCell(metrics))
      // The selection column is a Fortal extension with no Radix counterpart.
      // It carries no padding of its own, so the composed checkbox's
      // interaction target — sized to this cell — spans the whole column and
      // the full row height instead of being inset from both.
      .selectionCell(BoxStyler().alignment(Alignment.center))
      .headerMinHeight(metrics.minHeight)
      .rowMinHeight(metrics.minHeight)
      .selectionColumnWidth(FortalTokens.space8())
      .sortIconSpacing(FortalTokens.space1())
      .sortIcon(
        IconStyler(color: FortalTokens.gray11(), size: metrics.sortIconSize),
      )
      .headerRow(_fortalDataTableRowDivider())
      .bodyRow(
        _fortalDataTableRowDivider()
            .color(Colors.transparent)
            // Hover and selection are Fortal extensions. Both are pure color
            // layers, so a row never changes geometry when either applies.
            .onHovered(.color(FortalTokens.grayA3()))
            .onSelected(
              .color(
                FortalTokens.accentA3(),
              ).onHovered(.color(FortalTokens.accentA4())),
            ),
      )
      .footer(_fortalDataTableFooter())
      .selectionCheckbox(fortalCheckboxStyle(size: .size1))
      .pageButton(fortalIconButtonStyle(variant: .ghost, size: .size1))
      .pageSizeSelect(fortalSelectStyle(variant: .ghost, size: .size1));

  return switch (variant) {
    .surface => _fortalDataTableSurface(base, metrics.radius),
    .ghost => base.color(Colors.transparent),
  };
}

_FortalDataTableMetrics _fortalDataTableMetrics(FortalDataTableSize size) =>
    switch (size) {
      .size1 => (
        paddingX: FortalTokens.space2(),
        paddingY: FortalTokens.space2(),
        minHeight: FortalTokens.dataTableRowHeight1(),
        sortIconSize: 14.0,
        radius: FortalTokens.radius3(),
        text: FortalTokens.text2,
      ),
      .size2 => (
        paddingX: FortalTokens.space3(),
        paddingY: FortalTokens.space3(),
        minHeight: FortalTokens.dataTableRowHeight2(),
        sortIconSize: 16.0,
        radius: FortalTokens.radius4(),
        text: FortalTokens.text2,
      ),
      .size3 => (
        paddingX: FortalTokens.space4(),
        paddingY: FortalTokens.space3(),
        minHeight: FortalTokens.space8(),
        sortIconSize: 18.0,
        radius: FortalTokens.radius4(),
        text: FortalTokens.text3,
      ),
    };

BoxStyler _fortalDataTableCell(_FortalDataTableMetrics metrics) =>
    BoxStyler().paddingX(metrics.paddingX).paddingY(metrics.paddingY);

/// Radix draws the row divider as `inset 0 -1px var(--gray-a5)`, which paints
/// over the cell without reserving layout space. A foreground border is the
/// Flutter equivalent; a regular border would inset the cell content by 1px.
BoxStyler _fortalDataTableRowDivider() => BoxStyler().foregroundDecoration(
  BoxDecorationMix(border: BoxBorderMix.bottom(_fortalDataTableDividerSide())),
);

/// The `gray-a5` 1px edge shared by the row divider and the footer's top
/// border, so the footer reads as a continuation of the last row's divider.
BorderSideMix _fortalDataTableDividerSide() =>
    BorderSideMix(color: FortalTokens.grayA5(), width: 1);

FlexBoxStyler _fortalDataTableFooter() => FlexBoxStyler()
    .direction(.horizontal)
    .crossAxisAlignment(.center)
    .spacing(FortalTokens.space2())
    .paddingX(FortalTokens.space4())
    .paddingY(FortalTokens.space2())
    .foregroundDecoration(
      BoxDecorationMix(border: BoxBorderMix.top(_fortalDataTableDividerSide())),
    );

DataTableStyler _fortalDataTableSurface(DataTableStyler base, Radius radius) {
  return base
      .color(FortalTokens.colorPanel())
      .border(
        BoxBorderMix.all(
          BorderSideMix(color: FortalTokens.dataTableBorder(), width: 1),
        ),
      )
      .borderRadiusAll(radius)
      .clipBehavior(Clip.antiAlias)
      .containerEffects(
        RemixBoxEffectsMix(backdropBlur: FortalTokens.panelBlur()),
      )
      .headerRow(.color(FortalTokens.grayA2()))
      // Radix clears `--table-row-box-shadow` on the surface variant's last
      // row so its divider never doubles up with the panel border.
      .lastBodyRow(
        BoxStyler().foregroundDecoration(
          BoxDecorationMix(border: BoxBorderMix.bottom(BorderSideMix.none)),
        ),
      );
}
