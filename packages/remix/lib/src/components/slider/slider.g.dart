// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixSliderSpec implements Spec<RemixSliderSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get track;
  RemixSurfaceLayerSpec? get trackSurface;
  RemixSurfaceLayerSpec? get trackOverlay;
  StyleSpec<BoxSpec> get range;
  RemixSurfaceLayerSpec? get rangeSurface;
  RemixSurfaceLayerSpec? get rangeOverlay;
  StyleSpec<BoxSpec> get thumb;
  RemixSurfaceLayerSpec? get thumbSurface;
  RemixSurfaceLayerSpec? get thumbOverlay;
  RemixSurfaceLayerSpec? get thumbFocusOverlay;
  double get trackThickness;
  BlendMode? get blendMode;

  @override
  Type get type => RemixSliderSpec;

  @override
  RemixSliderSpec copyWith({
    StyleSpec<BoxSpec>? track,
    RemixSurfaceLayerSpec? trackSurface,
    RemixSurfaceLayerSpec? trackOverlay,
    StyleSpec<BoxSpec>? range,
    RemixSurfaceLayerSpec? rangeSurface,
    RemixSurfaceLayerSpec? rangeOverlay,
    StyleSpec<BoxSpec>? thumb,
    RemixSurfaceLayerSpec? thumbSurface,
    RemixSurfaceLayerSpec? thumbOverlay,
    RemixSurfaceLayerSpec? thumbFocusOverlay,
    double? trackThickness,
    BlendMode? blendMode,
  }) {
    return RemixSliderSpec(
      track: track ?? this.track,
      trackSurface: trackSurface ?? this.trackSurface,
      trackOverlay: trackOverlay ?? this.trackOverlay,
      range: range ?? this.range,
      rangeSurface: rangeSurface ?? this.rangeSurface,
      rangeOverlay: rangeOverlay ?? this.rangeOverlay,
      thumb: thumb ?? this.thumb,
      thumbSurface: thumbSurface ?? this.thumbSurface,
      thumbOverlay: thumbOverlay ?? this.thumbOverlay,
      thumbFocusOverlay: thumbFocusOverlay ?? this.thumbFocusOverlay,
      trackThickness: trackThickness ?? this.trackThickness,
      blendMode: blendMode ?? this.blendMode,
    );
  }

  @override
  RemixSliderSpec lerp(RemixSliderSpec? other, double t) {
    return RemixSliderSpec(
      track: track.lerp(other?.track, t),
      trackSurface: MixOps.lerpSnap(trackSurface, other?.trackSurface, t),
      trackOverlay: MixOps.lerpSnap(trackOverlay, other?.trackOverlay, t),
      range: range.lerp(other?.range, t),
      rangeSurface: MixOps.lerpSnap(rangeSurface, other?.rangeSurface, t),
      rangeOverlay: MixOps.lerpSnap(rangeOverlay, other?.rangeOverlay, t),
      thumb: thumb.lerp(other?.thumb, t),
      thumbSurface: MixOps.lerpSnap(thumbSurface, other?.thumbSurface, t),
      thumbOverlay: MixOps.lerpSnap(thumbOverlay, other?.thumbOverlay, t),
      thumbFocusOverlay: MixOps.lerpSnap(
        thumbFocusOverlay,
        other?.thumbFocusOverlay,
        t,
      ),
      trackThickness: MixOps.lerp(trackThickness, other?.trackThickness, t),
      blendMode: MixOps.lerpSnap(blendMode, other?.blendMode, t),
    );
  }

  @override
  List<Object?> get props => [
    track,
    trackSurface,
    trackOverlay,
    range,
    rangeSurface,
    rangeOverlay,
    thumb,
    thumbSurface,
    thumbOverlay,
    thumbFocusOverlay,
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
      ..add(DiagnosticsProperty('trackSurface', trackSurface))
      ..add(DiagnosticsProperty('trackOverlay', trackOverlay))
      ..add(DiagnosticsProperty('range', range))
      ..add(DiagnosticsProperty('rangeSurface', rangeSurface))
      ..add(DiagnosticsProperty('rangeOverlay', rangeOverlay))
      ..add(DiagnosticsProperty('thumb', thumb))
      ..add(DiagnosticsProperty('thumbSurface', thumbSurface))
      ..add(DiagnosticsProperty('thumbOverlay', thumbOverlay))
      ..add(DiagnosticsProperty('thumbFocusOverlay', thumbFocusOverlay))
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
  final Prop<RemixSurfaceLayerSpec>? $trackSurface;
  final Prop<RemixSurfaceLayerSpec>? $trackOverlay;
  final Prop<StyleSpec<BoxSpec>>? $range;
  final Prop<RemixSurfaceLayerSpec>? $rangeSurface;
  final Prop<RemixSurfaceLayerSpec>? $rangeOverlay;
  final Prop<StyleSpec<BoxSpec>>? $thumb;
  final Prop<RemixSurfaceLayerSpec>? $thumbSurface;
  final Prop<RemixSurfaceLayerSpec>? $thumbOverlay;
  final Prop<RemixSurfaceLayerSpec>? $thumbFocusOverlay;
  final Prop<double>? $trackThickness;
  final Prop<BlendMode>? $blendMode;

  const RemixSliderStyler.create({
    Prop<StyleSpec<BoxSpec>>? track,
    Prop<RemixSurfaceLayerSpec>? trackSurface,
    Prop<RemixSurfaceLayerSpec>? trackOverlay,
    Prop<StyleSpec<BoxSpec>>? range,
    Prop<RemixSurfaceLayerSpec>? rangeSurface,
    Prop<RemixSurfaceLayerSpec>? rangeOverlay,
    Prop<StyleSpec<BoxSpec>>? thumb,
    Prop<RemixSurfaceLayerSpec>? thumbSurface,
    Prop<RemixSurfaceLayerSpec>? thumbOverlay,
    Prop<RemixSurfaceLayerSpec>? thumbFocusOverlay,
    Prop<double>? trackThickness,
    Prop<BlendMode>? blendMode,
    super.variants,
    super.modifier,
    super.animation,
  }) : $track = track,
       $trackSurface = trackSurface,
       $trackOverlay = trackOverlay,
       $range = range,
       $rangeSurface = rangeSurface,
       $rangeOverlay = rangeOverlay,
       $thumb = thumb,
       $thumbSurface = thumbSurface,
       $thumbOverlay = thumbOverlay,
       $thumbFocusOverlay = thumbFocusOverlay,
       $trackThickness = trackThickness,
       $blendMode = blendMode;

  RemixSliderStyler({
    BoxStyler? track,
    RemixSurfaceLayerMix? trackSurface,
    RemixSurfaceLayerMix? trackOverlay,
    BoxStyler? range,
    RemixSurfaceLayerMix? rangeSurface,
    RemixSurfaceLayerMix? rangeOverlay,
    BoxStyler? thumb,
    RemixSurfaceLayerMix? thumbSurface,
    RemixSurfaceLayerMix? thumbOverlay,
    RemixSurfaceLayerMix? thumbFocusOverlay,
    double? trackThickness,
    BlendMode? blendMode,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixSliderSpec>>? variants,
  }) : this.create(
         track: Prop.maybeMix(track),
         trackSurface: Prop.maybeMix(trackSurface),
         trackOverlay: Prop.maybeMix(trackOverlay),
         range: Prop.maybeMix(range),
         rangeSurface: Prop.maybeMix(rangeSurface),
         rangeOverlay: Prop.maybeMix(rangeOverlay),
         thumb: Prop.maybeMix(thumb),
         thumbSurface: Prop.maybeMix(thumbSurface),
         thumbOverlay: Prop.maybeMix(thumbOverlay),
         thumbFocusOverlay: Prop.maybeMix(thumbFocusOverlay),
         trackThickness: Prop.maybe(trackThickness),
         blendMode: Prop.maybe(blendMode),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixSliderStyler.track(BoxStyler value) =>
      RemixSliderStyler().track(value);
  factory RemixSliderStyler.trackSurface(RemixSurfaceLayerMix value) =>
      RemixSliderStyler().trackSurface(value);
  factory RemixSliderStyler.trackOverlay(RemixSurfaceLayerMix value) =>
      RemixSliderStyler().trackOverlay(value);
  factory RemixSliderStyler.range(BoxStyler value) =>
      RemixSliderStyler().range(value);
  factory RemixSliderStyler.rangeSurface(RemixSurfaceLayerMix value) =>
      RemixSliderStyler().rangeSurface(value);
  factory RemixSliderStyler.rangeOverlay(RemixSurfaceLayerMix value) =>
      RemixSliderStyler().rangeOverlay(value);
  factory RemixSliderStyler.thumb(BoxStyler value) =>
      RemixSliderStyler().thumb(value);
  factory RemixSliderStyler.thumbSurface(RemixSurfaceLayerMix value) =>
      RemixSliderStyler().thumbSurface(value);
  factory RemixSliderStyler.thumbOverlay(RemixSurfaceLayerMix value) =>
      RemixSliderStyler().thumbOverlay(value);
  factory RemixSliderStyler.thumbFocusOverlay(RemixSurfaceLayerMix value) =>
      RemixSliderStyler().thumbFocusOverlay(value);
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

  /// Sets the trackSurface.
  RemixSliderStyler trackSurface(RemixSurfaceLayerMix value) {
    return merge(RemixSliderStyler(trackSurface: value));
  }

  /// Sets the trackOverlay.
  RemixSliderStyler trackOverlay(RemixSurfaceLayerMix value) {
    return merge(RemixSliderStyler(trackOverlay: value));
  }

  /// Sets the range.
  RemixSliderStyler range(BoxStyler value) {
    return merge(RemixSliderStyler(range: value));
  }

  /// Sets the rangeSurface.
  RemixSliderStyler rangeSurface(RemixSurfaceLayerMix value) {
    return merge(RemixSliderStyler(rangeSurface: value));
  }

  /// Sets the rangeOverlay.
  RemixSliderStyler rangeOverlay(RemixSurfaceLayerMix value) {
    return merge(RemixSliderStyler(rangeOverlay: value));
  }

  /// Sets the thumb.
  RemixSliderStyler thumb(BoxStyler value) {
    return merge(RemixSliderStyler(thumb: value));
  }

  /// Sets the thumbSurface.
  RemixSliderStyler thumbSurface(RemixSurfaceLayerMix value) {
    return merge(RemixSliderStyler(thumbSurface: value));
  }

  /// Sets the thumbOverlay.
  RemixSliderStyler thumbOverlay(RemixSurfaceLayerMix value) {
    return merge(RemixSliderStyler(thumbOverlay: value));
  }

  /// Sets the thumbFocusOverlay.
  RemixSliderStyler thumbFocusOverlay(RemixSurfaceLayerMix value) {
    return merge(RemixSliderStyler(thumbFocusOverlay: value));
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
      trackSurface: MixOps.merge($trackSurface, other?.$trackSurface),
      trackOverlay: MixOps.merge($trackOverlay, other?.$trackOverlay),
      range: MixOps.merge($range, other?.$range),
      rangeSurface: MixOps.merge($rangeSurface, other?.$rangeSurface),
      rangeOverlay: MixOps.merge($rangeOverlay, other?.$rangeOverlay),
      thumb: MixOps.merge($thumb, other?.$thumb),
      thumbSurface: MixOps.merge($thumbSurface, other?.$thumbSurface),
      thumbOverlay: MixOps.merge($thumbOverlay, other?.$thumbOverlay),
      thumbFocusOverlay: MixOps.merge(
        $thumbFocusOverlay,
        other?.$thumbFocusOverlay,
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
      trackSurface: MixOps.resolve(context, $trackSurface),
      trackOverlay: MixOps.resolve(context, $trackOverlay),
      range: MixOps.resolve(context, $range),
      rangeSurface: MixOps.resolve(context, $rangeSurface),
      rangeOverlay: MixOps.resolve(context, $rangeOverlay),
      thumb: MixOps.resolve(context, $thumb),
      thumbSurface: MixOps.resolve(context, $thumbSurface),
      thumbOverlay: MixOps.resolve(context, $thumbOverlay),
      thumbFocusOverlay: MixOps.resolve(context, $thumbFocusOverlay),
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
      ..add(DiagnosticsProperty('trackSurface', $trackSurface))
      ..add(DiagnosticsProperty('trackOverlay', $trackOverlay))
      ..add(DiagnosticsProperty('range', $range))
      ..add(DiagnosticsProperty('rangeSurface', $rangeSurface))
      ..add(DiagnosticsProperty('rangeOverlay', $rangeOverlay))
      ..add(DiagnosticsProperty('thumb', $thumb))
      ..add(DiagnosticsProperty('thumbSurface', $thumbSurface))
      ..add(DiagnosticsProperty('thumbOverlay', $thumbOverlay))
      ..add(DiagnosticsProperty('thumbFocusOverlay', $thumbFocusOverlay))
      ..add(DiagnosticsProperty('trackThickness', $trackThickness))
      ..add(DiagnosticsProperty('blendMode', $blendMode));
  }

  @override
  List<Object?> get props => [
    $track,
    $trackSurface,
    $trackOverlay,
    $range,
    $rangeSurface,
    $rangeOverlay,
    $thumb,
    $thumbSurface,
    $thumbOverlay,
    $thumbFocusOverlay,
    $trackThickness,
    $blendMode,
    $animation,
    $modifier,
    $variants,
  ];
}
