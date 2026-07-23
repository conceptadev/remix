// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkbox.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixCheckboxSpec implements Spec<RemixCheckboxSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<IconSpec> get indicator;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => RemixCheckboxSpec;

  @override
  RemixCheckboxSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<IconSpec>? indicator,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return RemixCheckboxSpec(
      container: container ?? this.container,
      indicator: indicator ?? this.indicator,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  RemixCheckboxSpec lerp(RemixCheckboxSpec? other, double t) {
    return RemixCheckboxSpec(
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
        other is RemixCheckboxSpec &&
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
  'Rename to `_\$RemixCheckboxSpec` and migrate the class declaration to `class RemixCheckboxSpec with _\$RemixCheckboxSpec`. The `_\$RemixCheckboxSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixCheckboxSpecMethods = _$RemixCheckboxSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixCheckboxStyler
    extends MixStyler<RemixCheckboxStyler, RemixCheckboxSpec>
    with RemixBoxStylerMixin<RemixCheckboxStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<IconSpec>>? $indicator;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const RemixCheckboxStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<IconSpec>>? indicator,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $indicator = indicator,
       $containerEffects = containerEffects;

  RemixCheckboxStyler({
    BoxStyler? container,
    IconStyler? indicator,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixCheckboxSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         indicator: Prop.maybeMix(indicator),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixCheckboxStyler.container(BoxStyler value) =>
      RemixCheckboxStyler().container(value);
  factory RemixCheckboxStyler.indicator(IconStyler value) =>
      RemixCheckboxStyler().indicator(value);
  factory RemixCheckboxStyler.containerEffects(RemixBoxEffectsMix value) =>
      RemixCheckboxStyler().containerEffects(value);
  factory RemixCheckboxStyler.alignment(AlignmentGeometry value) =>
      RemixCheckboxStyler().alignment(value);
  factory RemixCheckboxStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixCheckboxStyler().padding(value);
  factory RemixCheckboxStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixCheckboxStyler().margin(value);
  factory RemixCheckboxStyler.constraints(BoxConstraintsMix value) =>
      RemixCheckboxStyler().constraints(value);
  factory RemixCheckboxStyler.decoration(DecorationMix value) =>
      RemixCheckboxStyler().decoration(value);
  factory RemixCheckboxStyler.foregroundDecoration(DecorationMix value) =>
      RemixCheckboxStyler().foregroundDecoration(value);
  factory RemixCheckboxStyler.clipBehavior(Clip value) =>
      RemixCheckboxStyler().clipBehavior(value);
  factory RemixCheckboxStyler.color(Color value) =>
      RemixCheckboxStyler().color(value);
  factory RemixCheckboxStyler.gradient(GradientMix value) =>
      RemixCheckboxStyler().gradient(value);
  factory RemixCheckboxStyler.border(BoxBorderMix value) =>
      RemixCheckboxStyler().border(value);
  factory RemixCheckboxStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixCheckboxStyler().borderRadius(value);
  factory RemixCheckboxStyler.elevation(ElevationShadow value) =>
      RemixCheckboxStyler().elevation(value);
  factory RemixCheckboxStyler.shadow(BoxShadowMix value) =>
      RemixCheckboxStyler().shadow(value);
  factory RemixCheckboxStyler.shadows(List<BoxShadowMix> value) =>
      RemixCheckboxStyler().shadows(value);
  factory RemixCheckboxStyler.width(double value) =>
      RemixCheckboxStyler().width(value);
  factory RemixCheckboxStyler.height(double value) =>
      RemixCheckboxStyler().height(value);
  factory RemixCheckboxStyler.size(double width, double height) =>
      RemixCheckboxStyler().size(width, height);
  factory RemixCheckboxStyler.minWidth(double value) =>
      RemixCheckboxStyler().minWidth(value);
  factory RemixCheckboxStyler.maxWidth(double value) =>
      RemixCheckboxStyler().maxWidth(value);
  factory RemixCheckboxStyler.minHeight(double value) =>
      RemixCheckboxStyler().minHeight(value);
  factory RemixCheckboxStyler.maxHeight(double value) =>
      RemixCheckboxStyler().maxHeight(value);
  factory RemixCheckboxStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixCheckboxStyler().scale(scale, alignment: alignment);
  factory RemixCheckboxStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixCheckboxStyler().rotate(radians, alignment: alignment);
  factory RemixCheckboxStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixCheckboxStyler().translate(x, y, z);
  factory RemixCheckboxStyler.skew(double skewX, double skewY) =>
      RemixCheckboxStyler().skew(skewX, skewY);
  factory RemixCheckboxStyler.textStyle(TextStyler value) =>
      RemixCheckboxStyler().textStyle(value);
  factory RemixCheckboxStyler.image(DecorationImageMix value) =>
      RemixCheckboxStyler().image(value);
  factory RemixCheckboxStyler.shape(ShapeBorderMix value) =>
      RemixCheckboxStyler().shape(value);
  factory RemixCheckboxStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixCheckboxStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixCheckboxStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixCheckboxStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixCheckboxStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixCheckboxStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixCheckboxStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixCheckboxStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixCheckboxStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixCheckboxStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixCheckboxStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixCheckboxStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixCheckboxStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixCheckboxStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixCheckboxStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixCheckboxStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixCheckboxStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixCheckboxStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixCheckboxStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixCheckboxStyler().transform(value, alignment: alignment);

  RemixCheckboxStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixCheckboxStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixCheckboxStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixCheckboxStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixCheckboxStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixCheckboxStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixCheckboxStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixCheckboxStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixCheckboxStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixCheckboxStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixCheckboxStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixCheckboxStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixCheckboxStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixCheckboxStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixCheckboxStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixCheckboxStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixCheckboxStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixCheckboxStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixCheckboxStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixCheckboxStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixCheckboxStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixCheckboxStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixCheckboxStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixCheckboxStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixCheckboxStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixCheckboxStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixCheckboxStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixCheckboxStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixCheckboxStyler backgroundImage(
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

  RemixCheckboxStyler backgroundImageUrl(
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

  RemixCheckboxStyler backgroundImageAsset(
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

  RemixCheckboxStyler linearGradient({
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

  RemixCheckboxStyler radialGradient({
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

  RemixCheckboxStyler sweepGradient({
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

  RemixCheckboxStyler foregroundLinearGradient({
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

  RemixCheckboxStyler foregroundRadialGradient({
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

  RemixCheckboxStyler foregroundSweepGradient({
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

  RemixCheckboxStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixCheckboxStyler container(BoxStyler value) {
    return merge(RemixCheckboxStyler(container: value));
  }

  /// Sets the indicator.
  RemixCheckboxStyler indicator(IconStyler value) {
    return merge(RemixCheckboxStyler(indicator: value));
  }

  /// Sets the containerEffects.
  RemixCheckboxStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(RemixCheckboxStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  RemixCheckboxStyler animate(AnimationConfig value) {
    return merge(RemixCheckboxStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixCheckboxStyler variants(List<VariantStyle<RemixCheckboxSpec>> value) {
    return merge(RemixCheckboxStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixCheckboxStyler wrap(WidgetModifierConfig value) {
    return merge(RemixCheckboxStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixCheckboxStyler modifier(WidgetModifierConfig value) {
    return merge(RemixCheckboxStyler(modifier: value));
  }

  /// Merges with another [RemixCheckboxStyler].
  @override
  RemixCheckboxStyler merge(RemixCheckboxStyler? other) {
    return RemixCheckboxStyler.create(
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

  /// Resolves to [StyleSpec<RemixCheckboxSpec>] using [context].
  @override
  StyleSpec<RemixCheckboxSpec> resolve(BuildContext context) {
    final spec = RemixCheckboxSpec(
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
