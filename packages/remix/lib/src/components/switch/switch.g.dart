// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixSwitchSpec implements Spec<RemixSwitchSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get thumb;
  RemixSurfaceLayerSpec? get surface;
  RemixSurfaceLayerSpec? get overlay;
  RemixSurfaceLayerSpec? get thumbSurface;
  RemixSurfaceLayerSpec? get thumbOverlay;

  @override
  Type get type => RemixSwitchSpec;

  @override
  RemixSwitchSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? thumb,
    RemixSurfaceLayerSpec? surface,
    RemixSurfaceLayerSpec? overlay,
    RemixSurfaceLayerSpec? thumbSurface,
    RemixSurfaceLayerSpec? thumbOverlay,
  }) {
    return RemixSwitchSpec(
      container: container ?? this.container,
      thumb: thumb ?? this.thumb,
      surface: surface ?? this.surface,
      overlay: overlay ?? this.overlay,
      thumbSurface: thumbSurface ?? this.thumbSurface,
      thumbOverlay: thumbOverlay ?? this.thumbOverlay,
    );
  }

  @override
  RemixSwitchSpec lerp(RemixSwitchSpec? other, double t) {
    return RemixSwitchSpec(
      container: container.lerp(other?.container, t),
      thumb: thumb.lerp(other?.thumb, t),
      surface: MixOps.lerpSnap(surface, other?.surface, t),
      overlay: MixOps.lerpSnap(overlay, other?.overlay, t),
      thumbSurface: MixOps.lerpSnap(thumbSurface, other?.thumbSurface, t),
      thumbOverlay: MixOps.lerpSnap(thumbOverlay, other?.thumbOverlay, t),
    );
  }

  @override
  List<Object?> get props => [
    container,
    thumb,
    surface,
    overlay,
    thumbSurface,
    thumbOverlay,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixSwitchSpec &&
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
      ..add(DiagnosticsProperty('thumb', thumb))
      ..add(DiagnosticsProperty('surface', surface))
      ..add(DiagnosticsProperty('overlay', overlay))
      ..add(DiagnosticsProperty('thumbSurface', thumbSurface))
      ..add(DiagnosticsProperty('thumbOverlay', thumbOverlay));
  }
}

@Deprecated(
  'Rename to `_\$RemixSwitchSpec` and migrate the class declaration to `class RemixSwitchSpec with _\$RemixSwitchSpec`. The `_\$RemixSwitchSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixSwitchSpecMethods = _$RemixSwitchSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixSwitchStyler extends MixStyler<RemixSwitchStyler, RemixSwitchSpec>
    with RemixBoxStylerMixin<RemixSwitchStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $thumb;
  final Prop<RemixSurfaceLayerSpec>? $surface;
  final Prop<RemixSurfaceLayerSpec>? $overlay;
  final Prop<RemixSurfaceLayerSpec>? $thumbSurface;
  final Prop<RemixSurfaceLayerSpec>? $thumbOverlay;

  const RemixSwitchStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? thumb,
    Prop<RemixSurfaceLayerSpec>? surface,
    Prop<RemixSurfaceLayerSpec>? overlay,
    Prop<RemixSurfaceLayerSpec>? thumbSurface,
    Prop<RemixSurfaceLayerSpec>? thumbOverlay,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $thumb = thumb,
       $surface = surface,
       $overlay = overlay,
       $thumbSurface = thumbSurface,
       $thumbOverlay = thumbOverlay;

  RemixSwitchStyler({
    BoxStyler? container,
    BoxStyler? thumb,
    RemixSurfaceLayerMix? surface,
    RemixSurfaceLayerMix? overlay,
    RemixSurfaceLayerMix? thumbSurface,
    RemixSurfaceLayerMix? thumbOverlay,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixSwitchSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         thumb: Prop.maybeMix(thumb),
         surface: Prop.maybeMix(surface),
         overlay: Prop.maybeMix(overlay),
         thumbSurface: Prop.maybeMix(thumbSurface),
         thumbOverlay: Prop.maybeMix(thumbOverlay),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixSwitchStyler.container(BoxStyler value) =>
      RemixSwitchStyler().container(value);
  factory RemixSwitchStyler.thumb(BoxStyler value) =>
      RemixSwitchStyler().thumb(value);
  factory RemixSwitchStyler.surface(RemixSurfaceLayerMix value) =>
      RemixSwitchStyler().surface(value);
  factory RemixSwitchStyler.overlay(RemixSurfaceLayerMix value) =>
      RemixSwitchStyler().overlay(value);
  factory RemixSwitchStyler.thumbSurface(RemixSurfaceLayerMix value) =>
      RemixSwitchStyler().thumbSurface(value);
  factory RemixSwitchStyler.thumbOverlay(RemixSurfaceLayerMix value) =>
      RemixSwitchStyler().thumbOverlay(value);
  factory RemixSwitchStyler.alignment(AlignmentGeometry value) =>
      RemixSwitchStyler().alignment(value);
  factory RemixSwitchStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixSwitchStyler().padding(value);
  factory RemixSwitchStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixSwitchStyler().margin(value);
  factory RemixSwitchStyler.constraints(BoxConstraintsMix value) =>
      RemixSwitchStyler().constraints(value);
  factory RemixSwitchStyler.decoration(DecorationMix value) =>
      RemixSwitchStyler().decoration(value);
  factory RemixSwitchStyler.foregroundDecoration(DecorationMix value) =>
      RemixSwitchStyler().foregroundDecoration(value);
  factory RemixSwitchStyler.clipBehavior(Clip value) =>
      RemixSwitchStyler().clipBehavior(value);
  factory RemixSwitchStyler.color(Color value) =>
      RemixSwitchStyler().color(value);
  factory RemixSwitchStyler.gradient(GradientMix value) =>
      RemixSwitchStyler().gradient(value);
  factory RemixSwitchStyler.border(BoxBorderMix value) =>
      RemixSwitchStyler().border(value);
  factory RemixSwitchStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixSwitchStyler().borderRadius(value);
  factory RemixSwitchStyler.elevation(ElevationShadow value) =>
      RemixSwitchStyler().elevation(value);
  factory RemixSwitchStyler.shadow(BoxShadowMix value) =>
      RemixSwitchStyler().shadow(value);
  factory RemixSwitchStyler.shadows(List<BoxShadowMix> value) =>
      RemixSwitchStyler().shadows(value);
  factory RemixSwitchStyler.width(double value) =>
      RemixSwitchStyler().width(value);
  factory RemixSwitchStyler.height(double value) =>
      RemixSwitchStyler().height(value);
  factory RemixSwitchStyler.size(double width, double height) =>
      RemixSwitchStyler().size(width, height);
  factory RemixSwitchStyler.minWidth(double value) =>
      RemixSwitchStyler().minWidth(value);
  factory RemixSwitchStyler.maxWidth(double value) =>
      RemixSwitchStyler().maxWidth(value);
  factory RemixSwitchStyler.minHeight(double value) =>
      RemixSwitchStyler().minHeight(value);
  factory RemixSwitchStyler.maxHeight(double value) =>
      RemixSwitchStyler().maxHeight(value);
  factory RemixSwitchStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixSwitchStyler().scale(scale, alignment: alignment);
  factory RemixSwitchStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixSwitchStyler().rotate(radians, alignment: alignment);
  factory RemixSwitchStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixSwitchStyler().translate(x, y, z);
  factory RemixSwitchStyler.skew(double skewX, double skewY) =>
      RemixSwitchStyler().skew(skewX, skewY);
  factory RemixSwitchStyler.textStyle(TextStyler value) =>
      RemixSwitchStyler().textStyle(value);
  factory RemixSwitchStyler.image(DecorationImageMix value) =>
      RemixSwitchStyler().image(value);
  factory RemixSwitchStyler.shape(ShapeBorderMix value) =>
      RemixSwitchStyler().shape(value);
  factory RemixSwitchStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSwitchStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSwitchStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSwitchStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSwitchStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSwitchStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSwitchStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSwitchStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSwitchStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSwitchStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSwitchStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSwitchStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSwitchStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSwitchStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSwitchStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSwitchStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSwitchStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSwitchStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSwitchStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixSwitchStyler().transform(value, alignment: alignment);

  RemixSwitchStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixSwitchStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixSwitchStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixSwitchStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixSwitchStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixSwitchStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixSwitchStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixSwitchStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixSwitchStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixSwitchStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixSwitchStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixSwitchStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixSwitchStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixSwitchStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixSwitchStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixSwitchStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixSwitchStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixSwitchStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixSwitchStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixSwitchStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixSwitchStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixSwitchStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixSwitchStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixSwitchStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixSwitchStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixSwitchStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixSwitchStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixSwitchStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixSwitchStyler backgroundImage(
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

  RemixSwitchStyler backgroundImageUrl(
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

  RemixSwitchStyler backgroundImageAsset(
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

  RemixSwitchStyler linearGradient({
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

  RemixSwitchStyler radialGradient({
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

  RemixSwitchStyler sweepGradient({
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

  RemixSwitchStyler foregroundLinearGradient({
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

  RemixSwitchStyler foregroundRadialGradient({
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

  RemixSwitchStyler foregroundSweepGradient({
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

  RemixSwitchStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixSwitchStyler container(BoxStyler value) {
    return merge(RemixSwitchStyler(container: value));
  }

  /// Sets the thumb.
  RemixSwitchStyler thumb(BoxStyler value) {
    return merge(RemixSwitchStyler(thumb: value));
  }

  /// Sets the surface.
  RemixSwitchStyler surface(RemixSurfaceLayerMix value) {
    return merge(RemixSwitchStyler(surface: value));
  }

  /// Sets the overlay.
  RemixSwitchStyler overlay(RemixSurfaceLayerMix value) {
    return merge(RemixSwitchStyler(overlay: value));
  }

  /// Sets the thumbSurface.
  RemixSwitchStyler thumbSurface(RemixSurfaceLayerMix value) {
    return merge(RemixSwitchStyler(thumbSurface: value));
  }

  /// Sets the thumbOverlay.
  RemixSwitchStyler thumbOverlay(RemixSurfaceLayerMix value) {
    return merge(RemixSwitchStyler(thumbOverlay: value));
  }

  /// Sets the animation configuration.
  @override
  RemixSwitchStyler animate(AnimationConfig value) {
    return merge(RemixSwitchStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixSwitchStyler variants(List<VariantStyle<RemixSwitchSpec>> value) {
    return merge(RemixSwitchStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixSwitchStyler wrap(WidgetModifierConfig value) {
    return merge(RemixSwitchStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixSwitchStyler modifier(WidgetModifierConfig value) {
    return merge(RemixSwitchStyler(modifier: value));
  }

  /// Merges with another [RemixSwitchStyler].
  @override
  RemixSwitchStyler merge(RemixSwitchStyler? other) {
    return RemixSwitchStyler.create(
      container: MixOps.merge($container, other?.$container),
      thumb: MixOps.merge($thumb, other?.$thumb),
      surface: MixOps.merge($surface, other?.$surface),
      overlay: MixOps.merge($overlay, other?.$overlay),
      thumbSurface: MixOps.merge($thumbSurface, other?.$thumbSurface),
      thumbOverlay: MixOps.merge($thumbOverlay, other?.$thumbOverlay),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixSwitchSpec>] using [context].
  @override
  StyleSpec<RemixSwitchSpec> resolve(BuildContext context) {
    final spec = RemixSwitchSpec(
      container: MixOps.resolve(context, $container),
      thumb: MixOps.resolve(context, $thumb),
      surface: MixOps.resolve(context, $surface),
      overlay: MixOps.resolve(context, $overlay),
      thumbSurface: MixOps.resolve(context, $thumbSurface),
      thumbOverlay: MixOps.resolve(context, $thumbOverlay),
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
      ..add(DiagnosticsProperty('thumb', $thumb))
      ..add(DiagnosticsProperty('surface', $surface))
      ..add(DiagnosticsProperty('overlay', $overlay))
      ..add(DiagnosticsProperty('thumbSurface', $thumbSurface))
      ..add(DiagnosticsProperty('thumbOverlay', $thumbOverlay));
  }

  @override
  List<Object?> get props => [
    $container,
    $thumb,
    $surface,
    $overlay,
    $thumbSurface,
    $thumbOverlay,
    $animation,
    $modifier,
    $variants,
  ];
}
