// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$CardSpec implements Spec<CardSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => CardSpec;

  @override
  CardSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return CardSpec(
      container: container ?? this.container,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  CardSpec lerp(CardSpec? other, double t) {
    return CardSpec(
      container: container.lerp(other?.container, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [container, containerEffects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CardSpec &&
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
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$CardSpec` and migrate the class declaration to `class CardSpec with _\$CardSpec`. The `_\$CardSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$CardSpecMethods = _$CardSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class CardStyler extends MixStyler<CardStyler, CardSpec>
    with RemixBoxStylerMixin<CardStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const CardStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $containerEffects = containerEffects;

  CardStyler({
    BoxStyler? container,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<CardSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory CardStyler.container(BoxStyler value) =>
      CardStyler().container(value);
  factory CardStyler.containerEffects(RemixBoxEffectsMix value) =>
      CardStyler().containerEffects(value);
  factory CardStyler.alignment(AlignmentGeometry value) =>
      CardStyler().alignment(value);
  factory CardStyler.padding(EdgeInsetsGeometryMix value) =>
      CardStyler().padding(value);
  factory CardStyler.margin(EdgeInsetsGeometryMix value) =>
      CardStyler().margin(value);
  factory CardStyler.constraints(BoxConstraintsMix value) =>
      CardStyler().constraints(value);
  factory CardStyler.decoration(DecorationMix value) =>
      CardStyler().decoration(value);
  factory CardStyler.foregroundDecoration(DecorationMix value) =>
      CardStyler().foregroundDecoration(value);
  factory CardStyler.clipBehavior(Clip value) =>
      CardStyler().clipBehavior(value);
  factory CardStyler.color(Color value) => CardStyler().color(value);
  factory CardStyler.gradient(GradientMix value) =>
      CardStyler().gradient(value);
  factory CardStyler.border(BoxBorderMix value) => CardStyler().border(value);
  factory CardStyler.borderRadius(BorderRadiusGeometryMix value) =>
      CardStyler().borderRadius(value);
  factory CardStyler.elevation(ElevationShadow value) =>
      CardStyler().elevation(value);
  factory CardStyler.shadow(BoxShadowMix value) => CardStyler().shadow(value);
  factory CardStyler.shadows(List<BoxShadowMix> value) =>
      CardStyler().shadows(value);
  factory CardStyler.width(double value) => CardStyler().width(value);
  factory CardStyler.height(double value) => CardStyler().height(value);
  factory CardStyler.size(double width, double height) =>
      CardStyler().size(width, height);
  factory CardStyler.minWidth(double value) => CardStyler().minWidth(value);
  factory CardStyler.maxWidth(double value) => CardStyler().maxWidth(value);
  factory CardStyler.minHeight(double value) => CardStyler().minHeight(value);
  factory CardStyler.maxHeight(double value) => CardStyler().maxHeight(value);
  factory CardStyler.scale(double scale, {Alignment alignment = .center}) =>
      CardStyler().scale(scale, alignment: alignment);
  factory CardStyler.rotate(double radians, {Alignment alignment = .center}) =>
      CardStyler().rotate(radians, alignment: alignment);
  factory CardStyler.translate(double x, double y, [double z = 0.0]) =>
      CardStyler().translate(x, y, z);
  factory CardStyler.skew(double skewX, double skewY) =>
      CardStyler().skew(skewX, skewY);
  factory CardStyler.textStyle(TextStyler value) =>
      CardStyler().textStyle(value);
  factory CardStyler.image(DecorationImageMix value) =>
      CardStyler().image(value);
  factory CardStyler.shape(ShapeBorderMix value) => CardStyler().shape(value);
  factory CardStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => CardStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory CardStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => CardStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory CardStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => CardStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory CardStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => CardStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory CardStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => CardStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory CardStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => CardStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory CardStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => CardStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory CardStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => CardStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory CardStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => CardStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory CardStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => CardStyler().transform(value, alignment: alignment);

  CardStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  CardStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  CardStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  CardStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  CardStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  CardStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  CardStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  CardStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  CardStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  CardStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  CardStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  CardStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  CardStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  CardStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  CardStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  CardStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  CardStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  CardStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  CardStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  CardStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  CardStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  CardStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  CardStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  CardStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  CardStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  CardStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  CardStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  CardStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  CardStyler backgroundImage(
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

  CardStyler backgroundImageUrl(
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

  CardStyler backgroundImageAsset(
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

  CardStyler linearGradient({
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

  CardStyler radialGradient({
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

  CardStyler sweepGradient({
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

  CardStyler foregroundLinearGradient({
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

  CardStyler foregroundRadialGradient({
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

  CardStyler foregroundSweepGradient({
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

  CardStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  CardStyler container(BoxStyler value) {
    return merge(CardStyler(container: value));
  }

  /// Sets the containerEffects.
  CardStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(CardStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  CardStyler animate(AnimationConfig value) {
    return merge(CardStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  CardStyler variants(List<VariantStyle<CardSpec>> value) {
    return merge(CardStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  CardStyler wrap(WidgetModifierConfig value) {
    return merge(CardStyler(modifier: value));
  }

  /// Sets the widget modifier.
  CardStyler modifier(WidgetModifierConfig value) {
    return merge(CardStyler(modifier: value));
  }

  /// Merges with another [CardStyler].
  @override
  CardStyler merge(CardStyler? other) {
    return CardStyler.create(
      container: MixOps.merge($container, other?.$container),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<CardSpec>] using [context].
  @override
  StyleSpec<CardSpec> resolve(BuildContext context) {
    final spec = CardSpec(
      container: MixOps.resolve(context, $container),
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
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
