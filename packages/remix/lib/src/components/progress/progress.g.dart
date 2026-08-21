// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$ProgressSpec implements Spec<ProgressSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get track;
  StyleSpec<BoxSpec> get indicator;
  StyleSpec<BoxSpec> get trackContainer;
  RemixBoxEffectsSpec? get trackEffects;
  RemixBoxEffectsSpec? get indicatorEffects;

  @override
  Type get type => ProgressSpec;

  @override
  ProgressSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? track,
    StyleSpec<BoxSpec>? indicator,
    StyleSpec<BoxSpec>? trackContainer,
    RemixBoxEffectsSpec? trackEffects,
    RemixBoxEffectsSpec? indicatorEffects,
  }) {
    return ProgressSpec(
      container: container ?? this.container,
      track: track ?? this.track,
      indicator: indicator ?? this.indicator,
      trackContainer: trackContainer ?? this.trackContainer,
      trackEffects: trackEffects ?? this.trackEffects,
      indicatorEffects: indicatorEffects ?? this.indicatorEffects,
    );
  }

  @override
  ProgressSpec lerp(ProgressSpec? other, double t) {
    return ProgressSpec(
      container: container.lerp(other?.container, t),
      track: track.lerp(other?.track, t),
      indicator: indicator.lerp(other?.indicator, t),
      trackContainer: trackContainer.lerp(other?.trackContainer, t),
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
    trackContainer,
    trackEffects,
    indicatorEffects,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ProgressSpec &&
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
      ..add(DiagnosticsProperty('trackContainer', trackContainer))
      ..add(DiagnosticsProperty('trackEffects', trackEffects))
      ..add(DiagnosticsProperty('indicatorEffects', indicatorEffects));
  }
}

@Deprecated(
  'Rename to `_\$ProgressSpec` and migrate the class declaration to `class ProgressSpec with _\$ProgressSpec`. The `_\$ProgressSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$ProgressSpecMethods = _$ProgressSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class ProgressStyler extends MixStyler<ProgressStyler, ProgressSpec>
    with RemixBoxStylerMixin<ProgressStyler>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $track;
  final Prop<StyleSpec<BoxSpec>>? $indicator;
  final Prop<StyleSpec<BoxSpec>>? $trackContainer;
  final Prop<RemixBoxEffectsSpec>? $trackEffects;
  final Prop<RemixBoxEffectsSpec>? $indicatorEffects;

  const ProgressStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? track,
    Prop<StyleSpec<BoxSpec>>? indicator,
    Prop<StyleSpec<BoxSpec>>? trackContainer,
    Prop<RemixBoxEffectsSpec>? trackEffects,
    Prop<RemixBoxEffectsSpec>? indicatorEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $track = track,
       $indicator = indicator,
       $trackContainer = trackContainer,
       $trackEffects = trackEffects,
       $indicatorEffects = indicatorEffects;

  ProgressStyler({
    BoxStyler? container,
    BoxStyler? track,
    BoxStyler? indicator,
    BoxStyler? trackContainer,
    RemixBoxEffectsMix? trackEffects,
    RemixBoxEffectsMix? indicatorEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<ProgressSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         track: Prop.maybeMix(track),
         indicator: Prop.maybeMix(indicator),
         trackContainer: Prop.maybeMix(trackContainer),
         trackEffects: Prop.maybeMix(trackEffects),
         indicatorEffects: Prop.maybeMix(indicatorEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory ProgressStyler.container(BoxStyler value) =>
      ProgressStyler().container(value);
  factory ProgressStyler.track(BoxStyler value) =>
      ProgressStyler().track(value);
  factory ProgressStyler.indicator(BoxStyler value) =>
      ProgressStyler().indicator(value);
  factory ProgressStyler.trackContainer(BoxStyler value) =>
      ProgressStyler().trackContainer(value);
  factory ProgressStyler.trackEffects(RemixBoxEffectsMix value) =>
      ProgressStyler().trackEffects(value);
  factory ProgressStyler.indicatorEffects(RemixBoxEffectsMix value) =>
      ProgressStyler().indicatorEffects(value);
  factory ProgressStyler.alignment(AlignmentGeometry value) =>
      ProgressStyler().alignment(value);
  factory ProgressStyler.padding(EdgeInsetsGeometryMix value) =>
      ProgressStyler().padding(value);
  factory ProgressStyler.margin(EdgeInsetsGeometryMix value) =>
      ProgressStyler().margin(value);
  factory ProgressStyler.constraints(BoxConstraintsMix value) =>
      ProgressStyler().constraints(value);
  factory ProgressStyler.decoration(DecorationMix value) =>
      ProgressStyler().decoration(value);
  factory ProgressStyler.foregroundDecoration(DecorationMix value) =>
      ProgressStyler().foregroundDecoration(value);
  factory ProgressStyler.clipBehavior(Clip value) =>
      ProgressStyler().clipBehavior(value);
  factory ProgressStyler.color(Color value) => ProgressStyler().color(value);
  factory ProgressStyler.gradient(GradientMix value) =>
      ProgressStyler().gradient(value);
  factory ProgressStyler.border(BoxBorderMix value) =>
      ProgressStyler().border(value);
  factory ProgressStyler.borderRadius(BorderRadiusGeometryMix value) =>
      ProgressStyler().borderRadius(value);
  factory ProgressStyler.elevation(ElevationShadow value) =>
      ProgressStyler().elevation(value);
  factory ProgressStyler.shadow(BoxShadowMix value) =>
      ProgressStyler().shadow(value);
  factory ProgressStyler.shadows(List<BoxShadowMix> value) =>
      ProgressStyler().shadows(value);
  factory ProgressStyler.width(double value) => ProgressStyler().width(value);
  factory ProgressStyler.height(double value) => ProgressStyler().height(value);
  factory ProgressStyler.size(double width, double height) =>
      ProgressStyler().size(width, height);
  factory ProgressStyler.minWidth(double value) =>
      ProgressStyler().minWidth(value);
  factory ProgressStyler.maxWidth(double value) =>
      ProgressStyler().maxWidth(value);
  factory ProgressStyler.minHeight(double value) =>
      ProgressStyler().minHeight(value);
  factory ProgressStyler.maxHeight(double value) =>
      ProgressStyler().maxHeight(value);
  factory ProgressStyler.scale(double scale, {Alignment alignment = .center}) =>
      ProgressStyler().scale(scale, alignment: alignment);
  factory ProgressStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => ProgressStyler().rotate(radians, alignment: alignment);
  factory ProgressStyler.translate(double x, double y, [double z = 0.0]) =>
      ProgressStyler().translate(x, y, z);
  factory ProgressStyler.skew(double skewX, double skewY) =>
      ProgressStyler().skew(skewX, skewY);
  factory ProgressStyler.textStyle(TextStyler value) =>
      ProgressStyler().textStyle(value);
  factory ProgressStyler.image(DecorationImageMix value) =>
      ProgressStyler().image(value);
  factory ProgressStyler.shape(ShapeBorderMix value) =>
      ProgressStyler().shape(value);
  factory ProgressStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ProgressStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ProgressStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ProgressStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ProgressStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ProgressStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ProgressStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ProgressStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ProgressStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ProgressStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ProgressStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ProgressStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ProgressStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ProgressStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ProgressStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ProgressStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ProgressStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ProgressStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ProgressStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => ProgressStyler().transform(value, alignment: alignment);

  ProgressStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  ProgressStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  ProgressStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  ProgressStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  ProgressStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  ProgressStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  ProgressStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  ProgressStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  ProgressStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  ProgressStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  ProgressStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  ProgressStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  ProgressStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  ProgressStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  ProgressStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  ProgressStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  ProgressStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  ProgressStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  ProgressStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  ProgressStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  ProgressStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  ProgressStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  ProgressStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  ProgressStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  ProgressStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  ProgressStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  ProgressStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  ProgressStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  ProgressStyler backgroundImage(
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

  ProgressStyler backgroundImageUrl(
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

  ProgressStyler backgroundImageAsset(
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

  ProgressStyler linearGradient({
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

  ProgressStyler radialGradient({
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

  ProgressStyler sweepGradient({
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

  ProgressStyler foregroundLinearGradient({
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

  ProgressStyler foregroundRadialGradient({
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

  ProgressStyler foregroundSweepGradient({
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

  ProgressStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  @override
  Set<String> get $stylerFieldNames => const {
    'container',
    'track',
    'indicator',
    'trackContainer',
    'trackEffects',
    'indicatorEffects',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the container.
  ProgressStyler container(BoxStyler value) {
    return merge(ProgressStyler(container: value));
  }

  /// Sets the track.
  ProgressStyler track(BoxStyler value) {
    return merge(ProgressStyler(track: value));
  }

  /// Sets the indicator.
  ProgressStyler indicator(BoxStyler value) {
    return merge(ProgressStyler(indicator: value));
  }

  /// Sets the trackContainer.
  ProgressStyler trackContainer(BoxStyler value) {
    return merge(ProgressStyler(trackContainer: value));
  }

  /// Sets the trackEffects.
  ProgressStyler trackEffects(RemixBoxEffectsMix value) {
    return merge(ProgressStyler(trackEffects: value));
  }

  /// Sets the indicatorEffects.
  ProgressStyler indicatorEffects(RemixBoxEffectsMix value) {
    return merge(ProgressStyler(indicatorEffects: value));
  }

  /// Sets the animation configuration.
  @override
  ProgressStyler animate(AnimationConfig value) {
    return merge(ProgressStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  ProgressStyler variants(List<VariantStyle<ProgressSpec>> value) {
    return merge(ProgressStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  ProgressStyler wrap(WidgetModifierConfig value) {
    return merge(ProgressStyler(modifier: value));
  }

  /// Sets the widget modifier.
  ProgressStyler modifier(WidgetModifierConfig value) {
    return merge(ProgressStyler(modifier: value));
  }

  RemixProgress call({
    Key? key,
    required double value,
    String? semanticsLabel,
    String? semanticsValue,
  }) {
    return RemixProgress(
      key: key,
      style: this,
      value: value,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
    );
  }

  /// Merges with another [ProgressStyler].
  @override
  ProgressStyler merge(ProgressStyler? other) {
    return ProgressStyler.create(
      container: MixOps.merge($container, other?.$container),
      track: MixOps.merge($track, other?.$track),
      indicator: MixOps.merge($indicator, other?.$indicator),
      trackContainer: MixOps.merge($trackContainer, other?.$trackContainer),
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

  /// Resolves to [StyleSpec<ProgressSpec>] using [context].
  @override
  StyleSpec<ProgressSpec> resolve(BuildContext context) {
    final spec = ProgressSpec(
      container: MixOps.resolve(context, $container),
      track: MixOps.resolve(context, $track),
      indicator: MixOps.resolve(context, $indicator),
      trackContainer: MixOps.resolve(context, $trackContainer),
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
      ..add(DiagnosticsProperty('trackContainer', $trackContainer))
      ..add(DiagnosticsProperty('trackEffects', $trackEffects))
      ..add(DiagnosticsProperty('indicatorEffects', $indicatorEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $track,
    $indicator,
    $trackContainer,
    $trackEffects,
    $indicatorEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
