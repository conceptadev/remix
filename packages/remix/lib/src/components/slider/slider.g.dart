// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixSliderSpec implements Spec<RemixSliderSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get track;
  RemixSurfaceEffectsSpec? get trackEffects;
  StyleSpec<BoxSpec> get range;
  RemixSurfaceEffectsSpec? get rangeEffects;
  StyleSpec<BoxSpec> get thumb;
  RemixSurfaceEffectsSpec? get thumbEffects;
  RemixSurfaceEffectsSpec? get thumbFocusEffects;
  double get trackThickness;
  BlendMode? get blendMode;

  @override
  Type get type => RemixSliderSpec;

  @override
  RemixSliderSpec copyWith({
    StyleSpec<BoxSpec>? track,
    RemixSurfaceEffectsSpec? trackEffects,
    StyleSpec<BoxSpec>? range,
    RemixSurfaceEffectsSpec? rangeEffects,
    StyleSpec<BoxSpec>? thumb,
    RemixSurfaceEffectsSpec? thumbEffects,
    RemixSurfaceEffectsSpec? thumbFocusEffects,
    double? trackThickness,
    BlendMode? blendMode,
  }) {
    return RemixSliderSpec(
      track: track ?? this.track,
      trackEffects: trackEffects ?? this.trackEffects,
      range: range ?? this.range,
      rangeEffects: rangeEffects ?? this.rangeEffects,
      thumb: thumb ?? this.thumb,
      thumbEffects: thumbEffects ?? this.thumbEffects,
      thumbFocusEffects: thumbFocusEffects ?? this.thumbFocusEffects,
      trackThickness: trackThickness ?? this.trackThickness,
      blendMode: blendMode ?? this.blendMode,
    );
  }

  @override
  RemixSliderSpec lerp(RemixSliderSpec? other, double t) {
    return RemixSliderSpec(
      track: track.lerp(other?.track, t),
      trackEffects: MixOps.lerpSnap(trackEffects, other?.trackEffects, t),
      range: range.lerp(other?.range, t),
      rangeEffects: MixOps.lerpSnap(rangeEffects, other?.rangeEffects, t),
      thumb: thumb.lerp(other?.thumb, t),
      thumbEffects: MixOps.lerpSnap(thumbEffects, other?.thumbEffects, t),
      thumbFocusEffects: MixOps.lerpSnap(
        thumbFocusEffects,
        other?.thumbFocusEffects,
        t,
      ),
      trackThickness: MixOps.lerp(trackThickness, other?.trackThickness, t),
      blendMode: MixOps.lerpSnap(blendMode, other?.blendMode, t),
    );
  }

  @override
  List<Object?> get props => [
    track,
    trackEffects,
    range,
    rangeEffects,
    thumb,
    thumbEffects,
    thumbFocusEffects,
    trackThickness,
    blendMode,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixSliderSpec &&
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
      ..add(DiagnosticsProperty('track', track))
      ..add(DiagnosticsProperty('trackEffects', trackEffects))
      ..add(DiagnosticsProperty('range', range))
      ..add(DiagnosticsProperty('rangeEffects', rangeEffects))
      ..add(DiagnosticsProperty('thumb', thumb))
      ..add(DiagnosticsProperty('thumbEffects', thumbEffects))
      ..add(DiagnosticsProperty('thumbFocusEffects', thumbFocusEffects))
      ..add(DoubleProperty('trackThickness', trackThickness))
      ..add(EnumProperty<BlendMode>('blendMode', blendMode));
  }
}

@Deprecated(
  'Rename to `_\$RemixSliderSpec` and migrate the class declaration to `class RemixSliderSpec with _\$RemixSliderSpec`. The `_\$RemixSliderSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixSliderSpecMethods = _$RemixSliderSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixSliderStyler extends MixStyler<RemixSliderStyler, RemixSliderSpec>
    with RemixBoxStylerMixin<RemixSliderStyler> {
  final Prop<StyleSpec<BoxSpec>>? $track;
  final Prop<RemixSurfaceEffectsSpec>? $trackEffects;
  final Prop<StyleSpec<BoxSpec>>? $range;
  final Prop<RemixSurfaceEffectsSpec>? $rangeEffects;
  final Prop<StyleSpec<BoxSpec>>? $thumb;
  final Prop<RemixSurfaceEffectsSpec>? $thumbEffects;
  final Prop<RemixSurfaceEffectsSpec>? $thumbFocusEffects;
  final Prop<double>? $trackThickness;
  final Prop<BlendMode>? $blendMode;

  const RemixSliderStyler.create({
    Prop<StyleSpec<BoxSpec>>? track,
    Prop<RemixSurfaceEffectsSpec>? trackEffects,
    Prop<StyleSpec<BoxSpec>>? range,
    Prop<RemixSurfaceEffectsSpec>? rangeEffects,
    Prop<StyleSpec<BoxSpec>>? thumb,
    Prop<RemixSurfaceEffectsSpec>? thumbEffects,
    Prop<RemixSurfaceEffectsSpec>? thumbFocusEffects,
    Prop<double>? trackThickness,
    Prop<BlendMode>? blendMode,
    super.variants,
    super.modifier,
    super.animation,
  }) : $track = track,
       $trackEffects = trackEffects,
       $range = range,
       $rangeEffects = rangeEffects,
       $thumb = thumb,
       $thumbEffects = thumbEffects,
       $thumbFocusEffects = thumbFocusEffects,
       $trackThickness = trackThickness,
       $blendMode = blendMode;

  RemixSliderStyler({
    BoxStyler? track,
    RemixSurfaceEffectsMix? trackEffects,
    BoxStyler? range,
    RemixSurfaceEffectsMix? rangeEffects,
    BoxStyler? thumb,
    RemixSurfaceEffectsMix? thumbEffects,
    RemixSurfaceEffectsMix? thumbFocusEffects,
    double? trackThickness,
    BlendMode? blendMode,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixSliderSpec>>? variants,
  }) : this.create(
         track: Prop.maybeMix(track),
         trackEffects: Prop.maybeMix(trackEffects),
         range: Prop.maybeMix(range),
         rangeEffects: Prop.maybeMix(rangeEffects),
         thumb: Prop.maybeMix(thumb),
         thumbEffects: Prop.maybeMix(thumbEffects),
         thumbFocusEffects: Prop.maybeMix(thumbFocusEffects),
         trackThickness: Prop.maybe(trackThickness),
         blendMode: Prop.maybe(blendMode),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixSliderStyler.track(BoxStyler value) =>
      RemixSliderStyler().track(value);
  factory RemixSliderStyler.trackEffects(RemixSurfaceEffectsMix value) =>
      RemixSliderStyler().trackEffects(value);
  factory RemixSliderStyler.range(BoxStyler value) =>
      RemixSliderStyler().range(value);
  factory RemixSliderStyler.rangeEffects(RemixSurfaceEffectsMix value) =>
      RemixSliderStyler().rangeEffects(value);
  factory RemixSliderStyler.thumb(BoxStyler value) =>
      RemixSliderStyler().thumb(value);
  factory RemixSliderStyler.thumbEffects(RemixSurfaceEffectsMix value) =>
      RemixSliderStyler().thumbEffects(value);
  factory RemixSliderStyler.thumbFocusEffects(RemixSurfaceEffectsMix value) =>
      RemixSliderStyler().thumbFocusEffects(value);
  factory RemixSliderStyler.trackThickness(double value) =>
      RemixSliderStyler().trackThickness(value);
  factory RemixSliderStyler.blendMode(BlendMode value) =>
      RemixSliderStyler().blendMode(value);
  factory RemixSliderStyler.alignment(AlignmentGeometry value) =>
      RemixSliderStyler().alignment(value);
  factory RemixSliderStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixSliderStyler().padding(value);
  factory RemixSliderStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixSliderStyler().margin(value);
  factory RemixSliderStyler.constraints(BoxConstraintsMix value) =>
      RemixSliderStyler().constraints(value);
  factory RemixSliderStyler.decoration(DecorationMix value) =>
      RemixSliderStyler().decoration(value);
  factory RemixSliderStyler.foregroundDecoration(DecorationMix value) =>
      RemixSliderStyler().foregroundDecoration(value);
  factory RemixSliderStyler.clipBehavior(Clip value) =>
      RemixSliderStyler().clipBehavior(value);
  factory RemixSliderStyler.color(Color value) =>
      RemixSliderStyler().color(value);
  factory RemixSliderStyler.gradient(GradientMix value) =>
      RemixSliderStyler().gradient(value);
  factory RemixSliderStyler.border(BoxBorderMix value) =>
      RemixSliderStyler().border(value);
  factory RemixSliderStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixSliderStyler().borderRadius(value);
  factory RemixSliderStyler.elevation(ElevationShadow value) =>
      RemixSliderStyler().elevation(value);
  factory RemixSliderStyler.shadow(BoxShadowMix value) =>
      RemixSliderStyler().shadow(value);
  factory RemixSliderStyler.shadows(List<BoxShadowMix> value) =>
      RemixSliderStyler().shadows(value);
  factory RemixSliderStyler.width(double value) =>
      RemixSliderStyler().width(value);
  factory RemixSliderStyler.height(double value) =>
      RemixSliderStyler().height(value);
  factory RemixSliderStyler.size(double width, double height) =>
      RemixSliderStyler().size(width, height);
  factory RemixSliderStyler.minWidth(double value) =>
      RemixSliderStyler().minWidth(value);
  factory RemixSliderStyler.maxWidth(double value) =>
      RemixSliderStyler().maxWidth(value);
  factory RemixSliderStyler.minHeight(double value) =>
      RemixSliderStyler().minHeight(value);
  factory RemixSliderStyler.maxHeight(double value) =>
      RemixSliderStyler().maxHeight(value);
  factory RemixSliderStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixSliderStyler().scale(scale, alignment: alignment);
  factory RemixSliderStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixSliderStyler().rotate(radians, alignment: alignment);
  factory RemixSliderStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixSliderStyler().translate(x, y, z);
  factory RemixSliderStyler.skew(double skewX, double skewY) =>
      RemixSliderStyler().skew(skewX, skewY);
  factory RemixSliderStyler.textStyle(TextStyler value) =>
      RemixSliderStyler().textStyle(value);
  factory RemixSliderStyler.image(DecorationImageMix value) =>
      RemixSliderStyler().image(value);
  factory RemixSliderStyler.shape(ShapeBorderMix value) =>
      RemixSliderStyler().shape(value);
  factory RemixSliderStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSliderStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSliderStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSliderStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSliderStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSliderStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSliderStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSliderStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSliderStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSliderStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSliderStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSliderStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSliderStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSliderStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSliderStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSliderStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSliderStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSliderStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSliderStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixSliderStyler().transform(value, alignment: alignment);

  RemixSliderStyler alignment(AlignmentGeometry value) {
    return thumb(BoxStyler().alignment(value));
  }

  RemixSliderStyler padding(EdgeInsetsGeometryMix value) {
    return thumb(BoxStyler().padding(value));
  }

  RemixSliderStyler margin(EdgeInsetsGeometryMix value) {
    return thumb(BoxStyler().margin(value));
  }

  RemixSliderStyler constraints(BoxConstraintsMix value) {
    return thumb(BoxStyler().constraints(value));
  }

  RemixSliderStyler decoration(DecorationMix value) {
    return thumb(BoxStyler().decoration(value));
  }

  RemixSliderStyler foregroundDecoration(DecorationMix value) {
    return thumb(BoxStyler().foregroundDecoration(value));
  }

  RemixSliderStyler clipBehavior(Clip value) {
    return thumb(BoxStyler().clipBehavior(value));
  }

  RemixSliderStyler color(Color value) {
    return thumb(BoxStyler().color(value));
  }

  RemixSliderStyler gradient(GradientMix value) {
    return thumb(BoxStyler().gradient(value));
  }

  RemixSliderStyler border(BoxBorderMix value) {
    return thumb(BoxStyler().border(value));
  }

  RemixSliderStyler borderRadius(BorderRadiusGeometryMix value) {
    return thumb(BoxStyler().borderRadius(value));
  }

  RemixSliderStyler elevation(ElevationShadow value) {
    return thumb(BoxStyler().elevation(value));
  }

  RemixSliderStyler shadow(BoxShadowMix value) {
    return thumb(BoxStyler().shadow(value));
  }

  RemixSliderStyler shadows(List<BoxShadowMix> value) {
    return thumb(BoxStyler().shadows(value));
  }

  RemixSliderStyler width(double value) {
    return thumb(BoxStyler().width(value));
  }

  RemixSliderStyler height(double value) {
    return thumb(BoxStyler().height(value));
  }

  RemixSliderStyler size(double width, double height) {
    return thumb(BoxStyler().size(width, height));
  }

  RemixSliderStyler minWidth(double value) {
    return thumb(BoxStyler().minWidth(value));
  }

  RemixSliderStyler maxWidth(double value) {
    return thumb(BoxStyler().maxWidth(value));
  }

  RemixSliderStyler minHeight(double value) {
    return thumb(BoxStyler().minHeight(value));
  }

  RemixSliderStyler maxHeight(double value) {
    return thumb(BoxStyler().maxHeight(value));
  }

  RemixSliderStyler scale(double scale, {Alignment alignment = .center}) {
    return thumb(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixSliderStyler rotate(double radians, {Alignment alignment = .center}) {
    return thumb(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixSliderStyler translate(double x, double y, [double z = 0.0]) {
    return thumb(BoxStyler().translate(x, y, z));
  }

  RemixSliderStyler skew(double skewX, double skewY) {
    return thumb(BoxStyler().skew(skewX, skewY));
  }

  RemixSliderStyler textStyle(TextStyler value) {
    return thumb(BoxStyler().textStyle(value));
  }

  RemixSliderStyler image(DecorationImageMix value) {
    return thumb(BoxStyler().image(value));
  }

  RemixSliderStyler shape(ShapeBorderMix value) {
    return thumb(BoxStyler().shape(value));
  }

  RemixSliderStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return thumb(
      BoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  RemixSliderStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return thumb(
      BoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  RemixSliderStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return thumb(
      BoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  RemixSliderStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return thumb(
      BoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  RemixSliderStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return thumb(
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

  RemixSliderStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return thumb(
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

  RemixSliderStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return thumb(
      BoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  RemixSliderStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return thumb(
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

  RemixSliderStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return thumb(
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

  RemixSliderStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return thumb(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the track.
  RemixSliderStyler track(BoxStyler value) {
    return merge(RemixSliderStyler(track: value));
  }

  /// Sets the trackEffects.
  RemixSliderStyler trackEffects(RemixSurfaceEffectsMix value) {
    return merge(RemixSliderStyler(trackEffects: value));
  }

  /// Sets the range.
  RemixSliderStyler range(BoxStyler value) {
    return merge(RemixSliderStyler(range: value));
  }

  /// Sets the rangeEffects.
  RemixSliderStyler rangeEffects(RemixSurfaceEffectsMix value) {
    return merge(RemixSliderStyler(rangeEffects: value));
  }

  /// Sets the thumb.
  RemixSliderStyler thumb(BoxStyler value) {
    return merge(RemixSliderStyler(thumb: value));
  }

  /// Sets the thumbEffects.
  RemixSliderStyler thumbEffects(RemixSurfaceEffectsMix value) {
    return merge(RemixSliderStyler(thumbEffects: value));
  }

  /// Sets the thumbFocusEffects.
  RemixSliderStyler thumbFocusEffects(RemixSurfaceEffectsMix value) {
    return merge(RemixSliderStyler(thumbFocusEffects: value));
  }

  /// Sets the trackThickness.
  RemixSliderStyler trackThickness(double value) {
    return merge(RemixSliderStyler(trackThickness: value));
  }

  /// Sets the blendMode.
  RemixSliderStyler blendMode(BlendMode value) {
    return merge(RemixSliderStyler(blendMode: value));
  }

  /// Sets the animation configuration.
  @override
  RemixSliderStyler animate(AnimationConfig value) {
    return merge(RemixSliderStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixSliderStyler variants(List<VariantStyle<RemixSliderSpec>> value) {
    return merge(RemixSliderStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixSliderStyler wrap(WidgetModifierConfig value) {
    return merge(RemixSliderStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixSliderStyler modifier(WidgetModifierConfig value) {
    return merge(RemixSliderStyler(modifier: value));
  }

  /// Merges with another [RemixSliderStyler].
  @override
  RemixSliderStyler merge(RemixSliderStyler? other) {
    return RemixSliderStyler.create(
      track: MixOps.merge($track, other?.$track),
      trackEffects: MixOps.merge($trackEffects, other?.$trackEffects),
      range: MixOps.merge($range, other?.$range),
      rangeEffects: MixOps.merge($rangeEffects, other?.$rangeEffects),
      thumb: MixOps.merge($thumb, other?.$thumb),
      thumbEffects: MixOps.merge($thumbEffects, other?.$thumbEffects),
      thumbFocusEffects: MixOps.merge(
        $thumbFocusEffects,
        other?.$thumbFocusEffects,
      ),
      trackThickness: MixOps.merge($trackThickness, other?.$trackThickness),
      blendMode: MixOps.merge($blendMode, other?.$blendMode),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixSliderSpec>] using [context].
  @override
  StyleSpec<RemixSliderSpec> resolve(BuildContext context) {
    final spec = RemixSliderSpec(
      track: MixOps.resolve(context, $track),
      trackEffects: MixOps.resolve(context, $trackEffects),
      range: MixOps.resolve(context, $range),
      rangeEffects: MixOps.resolve(context, $rangeEffects),
      thumb: MixOps.resolve(context, $thumb),
      thumbEffects: MixOps.resolve(context, $thumbEffects),
      thumbFocusEffects: MixOps.resolve(context, $thumbFocusEffects),
      trackThickness: MixOps.resolve(context, $trackThickness),
      blendMode: MixOps.resolve(context, $blendMode),
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
      ..add(DiagnosticsProperty('track', $track))
      ..add(DiagnosticsProperty('trackEffects', $trackEffects))
      ..add(DiagnosticsProperty('range', $range))
      ..add(DiagnosticsProperty('rangeEffects', $rangeEffects))
      ..add(DiagnosticsProperty('thumb', $thumb))
      ..add(DiagnosticsProperty('thumbEffects', $thumbEffects))
      ..add(DiagnosticsProperty('thumbFocusEffects', $thumbFocusEffects))
      ..add(DiagnosticsProperty('trackThickness', $trackThickness))
      ..add(DiagnosticsProperty('blendMode', $blendMode));
  }

  @override
  List<Object?> get props => [
    $track,
    $trackEffects,
    $range,
    $rangeEffects,
    $thumb,
    $thumbEffects,
    $thumbFocusEffects,
    $trackThickness,
    $blendMode,
    $animation,
    $modifier,
    $variants,
  ];
}
