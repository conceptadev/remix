part of 'data_list.dart';

/// Resolved visual values for a [RemixDataList].
///
/// Geometry scalars stay null here and default to zero at render time; the
/// unopinionated Remix renderer carries no Radix metrics such as the 120 px
/// label minimum. Orientation is deliberately not part of the spec: it is
/// semantic layout behavior owned by the [RemixDataList] constructor, so
/// styles cannot override it.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class DataListSpec with _$DataListSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<BoxSpec> labelContainer;
  @override
  final StyleSpec<BoxSpec> valueContainer;
  @override
  final StyleSpec<TextSpec> label;
  @override
  final StyleSpec<TextSpec> value;

  /// Gap between items along the list's main axis.
  @override
  final double? rowSpacing;

  /// Directional horizontal gap between the label and value columns.
  @override
  final double? columnSpacing;

  /// Inner vertical gap between label and value in vertical orientation.
  @override
  final double? labelValueSpacing;

  /// Minimum width of the shared horizontal label column.
  @override
  final double? minLabelWidth;

  const DataListSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? labelContainer,
    StyleSpec<BoxSpec>? valueContainer,
    StyleSpec<TextSpec>? label,
    StyleSpec<TextSpec>? value,
    this.rowSpacing,
    this.columnSpacing,
    this.labelValueSpacing,
    this.minLabelWidth,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       labelContainer = labelContainer ?? const StyleSpec(spec: BoxSpec()),
       valueContainer = valueContainer ?? const StyleSpec(spec: BoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       value = value ?? const StyleSpec(spec: TextSpec());
}
