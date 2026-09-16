import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';
import 'checkbox.dart';
import 'icon_button.dart';
import 'select.dart';

part 'data_table.g.dart';

/// Radix Themes Table size presets.
enum UiDataTableSize { size1, size2, size3 }

/// Radix Themes Table variants.
enum UiDataTableVariant { surface, ghost }

/// Resolved Radix `table.css` metrics for one size step.
typedef _UiDataTableMetrics = ({
  double paddingX,
  double paddingY,
  double minHeight,
  double sortIconSize,
  Radius radius,
  TextStyleToken text,
});

/// Ui recipe for [RemixDataTable].
///
/// Sizes and variants map `@radix-ui/themes@3.3.0` `table.css` exactly: cell
/// padding, minimum cell height, typography, radius, the `gray-a5` row
/// divider, bold column headers, the surface panel/border, the `gray-a2`
/// header background, and the suppressed divider under a surface table's last
/// row.
///
/// Sorting, selection, pagination, and row hover have no Radix counterpart —
/// Radix's Table is a passive layout. They are Ui extensions built from
/// existing accent/gray control tokens and are recorded as extensions in the
/// parity manifest.
@MixWidget(target: RemixDataTable.new)
DataTableStyler uiDataTableStyle({
  UiDataTableSize size = .size2,
  UiDataTableVariant variant = .ghost,
  DataTableStyler style = const DataTableStyler.create(),
}) {
  final metrics = _uiDataTableMetrics(size);
  final base = DataTableStyler()
      .cellText(TextStyler(style: metrics.text.mix()).color(UiTokens.gray12()))
      .headerLabel(
        TextStyler(
          style: metrics.text.mix(),
        ).fontWeight(UiTokens.fontWeightBold()).color(UiTokens.gray12()),
      )
      .footerLabel(
        TextStyler(
          style: UiTokens.text1.mix(),
        ).fontWeight(UiTokens.fontWeightRegular()).color(UiTokens.gray11()),
      )
      .headerCell(_uiDataTableCell(metrics))
      .bodyCell(_uiDataTableCell(metrics))
      // The selection column is a Ui extension with no Radix counterpart.
      // It carries no padding of its own, so the composed checkbox's
      // interaction target — sized to this cell — spans the whole column and
      // the full row height instead of being inset from both.
      .selectionCell(BoxStyler().alignment(Alignment.center))
      .headerMinHeight(metrics.minHeight)
      .rowMinHeight(metrics.minHeight)
      .selectionColumnWidth(UiTokens.space8())
      .sortIconSpacing(UiTokens.space1())
      .sortIcon(
        IconStyler(color: UiTokens.gray11(), size: metrics.sortIconSize),
      )
      .headerRow(_uiDataTableRowDivider())
      .bodyRow(
        _uiDataTableRowDivider()
            .color(const Color(0x00000000))
            // Hover and selection are Ui extensions. Both are pure color
            // layers, so a row never changes geometry when either applies.
            .onHovered(.color(UiTokens.grayA3()))
            .onSelected(
              .color(
                UiTokens.accentA3(),
              ).onHovered(.color(UiTokens.accentA4())),
            ),
      )
      .footer(_uiDataTableFooter())
      .selectionCheckbox(uiCheckboxStyle(size: .size1))
      .pageButton(uiIconButtonStyle(variant: .ghost, size: .size1))
      .pageSizeSelect(uiSelectStyle(variant: .ghost, size: .size1));

  return (switch (variant) {
    .surface => _uiDataTableSurface(base, metrics.radius),
    .ghost => base.color(const Color(0x00000000)),
  }).merge(style);
}

_UiDataTableMetrics _uiDataTableMetrics(UiDataTableSize size) => switch (size) {
  .size1 => (
    paddingX: UiTokens.space2(),
    paddingY: UiTokens.space2(),
    minHeight: UiTokens.dataTableRowHeight1(),
    sortIconSize: 14.0,
    radius: UiTokens.radius3(),
    text: UiTokens.text2,
  ),
  .size2 => (
    paddingX: UiTokens.space3(),
    paddingY: UiTokens.space3(),
    minHeight: UiTokens.dataTableRowHeight2(),
    sortIconSize: 16.0,
    radius: UiTokens.radius4(),
    text: UiTokens.text2,
  ),
  .size3 => (
    paddingX: UiTokens.space4(),
    paddingY: UiTokens.space3(),
    minHeight: UiTokens.space8(),
    sortIconSize: 18.0,
    radius: UiTokens.radius4(),
    text: UiTokens.text3,
  ),
};

BoxStyler _uiDataTableCell(_UiDataTableMetrics metrics) => BoxStyler()
    .padding(.horizontal(metrics.paddingX))
    .padding(.vertical(metrics.paddingY));

/// Radix draws the row divider as `inset 0 -1px var(--gray-a5)`, which paints
/// over the cell without reserving layout space. A foreground border is the
/// Flutter equivalent; a regular border would inset the cell content by 1px.
BoxStyler _uiDataTableRowDivider() => BoxStyler().foregroundDecoration(
  BoxDecorationMix(border: BoxBorderMix.bottom(_uiDataTableDividerSide())),
);

/// The `gray-a5` 1px edge shared by the row divider and the footer's top
/// border, so the footer reads as a continuation of the last row's divider.
BorderSideMix _uiDataTableDividerSide() =>
    BorderSideMix(color: UiTokens.grayA5(), width: 1);

FlexBoxStyler _uiDataTableFooter() => FlexBoxStyler()
    .direction(.horizontal)
    .spacing(UiTokens.space2())
    .padding(.horizontal(UiTokens.space4()))
    .padding(.vertical(UiTokens.space2()))
    .foregroundDecoration(
      BoxDecorationMix(border: BoxBorderMix.top(_uiDataTableDividerSide())),
    );

DataTableStyler _uiDataTableSurface(DataTableStyler base, Radius radius) {
  return base
      .container(
        uiSurfaceFrame(
          fillColor: UiTokens.colorPanel(),
          borderColor: UiTokens.dataTableBorder(),
          borderWidth: UiTokens.borderWidth1(),
          radius: radius,
        ),
      )
      .containerEffects(RemixBoxEffectsMix.backdropBlur(UiTokens.panelBlur()))
      .headerRow(.color(UiTokens.grayA2()))
      // Radix clears `--table-row-box-shadow` on the surface variant's last
      // row so its divider never doubles up with the panel border.
      .lastBodyRow(
        BoxStyler().foregroundDecoration(
          BoxDecorationMix(border: BoxBorderMix.bottom(BorderSideMix.none)),
        ),
      );
}
