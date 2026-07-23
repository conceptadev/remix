// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'divider.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixDividerSpec implements Spec<RemixDividerSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  double? get thickness;

  @override
  Type get type => RemixDividerSpec;

  @override
  RemixDividerSpec copyWith({
    StyleSpec<BoxSpec>? container,
    double? thickness,
  }) {
    return RemixDividerSpec(
      container: container ?? this.container,
      thickness: thickness ?? this.thickness,
    );
  }

  @override
  RemixDividerSpec lerp(RemixDividerSpec? other, double t) {
    return RemixDividerSpec(
      container: container.lerp(other?.container, t),
      thickness: MixOps.lerp(thickness, other?.thickness, t),
    );
  }

  @override
  List<Object?> get props => [container, thickness];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixDividerSpec &&
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
      ..add(DoubleProperty('thickness', thickness));
  }
}

@Deprecated(
  'Rename to `_\$RemixDividerSpec` and migrate the class declaration to `class RemixDividerSpec with _\$RemixDividerSpec`. The `_\$RemixDividerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixDividerSpecMethods = _$RemixDividerSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixDividerStyler extends MixStyler<RemixDividerStyler, RemixDividerSpec>
    with RemixBoxStylerMixin<RemixDividerStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<double>? $thickness;

  const RemixDividerStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<double>? thickness,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $thickness = thickness;

  RemixDividerStyler({
    BoxStyler? container,
    double? thickness,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixDividerSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         thickness: Prop.maybe(thickness),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixDividerStyler.container(BoxStyler value) =>
      RemixDividerStyler().container(value);
  factory RemixDividerStyler.thickness(double value) =>
      RemixDividerStyler().thickness(value);
  factory RemixDividerStyler.alignment(AlignmentGeometry value) =>
      RemixDividerStyler().alignment(value);
  factory RemixDividerStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixDividerStyler().padding(value);
  factory RemixDividerStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixDividerStyler().margin(value);
  factory RemixDividerStyler.constraints(BoxConstraintsMix value) =>
      RemixDividerStyler().constraints(value);
  factory RemixDividerStyler.decoration(DecorationMix value) =>
      RemixDividerStyler().decoration(value);
  factory RemixDividerStyler.foregroundDecoration(DecorationMix value) =>
      RemixDividerStyler().foregroundDecoration(value);
  factory RemixDividerStyler.clipBehavior(Clip value) =>
      RemixDividerStyler().clipBehavior(value);
  factory RemixDividerStyler.color(Color value) =>
      RemixDividerStyler().color(value);
  factory RemixDividerStyler.gradient(GradientMix value) =>
      RemixDividerStyler().gradient(value);
  factory RemixDividerStyler.border(BoxBorderMix value) =>
      RemixDividerStyler().border(value);
  factory RemixDividerStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixDividerStyler().borderRadius(value);
  factory RemixDividerStyler.elevation(ElevationShadow value) =>
      RemixDividerStyler().elevation(value);
  factory RemixDividerStyler.shadow(BoxShadowMix value) =>
      RemixDividerStyler().shadow(value);
  factory RemixDividerStyler.shadows(List<BoxShadowMix> value) =>
      RemixDividerStyler().shadows(value);
  factory RemixDividerStyler.width(double value) =>
      RemixDividerStyler().width(value);
  factory RemixDividerStyler.height(double value) =>
      RemixDividerStyler().height(value);
  factory RemixDividerStyler.size(double width, double height) =>
      RemixDividerStyler().size(width, height);
  factory RemixDividerStyler.minWidth(double value) =>
      RemixDividerStyler().minWidth(value);
  factory RemixDividerStyler.maxWidth(double value) =>
      RemixDividerStyler().maxWidth(value);
  factory RemixDividerStyler.minHeight(double value) =>
      RemixDividerStyler().minHeight(value);
  factory RemixDividerStyler.maxHeight(double value) =>
      RemixDividerStyler().maxHeight(value);
  factory RemixDividerStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixDividerStyler().scale(scale, alignment: alignment);
  factory RemixDividerStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixDividerStyler().rotate(radians, alignment: alignment);
  factory RemixDividerStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixDividerStyler().translate(x, y, z);
  factory RemixDividerStyler.skew(double skewX, double skewY) =>
      RemixDividerStyler().skew(skewX, skewY);
  factory RemixDividerStyler.textStyle(TextStyler value) =>
      RemixDividerStyler().textStyle(value);
  factory RemixDividerStyler.image(DecorationImageMix value) =>
      RemixDividerStyler().image(value);
  factory RemixDividerStyler.shape(ShapeBorderMix value) =>
      RemixDividerStyler().shape(value);
  factory RemixDividerStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixDividerStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixDividerStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixDividerStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixDividerStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixDividerStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixDividerStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixDividerStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixDividerStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixDividerStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixDividerStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixDividerStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixDividerStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixDividerStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixDividerStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixDividerStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixDividerStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixDividerStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixDividerStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixDividerStyler().transform(value, alignment: alignment);

  RemixDividerStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixDividerStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixDividerStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixDividerStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixDividerStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixDividerStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixDividerStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixDividerStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixDividerStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixDividerStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixDividerStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixDividerStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixDividerStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixDividerStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixDividerStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixDividerStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixDividerStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixDividerStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixDividerStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixDividerStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixDividerStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixDividerStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixDividerStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixDividerStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixDividerStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixDividerStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixDividerStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixDividerStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixDividerStyler backgroundImage(
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

  RemixDividerStyler backgroundImageUrl(
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

  RemixDividerStyler backgroundImageAsset(
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

  RemixDividerStyler linearGradient({
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

  RemixDividerStyler radialGradient({
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

  RemixDividerStyler sweepGradient({
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

  RemixDividerStyler foregroundLinearGradient({
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

  RemixDividerStyler foregroundRadialGradient({
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

  RemixDividerStyler foregroundSweepGradient({
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

  RemixDividerStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixDividerStyler container(BoxStyler value) {
    return merge(RemixDividerStyler(container: value));
  }

  /// Sets the thickness.
  RemixDividerStyler thickness(double value) {
    return merge(RemixDividerStyler(thickness: value));
  }

  /// Sets the animation configuration.
  @override
  RemixDividerStyler animate(AnimationConfig value) {
    return merge(RemixDividerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixDividerStyler variants(List<VariantStyle<RemixDividerSpec>> value) {
    return merge(RemixDividerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixDividerStyler wrap(WidgetModifierConfig value) {
    return merge(RemixDividerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixDividerStyler modifier(WidgetModifierConfig value) {
    return merge(RemixDividerStyler(modifier: value));
  }

  /// Merges with another [RemixDividerStyler].
  @override
  RemixDividerStyler merge(RemixDividerStyler? other) {
    return RemixDividerStyler.create(
      container: MixOps.merge($container, other?.$container),
      thickness: MixOps.merge($thickness, other?.$thickness),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixDividerSpec>] using [context].
  @override
  StyleSpec<RemixDividerSpec> resolve(BuildContext context) {
    final spec = RemixDividerSpec(
      container: MixOps.resolve(context, $container),
      thickness: MixOps.resolve(context, $thickness),
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
      ..add(DiagnosticsProperty('thickness', $thickness));
  }

  @override
  List<Object?> get props => [
    $container,
    $thickness,
    $animation,
    $modifier,
    $variants,
  ];
}
