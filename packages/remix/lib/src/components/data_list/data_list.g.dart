// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_list.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$DataListSpec implements Spec<DataListSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get labelContainer;
  StyleSpec<BoxSpec> get valueContainer;
  StyleSpec<TextSpec> get label;
  StyleSpec<TextSpec> get value;
  double? get rowSpacing;
  double? get columnSpacing;
  double? get labelValueSpacing;
  double? get minLabelWidth;

  @override
  Type get type => DataListSpec;

  @override
  DataListSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? labelContainer,
    StyleSpec<BoxSpec>? valueContainer,
    StyleSpec<TextSpec>? label,
    StyleSpec<TextSpec>? value,
    double? rowSpacing,
    double? columnSpacing,
    double? labelValueSpacing,
    double? minLabelWidth,
  }) {
    return DataListSpec(
      container: container ?? this.container,
      labelContainer: labelContainer ?? this.labelContainer,
      valueContainer: valueContainer ?? this.valueContainer,
      label: label ?? this.label,
      value: value ?? this.value,
      rowSpacing: rowSpacing ?? this.rowSpacing,
      columnSpacing: columnSpacing ?? this.columnSpacing,
      labelValueSpacing: labelValueSpacing ?? this.labelValueSpacing,
      minLabelWidth: minLabelWidth ?? this.minLabelWidth,
    );
  }

  @override
  DataListSpec lerp(DataListSpec? other, double t) {
    return DataListSpec(
      container: container.lerp(other?.container, t),
      labelContainer: labelContainer.lerp(other?.labelContainer, t),
      valueContainer: valueContainer.lerp(other?.valueContainer, t),
      label: label.lerp(other?.label, t),
      value: value.lerp(other?.value, t),
      rowSpacing: MixOps.lerp(rowSpacing, other?.rowSpacing, t),
      columnSpacing: MixOps.lerp(columnSpacing, other?.columnSpacing, t),
      labelValueSpacing: MixOps.lerp(
        labelValueSpacing,
        other?.labelValueSpacing,
        t,
      ),
      minLabelWidth: MixOps.lerp(minLabelWidth, other?.minLabelWidth, t),
    );
  }

  @override
  List<Object?> get props => [
    container,
    labelContainer,
    valueContainer,
    label,
    value,
    rowSpacing,
    columnSpacing,
    labelValueSpacing,
    minLabelWidth,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DataListSpec &&
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
      ..add(DiagnosticsProperty('labelContainer', labelContainer))
      ..add(DiagnosticsProperty('valueContainer', valueContainer))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('value', value))
      ..add(DoubleProperty('rowSpacing', rowSpacing))
      ..add(DoubleProperty('columnSpacing', columnSpacing))
      ..add(DoubleProperty('labelValueSpacing', labelValueSpacing))
      ..add(DoubleProperty('minLabelWidth', minLabelWidth));
  }
}

@Deprecated(
  'Rename to `_\$DataListSpec` and migrate the class declaration to `class DataListSpec with _\$DataListSpec`. The `_\$DataListSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$DataListSpecMethods = _$DataListSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class DataListStyler extends MixStyler<DataListStyler, DataListSpec>
    with RemixBoxStylerMixin<DataListStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $labelContainer;
  final Prop<StyleSpec<BoxSpec>>? $valueContainer;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<TextSpec>>? $value;
  final Prop<double>? $rowSpacing;
  final Prop<double>? $columnSpacing;
  final Prop<double>? $labelValueSpacing;
  final Prop<double>? $minLabelWidth;

  const DataListStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? labelContainer,
    Prop<StyleSpec<BoxSpec>>? valueContainer,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<TextSpec>>? value,
    Prop<double>? rowSpacing,
    Prop<double>? columnSpacing,
    Prop<double>? labelValueSpacing,
    Prop<double>? minLabelWidth,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $labelContainer = labelContainer,
       $valueContainer = valueContainer,
       $label = label,
       $value = value,
       $rowSpacing = rowSpacing,
       $columnSpacing = columnSpacing,
       $labelValueSpacing = labelValueSpacing,
       $minLabelWidth = minLabelWidth;

  DataListStyler({
    BoxStyler? container,
    BoxStyler? labelContainer,
    BoxStyler? valueContainer,
    TextStyler? label,
    TextStyler? value,
    double? rowSpacing,
    double? columnSpacing,
    double? labelValueSpacing,
    double? minLabelWidth,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<DataListSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         labelContainer: Prop.maybeMix(labelContainer),
         valueContainer: Prop.maybeMix(valueContainer),
         label: Prop.maybeMix(label),
         value: Prop.maybeMix(value),
         rowSpacing: Prop.maybe(rowSpacing),
         columnSpacing: Prop.maybe(columnSpacing),
         labelValueSpacing: Prop.maybe(labelValueSpacing),
         minLabelWidth: Prop.maybe(minLabelWidth),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory DataListStyler.container(BoxStyler value) =>
      DataListStyler().container(value);
  factory DataListStyler.labelContainer(BoxStyler value) =>
      DataListStyler().labelContainer(value);
  factory DataListStyler.valueContainer(BoxStyler value) =>
      DataListStyler().valueContainer(value);
  factory DataListStyler.label(TextStyler value) =>
      DataListStyler().label(value);
  factory DataListStyler.value(TextStyler value) =>
      DataListStyler().value(value);
  factory DataListStyler.rowSpacing(double value) =>
      DataListStyler().rowSpacing(value);
  factory DataListStyler.columnSpacing(double value) =>
      DataListStyler().columnSpacing(value);
  factory DataListStyler.labelValueSpacing(double value) =>
      DataListStyler().labelValueSpacing(value);
  factory DataListStyler.minLabelWidth(double value) =>
      DataListStyler().minLabelWidth(value);
  factory DataListStyler.alignment(AlignmentGeometry value) =>
      DataListStyler().alignment(value);
  factory DataListStyler.padding(EdgeInsetsGeometryMix value) =>
      DataListStyler().padding(value);
  factory DataListStyler.margin(EdgeInsetsGeometryMix value) =>
      DataListStyler().margin(value);
  factory DataListStyler.constraints(BoxConstraintsMix value) =>
      DataListStyler().constraints(value);
  factory DataListStyler.decoration(DecorationMix value) =>
      DataListStyler().decoration(value);
  factory DataListStyler.foregroundDecoration(DecorationMix value) =>
      DataListStyler().foregroundDecoration(value);
  factory DataListStyler.clipBehavior(Clip value) =>
      DataListStyler().clipBehavior(value);
  factory DataListStyler.color(Color value) => DataListStyler().color(value);
  factory DataListStyler.gradient(GradientMix value) =>
      DataListStyler().gradient(value);
  factory DataListStyler.border(BoxBorderMix value) =>
      DataListStyler().border(value);
  factory DataListStyler.borderRadius(BorderRadiusGeometryMix value) =>
      DataListStyler().borderRadius(value);
  factory DataListStyler.elevation(ElevationShadow value) =>
      DataListStyler().elevation(value);
  factory DataListStyler.shadow(BoxShadowMix value) =>
      DataListStyler().shadow(value);
  factory DataListStyler.shadows(List<BoxShadowMix> value) =>
      DataListStyler().shadows(value);
  factory DataListStyler.width(double value) => DataListStyler().width(value);
  factory DataListStyler.height(double value) => DataListStyler().height(value);
  factory DataListStyler.size(double width, double height) =>
      DataListStyler().size(width, height);
  factory DataListStyler.minWidth(double value) =>
      DataListStyler().minWidth(value);
  factory DataListStyler.maxWidth(double value) =>
      DataListStyler().maxWidth(value);
  factory DataListStyler.minHeight(double value) =>
      DataListStyler().minHeight(value);
  factory DataListStyler.maxHeight(double value) =>
      DataListStyler().maxHeight(value);
  factory DataListStyler.scale(double scale, {Alignment alignment = .center}) =>
      DataListStyler().scale(scale, alignment: alignment);
  factory DataListStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => DataListStyler().rotate(radians, alignment: alignment);
  factory DataListStyler.translate(double x, double y, [double z = 0.0]) =>
      DataListStyler().translate(x, y, z);
  factory DataListStyler.skew(double skewX, double skewY) =>
      DataListStyler().skew(skewX, skewY);
  factory DataListStyler.textStyle(TextStyler value) =>
      DataListStyler().textStyle(value);
  factory DataListStyler.image(DecorationImageMix value) =>
      DataListStyler().image(value);
  factory DataListStyler.shape(ShapeBorderMix value) =>
      DataListStyler().shape(value);
  factory DataListStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DataListStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DataListStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DataListStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DataListStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DataListStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DataListStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DataListStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DataListStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DataListStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DataListStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DataListStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DataListStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DataListStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DataListStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DataListStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DataListStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DataListStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DataListStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => DataListStyler().transform(value, alignment: alignment);

  DataListStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  DataListStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  DataListStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  DataListStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  DataListStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  DataListStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  DataListStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  DataListStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  DataListStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  DataListStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  DataListStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  DataListStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  DataListStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  DataListStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  DataListStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  DataListStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  DataListStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  DataListStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  DataListStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  DataListStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  DataListStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  DataListStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  DataListStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  DataListStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  DataListStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  DataListStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  DataListStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  DataListStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  DataListStyler backgroundImage(
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

  DataListStyler backgroundImageUrl(
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

  DataListStyler backgroundImageAsset(
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

  DataListStyler linearGradient({
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

  DataListStyler radialGradient({
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

  DataListStyler sweepGradient({
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

  DataListStyler foregroundLinearGradient({
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

  DataListStyler foregroundRadialGradient({
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

  DataListStyler foregroundSweepGradient({
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

  DataListStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  DataListStyler container(BoxStyler value) {
    return merge(DataListStyler(container: value));
  }

  /// Sets the labelContainer.
  DataListStyler labelContainer(BoxStyler value) {
    return merge(DataListStyler(labelContainer: value));
  }

  /// Sets the valueContainer.
  DataListStyler valueContainer(BoxStyler value) {
    return merge(DataListStyler(valueContainer: value));
  }

  /// Sets the label.
  DataListStyler label(TextStyler value) {
    return merge(DataListStyler(label: value));
  }

  /// Sets the value.
  DataListStyler value(TextStyler value) {
    return merge(DataListStyler(value: value));
  }

  /// Sets the rowSpacing.
  DataListStyler rowSpacing(double value) {
    return merge(DataListStyler(rowSpacing: value));
  }

  /// Sets the columnSpacing.
  DataListStyler columnSpacing(double value) {
    return merge(DataListStyler(columnSpacing: value));
  }

  /// Sets the labelValueSpacing.
  DataListStyler labelValueSpacing(double value) {
    return merge(DataListStyler(labelValueSpacing: value));
  }

  /// Sets the minLabelWidth.
  DataListStyler minLabelWidth(double value) {
    return merge(DataListStyler(minLabelWidth: value));
  }

  /// Sets the animation configuration.
  @override
  DataListStyler animate(AnimationConfig value) {
    return merge(DataListStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  DataListStyler variants(List<VariantStyle<DataListSpec>> value) {
    return merge(DataListStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  DataListStyler wrap(WidgetModifierConfig value) {
    return merge(DataListStyler(modifier: value));
  }

  /// Sets the widget modifier.
  DataListStyler modifier(WidgetModifierConfig value) {
    return merge(DataListStyler(modifier: value));
  }

  RemixDataList call({
    Key? key,
    required List<RemixDataListItem> items,
    Axis orientation = Axis.horizontal,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixDataList(
      key: key,
      style: this,
      items: items,
      orientation: orientation,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
    );
  }

  /// Merges with another [DataListStyler].
  @override
  DataListStyler merge(DataListStyler? other) {
    return DataListStyler.create(
      container: MixOps.merge($container, other?.$container),
      labelContainer: MixOps.merge($labelContainer, other?.$labelContainer),
      valueContainer: MixOps.merge($valueContainer, other?.$valueContainer),
      label: MixOps.merge($label, other?.$label),
      value: MixOps.merge($value, other?.$value),
      rowSpacing: MixOps.merge($rowSpacing, other?.$rowSpacing),
      columnSpacing: MixOps.merge($columnSpacing, other?.$columnSpacing),
      labelValueSpacing: MixOps.merge(
        $labelValueSpacing,
        other?.$labelValueSpacing,
      ),
      minLabelWidth: MixOps.merge($minLabelWidth, other?.$minLabelWidth),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<DataListSpec>] using [context].
  @override
  StyleSpec<DataListSpec> resolve(BuildContext context) {
    final spec = DataListSpec(
      container: MixOps.resolve(context, $container),
      labelContainer: MixOps.resolve(context, $labelContainer),
      valueContainer: MixOps.resolve(context, $valueContainer),
      label: MixOps.resolve(context, $label),
      value: MixOps.resolve(context, $value),
      rowSpacing: MixOps.resolve(context, $rowSpacing),
      columnSpacing: MixOps.resolve(context, $columnSpacing),
      labelValueSpacing: MixOps.resolve(context, $labelValueSpacing),
      minLabelWidth: MixOps.resolve(context, $minLabelWidth),
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
      ..add(DiagnosticsProperty('labelContainer', $labelContainer))
      ..add(DiagnosticsProperty('valueContainer', $valueContainer))
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('value', $value))
      ..add(DiagnosticsProperty('rowSpacing', $rowSpacing))
      ..add(DiagnosticsProperty('columnSpacing', $columnSpacing))
      ..add(DiagnosticsProperty('labelValueSpacing', $labelValueSpacing))
      ..add(DiagnosticsProperty('minLabelWidth', $minLabelWidth));
  }

  @override
  List<Object?> get props => [
    $container,
    $labelContainer,
    $valueContainer,
    $label,
    $value,
    $rowSpacing,
    $columnSpacing,
    $labelValueSpacing,
    $minLabelWidth,
    $animation,
    $modifier,
    $variants,
  ];
}
