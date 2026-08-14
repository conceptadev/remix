// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'divider.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$DividerSpec implements Spec<DividerSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;

  @override
  Type get type => DividerSpec;

  @override
  DividerSpec copyWith({StyleSpec<BoxSpec>? container}) {
    return DividerSpec(container: container ?? this.container);
  }

  @override
  DividerSpec lerp(DividerSpec? other, double t) {
    return DividerSpec(container: container.lerp(other?.container, t));
  }

  @override
  List<Object?> get props => [container];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DividerSpec &&
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
    properties.add(DiagnosticsProperty('container', container));
  }
}

@Deprecated(
  'Rename to `_\$DividerSpec` and migrate the class declaration to `class DividerSpec with _\$DividerSpec`. The `_\$DividerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$DividerSpecMethods = _$DividerSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class DividerStyler extends MixStyler<DividerStyler, DividerSpec>
    with RemixBoxStylerMixin<DividerStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;

  const DividerStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container;

  DividerStyler({
    BoxStyler? container,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<DividerSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory DividerStyler.container(BoxStyler value) =>
      DividerStyler().container(value);
  factory DividerStyler.alignment(AlignmentGeometry value) =>
      DividerStyler().alignment(value);
  factory DividerStyler.padding(EdgeInsetsGeometryMix value) =>
      DividerStyler().padding(value);
  factory DividerStyler.margin(EdgeInsetsGeometryMix value) =>
      DividerStyler().margin(value);
  factory DividerStyler.constraints(BoxConstraintsMix value) =>
      DividerStyler().constraints(value);
  factory DividerStyler.decoration(DecorationMix value) =>
      DividerStyler().decoration(value);
  factory DividerStyler.foregroundDecoration(DecorationMix value) =>
      DividerStyler().foregroundDecoration(value);
  factory DividerStyler.clipBehavior(Clip value) =>
      DividerStyler().clipBehavior(value);
  factory DividerStyler.color(Color value) => DividerStyler().color(value);
  factory DividerStyler.gradient(GradientMix value) =>
      DividerStyler().gradient(value);
  factory DividerStyler.border(BoxBorderMix value) =>
      DividerStyler().border(value);
  factory DividerStyler.borderRadius(BorderRadiusGeometryMix value) =>
      DividerStyler().borderRadius(value);
  factory DividerStyler.elevation(ElevationShadow value) =>
      DividerStyler().elevation(value);
  factory DividerStyler.shadow(BoxShadowMix value) =>
      DividerStyler().shadow(value);
  factory DividerStyler.shadows(List<BoxShadowMix> value) =>
      DividerStyler().shadows(value);
  factory DividerStyler.width(double value) => DividerStyler().width(value);
  factory DividerStyler.height(double value) => DividerStyler().height(value);
  factory DividerStyler.size(double width, double height) =>
      DividerStyler().size(width, height);
  factory DividerStyler.minWidth(double value) =>
      DividerStyler().minWidth(value);
  factory DividerStyler.maxWidth(double value) =>
      DividerStyler().maxWidth(value);
  factory DividerStyler.minHeight(double value) =>
      DividerStyler().minHeight(value);
  factory DividerStyler.maxHeight(double value) =>
      DividerStyler().maxHeight(value);
  factory DividerStyler.scale(double scale, {Alignment alignment = .center}) =>
      DividerStyler().scale(scale, alignment: alignment);
  factory DividerStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => DividerStyler().rotate(radians, alignment: alignment);
  factory DividerStyler.translate(double x, double y, [double z = 0.0]) =>
      DividerStyler().translate(x, y, z);
  factory DividerStyler.skew(double skewX, double skewY) =>
      DividerStyler().skew(skewX, skewY);
  factory DividerStyler.textStyle(TextStyler value) =>
      DividerStyler().textStyle(value);
  factory DividerStyler.image(DecorationImageMix value) =>
      DividerStyler().image(value);
  factory DividerStyler.shape(ShapeBorderMix value) =>
      DividerStyler().shape(value);
  factory DividerStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DividerStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DividerStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DividerStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DividerStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DividerStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DividerStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DividerStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DividerStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DividerStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DividerStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DividerStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DividerStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DividerStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DividerStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DividerStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DividerStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DividerStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DividerStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => DividerStyler().transform(value, alignment: alignment);

  DividerStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  DividerStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  DividerStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  DividerStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  DividerStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  DividerStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  DividerStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  DividerStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  DividerStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  DividerStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  DividerStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  DividerStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  DividerStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  DividerStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  DividerStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  DividerStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  DividerStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  DividerStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  DividerStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  DividerStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  DividerStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  DividerStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  DividerStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  DividerStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  DividerStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  DividerStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  DividerStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  DividerStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  DividerStyler backgroundImage(
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

  DividerStyler backgroundImageUrl(
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

  DividerStyler backgroundImageAsset(
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

  DividerStyler linearGradient({
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

  DividerStyler radialGradient({
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

  DividerStyler sweepGradient({
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

  DividerStyler foregroundLinearGradient({
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

  DividerStyler foregroundRadialGradient({
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

  DividerStyler foregroundSweepGradient({
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

  DividerStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  DividerStyler container(BoxStyler value) {
    return merge(DividerStyler(container: value));
  }

  /// Sets the animation configuration.
  @override
  DividerStyler animate(AnimationConfig value) {
    return merge(DividerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  DividerStyler variants(List<VariantStyle<DividerSpec>> value) {
    return merge(DividerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  DividerStyler wrap(WidgetModifierConfig value) {
    return merge(DividerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  DividerStyler modifier(WidgetModifierConfig value) {
    return merge(DividerStyler(modifier: value));
  }

  RemixDivider call({Key? key}) {
    return RemixDivider(key: key, style: this);
  }

  /// Merges with another [DividerStyler].
  @override
  DividerStyler merge(DividerStyler? other) {
    return DividerStyler.create(
      container: MixOps.merge($container, other?.$container),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<DividerSpec>] using [context].
  @override
  StyleSpec<DividerSpec> resolve(BuildContext context) {
    final spec = DividerSpec(container: MixOps.resolve(context, $container));

    return StyleSpec(
      spec: spec,
      animation: $animation,
      widgetModifiers: $modifier?.resolve(context),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('container', $container));
  }

  @override
  List<Object?> get props => [$container, $animation, $modifier, $variants];
}
