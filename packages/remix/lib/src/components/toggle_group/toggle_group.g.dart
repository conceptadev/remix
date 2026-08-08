// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_group.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$ToggleGroupSpec implements Spec<ToggleGroupSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<ToggleGroupItemSpec> get item;

  @override
  Type get type => ToggleGroupSpec;

  @override
  ToggleGroupSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<ToggleGroupItemSpec>? item,
  }) {
    return ToggleGroupSpec(
      container: container ?? this.container,
      item: item ?? this.item,
    );
  }

  @override
  ToggleGroupSpec lerp(ToggleGroupSpec? other, double t) {
    return ToggleGroupSpec(
      container: container.lerp(other?.container, t),
      item: item.lerp(other?.item, t),
    );
  }

  @override
  List<Object?> get props => [container, item];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ToggleGroupSpec &&
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
      ..add(DiagnosticsProperty('item', item));
  }
}

@Deprecated(
  'Rename to `_\$ToggleGroupSpec` and migrate the class declaration to `class ToggleGroupSpec with _\$ToggleGroupSpec`. The `_\$ToggleGroupSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$ToggleGroupSpecMethods = _$ToggleGroupSpec; // ignore: unused_element

mixin _$ToggleGroupItemSpec
    implements Spec<ToggleGroupItemSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => ToggleGroupItemSpec;

  @override
  ToggleGroupItemSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return ToggleGroupItemSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  ToggleGroupItemSpec lerp(ToggleGroupItemSpec? other, double t) {
    return ToggleGroupItemSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      icon: icon.lerp(other?.icon, t),
    );
  }

  @override
  List<Object?> get props => [container, label, icon];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ToggleGroupItemSpec &&
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
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('icon', icon));
  }
}

@Deprecated(
  'Rename to `_\$ToggleGroupItemSpec` and migrate the class declaration to `class ToggleGroupItemSpec with _\$ToggleGroupItemSpec`. The `_\$ToggleGroupItemSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$ToggleGroupItemSpecMethods = _$ToggleGroupItemSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class ToggleGroupStyler extends MixStyler<ToggleGroupStyler, ToggleGroupSpec>
    with RemixBoxStylerMixin<ToggleGroupStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<ToggleGroupItemSpec>>? $item;

  const ToggleGroupStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<ToggleGroupItemSpec>>? item,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $item = item;

  ToggleGroupStyler({
    FlexBoxStyler? container,
    ToggleGroupItemStyler? item,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<ToggleGroupSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         item: Prop.maybeMix(item),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory ToggleGroupStyler.container(FlexBoxStyler value) =>
      ToggleGroupStyler().container(value);
  factory ToggleGroupStyler.item(ToggleGroupItemStyler value) =>
      ToggleGroupStyler().item(value);
  factory ToggleGroupStyler.color(Color value) =>
      ToggleGroupStyler().color(value);
  factory ToggleGroupStyler.gradient(GradientMix value) =>
      ToggleGroupStyler().gradient(value);
  factory ToggleGroupStyler.border(BoxBorderMix value) =>
      ToggleGroupStyler().border(value);
  factory ToggleGroupStyler.borderRadius(BorderRadiusGeometryMix value) =>
      ToggleGroupStyler().borderRadius(value);
  factory ToggleGroupStyler.elevation(ElevationShadow value) =>
      ToggleGroupStyler().elevation(value);
  factory ToggleGroupStyler.shadow(BoxShadowMix value) =>
      ToggleGroupStyler().shadow(value);
  factory ToggleGroupStyler.shadows(List<BoxShadowMix> value) =>
      ToggleGroupStyler().shadows(value);
  factory ToggleGroupStyler.width(double value) =>
      ToggleGroupStyler().width(value);
  factory ToggleGroupStyler.height(double value) =>
      ToggleGroupStyler().height(value);
  factory ToggleGroupStyler.size(double width, double height) =>
      ToggleGroupStyler().size(width, height);
  factory ToggleGroupStyler.minWidth(double value) =>
      ToggleGroupStyler().minWidth(value);
  factory ToggleGroupStyler.maxWidth(double value) =>
      ToggleGroupStyler().maxWidth(value);
  factory ToggleGroupStyler.minHeight(double value) =>
      ToggleGroupStyler().minHeight(value);
  factory ToggleGroupStyler.maxHeight(double value) =>
      ToggleGroupStyler().maxHeight(value);
  factory ToggleGroupStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => ToggleGroupStyler().scale(scale, alignment: alignment);
  factory ToggleGroupStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => ToggleGroupStyler().rotate(radians, alignment: alignment);
  factory ToggleGroupStyler.translate(double x, double y, [double z = 0.0]) =>
      ToggleGroupStyler().translate(x, y, z);
  factory ToggleGroupStyler.skew(double skewX, double skewY) =>
      ToggleGroupStyler().skew(skewX, skewY);
  factory ToggleGroupStyler.textStyle(TextStyler value) =>
      ToggleGroupStyler().textStyle(value);
  factory ToggleGroupStyler.image(DecorationImageMix value) =>
      ToggleGroupStyler().image(value);
  factory ToggleGroupStyler.shape(ShapeBorderMix value) =>
      ToggleGroupStyler().shape(value);
  factory ToggleGroupStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToggleGroupStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToggleGroupStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToggleGroupStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToggleGroupStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToggleGroupStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToggleGroupStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ToggleGroupStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ToggleGroupStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ToggleGroupStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ToggleGroupStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ToggleGroupStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ToggleGroupStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ToggleGroupStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ToggleGroupStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ToggleGroupStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ToggleGroupStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ToggleGroupStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ToggleGroupStyler.row() => ToggleGroupStyler().row();
  factory ToggleGroupStyler.column() => ToggleGroupStyler().column();
  factory ToggleGroupStyler.alignment(AlignmentGeometry value) =>
      ToggleGroupStyler().alignment(value);
  factory ToggleGroupStyler.padding(EdgeInsetsGeometryMix value) =>
      ToggleGroupStyler().padding(value);
  factory ToggleGroupStyler.margin(EdgeInsetsGeometryMix value) =>
      ToggleGroupStyler().margin(value);
  factory ToggleGroupStyler.constraints(BoxConstraintsMix value) =>
      ToggleGroupStyler().constraints(value);
  factory ToggleGroupStyler.decoration(DecorationMix value) =>
      ToggleGroupStyler().decoration(value);
  factory ToggleGroupStyler.foregroundDecoration(DecorationMix value) =>
      ToggleGroupStyler().foregroundDecoration(value);
  factory ToggleGroupStyler.clipBehavior(Clip value) =>
      ToggleGroupStyler().clipBehavior(value);
  factory ToggleGroupStyler.direction(Axis value) =>
      ToggleGroupStyler().direction(value);
  factory ToggleGroupStyler.mainAxisAlignment(MainAxisAlignment value) =>
      ToggleGroupStyler().mainAxisAlignment(value);
  factory ToggleGroupStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      ToggleGroupStyler().crossAxisAlignment(value);
  factory ToggleGroupStyler.mainAxisSize(MainAxisSize value) =>
      ToggleGroupStyler().mainAxisSize(value);
  factory ToggleGroupStyler.spacing(double value) =>
      ToggleGroupStyler().spacing(value);
  factory ToggleGroupStyler.verticalDirection(VerticalDirection value) =>
      ToggleGroupStyler().verticalDirection(value);
  factory ToggleGroupStyler.textDirection(TextDirection value) =>
      ToggleGroupStyler().textDirection(value);
  factory ToggleGroupStyler.textBaseline(TextBaseline value) =>
      ToggleGroupStyler().textBaseline(value);
  factory ToggleGroupStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => ToggleGroupStyler().transform(value, alignment: alignment);

  ToggleGroupStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  ToggleGroupStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  ToggleGroupStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  ToggleGroupStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  ToggleGroupStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  ToggleGroupStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  ToggleGroupStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  ToggleGroupStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  ToggleGroupStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  ToggleGroupStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  ToggleGroupStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  ToggleGroupStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  ToggleGroupStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  ToggleGroupStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  ToggleGroupStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  ToggleGroupStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  ToggleGroupStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  ToggleGroupStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  ToggleGroupStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  ToggleGroupStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  ToggleGroupStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  ToggleGroupStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  ToggleGroupStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  ToggleGroupStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  ToggleGroupStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  ToggleGroupStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().radialGradient(
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

  ToggleGroupStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().sweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  ToggleGroupStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  ToggleGroupStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundRadialGradient(
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

  ToggleGroupStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundSweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  ToggleGroupStyler row() {
    return container(FlexBoxStyler().row());
  }

  ToggleGroupStyler column() {
    return container(FlexBoxStyler().column());
  }

  ToggleGroupStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  ToggleGroupStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  ToggleGroupStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  ToggleGroupStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  ToggleGroupStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  ToggleGroupStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  ToggleGroupStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  ToggleGroupStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  ToggleGroupStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  ToggleGroupStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  ToggleGroupStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  ToggleGroupStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  ToggleGroupStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  ToggleGroupStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  ToggleGroupStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  ToggleGroupStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  ToggleGroupStyler container(FlexBoxStyler value) {
    return merge(ToggleGroupStyler(container: value));
  }

  /// Sets the item.
  ToggleGroupStyler item(ToggleGroupItemStyler value) {
    return merge(ToggleGroupStyler(item: value));
  }

  /// Sets the animation configuration.
  @override
  ToggleGroupStyler animate(AnimationConfig value) {
    return merge(ToggleGroupStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  ToggleGroupStyler variants(List<VariantStyle<ToggleGroupSpec>> value) {
    return merge(ToggleGroupStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  ToggleGroupStyler wrap(WidgetModifierConfig value) {
    return merge(ToggleGroupStyler(modifier: value));
  }

  /// Sets the widget modifier.
  ToggleGroupStyler modifier(WidgetModifierConfig value) {
    return merge(ToggleGroupStyler(modifier: value));
  }

  /// Merges with another [ToggleGroupStyler].
  @override
  ToggleGroupStyler merge(ToggleGroupStyler? other) {
    return ToggleGroupStyler.create(
      container: MixOps.merge($container, other?.$container),
      item: MixOps.merge($item, other?.$item),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<ToggleGroupSpec>] using [context].
  @override
  StyleSpec<ToggleGroupSpec> resolve(BuildContext context) {
    final spec = ToggleGroupSpec(
      container: MixOps.resolve(context, $container),
      item: MixOps.resolve(context, $item),
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
      ..add(DiagnosticsProperty('item', $item));
  }

  @override
  List<Object?> get props => [
    $container,
    $item,
    $animation,
    $modifier,
    $variants,
  ];
}

class ToggleGroupItemStyler
    extends MixStyler<ToggleGroupItemStyler, ToggleGroupItemSpec>
    with
        RemixBoxStylerMixin<ToggleGroupItemStyler>,
        LabelStyleMixin<ToggleGroupItemStyler>,
        IconStyleMixin<ToggleGroupItemStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const ToggleGroupItemStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  ToggleGroupItemStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<ToggleGroupItemSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory ToggleGroupItemStyler.container(FlexBoxStyler value) =>
      ToggleGroupItemStyler().container(value);
  factory ToggleGroupItemStyler.label(TextStyler value) =>
      ToggleGroupItemStyler().label(value);
  factory ToggleGroupItemStyler.icon(IconStyler value) =>
      ToggleGroupItemStyler().icon(value);
  factory ToggleGroupItemStyler.color(Color value) =>
      ToggleGroupItemStyler().color(value);
  factory ToggleGroupItemStyler.gradient(GradientMix value) =>
      ToggleGroupItemStyler().gradient(value);
  factory ToggleGroupItemStyler.border(BoxBorderMix value) =>
      ToggleGroupItemStyler().border(value);
  factory ToggleGroupItemStyler.borderRadius(BorderRadiusGeometryMix value) =>
      ToggleGroupItemStyler().borderRadius(value);
  factory ToggleGroupItemStyler.elevation(ElevationShadow value) =>
      ToggleGroupItemStyler().elevation(value);
  factory ToggleGroupItemStyler.shadow(BoxShadowMix value) =>
      ToggleGroupItemStyler().shadow(value);
  factory ToggleGroupItemStyler.shadows(List<BoxShadowMix> value) =>
      ToggleGroupItemStyler().shadows(value);
  factory ToggleGroupItemStyler.width(double value) =>
      ToggleGroupItemStyler().width(value);
  factory ToggleGroupItemStyler.height(double value) =>
      ToggleGroupItemStyler().height(value);
  factory ToggleGroupItemStyler.size(double width, double height) =>
      ToggleGroupItemStyler().size(width, height);
  factory ToggleGroupItemStyler.minWidth(double value) =>
      ToggleGroupItemStyler().minWidth(value);
  factory ToggleGroupItemStyler.maxWidth(double value) =>
      ToggleGroupItemStyler().maxWidth(value);
  factory ToggleGroupItemStyler.minHeight(double value) =>
      ToggleGroupItemStyler().minHeight(value);
  factory ToggleGroupItemStyler.maxHeight(double value) =>
      ToggleGroupItemStyler().maxHeight(value);
  factory ToggleGroupItemStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => ToggleGroupItemStyler().scale(scale, alignment: alignment);
  factory ToggleGroupItemStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => ToggleGroupItemStyler().rotate(radians, alignment: alignment);
  factory ToggleGroupItemStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => ToggleGroupItemStyler().translate(x, y, z);
  factory ToggleGroupItemStyler.skew(double skewX, double skewY) =>
      ToggleGroupItemStyler().skew(skewX, skewY);
  factory ToggleGroupItemStyler.textStyle(TextStyler value) =>
      ToggleGroupItemStyler().textStyle(value);
  factory ToggleGroupItemStyler.image(DecorationImageMix value) =>
      ToggleGroupItemStyler().image(value);
  factory ToggleGroupItemStyler.shape(ShapeBorderMix value) =>
      ToggleGroupItemStyler().shape(value);
  factory ToggleGroupItemStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToggleGroupItemStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToggleGroupItemStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToggleGroupItemStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToggleGroupItemStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToggleGroupItemStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToggleGroupItemStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ToggleGroupItemStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ToggleGroupItemStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ToggleGroupItemStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ToggleGroupItemStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ToggleGroupItemStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ToggleGroupItemStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ToggleGroupItemStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ToggleGroupItemStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ToggleGroupItemStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ToggleGroupItemStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ToggleGroupItemStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ToggleGroupItemStyler.row() => ToggleGroupItemStyler().row();
  factory ToggleGroupItemStyler.column() => ToggleGroupItemStyler().column();
  factory ToggleGroupItemStyler.alignment(AlignmentGeometry value) =>
      ToggleGroupItemStyler().alignment(value);
  factory ToggleGroupItemStyler.padding(EdgeInsetsGeometryMix value) =>
      ToggleGroupItemStyler().padding(value);
  factory ToggleGroupItemStyler.margin(EdgeInsetsGeometryMix value) =>
      ToggleGroupItemStyler().margin(value);
  factory ToggleGroupItemStyler.constraints(BoxConstraintsMix value) =>
      ToggleGroupItemStyler().constraints(value);
  factory ToggleGroupItemStyler.decoration(DecorationMix value) =>
      ToggleGroupItemStyler().decoration(value);
  factory ToggleGroupItemStyler.foregroundDecoration(DecorationMix value) =>
      ToggleGroupItemStyler().foregroundDecoration(value);
  factory ToggleGroupItemStyler.clipBehavior(Clip value) =>
      ToggleGroupItemStyler().clipBehavior(value);
  factory ToggleGroupItemStyler.direction(Axis value) =>
      ToggleGroupItemStyler().direction(value);
  factory ToggleGroupItemStyler.mainAxisAlignment(MainAxisAlignment value) =>
      ToggleGroupItemStyler().mainAxisAlignment(value);
  factory ToggleGroupItemStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      ToggleGroupItemStyler().crossAxisAlignment(value);
  factory ToggleGroupItemStyler.mainAxisSize(MainAxisSize value) =>
      ToggleGroupItemStyler().mainAxisSize(value);
  factory ToggleGroupItemStyler.spacing(double value) =>
      ToggleGroupItemStyler().spacing(value);
  factory ToggleGroupItemStyler.verticalDirection(VerticalDirection value) =>
      ToggleGroupItemStyler().verticalDirection(value);
  factory ToggleGroupItemStyler.textDirection(TextDirection value) =>
      ToggleGroupItemStyler().textDirection(value);
  factory ToggleGroupItemStyler.textBaseline(TextBaseline value) =>
      ToggleGroupItemStyler().textBaseline(value);
  factory ToggleGroupItemStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => ToggleGroupItemStyler().transform(value, alignment: alignment);

  ToggleGroupItemStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  ToggleGroupItemStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  ToggleGroupItemStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  ToggleGroupItemStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  ToggleGroupItemStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  ToggleGroupItemStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  ToggleGroupItemStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  ToggleGroupItemStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  ToggleGroupItemStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  ToggleGroupItemStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  ToggleGroupItemStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  ToggleGroupItemStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  ToggleGroupItemStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  ToggleGroupItemStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  ToggleGroupItemStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  ToggleGroupItemStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  ToggleGroupItemStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  ToggleGroupItemStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  ToggleGroupItemStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  ToggleGroupItemStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  ToggleGroupItemStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  ToggleGroupItemStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  ToggleGroupItemStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  ToggleGroupItemStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  ToggleGroupItemStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  ToggleGroupItemStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().radialGradient(
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

  ToggleGroupItemStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().sweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  ToggleGroupItemStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  ToggleGroupItemStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundRadialGradient(
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

  ToggleGroupItemStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundSweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  ToggleGroupItemStyler row() {
    return container(FlexBoxStyler().row());
  }

  ToggleGroupItemStyler column() {
    return container(FlexBoxStyler().column());
  }

  ToggleGroupItemStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  ToggleGroupItemStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  ToggleGroupItemStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  ToggleGroupItemStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  ToggleGroupItemStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  ToggleGroupItemStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  ToggleGroupItemStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  ToggleGroupItemStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  ToggleGroupItemStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  ToggleGroupItemStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  ToggleGroupItemStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  ToggleGroupItemStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  ToggleGroupItemStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  ToggleGroupItemStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  ToggleGroupItemStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  ToggleGroupItemStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  ToggleGroupItemStyler container(FlexBoxStyler value) {
    return merge(ToggleGroupItemStyler(container: value));
  }

  /// Sets the label.
  @override
  ToggleGroupItemStyler label(TextStyler value) {
    return merge(ToggleGroupItemStyler(label: value));
  }

  /// Sets the icon.
  @override
  ToggleGroupItemStyler icon(IconStyler value) {
    return merge(ToggleGroupItemStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  ToggleGroupItemStyler animate(AnimationConfig value) {
    return merge(ToggleGroupItemStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  ToggleGroupItemStyler variants(
    List<VariantStyle<ToggleGroupItemSpec>> value,
  ) {
    return merge(ToggleGroupItemStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  ToggleGroupItemStyler wrap(WidgetModifierConfig value) {
    return merge(ToggleGroupItemStyler(modifier: value));
  }

  /// Sets the widget modifier.
  ToggleGroupItemStyler modifier(WidgetModifierConfig value) {
    return merge(ToggleGroupItemStyler(modifier: value));
  }

  /// Merges with another [ToggleGroupItemStyler].
  @override
  ToggleGroupItemStyler merge(ToggleGroupItemStyler? other) {
    return ToggleGroupItemStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<ToggleGroupItemSpec>] using [context].
  @override
  StyleSpec<ToggleGroupItemSpec> resolve(BuildContext context) {
    final spec = ToggleGroupItemSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      icon: MixOps.resolve(context, $icon),
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
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('icon', $icon));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $icon,
    $animation,
    $modifier,
    $variants,
  ];
}
