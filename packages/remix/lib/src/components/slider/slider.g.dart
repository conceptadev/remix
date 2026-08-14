// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$SliderSpec implements Spec<SliderSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get track;
  Color get trackColor;
  double get trackWidth;
  RemixBoxEffectsSpec? get trackEffects;
  StyleSpec<BoxSpec> get range;
  Color get rangeColor;
  double get rangeWidth;
  RemixBoxEffectsSpec? get rangeEffects;
  StyleSpec<BoxSpec> get thumb;
  RemixBoxEffectsSpec? get thumbEffects;
  RemixBoxEffectsSpec? get thumbFocusEffects;
  BlendMode? get blendMode;

  @override
  Type get type => SliderSpec;

  @override
  SliderSpec copyWith({
    StyleSpec<BoxSpec>? track,
    Color? trackColor,
    double? trackWidth,
    RemixBoxEffectsSpec? trackEffects,
    StyleSpec<BoxSpec>? range,
    Color? rangeColor,
    double? rangeWidth,
    RemixBoxEffectsSpec? rangeEffects,
    StyleSpec<BoxSpec>? thumb,
    RemixBoxEffectsSpec? thumbEffects,
    RemixBoxEffectsSpec? thumbFocusEffects,
    BlendMode? blendMode,
  }) {
    return SliderSpec(
      track: track ?? this.track,
      trackColor: trackColor ?? this.trackColor,
      trackWidth: trackWidth ?? this.trackWidth,
      trackEffects: trackEffects ?? this.trackEffects,
      range: range ?? this.range,
      rangeColor: rangeColor ?? this.rangeColor,
      rangeWidth: rangeWidth ?? this.rangeWidth,
      rangeEffects: rangeEffects ?? this.rangeEffects,
      thumb: thumb ?? this.thumb,
      thumbEffects: thumbEffects ?? this.thumbEffects,
      thumbFocusEffects: thumbFocusEffects ?? this.thumbFocusEffects,
      blendMode: blendMode ?? this.blendMode,
    );
  }

  @override
  SliderSpec lerp(SliderSpec? other, double t) {
    return SliderSpec(
      track: track.lerp(other?.track, t),
      trackColor: MixOps.lerp(trackColor, other?.trackColor, t),
      trackWidth: MixOps.lerp(trackWidth, other?.trackWidth, t),
      trackEffects: MixOps.lerpSnap(trackEffects, other?.trackEffects, t),
      range: range.lerp(other?.range, t),
      rangeColor: MixOps.lerp(rangeColor, other?.rangeColor, t),
      rangeWidth: MixOps.lerp(rangeWidth, other?.rangeWidth, t),
      rangeEffects: MixOps.lerpSnap(rangeEffects, other?.rangeEffects, t),
      thumb: thumb.lerp(other?.thumb, t),
      thumbEffects: MixOps.lerpSnap(thumbEffects, other?.thumbEffects, t),
      thumbFocusEffects: MixOps.lerpSnap(
        thumbFocusEffects,
        other?.thumbFocusEffects,
        t,
      ),
      blendMode: MixOps.lerpSnap(blendMode, other?.blendMode, t),
    );
  }

  @override
  List<Object?> get props => [
    track,
    trackColor,
    trackWidth,
    trackEffects,
    range,
    rangeColor,
    rangeWidth,
    rangeEffects,
    thumb,
    thumbEffects,
    thumbFocusEffects,
    blendMode,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SliderSpec &&
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
      ..add(ColorProperty('trackColor', trackColor))
      ..add(DoubleProperty('trackWidth', trackWidth))
      ..add(DiagnosticsProperty('trackEffects', trackEffects))
      ..add(DiagnosticsProperty('range', range))
      ..add(ColorProperty('rangeColor', rangeColor))
      ..add(DoubleProperty('rangeWidth', rangeWidth))
      ..add(DiagnosticsProperty('rangeEffects', rangeEffects))
      ..add(DiagnosticsProperty('thumb', thumb))
      ..add(DiagnosticsProperty('thumbEffects', thumbEffects))
      ..add(DiagnosticsProperty('thumbFocusEffects', thumbFocusEffects))
      ..add(EnumProperty<BlendMode>('blendMode', blendMode));
  }
}

@Deprecated(
  'Rename to `_\$SliderSpec` and migrate the class declaration to `class SliderSpec with _\$SliderSpec`. The `_\$SliderSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SliderSpecMethods = _$SliderSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class SliderStyler extends MixStyler<SliderStyler, SliderSpec>
    with RemixBoxStylerMixin<SliderStyler> {
  final Prop<StyleSpec<BoxSpec>>? $track;
  final Prop<Color>? $trackColor;
  final Prop<double>? $trackWidth;
  final Prop<RemixBoxEffectsSpec>? $trackEffects;
  final Prop<StyleSpec<BoxSpec>>? $range;
  final Prop<Color>? $rangeColor;
  final Prop<double>? $rangeWidth;
  final Prop<RemixBoxEffectsSpec>? $rangeEffects;
  final Prop<StyleSpec<BoxSpec>>? $thumb;
  final Prop<RemixBoxEffectsSpec>? $thumbEffects;
  final Prop<RemixBoxEffectsSpec>? $thumbFocusEffects;
  final Prop<BlendMode>? $blendMode;

  const SliderStyler.create({
    Prop<StyleSpec<BoxSpec>>? track,
    Prop<Color>? trackColor,
    Prop<double>? trackWidth,
    Prop<RemixBoxEffectsSpec>? trackEffects,
    Prop<StyleSpec<BoxSpec>>? range,
    Prop<Color>? rangeColor,
    Prop<double>? rangeWidth,
    Prop<RemixBoxEffectsSpec>? rangeEffects,
    Prop<StyleSpec<BoxSpec>>? thumb,
    Prop<RemixBoxEffectsSpec>? thumbEffects,
    Prop<RemixBoxEffectsSpec>? thumbFocusEffects,
    Prop<BlendMode>? blendMode,
    super.variants,
    super.modifier,
    super.animation,
  }) : $track = track,
       $trackColor = trackColor,
       $trackWidth = trackWidth,
       $trackEffects = trackEffects,
       $range = range,
       $rangeColor = rangeColor,
       $rangeWidth = rangeWidth,
       $rangeEffects = rangeEffects,
       $thumb = thumb,
       $thumbEffects = thumbEffects,
       $thumbFocusEffects = thumbFocusEffects,
       $blendMode = blendMode;

  SliderStyler({
    BoxStyler? track,
    Color? trackColor,
    double? trackWidth,
    RemixBoxEffectsMix? trackEffects,
    BoxStyler? range,
    Color? rangeColor,
    double? rangeWidth,
    RemixBoxEffectsMix? rangeEffects,
    BoxStyler? thumb,
    RemixBoxEffectsMix? thumbEffects,
    RemixBoxEffectsMix? thumbFocusEffects,
    BlendMode? blendMode,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SliderSpec>>? variants,
  }) : this.create(
         track: Prop.maybeMix(track),
         trackColor: Prop.maybe(trackColor),
         trackWidth: Prop.maybe(trackWidth),
         trackEffects: Prop.maybeMix(trackEffects),
         range: Prop.maybeMix(range),
         rangeColor: Prop.maybe(rangeColor),
         rangeWidth: Prop.maybe(rangeWidth),
         rangeEffects: Prop.maybeMix(rangeEffects),
         thumb: Prop.maybeMix(thumb),
         thumbEffects: Prop.maybeMix(thumbEffects),
         thumbFocusEffects: Prop.maybeMix(thumbFocusEffects),
         blendMode: Prop.maybe(blendMode),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SliderStyler.track(BoxStyler value) => SliderStyler().track(value);
  factory SliderStyler.trackColor(Color value) =>
      SliderStyler().trackColor(value);
  factory SliderStyler.trackWidth(double value) =>
      SliderStyler().trackWidth(value);
  factory SliderStyler.trackEffects(RemixBoxEffectsMix value) =>
      SliderStyler().trackEffects(value);
  factory SliderStyler.range(BoxStyler value) => SliderStyler().range(value);
  factory SliderStyler.rangeColor(Color value) =>
      SliderStyler().rangeColor(value);
  factory SliderStyler.rangeWidth(double value) =>
      SliderStyler().rangeWidth(value);
  factory SliderStyler.rangeEffects(RemixBoxEffectsMix value) =>
      SliderStyler().rangeEffects(value);
  factory SliderStyler.thumb(BoxStyler value) => SliderStyler().thumb(value);
  factory SliderStyler.thumbEffects(RemixBoxEffectsMix value) =>
      SliderStyler().thumbEffects(value);
  factory SliderStyler.thumbFocusEffects(RemixBoxEffectsMix value) =>
      SliderStyler().thumbFocusEffects(value);
  factory SliderStyler.blendMode(BlendMode value) =>
      SliderStyler().blendMode(value);
  factory SliderStyler.alignment(AlignmentGeometry value) =>
      SliderStyler().alignment(value);
  factory SliderStyler.padding(EdgeInsetsGeometryMix value) =>
      SliderStyler().padding(value);
  factory SliderStyler.margin(EdgeInsetsGeometryMix value) =>
      SliderStyler().margin(value);
  factory SliderStyler.constraints(BoxConstraintsMix value) =>
      SliderStyler().constraints(value);
  factory SliderStyler.decoration(DecorationMix value) =>
      SliderStyler().decoration(value);
  factory SliderStyler.foregroundDecoration(DecorationMix value) =>
      SliderStyler().foregroundDecoration(value);
  factory SliderStyler.clipBehavior(Clip value) =>
      SliderStyler().clipBehavior(value);
  factory SliderStyler.color(Color value) => SliderStyler().color(value);
  factory SliderStyler.gradient(GradientMix value) =>
      SliderStyler().gradient(value);
  factory SliderStyler.border(BoxBorderMix value) =>
      SliderStyler().border(value);
  factory SliderStyler.borderRadius(BorderRadiusGeometryMix value) =>
      SliderStyler().borderRadius(value);
  factory SliderStyler.elevation(ElevationShadow value) =>
      SliderStyler().elevation(value);
  factory SliderStyler.shadow(BoxShadowMix value) =>
      SliderStyler().shadow(value);
  factory SliderStyler.shadows(List<BoxShadowMix> value) =>
      SliderStyler().shadows(value);
  factory SliderStyler.width(double value) => SliderStyler().width(value);
  factory SliderStyler.height(double value) => SliderStyler().height(value);
  factory SliderStyler.size(double width, double height) =>
      SliderStyler().size(width, height);
  factory SliderStyler.minWidth(double value) => SliderStyler().minWidth(value);
  factory SliderStyler.maxWidth(double value) => SliderStyler().maxWidth(value);
  factory SliderStyler.minHeight(double value) =>
      SliderStyler().minHeight(value);
  factory SliderStyler.maxHeight(double value) =>
      SliderStyler().maxHeight(value);
  factory SliderStyler.scale(double scale, {Alignment alignment = .center}) =>
      SliderStyler().scale(scale, alignment: alignment);
  factory SliderStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SliderStyler().rotate(radians, alignment: alignment);
  factory SliderStyler.translate(double x, double y, [double z = 0.0]) =>
      SliderStyler().translate(x, y, z);
  factory SliderStyler.skew(double skewX, double skewY) =>
      SliderStyler().skew(skewX, skewY);
  factory SliderStyler.textStyle(TextStyler value) =>
      SliderStyler().textStyle(value);
  factory SliderStyler.image(DecorationImageMix value) =>
      SliderStyler().image(value);
  factory SliderStyler.shape(ShapeBorderMix value) =>
      SliderStyler().shape(value);
  factory SliderStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SliderStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SliderStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SliderStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SliderStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SliderStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SliderStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SliderStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SliderStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SliderStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SliderStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SliderStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SliderStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SliderStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SliderStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SliderStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SliderStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SliderStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SliderStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SliderStyler().transform(value, alignment: alignment);

  SliderStyler alignment(AlignmentGeometry value) {
    return thumb(BoxStyler().alignment(value));
  }

  SliderStyler padding(EdgeInsetsGeometryMix value) {
    return thumb(BoxStyler().padding(value));
  }

  SliderStyler margin(EdgeInsetsGeometryMix value) {
    return thumb(BoxStyler().margin(value));
  }

  SliderStyler constraints(BoxConstraintsMix value) {
    return thumb(BoxStyler().constraints(value));
  }

  SliderStyler decoration(DecorationMix value) {
    return thumb(BoxStyler().decoration(value));
  }

  SliderStyler foregroundDecoration(DecorationMix value) {
    return thumb(BoxStyler().foregroundDecoration(value));
  }

  SliderStyler clipBehavior(Clip value) {
    return thumb(BoxStyler().clipBehavior(value));
  }

  SliderStyler color(Color value) {
    return thumb(BoxStyler().color(value));
  }

  SliderStyler gradient(GradientMix value) {
    return thumb(BoxStyler().gradient(value));
  }

  SliderStyler border(BoxBorderMix value) {
    return thumb(BoxStyler().border(value));
  }

  SliderStyler borderRadius(BorderRadiusGeometryMix value) {
    return thumb(BoxStyler().borderRadius(value));
  }

  SliderStyler elevation(ElevationShadow value) {
    return thumb(BoxStyler().elevation(value));
  }

  SliderStyler shadow(BoxShadowMix value) {
    return thumb(BoxStyler().shadow(value));
  }

  SliderStyler shadows(List<BoxShadowMix> value) {
    return thumb(BoxStyler().shadows(value));
  }

  SliderStyler width(double value) {
    return thumb(BoxStyler().width(value));
  }

  SliderStyler height(double value) {
    return thumb(BoxStyler().height(value));
  }

  SliderStyler size(double width, double height) {
    return thumb(BoxStyler().size(width, height));
  }

  SliderStyler minWidth(double value) {
    return thumb(BoxStyler().minWidth(value));
  }

  SliderStyler maxWidth(double value) {
    return thumb(BoxStyler().maxWidth(value));
  }

  SliderStyler minHeight(double value) {
    return thumb(BoxStyler().minHeight(value));
  }

  SliderStyler maxHeight(double value) {
    return thumb(BoxStyler().maxHeight(value));
  }

  SliderStyler scale(double scale, {Alignment alignment = .center}) {
    return thumb(BoxStyler().scale(scale, alignment: alignment));
  }

  SliderStyler rotate(double radians, {Alignment alignment = .center}) {
    return thumb(BoxStyler().rotate(radians, alignment: alignment));
  }

  SliderStyler translate(double x, double y, [double z = 0.0]) {
    return thumb(BoxStyler().translate(x, y, z));
  }

  SliderStyler skew(double skewX, double skewY) {
    return thumb(BoxStyler().skew(skewX, skewY));
  }

  SliderStyler textStyle(TextStyler value) {
    return thumb(BoxStyler().textStyle(value));
  }

  SliderStyler image(DecorationImageMix value) {
    return thumb(BoxStyler().image(value));
  }

  SliderStyler shape(ShapeBorderMix value) {
    return thumb(BoxStyler().shape(value));
  }

  SliderStyler backgroundImage(
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

  SliderStyler backgroundImageUrl(
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

  SliderStyler backgroundImageAsset(
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

  SliderStyler linearGradient({
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

  SliderStyler radialGradient({
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

  SliderStyler sweepGradient({
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

  SliderStyler foregroundLinearGradient({
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

  SliderStyler foregroundRadialGradient({
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

  SliderStyler foregroundSweepGradient({
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

  SliderStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return thumb(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the track.
  SliderStyler track(BoxStyler value) {
    return merge(SliderStyler(track: value));
  }

  /// Sets the trackColor.
  SliderStyler trackColor(Color value) {
    return merge(SliderStyler(trackColor: value));
  }

  /// Sets the trackWidth.
  SliderStyler trackWidth(double value) {
    return merge(SliderStyler(trackWidth: value));
  }

  /// Sets the trackEffects.
  SliderStyler trackEffects(RemixBoxEffectsMix value) {
    return merge(SliderStyler(trackEffects: value));
  }

  /// Sets the range.
  SliderStyler range(BoxStyler value) {
    return merge(SliderStyler(range: value));
  }

  /// Sets the rangeColor.
  SliderStyler rangeColor(Color value) {
    return merge(SliderStyler(rangeColor: value));
  }

  /// Sets the rangeWidth.
  SliderStyler rangeWidth(double value) {
    return merge(SliderStyler(rangeWidth: value));
  }

  /// Sets the rangeEffects.
  SliderStyler rangeEffects(RemixBoxEffectsMix value) {
    return merge(SliderStyler(rangeEffects: value));
  }

  /// Sets the thumb.
  SliderStyler thumb(BoxStyler value) {
    return merge(SliderStyler(thumb: value));
  }

  /// Sets the thumbEffects.
  SliderStyler thumbEffects(RemixBoxEffectsMix value) {
    return merge(SliderStyler(thumbEffects: value));
  }

  /// Sets the thumbFocusEffects.
  SliderStyler thumbFocusEffects(RemixBoxEffectsMix value) {
    return merge(SliderStyler(thumbFocusEffects: value));
  }

  /// Sets the blendMode.
  SliderStyler blendMode(BlendMode value) {
    return merge(SliderStyler(blendMode: value));
  }

  /// Sets the animation configuration.
  @override
  SliderStyler animate(AnimationConfig value) {
    return merge(SliderStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SliderStyler variants(List<VariantStyle<SliderSpec>> value) {
    return merge(SliderStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SliderStyler wrap(WidgetModifierConfig value) {
    return merge(SliderStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SliderStyler modifier(WidgetModifierConfig value) {
    return merge(SliderStyler(modifier: value));
  }

  RemixSlider call({
    Key? key,
    required double value,
    ValueChanged<double>? onChanged,
    ValueChanged<double>? onChangeStart,
    ValueChanged<double>? onChangeEnd,
    double min = 0.0,
    double max = 1.0,
    bool enabled = true,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    int? snapDivisions,
    String? semanticLabel,
    NakedSliderSemanticFormatterCallback? semanticFormatterCallback,
    bool excludeSemantics = false,
  }) {
    return RemixSlider(
      key: key,
      style: this,
      value: value,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      min: min,
      max: max,
      enabled: enabled,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      snapDivisions: snapDivisions,
      semanticLabel: semanticLabel,
      semanticFormatterCallback: semanticFormatterCallback,
      excludeSemantics: excludeSemantics,
    );
  }

  /// Merges with another [SliderStyler].
  @override
  SliderStyler merge(SliderStyler? other) {
    return SliderStyler.create(
      track: MixOps.merge($track, other?.$track),
      trackColor: MixOps.merge($trackColor, other?.$trackColor),
      trackWidth: MixOps.merge($trackWidth, other?.$trackWidth),
      trackEffects: MixOps.merge($trackEffects, other?.$trackEffects),
      range: MixOps.merge($range, other?.$range),
      rangeColor: MixOps.merge($rangeColor, other?.$rangeColor),
      rangeWidth: MixOps.merge($rangeWidth, other?.$rangeWidth),
      rangeEffects: MixOps.merge($rangeEffects, other?.$rangeEffects),
      thumb: MixOps.merge($thumb, other?.$thumb),
      thumbEffects: MixOps.merge($thumbEffects, other?.$thumbEffects),
      thumbFocusEffects: MixOps.merge(
        $thumbFocusEffects,
        other?.$thumbFocusEffects,
      ),
      blendMode: MixOps.merge($blendMode, other?.$blendMode),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SliderSpec>] using [context].
  @override
  StyleSpec<SliderSpec> resolve(BuildContext context) {
    final spec = SliderSpec(
      track: MixOps.resolve(context, $track),
      trackColor: MixOps.resolve(context, $trackColor),
      trackWidth: MixOps.resolve(context, $trackWidth),
      trackEffects: MixOps.resolve(context, $trackEffects),
      range: MixOps.resolve(context, $range),
      rangeColor: MixOps.resolve(context, $rangeColor),
      rangeWidth: MixOps.resolve(context, $rangeWidth),
      rangeEffects: MixOps.resolve(context, $rangeEffects),
      thumb: MixOps.resolve(context, $thumb),
      thumbEffects: MixOps.resolve(context, $thumbEffects),
      thumbFocusEffects: MixOps.resolve(context, $thumbFocusEffects),
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
      ..add(DiagnosticsProperty('trackColor', $trackColor))
      ..add(DiagnosticsProperty('trackWidth', $trackWidth))
      ..add(DiagnosticsProperty('trackEffects', $trackEffects))
      ..add(DiagnosticsProperty('range', $range))
      ..add(DiagnosticsProperty('rangeColor', $rangeColor))
      ..add(DiagnosticsProperty('rangeWidth', $rangeWidth))
      ..add(DiagnosticsProperty('rangeEffects', $rangeEffects))
      ..add(DiagnosticsProperty('thumb', $thumb))
      ..add(DiagnosticsProperty('thumbEffects', $thumbEffects))
      ..add(DiagnosticsProperty('thumbFocusEffects', $thumbFocusEffects))
      ..add(DiagnosticsProperty('blendMode', $blendMode));
  }

  @override
  List<Object?> get props => [
    $track,
    $trackColor,
    $trackWidth,
    $trackEffects,
    $range,
    $rangeColor,
    $rangeWidth,
    $rangeEffects,
    $thumb,
    $thumbEffects,
    $thumbFocusEffects,
    $blendMode,
    $animation,
    $modifier,
    $variants,
  ];
}
