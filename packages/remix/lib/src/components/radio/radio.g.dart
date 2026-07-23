// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixRadioSpec implements Spec<RemixRadioSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get indicator;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => RemixRadioSpec;

  @override
  RemixRadioSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? indicator,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return RemixRadioSpec(
      container: container ?? this.container,
      indicator: indicator ?? this.indicator,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  RemixRadioSpec lerp(RemixRadioSpec? other, double t) {
    return RemixRadioSpec(
      container: container.lerp(other?.container, t),
      indicator: indicator.lerp(other?.indicator, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [container, indicator, containerEffects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixRadioSpec &&
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
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$RemixRadioSpec` and migrate the class declaration to `class RemixRadioSpec with _\$RemixRadioSpec`. The `_\$RemixRadioSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixRadioSpecMethods = _$RemixRadioSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixRadioStyler extends MixStyler<RemixRadioStyler, RemixRadioSpec>
    with RemixBoxStylerMixin<RemixRadioStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $indicator;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const RemixRadioStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? indicator,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $indicator = indicator,
       $containerEffects = containerEffects;

  RemixRadioStyler({
    BoxStyler? container,
    BoxStyler? indicator,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixRadioSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         indicator: Prop.maybeMix(indicator),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixRadioStyler.container(BoxStyler value) =>
      RemixRadioStyler().container(value);
  factory RemixRadioStyler.indicator(BoxStyler value) =>
      RemixRadioStyler().indicator(value);
  factory RemixRadioStyler.containerEffects(RemixBoxEffectsMix value) =>
      RemixRadioStyler().containerEffects(value);
  factory RemixRadioStyler.alignment(AlignmentGeometry value) =>
      RemixRadioStyler().alignment(value);
  factory RemixRadioStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixRadioStyler().padding(value);
  factory RemixRadioStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixRadioStyler().margin(value);
  factory RemixRadioStyler.constraints(BoxConstraintsMix value) =>
      RemixRadioStyler().constraints(value);
  factory RemixRadioStyler.decoration(DecorationMix value) =>
      RemixRadioStyler().decoration(value);
  factory RemixRadioStyler.foregroundDecoration(DecorationMix value) =>
      RemixRadioStyler().foregroundDecoration(value);
  factory RemixRadioStyler.clipBehavior(Clip value) =>
      RemixRadioStyler().clipBehavior(value);
  factory RemixRadioStyler.color(Color value) =>
      RemixRadioStyler().color(value);
  factory RemixRadioStyler.gradient(GradientMix value) =>
      RemixRadioStyler().gradient(value);
  factory RemixRadioStyler.border(BoxBorderMix value) =>
      RemixRadioStyler().border(value);
  factory RemixRadioStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixRadioStyler().borderRadius(value);
  factory RemixRadioStyler.elevation(ElevationShadow value) =>
      RemixRadioStyler().elevation(value);
  factory RemixRadioStyler.shadow(BoxShadowMix value) =>
      RemixRadioStyler().shadow(value);
  factory RemixRadioStyler.shadows(List<BoxShadowMix> value) =>
      RemixRadioStyler().shadows(value);
  factory RemixRadioStyler.width(double value) =>
      RemixRadioStyler().width(value);
  factory RemixRadioStyler.height(double value) =>
      RemixRadioStyler().height(value);
  factory RemixRadioStyler.size(double width, double height) =>
      RemixRadioStyler().size(width, height);
  factory RemixRadioStyler.minWidth(double value) =>
      RemixRadioStyler().minWidth(value);
  factory RemixRadioStyler.maxWidth(double value) =>
      RemixRadioStyler().maxWidth(value);
  factory RemixRadioStyler.minHeight(double value) =>
      RemixRadioStyler().minHeight(value);
  factory RemixRadioStyler.maxHeight(double value) =>
      RemixRadioStyler().maxHeight(value);
  factory RemixRadioStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixRadioStyler().scale(scale, alignment: alignment);
  factory RemixRadioStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixRadioStyler().rotate(radians, alignment: alignment);
  factory RemixRadioStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixRadioStyler().translate(x, y, z);
  factory RemixRadioStyler.skew(double skewX, double skewY) =>
      RemixRadioStyler().skew(skewX, skewY);
  factory RemixRadioStyler.textStyle(TextStyler value) =>
      RemixRadioStyler().textStyle(value);
  factory RemixRadioStyler.image(DecorationImageMix value) =>
      RemixRadioStyler().image(value);
  factory RemixRadioStyler.shape(ShapeBorderMix value) =>
      RemixRadioStyler().shape(value);
  factory RemixRadioStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixRadioStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixRadioStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixRadioStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixRadioStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixRadioStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixRadioStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixRadioStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixRadioStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixRadioStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixRadioStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixRadioStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixRadioStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixRadioStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixRadioStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixRadioStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixRadioStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixRadioStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixRadioStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixRadioStyler().transform(value, alignment: alignment);

  RemixRadioStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixRadioStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixRadioStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixRadioStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixRadioStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixRadioStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixRadioStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixRadioStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixRadioStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixRadioStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixRadioStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixRadioStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixRadioStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixRadioStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixRadioStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixRadioStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixRadioStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixRadioStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixRadioStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixRadioStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixRadioStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixRadioStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixRadioStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixRadioStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixRadioStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixRadioStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixRadioStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixRadioStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixRadioStyler backgroundImage(
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

  RemixRadioStyler backgroundImageUrl(
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

  RemixRadioStyler backgroundImageAsset(
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

  RemixRadioStyler linearGradient({
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

  RemixRadioStyler radialGradient({
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

  RemixRadioStyler sweepGradient({
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

  RemixRadioStyler foregroundLinearGradient({
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

  RemixRadioStyler foregroundRadialGradient({
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

  RemixRadioStyler foregroundSweepGradient({
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

  RemixRadioStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixRadioStyler container(BoxStyler value) {
    return merge(RemixRadioStyler(container: value));
  }

  /// Sets the indicator.
  RemixRadioStyler indicator(BoxStyler value) {
    return merge(RemixRadioStyler(indicator: value));
  }

  /// Sets the containerEffects.
  RemixRadioStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(RemixRadioStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  RemixRadioStyler animate(AnimationConfig value) {
    return merge(RemixRadioStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixRadioStyler variants(List<VariantStyle<RemixRadioSpec>> value) {
    return merge(RemixRadioStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixRadioStyler wrap(WidgetModifierConfig value) {
    return merge(RemixRadioStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixRadioStyler modifier(WidgetModifierConfig value) {
    return merge(RemixRadioStyler(modifier: value));
  }

  /// Merges with another [RemixRadioStyler].
  @override
  RemixRadioStyler merge(RemixRadioStyler? other) {
    return RemixRadioStyler.create(
      container: MixOps.merge($container, other?.$container),
      indicator: MixOps.merge($indicator, other?.$indicator),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixRadioSpec>] using [context].
  @override
  StyleSpec<RemixRadioSpec> resolve(BuildContext context) {
    final spec = RemixRadioSpec(
      container: MixOps.resolve(context, $container),
      indicator: MixOps.resolve(context, $indicator),
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
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $indicator,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
