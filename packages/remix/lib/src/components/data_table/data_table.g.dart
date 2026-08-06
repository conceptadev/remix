// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_table.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$DataTableSpec implements Spec<DataTableSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get headerRow;
  StyleSpec<BoxSpec> get bodyRow;
  StyleSpec<BoxSpec>? get lastBodyRow;
  StyleSpec<BoxSpec> get headerCell;
  StyleSpec<BoxSpec> get bodyCell;
  StyleSpec<BoxSpec> get selectionCell;
  StyleSpec<FlexBoxSpec> get footer;
  StyleSpec<TextSpec> get headerLabel;
  StyleSpec<TextSpec> get cellText;
  StyleSpec<TextSpec> get footerLabel;
  StyleSpec<IconSpec> get sortIcon;
  Style<CheckboxSpec>? get selectionCheckbox;
  Style<IconButtonSpec>? get pageButton;
  Style<SelectSpec>? get pageSizeSelect;
  double? get headerMinHeight;
  double? get rowMinHeight;
  double? get selectionColumnWidth;
  double? get sortIconSpacing;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => DataTableSpec;

  @override
  DataTableSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? headerRow,
    StyleSpec<BoxSpec>? bodyRow,
    StyleSpec<BoxSpec>? lastBodyRow,
    StyleSpec<BoxSpec>? headerCell,
    StyleSpec<BoxSpec>? bodyCell,
    StyleSpec<BoxSpec>? selectionCell,
    StyleSpec<FlexBoxSpec>? footer,
    StyleSpec<TextSpec>? headerLabel,
    StyleSpec<TextSpec>? cellText,
    StyleSpec<TextSpec>? footerLabel,
    StyleSpec<IconSpec>? sortIcon,
    Style<CheckboxSpec>? selectionCheckbox,
    Style<IconButtonSpec>? pageButton,
    Style<SelectSpec>? pageSizeSelect,
    double? headerMinHeight,
    double? rowMinHeight,
    double? selectionColumnWidth,
    double? sortIconSpacing,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return DataTableSpec(
      container: container ?? this.container,
      headerRow: headerRow ?? this.headerRow,
      bodyRow: bodyRow ?? this.bodyRow,
      lastBodyRow: lastBodyRow ?? this.lastBodyRow,
      headerCell: headerCell ?? this.headerCell,
      bodyCell: bodyCell ?? this.bodyCell,
      selectionCell: selectionCell ?? this.selectionCell,
      footer: footer ?? this.footer,
      headerLabel: headerLabel ?? this.headerLabel,
      cellText: cellText ?? this.cellText,
      footerLabel: footerLabel ?? this.footerLabel,
      sortIcon: sortIcon ?? this.sortIcon,
      selectionCheckbox: selectionCheckbox ?? this.selectionCheckbox,
      pageButton: pageButton ?? this.pageButton,
      pageSizeSelect: pageSizeSelect ?? this.pageSizeSelect,
      headerMinHeight: headerMinHeight ?? this.headerMinHeight,
      rowMinHeight: rowMinHeight ?? this.rowMinHeight,
      selectionColumnWidth: selectionColumnWidth ?? this.selectionColumnWidth,
      sortIconSpacing: sortIconSpacing ?? this.sortIconSpacing,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  DataTableSpec lerp(DataTableSpec? other, double t) {
    return DataTableSpec(
      container: container.lerp(other?.container, t),
      headerRow: headerRow.lerp(other?.headerRow, t),
      bodyRow: bodyRow.lerp(other?.bodyRow, t),
      lastBodyRow: lastBodyRow?.lerp(other?.lastBodyRow, t),
      headerCell: headerCell.lerp(other?.headerCell, t),
      bodyCell: bodyCell.lerp(other?.bodyCell, t),
      selectionCell: selectionCell.lerp(other?.selectionCell, t),
      footer: footer.lerp(other?.footer, t),
      headerLabel: headerLabel.lerp(other?.headerLabel, t),
      cellText: cellText.lerp(other?.cellText, t),
      footerLabel: footerLabel.lerp(other?.footerLabel, t),
      sortIcon: sortIcon.lerp(other?.sortIcon, t),
      selectionCheckbox: MixOps.lerpSnap(
        selectionCheckbox,
        other?.selectionCheckbox,
        t,
      ),
      pageButton: MixOps.lerpSnap(pageButton, other?.pageButton, t),
      pageSizeSelect: MixOps.lerpSnap(pageSizeSelect, other?.pageSizeSelect, t),
      headerMinHeight: MixOps.lerp(headerMinHeight, other?.headerMinHeight, t),
      rowMinHeight: MixOps.lerp(rowMinHeight, other?.rowMinHeight, t),
      selectionColumnWidth: MixOps.lerp(
        selectionColumnWidth,
        other?.selectionColumnWidth,
        t,
      ),
      sortIconSpacing: MixOps.lerp(sortIconSpacing, other?.sortIconSpacing, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [
    container,
    headerRow,
    bodyRow,
    lastBodyRow,
    headerCell,
    bodyCell,
    selectionCell,
    footer,
    headerLabel,
    cellText,
    footerLabel,
    sortIcon,
    selectionCheckbox,
    pageButton,
    pageSizeSelect,
    headerMinHeight,
    rowMinHeight,
    selectionColumnWidth,
    sortIconSpacing,
    containerEffects,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DataTableSpec &&
            runtimeType == other.runtimeType &&
            propsEquals(props, other.props);
  }

  @override
  int get hashCode => propsHash(runtimeType, props);

  @override
  bool get stringify => true;

  @override
  Map<String, String> getDiff(Equatable other) {
    if (this == other) return const {};

    return propsDiff(props, other.props);
  }

  @override
  String toStringShort() => '$runtimeType';

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      toDiagnosticsNode(
        style: DiagnosticsTreeStyle.singleLine,
      ).toString(minLevel: minLevel);

  @override
  DiagnosticsNode toDiagnosticsNode({
    String? name,
    DiagnosticsTreeStyle? style,
  }) =>
      DiagnosticableNode<Diagnosticable>(name: name, value: this, style: style);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('container', container))
      ..add(DiagnosticsProperty('headerRow', headerRow))
      ..add(DiagnosticsProperty('bodyRow', bodyRow))
      ..add(DiagnosticsProperty('lastBodyRow', lastBodyRow))
      ..add(DiagnosticsProperty('headerCell', headerCell))
      ..add(DiagnosticsProperty('bodyCell', bodyCell))
      ..add(DiagnosticsProperty('selectionCell', selectionCell))
      ..add(DiagnosticsProperty('footer', footer))
      ..add(DiagnosticsProperty('headerLabel', headerLabel))
      ..add(DiagnosticsProperty('cellText', cellText))
      ..add(DiagnosticsProperty('footerLabel', footerLabel))
      ..add(DiagnosticsProperty('sortIcon', sortIcon))
      ..add(DiagnosticsProperty('selectionCheckbox', selectionCheckbox))
      ..add(DiagnosticsProperty('pageButton', pageButton))
      ..add(DiagnosticsProperty('pageSizeSelect', pageSizeSelect))
      ..add(DoubleProperty('headerMinHeight', headerMinHeight))
      ..add(DoubleProperty('rowMinHeight', rowMinHeight))
      ..add(DoubleProperty('selectionColumnWidth', selectionColumnWidth))
      ..add(DoubleProperty('sortIconSpacing', sortIconSpacing))
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$DataTableSpec` and migrate the class declaration to `class DataTableSpec with _\$DataTableSpec`. The `_\$DataTableSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$DataTableSpecMethods = _$DataTableSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

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
class FortalDataTable<T> extends StatelessWidget {
  const FortalDataTable({
    super.key,
    this.size = .size2,
    this.variant = .ghost,
    required this.rows,
    required this.columns,
    this.semanticLabel,
    this.sort,
    this.onSortChanged,
    this.rowId,
    this.selectedRowIds = const {},
    this.onSelectionChanged,
    this.totalRows,
    this.pageIndex = 0,
    this.pageSize = 10,
    this.pageSizeOptions = const [10, 20, 50],
    this.onPageChanged,
    this.onPageSizeChanged,
    this.minimumWidth = 0,
    this.emptyBuilder,
    this.labels = const RemixDataTableLabels(),
    this.pageRangeFormatter = remixDefaultDataTablePageRangeFormatter,
    this.sortableIcon = Icons.unfold_more,
    this.sortAscendingIcon = Icons.keyboard_arrow_up,
    this.sortDescendingIcon = Icons.keyboard_arrow_down,
    this.previousPageIcon = Icons.chevron_left,
    this.nextPageIcon = Icons.chevron_right,
  });

  const FortalDataTable.surface({
    super.key,
    this.size = .size2,
    required this.rows,
    required this.columns,
    this.semanticLabel,
    this.sort,
    this.onSortChanged,
    this.rowId,
    this.selectedRowIds = const {},
    this.onSelectionChanged,
    this.totalRows,
    this.pageIndex = 0,
    this.pageSize = 10,
    this.pageSizeOptions = const [10, 20, 50],
    this.onPageChanged,
    this.onPageSizeChanged,
    this.minimumWidth = 0,
    this.emptyBuilder,
    this.labels = const RemixDataTableLabels(),
    this.pageRangeFormatter = remixDefaultDataTablePageRangeFormatter,
    this.sortableIcon = Icons.unfold_more,
    this.sortAscendingIcon = Icons.keyboard_arrow_up,
    this.sortDescendingIcon = Icons.keyboard_arrow_down,
    this.previousPageIcon = Icons.chevron_left,
    this.nextPageIcon = Icons.chevron_right,
  }) : variant = FortalDataTableVariant.surface;

  const FortalDataTable.ghost({
    super.key,
    this.size = .size2,
    required this.rows,
    required this.columns,
    this.semanticLabel,
    this.sort,
    this.onSortChanged,
    this.rowId,
    this.selectedRowIds = const {},
    this.onSelectionChanged,
    this.totalRows,
    this.pageIndex = 0,
    this.pageSize = 10,
    this.pageSizeOptions = const [10, 20, 50],
    this.onPageChanged,
    this.onPageSizeChanged,
    this.minimumWidth = 0,
    this.emptyBuilder,
    this.labels = const RemixDataTableLabels(),
    this.pageRangeFormatter = remixDefaultDataTablePageRangeFormatter,
    this.sortableIcon = Icons.unfold_more,
    this.sortAscendingIcon = Icons.keyboard_arrow_up,
    this.sortDescendingIcon = Icons.keyboard_arrow_down,
    this.previousPageIcon = Icons.chevron_left,
    this.nextPageIcon = Icons.chevron_right,
  }) : variant = FortalDataTableVariant.ghost;

  final FortalDataTableSize size;

  final FortalDataTableVariant variant;

  final List<T> rows;

  final List<RemixDataTableColumn<T>> columns;

  final String? semanticLabel;

  final RemixDataTableSort? sort;

  final ValueChanged<RemixDataTableSort>? onSortChanged;

  final Object Function(T row)? rowId;

  final Set<Object> selectedRowIds;

  final ValueChanged<Set<Object>>? onSelectionChanged;

  final int? totalRows;

  final int pageIndex;

  final int pageSize;

  final List<int> pageSizeOptions;

  final ValueChanged<int>? onPageChanged;

  final ValueChanged<int>? onPageSizeChanged;

  final double minimumWidth;

  final WidgetBuilder? emptyBuilder;

  final RemixDataTableLabels labels;

  final RemixDataTablePageRangeFormatter pageRangeFormatter;

  final IconData sortableIcon;

  final IconData sortAscendingIcon;

  final IconData sortDescendingIcon;

  final IconData previousPageIcon;

  final IconData nextPageIcon;

  @override
  Widget build(BuildContext context) {
    return RemixDataTable<T>(
      key: this.key,
      style: fortalDataTableStyle(size: this.size, variant: this.variant),
      rows: this.rows,
      columns: this.columns,
      semanticLabel: this.semanticLabel,
      sort: this.sort,
      onSortChanged: this.onSortChanged,
      rowId: this.rowId,
      selectedRowIds: this.selectedRowIds,
      onSelectionChanged: this.onSelectionChanged,
      totalRows: this.totalRows,
      pageIndex: this.pageIndex,
      pageSize: this.pageSize,
      pageSizeOptions: this.pageSizeOptions,
      onPageChanged: this.onPageChanged,
      onPageSizeChanged: this.onPageSizeChanged,
      minimumWidth: this.minimumWidth,
      emptyBuilder: this.emptyBuilder,
      labels: this.labels,
      pageRangeFormatter: this.pageRangeFormatter,
      sortableIcon: this.sortableIcon,
      sortAscendingIcon: this.sortAscendingIcon,
      sortDescendingIcon: this.sortDescendingIcon,
      previousPageIcon: this.previousPageIcon,
      nextPageIcon: this.nextPageIcon,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class DataTableStyler extends MixStyler<DataTableStyler, DataTableSpec>
    with RemixBoxStylerMixin<DataTableStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $headerRow;
  final Prop<StyleSpec<BoxSpec>>? $bodyRow;
  final Prop<StyleSpec<BoxSpec>>? $lastBodyRow;
  final Prop<StyleSpec<BoxSpec>>? $headerCell;
  final Prop<StyleSpec<BoxSpec>>? $bodyCell;
  final Prop<StyleSpec<BoxSpec>>? $selectionCell;
  final Prop<StyleSpec<FlexBoxSpec>>? $footer;
  final Prop<StyleSpec<TextSpec>>? $headerLabel;
  final Prop<StyleSpec<TextSpec>>? $cellText;
  final Prop<StyleSpec<TextSpec>>? $footerLabel;
  final Prop<StyleSpec<IconSpec>>? $sortIcon;
  final Prop<Style<CheckboxSpec>>? $selectionCheckbox;
  final Prop<Style<IconButtonSpec>>? $pageButton;
  final Prop<Style<SelectSpec>>? $pageSizeSelect;
  final Prop<double>? $headerMinHeight;
  final Prop<double>? $rowMinHeight;
  final Prop<double>? $selectionColumnWidth;
  final Prop<double>? $sortIconSpacing;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const DataTableStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? headerRow,
    Prop<StyleSpec<BoxSpec>>? bodyRow,
    Prop<StyleSpec<BoxSpec>>? lastBodyRow,
    Prop<StyleSpec<BoxSpec>>? headerCell,
    Prop<StyleSpec<BoxSpec>>? bodyCell,
    Prop<StyleSpec<BoxSpec>>? selectionCell,
    Prop<StyleSpec<FlexBoxSpec>>? footer,
    Prop<StyleSpec<TextSpec>>? headerLabel,
    Prop<StyleSpec<TextSpec>>? cellText,
    Prop<StyleSpec<TextSpec>>? footerLabel,
    Prop<StyleSpec<IconSpec>>? sortIcon,
    Prop<Style<CheckboxSpec>>? selectionCheckbox,
    Prop<Style<IconButtonSpec>>? pageButton,
    Prop<Style<SelectSpec>>? pageSizeSelect,
    Prop<double>? headerMinHeight,
    Prop<double>? rowMinHeight,
    Prop<double>? selectionColumnWidth,
    Prop<double>? sortIconSpacing,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $headerRow = headerRow,
       $bodyRow = bodyRow,
       $lastBodyRow = lastBodyRow,
       $headerCell = headerCell,
       $bodyCell = bodyCell,
       $selectionCell = selectionCell,
       $footer = footer,
       $headerLabel = headerLabel,
       $cellText = cellText,
       $footerLabel = footerLabel,
       $sortIcon = sortIcon,
       $selectionCheckbox = selectionCheckbox,
       $pageButton = pageButton,
       $pageSizeSelect = pageSizeSelect,
       $headerMinHeight = headerMinHeight,
       $rowMinHeight = rowMinHeight,
       $selectionColumnWidth = selectionColumnWidth,
       $sortIconSpacing = sortIconSpacing,
       $containerEffects = containerEffects;

  DataTableStyler({
    BoxStyler? container,
    BoxStyler? headerRow,
    BoxStyler? bodyRow,
    BoxStyler? lastBodyRow,
    BoxStyler? headerCell,
    BoxStyler? bodyCell,
    BoxStyler? selectionCell,
    FlexBoxStyler? footer,
    TextStyler? headerLabel,
    TextStyler? cellText,
    TextStyler? footerLabel,
    IconStyler? sortIcon,
    Style<CheckboxSpec>? selectionCheckbox,
    Style<IconButtonSpec>? pageButton,
    Style<SelectSpec>? pageSizeSelect,
    double? headerMinHeight,
    double? rowMinHeight,
    double? selectionColumnWidth,
    double? sortIconSpacing,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<DataTableSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         headerRow: Prop.maybeMix(headerRow),
         bodyRow: Prop.maybeMix(bodyRow),
         lastBodyRow: Prop.maybeMix(lastBodyRow),
         headerCell: Prop.maybeMix(headerCell),
         bodyCell: Prop.maybeMix(bodyCell),
         selectionCell: Prop.maybeMix(selectionCell),
         footer: Prop.maybeMix(footer),
         headerLabel: Prop.maybeMix(headerLabel),
         cellText: Prop.maybeMix(cellText),
         footerLabel: Prop.maybeMix(footerLabel),
         sortIcon: Prop.maybeMix(sortIcon),
         selectionCheckbox: Prop.maybe(selectionCheckbox),
         pageButton: Prop.maybe(pageButton),
         pageSizeSelect: Prop.maybe(pageSizeSelect),
         headerMinHeight: Prop.maybe(headerMinHeight),
         rowMinHeight: Prop.maybe(rowMinHeight),
         selectionColumnWidth: Prop.maybe(selectionColumnWidth),
         sortIconSpacing: Prop.maybe(sortIconSpacing),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory DataTableStyler.container(BoxStyler value) =>
      DataTableStyler().container(value);
  factory DataTableStyler.headerRow(BoxStyler value) =>
      DataTableStyler().headerRow(value);
  factory DataTableStyler.bodyRow(BoxStyler value) =>
      DataTableStyler().bodyRow(value);
  factory DataTableStyler.lastBodyRow(BoxStyler value) =>
      DataTableStyler().lastBodyRow(value);
  factory DataTableStyler.headerCell(BoxStyler value) =>
      DataTableStyler().headerCell(value);
  factory DataTableStyler.bodyCell(BoxStyler value) =>
      DataTableStyler().bodyCell(value);
  factory DataTableStyler.selectionCell(BoxStyler value) =>
      DataTableStyler().selectionCell(value);
  factory DataTableStyler.footer(FlexBoxStyler value) =>
      DataTableStyler().footer(value);
  factory DataTableStyler.headerLabel(TextStyler value) =>
      DataTableStyler().headerLabel(value);
  factory DataTableStyler.cellText(TextStyler value) =>
      DataTableStyler().cellText(value);
  factory DataTableStyler.footerLabel(TextStyler value) =>
      DataTableStyler().footerLabel(value);
  factory DataTableStyler.sortIcon(IconStyler value) =>
      DataTableStyler().sortIcon(value);
  factory DataTableStyler.selectionCheckbox(Style<CheckboxSpec> value) =>
      DataTableStyler().selectionCheckbox(value);
  factory DataTableStyler.pageButton(Style<IconButtonSpec> value) =>
      DataTableStyler().pageButton(value);
  factory DataTableStyler.pageSizeSelect(Style<SelectSpec> value) =>
      DataTableStyler().pageSizeSelect(value);
  factory DataTableStyler.headerMinHeight(double value) =>
      DataTableStyler().headerMinHeight(value);
  factory DataTableStyler.rowMinHeight(double value) =>
      DataTableStyler().rowMinHeight(value);
  factory DataTableStyler.selectionColumnWidth(double value) =>
      DataTableStyler().selectionColumnWidth(value);
  factory DataTableStyler.sortIconSpacing(double value) =>
      DataTableStyler().sortIconSpacing(value);
  factory DataTableStyler.containerEffects(RemixBoxEffectsMix value) =>
      DataTableStyler().containerEffects(value);
  factory DataTableStyler.alignment(AlignmentGeometry value) =>
      DataTableStyler().alignment(value);
  factory DataTableStyler.padding(EdgeInsetsGeometryMix value) =>
      DataTableStyler().padding(value);
  factory DataTableStyler.margin(EdgeInsetsGeometryMix value) =>
      DataTableStyler().margin(value);
  factory DataTableStyler.constraints(BoxConstraintsMix value) =>
      DataTableStyler().constraints(value);
  factory DataTableStyler.decoration(DecorationMix value) =>
      DataTableStyler().decoration(value);
  factory DataTableStyler.foregroundDecoration(DecorationMix value) =>
      DataTableStyler().foregroundDecoration(value);
  factory DataTableStyler.clipBehavior(Clip value) =>
      DataTableStyler().clipBehavior(value);
  factory DataTableStyler.color(Color value) => DataTableStyler().color(value);
  factory DataTableStyler.gradient(GradientMix value) =>
      DataTableStyler().gradient(value);
  factory DataTableStyler.border(BoxBorderMix value) =>
      DataTableStyler().border(value);
  factory DataTableStyler.borderRadius(BorderRadiusGeometryMix value) =>
      DataTableStyler().borderRadius(value);
  factory DataTableStyler.elevation(ElevationShadow value) =>
      DataTableStyler().elevation(value);
  factory DataTableStyler.shadow(BoxShadowMix value) =>
      DataTableStyler().shadow(value);
  factory DataTableStyler.shadows(List<BoxShadowMix> value) =>
      DataTableStyler().shadows(value);
  factory DataTableStyler.width(double value) => DataTableStyler().width(value);
  factory DataTableStyler.height(double value) =>
      DataTableStyler().height(value);
  factory DataTableStyler.size(double width, double height) =>
      DataTableStyler().size(width, height);
  factory DataTableStyler.minWidth(double value) =>
      DataTableStyler().minWidth(value);
  factory DataTableStyler.maxWidth(double value) =>
      DataTableStyler().maxWidth(value);
  factory DataTableStyler.minHeight(double value) =>
      DataTableStyler().minHeight(value);
  factory DataTableStyler.maxHeight(double value) =>
      DataTableStyler().maxHeight(value);
  factory DataTableStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => DataTableStyler().scale(scale, alignment: alignment);
  factory DataTableStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => DataTableStyler().rotate(radians, alignment: alignment);
  factory DataTableStyler.translate(double x, double y, [double z = 0.0]) =>
      DataTableStyler().translate(x, y, z);
  factory DataTableStyler.skew(double skewX, double skewY) =>
      DataTableStyler().skew(skewX, skewY);
  factory DataTableStyler.textStyle(TextStyler value) =>
      DataTableStyler().textStyle(value);
  factory DataTableStyler.image(DecorationImageMix value) =>
      DataTableStyler().image(value);
  factory DataTableStyler.shape(ShapeBorderMix value) =>
      DataTableStyler().shape(value);
  factory DataTableStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DataTableStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DataTableStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DataTableStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DataTableStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DataTableStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DataTableStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DataTableStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DataTableStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DataTableStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DataTableStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DataTableStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DataTableStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DataTableStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DataTableStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DataTableStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DataTableStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DataTableStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DataTableStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => DataTableStyler().transform(value, alignment: alignment);

  DataTableStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  DataTableStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  DataTableStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  DataTableStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  DataTableStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  DataTableStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  DataTableStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  DataTableStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  DataTableStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  DataTableStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  DataTableStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  DataTableStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  DataTableStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  DataTableStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  DataTableStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  DataTableStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  DataTableStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  DataTableStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  DataTableStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  DataTableStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  DataTableStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  DataTableStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  DataTableStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  DataTableStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  DataTableStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  DataTableStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  DataTableStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  DataTableStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  DataTableStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      BoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  DataTableStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      BoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  DataTableStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      BoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  DataTableStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  DataTableStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().radialGradient(
        colors: colors,
        stops: stops,
        center: center,
        radius: radius,
        focal: focal,
        focalRadius: focalRadius,
        tileMode: tileMode,
      ),
    );
  }

  DataTableStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().sweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  DataTableStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  DataTableStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().foregroundRadialGradient(
        colors: colors,
        stops: stops,
        center: center,
        radius: radius,
        focal: focal,
        focalRadius: focalRadius,
        tileMode: tileMode,
      ),
    );
  }

  DataTableStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().foregroundSweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  DataTableStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  DataTableStyler container(BoxStyler value) {
    return merge(DataTableStyler(container: value));
  }

  /// Sets the headerRow.
  DataTableStyler headerRow(BoxStyler value) {
    return merge(DataTableStyler(headerRow: value));
  }

  /// Sets the bodyRow.
  DataTableStyler bodyRow(BoxStyler value) {
    return merge(DataTableStyler(bodyRow: value));
  }

  /// Sets the lastBodyRow.
  DataTableStyler lastBodyRow(BoxStyler value) {
    return merge(DataTableStyler(lastBodyRow: value));
  }

  /// Sets the headerCell.
  DataTableStyler headerCell(BoxStyler value) {
    return merge(DataTableStyler(headerCell: value));
  }

  /// Sets the bodyCell.
  DataTableStyler bodyCell(BoxStyler value) {
    return merge(DataTableStyler(bodyCell: value));
  }

  /// Sets the selectionCell.
  DataTableStyler selectionCell(BoxStyler value) {
    return merge(DataTableStyler(selectionCell: value));
  }

  /// Sets the footer.
  DataTableStyler footer(FlexBoxStyler value) {
    return merge(DataTableStyler(footer: value));
  }

  /// Sets the headerLabel.
  DataTableStyler headerLabel(TextStyler value) {
    return merge(DataTableStyler(headerLabel: value));
  }

  /// Sets the cellText.
  DataTableStyler cellText(TextStyler value) {
    return merge(DataTableStyler(cellText: value));
  }

  /// Sets the footerLabel.
  DataTableStyler footerLabel(TextStyler value) {
    return merge(DataTableStyler(footerLabel: value));
  }

  /// Sets the sortIcon.
  DataTableStyler sortIcon(IconStyler value) {
    return merge(DataTableStyler(sortIcon: value));
  }

  /// Sets the selectionCheckbox.
  DataTableStyler selectionCheckbox(Style<CheckboxSpec> value) {
    return merge(DataTableStyler(selectionCheckbox: value));
  }

  /// Sets the pageButton.
  DataTableStyler pageButton(Style<IconButtonSpec> value) {
    return merge(DataTableStyler(pageButton: value));
  }

  /// Sets the pageSizeSelect.
  DataTableStyler pageSizeSelect(Style<SelectSpec> value) {
    return merge(DataTableStyler(pageSizeSelect: value));
  }

  /// Sets the headerMinHeight.
  DataTableStyler headerMinHeight(double value) {
    return merge(DataTableStyler(headerMinHeight: value));
  }

  /// Sets the rowMinHeight.
  DataTableStyler rowMinHeight(double value) {
    return merge(DataTableStyler(rowMinHeight: value));
  }

  /// Sets the selectionColumnWidth.
  DataTableStyler selectionColumnWidth(double value) {
    return merge(DataTableStyler(selectionColumnWidth: value));
  }

  /// Sets the sortIconSpacing.
  DataTableStyler sortIconSpacing(double value) {
    return merge(DataTableStyler(sortIconSpacing: value));
  }

  /// Sets the containerEffects.
  DataTableStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(DataTableStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  DataTableStyler animate(AnimationConfig value) {
    return merge(DataTableStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  DataTableStyler variants(List<VariantStyle<DataTableSpec>> value) {
    return merge(DataTableStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  DataTableStyler wrap(WidgetModifierConfig value) {
    return merge(DataTableStyler(modifier: value));
  }

  /// Sets the widget modifier.
  DataTableStyler modifier(WidgetModifierConfig value) {
    return merge(DataTableStyler(modifier: value));
  }

  /// Merges with another [DataTableStyler].
  @override
  DataTableStyler merge(DataTableStyler? other) {
    return DataTableStyler.create(
      container: MixOps.merge($container, other?.$container),
      headerRow: MixOps.merge($headerRow, other?.$headerRow),
      bodyRow: MixOps.merge($bodyRow, other?.$bodyRow),
      lastBodyRow: MixOps.merge($lastBodyRow, other?.$lastBodyRow),
      headerCell: MixOps.merge($headerCell, other?.$headerCell),
      bodyCell: MixOps.merge($bodyCell, other?.$bodyCell),
      selectionCell: MixOps.merge($selectionCell, other?.$selectionCell),
      footer: MixOps.merge($footer, other?.$footer),
      headerLabel: MixOps.merge($headerLabel, other?.$headerLabel),
      cellText: MixOps.merge($cellText, other?.$cellText),
      footerLabel: MixOps.merge($footerLabel, other?.$footerLabel),
      sortIcon: MixOps.merge($sortIcon, other?.$sortIcon),
      selectionCheckbox: MixOps.merge(
        $selectionCheckbox,
        other?.$selectionCheckbox,
      ),
      pageButton: MixOps.merge($pageButton, other?.$pageButton),
      pageSizeSelect: MixOps.merge($pageSizeSelect, other?.$pageSizeSelect),
      headerMinHeight: MixOps.merge($headerMinHeight, other?.$headerMinHeight),
      rowMinHeight: MixOps.merge($rowMinHeight, other?.$rowMinHeight),
      selectionColumnWidth: MixOps.merge(
        $selectionColumnWidth,
        other?.$selectionColumnWidth,
      ),
      sortIconSpacing: MixOps.merge($sortIconSpacing, other?.$sortIconSpacing),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<DataTableSpec>] using [context].
  @override
  StyleSpec<DataTableSpec> resolve(BuildContext context) {
    final spec = DataTableSpec(
      container: MixOps.resolve(context, $container),
      headerRow: MixOps.resolve(context, $headerRow),
      bodyRow: MixOps.resolve(context, $bodyRow),
      lastBodyRow: MixOps.resolve(context, $lastBodyRow),
      headerCell: MixOps.resolve(context, $headerCell),
      bodyCell: MixOps.resolve(context, $bodyCell),
      selectionCell: MixOps.resolve(context, $selectionCell),
      footer: MixOps.resolve(context, $footer),
      headerLabel: MixOps.resolve(context, $headerLabel),
      cellText: MixOps.resolve(context, $cellText),
      footerLabel: MixOps.resolve(context, $footerLabel),
      sortIcon: MixOps.resolve(context, $sortIcon),
      selectionCheckbox: MixOps.resolve(context, $selectionCheckbox),
      pageButton: MixOps.resolve(context, $pageButton),
      pageSizeSelect: MixOps.resolve(context, $pageSizeSelect),
      headerMinHeight: MixOps.resolve(context, $headerMinHeight),
      rowMinHeight: MixOps.resolve(context, $rowMinHeight),
      selectionColumnWidth: MixOps.resolve(context, $selectionColumnWidth),
      sortIconSpacing: MixOps.resolve(context, $sortIconSpacing),
      containerEffects: MixOps.resolve(context, $containerEffects),
    );

    return StyleSpec(
      spec: spec,
      animation: $animation,
      widgetModifiers: $modifier?.resolve(context),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('container', $container))
      ..add(DiagnosticsProperty('headerRow', $headerRow))
      ..add(DiagnosticsProperty('bodyRow', $bodyRow))
      ..add(DiagnosticsProperty('lastBodyRow', $lastBodyRow))
      ..add(DiagnosticsProperty('headerCell', $headerCell))
      ..add(DiagnosticsProperty('bodyCell', $bodyCell))
      ..add(DiagnosticsProperty('selectionCell', $selectionCell))
      ..add(DiagnosticsProperty('footer', $footer))
      ..add(DiagnosticsProperty('headerLabel', $headerLabel))
      ..add(DiagnosticsProperty('cellText', $cellText))
      ..add(DiagnosticsProperty('footerLabel', $footerLabel))
      ..add(DiagnosticsProperty('sortIcon', $sortIcon))
      ..add(DiagnosticsProperty('selectionCheckbox', $selectionCheckbox))
      ..add(DiagnosticsProperty('pageButton', $pageButton))
      ..add(DiagnosticsProperty('pageSizeSelect', $pageSizeSelect))
      ..add(DiagnosticsProperty('headerMinHeight', $headerMinHeight))
      ..add(DiagnosticsProperty('rowMinHeight', $rowMinHeight))
      ..add(DiagnosticsProperty('selectionColumnWidth', $selectionColumnWidth))
      ..add(DiagnosticsProperty('sortIconSpacing', $sortIconSpacing))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $headerRow,
    $bodyRow,
    $lastBodyRow,
    $headerCell,
    $bodyCell,
    $selectionCell,
    $footer,
    $headerLabel,
    $cellText,
    $footerLabel,
    $sortIcon,
    $selectionCheckbox,
    $pageButton,
    $pageSizeSelect,
    $headerMinHeight,
    $rowMinHeight,
    $selectionColumnWidth,
    $sortIconSpacing,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
