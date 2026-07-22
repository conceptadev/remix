// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixProgressSpec implements Spec<RemixProgressSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get track;
  StyleSpec<BoxSpec> get indicator;
  RemixSurfaceEffectsSpec? get trackEffects;
  RemixSurfaceEffectsSpec? get indicatorEffects;

  @override
  Type get type => RemixProgressSpec;

  @override
  RemixProgressSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? track,
    StyleSpec<BoxSpec>? indicator,
    RemixSurfaceEffectsSpec? trackEffects,
    RemixSurfaceEffectsSpec? indicatorEffects,
  }) {
    return RemixProgressSpec(
      container: container ?? this.container,
      track: track ?? this.track,
      indicator: indicator ?? this.indicator,
      trackEffects: trackEffects ?? this.trackEffects,
      indicatorEffects: indicatorEffects ?? this.indicatorEffects,
    );
  }

  @override
  RemixProgressSpec lerp(RemixProgressSpec? other, double t) {
    return RemixProgressSpec(
      container: container.lerp(other?.container, t),
      track: track.lerp(other?.track, t),
      indicator: indicator.lerp(other?.indicator, t),
      trackEffects: MixOps.lerpSnap(trackEffects, other?.trackEffects, t),
      indicatorEffects: MixOps.lerpSnap(
        indicatorEffects,
        other?.indicatorEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [
    container,
    track,
    indicator,
    trackEffects,
    indicatorEffects,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixProgressSpec &&
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
      ..add(DiagnosticsProperty('track', track))
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('trackEffects', trackEffects))
      ..add(DiagnosticsProperty('indicatorEffects', indicatorEffects));
  }
}

@Deprecated(
  'Rename to `_\$RemixProgressSpec` and migrate the class declaration to `class RemixProgressSpec with _\$RemixProgressSpec`. The `_\$RemixProgressSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixProgressSpecMethods = _$RemixProgressSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixProgressStyler
    extends MixStyler<RemixProgressStyler, RemixProgressSpec>
    with RemixBoxStylerMixin<RemixProgressStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $track;
  final Prop<StyleSpec<BoxSpec>>? $indicator;
  final Prop<RemixSurfaceEffectsSpec>? $trackEffects;
  final Prop<RemixSurfaceEffectsSpec>? $indicatorEffects;

  const RemixProgressStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? track,
    Prop<StyleSpec<BoxSpec>>? indicator,
    Prop<RemixSurfaceEffectsSpec>? trackEffects,
    Prop<RemixSurfaceEffectsSpec>? indicatorEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $track = track,
       $indicator = indicator,
       $trackEffects = trackEffects,
       $indicatorEffects = indicatorEffects;

  RemixProgressStyler({
    BoxStyler? container,
    BoxStyler? track,
    BoxStyler? indicator,
    RemixSurfaceEffectsMix? trackEffects,
    RemixSurfaceEffectsMix? indicatorEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixProgressSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         track: Prop.maybeMix(track),
         indicator: Prop.maybeMix(indicator),
         trackEffects: Prop.maybeMix(trackEffects),
         indicatorEffects: Prop.maybeMix(indicatorEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixProgressStyler.container(BoxStyler value) =>
      RemixProgressStyler().container(value);
  factory RemixProgressStyler.track(BoxStyler value) =>
      RemixProgressStyler().track(value);
  factory RemixProgressStyler.indicator(BoxStyler value) =>
      RemixProgressStyler().indicator(value);
  factory RemixProgressStyler.trackEffects(RemixSurfaceEffectsMix value) =>
      RemixProgressStyler().trackEffects(value);
  factory RemixProgressStyler.indicatorEffects(RemixSurfaceEffectsMix value) =>
      RemixProgressStyler().indicatorEffects(value);
  factory RemixProgressStyler.alignment(AlignmentGeometry value) =>
      RemixProgressStyler().alignment(value);
  factory RemixProgressStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixProgressStyler().padding(value);
  factory RemixProgressStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixProgressStyler().margin(value);
  factory RemixProgressStyler.constraints(BoxConstraintsMix value) =>
      RemixProgressStyler().constraints(value);
  factory RemixProgressStyler.decoration(DecorationMix value) =>
      RemixProgressStyler().decoration(value);
  factory RemixProgressStyler.foregroundDecoration(DecorationMix value) =>
      RemixProgressStyler().foregroundDecoration(value);
  factory RemixProgressStyler.clipBehavior(Clip value) =>
      RemixProgressStyler().clipBehavior(value);
  factory RemixProgressStyler.color(Color value) =>
      RemixProgressStyler().color(value);
  factory RemixProgressStyler.gradient(GradientMix value) =>
      RemixProgressStyler().gradient(value);
  factory RemixProgressStyler.border(BoxBorderMix value) =>
      RemixProgressStyler().border(value);
  factory RemixProgressStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixProgressStyler().borderRadius(value);
  factory RemixProgressStyler.elevation(ElevationShadow value) =>
      RemixProgressStyler().elevation(value);
  factory RemixProgressStyler.shadow(BoxShadowMix value) =>
      RemixProgressStyler().shadow(value);
  factory RemixProgressStyler.shadows(List<BoxShadowMix> value) =>
      RemixProgressStyler().shadows(value);
  factory RemixProgressStyler.width(double value) =>
      RemixProgressStyler().width(value);
  factory RemixProgressStyler.height(double value) =>
      RemixProgressStyler().height(value);
  factory RemixProgressStyler.size(double width, double height) =>
      RemixProgressStyler().size(width, height);
  factory RemixProgressStyler.minWidth(double value) =>
      RemixProgressStyler().minWidth(value);
  factory RemixProgressStyler.maxWidth(double value) =>
      RemixProgressStyler().maxWidth(value);
  factory RemixProgressStyler.minHeight(double value) =>
      RemixProgressStyler().minHeight(value);
  factory RemixProgressStyler.maxHeight(double value) =>
      RemixProgressStyler().maxHeight(value);
  factory RemixProgressStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixProgressStyler().scale(scale, alignment: alignment);
  factory RemixProgressStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixProgressStyler().rotate(radians, alignment: alignment);
  factory RemixProgressStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixProgressStyler().translate(x, y, z);
  factory RemixProgressStyler.skew(double skewX, double skewY) =>
      RemixProgressStyler().skew(skewX, skewY);
  factory RemixProgressStyler.textStyle(TextStyler value) =>
      RemixProgressStyler().textStyle(value);
  factory RemixProgressStyler.image(DecorationImageMix value) =>
      RemixProgressStyler().image(value);
  factory RemixProgressStyler.shape(ShapeBorderMix value) =>
      RemixProgressStyler().shape(value);
  factory RemixProgressStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixProgressStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixProgressStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixProgressStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixProgressStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixProgressStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixProgressStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixProgressStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixProgressStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixProgressStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixProgressStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixProgressStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixProgressStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixProgressStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixProgressStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixProgressStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixProgressStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixProgressStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixProgressStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixProgressStyler().transform(value, alignment: alignment);

  RemixProgressStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixProgressStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixProgressStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixProgressStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixProgressStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixProgressStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixProgressStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixProgressStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixProgressStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixProgressStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixProgressStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixProgressStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixProgressStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixProgressStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixProgressStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixProgressStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixProgressStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixProgressStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixProgressStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixProgressStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixProgressStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixProgressStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixProgressStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixProgressStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixProgressStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixProgressStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixProgressStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixProgressStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixProgressStyler backgroundImage(
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

  RemixProgressStyler backgroundImageUrl(
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

  RemixProgressStyler backgroundImageAsset(
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

  RemixProgressStyler linearGradient({
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

  RemixProgressStyler radialGradient({
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

  RemixProgressStyler sweepGradient({
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

  RemixProgressStyler foregroundLinearGradient({
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

  RemixProgressStyler foregroundRadialGradient({
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

  RemixProgressStyler foregroundSweepGradient({
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

  RemixProgressStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixProgressStyler container(BoxStyler value) {
    return merge(RemixProgressStyler(container: value));
  }

  /// Sets the track.
  RemixProgressStyler track(BoxStyler value) {
    return merge(RemixProgressStyler(track: value));
  }

  /// Sets the indicator.
  RemixProgressStyler indicator(BoxStyler value) {
    return merge(RemixProgressStyler(indicator: value));
  }

  /// Sets the trackEffects.
  RemixProgressStyler trackEffects(RemixSurfaceEffectsMix value) {
    return merge(RemixProgressStyler(trackEffects: value));
  }

  /// Sets the indicatorEffects.
  RemixProgressStyler indicatorEffects(RemixSurfaceEffectsMix value) {
    return merge(RemixProgressStyler(indicatorEffects: value));
  }

  /// Sets the animation configuration.
  @override
  RemixProgressStyler animate(AnimationConfig value) {
    return merge(RemixProgressStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixProgressStyler variants(List<VariantStyle<RemixProgressSpec>> value) {
    return merge(RemixProgressStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixProgressStyler wrap(WidgetModifierConfig value) {
    return merge(RemixProgressStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixProgressStyler modifier(WidgetModifierConfig value) {
    return merge(RemixProgressStyler(modifier: value));
  }

  /// Merges with another [RemixProgressStyler].
  @override
  RemixProgressStyler merge(RemixProgressStyler? other) {
    return RemixProgressStyler.create(
      container: MixOps.merge($container, other?.$container),
      track: MixOps.merge($track, other?.$track),
      indicator: MixOps.merge($indicator, other?.$indicator),
      trackEffects: MixOps.merge($trackEffects, other?.$trackEffects),
      indicatorEffects: MixOps.merge(
        $indicatorEffects,
        other?.$indicatorEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixProgressSpec>] using [context].
  @override
  StyleSpec<RemixProgressSpec> resolve(BuildContext context) {
    final spec = RemixProgressSpec(
      container: MixOps.resolve(context, $container),
      track: MixOps.resolve(context, $track),
      indicator: MixOps.resolve(context, $indicator),
      trackEffects: MixOps.resolve(context, $trackEffects),
      indicatorEffects: MixOps.resolve(context, $indicatorEffects),
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
      ..add(DiagnosticsProperty('track', $track))
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('trackEffects', $trackEffects))
      ..add(DiagnosticsProperty('indicatorEffects', $indicatorEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $track,
    $indicator,
    $trackEffects,
    $indicatorEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
