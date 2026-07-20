// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixCardSpec implements Spec<RemixCardSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixSurfaceLayerSpec? get surface;
  RemixSurfaceLayerSpec? get overlay;

  @override
  Type get type => RemixCardSpec;

  @override
  RemixCardSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixSurfaceLayerSpec? surface,
    RemixSurfaceLayerSpec? overlay,
  }) {
    return RemixCardSpec(
      container: container ?? this.container,
      surface: surface ?? this.surface,
      overlay: overlay ?? this.overlay,
    );
  }

  @override
  RemixCardSpec lerp(RemixCardSpec? other, double t) {
    return RemixCardSpec(
      container: container.lerp(other?.container, t),
      surface: MixOps.lerpSnap(surface, other?.surface, t),
      overlay: MixOps.lerpSnap(overlay, other?.overlay, t),
    );
  }

  @override
  List<Object?> get props => [container, surface, overlay];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixCardSpec &&
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
      ..add(DiagnosticsProperty('surface', surface))
      ..add(DiagnosticsProperty('overlay', overlay));
  }
}

@Deprecated(
  'Rename to `_\$RemixCardSpec` and migrate the class declaration to `class RemixCardSpec with _\$RemixCardSpec`. The `_\$RemixCardSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixCardSpecMethods = _$RemixCardSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixCardStyler extends MixStyler<RemixCardStyler, RemixCardSpec>
    with RemixBoxStylerMixin<RemixCardStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixSurfaceLayerSpec>? $surface;
  final Prop<RemixSurfaceLayerSpec>? $overlay;

  const RemixCardStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixSurfaceLayerSpec>? surface,
    Prop<RemixSurfaceLayerSpec>? overlay,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $surface = surface,
       $overlay = overlay;

  RemixCardStyler({
    BoxStyler? container,
    RemixSurfaceLayerMix? surface,
    RemixSurfaceLayerMix? overlay,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixCardSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         surface: Prop.maybeMix(surface),
         overlay: Prop.maybeMix(overlay),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixCardStyler.container(BoxStyler value) =>
      RemixCardStyler().container(value);
  factory RemixCardStyler.surface(RemixSurfaceLayerMix value) =>
      RemixCardStyler().surface(value);
  factory RemixCardStyler.overlay(RemixSurfaceLayerMix value) =>
      RemixCardStyler().overlay(value);
  factory RemixCardStyler.alignment(AlignmentGeometry value) =>
      RemixCardStyler().alignment(value);
  factory RemixCardStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixCardStyler().padding(value);
  factory RemixCardStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixCardStyler().margin(value);
  factory RemixCardStyler.constraints(BoxConstraintsMix value) =>
      RemixCardStyler().constraints(value);
  factory RemixCardStyler.decoration(DecorationMix value) =>
      RemixCardStyler().decoration(value);
  factory RemixCardStyler.foregroundDecoration(DecorationMix value) =>
      RemixCardStyler().foregroundDecoration(value);
  factory RemixCardStyler.clipBehavior(Clip value) =>
      RemixCardStyler().clipBehavior(value);
  factory RemixCardStyler.color(Color value) => RemixCardStyler().color(value);
  factory RemixCardStyler.gradient(GradientMix value) =>
      RemixCardStyler().gradient(value);
  factory RemixCardStyler.border(BoxBorderMix value) =>
      RemixCardStyler().border(value);
  factory RemixCardStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixCardStyler().borderRadius(value);
  factory RemixCardStyler.elevation(ElevationShadow value) =>
      RemixCardStyler().elevation(value);
  factory RemixCardStyler.shadow(BoxShadowMix value) =>
      RemixCardStyler().shadow(value);
  factory RemixCardStyler.shadows(List<BoxShadowMix> value) =>
      RemixCardStyler().shadows(value);
  factory RemixCardStyler.width(double value) => RemixCardStyler().width(value);
  factory RemixCardStyler.height(double value) =>
      RemixCardStyler().height(value);
  factory RemixCardStyler.size(double width, double height) =>
      RemixCardStyler().size(width, height);
  factory RemixCardStyler.minWidth(double value) =>
      RemixCardStyler().minWidth(value);
  factory RemixCardStyler.maxWidth(double value) =>
      RemixCardStyler().maxWidth(value);
  factory RemixCardStyler.minHeight(double value) =>
      RemixCardStyler().minHeight(value);
  factory RemixCardStyler.maxHeight(double value) =>
      RemixCardStyler().maxHeight(value);
  factory RemixCardStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixCardStyler().scale(scale, alignment: alignment);
  factory RemixCardStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixCardStyler().rotate(radians, alignment: alignment);
  factory RemixCardStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixCardStyler().translate(x, y, z);
  factory RemixCardStyler.skew(double skewX, double skewY) =>
      RemixCardStyler().skew(skewX, skewY);
  factory RemixCardStyler.textStyle(TextStyler value) =>
      RemixCardStyler().textStyle(value);
  factory RemixCardStyler.image(DecorationImageMix value) =>
      RemixCardStyler().image(value);
  factory RemixCardStyler.shape(ShapeBorderMix value) =>
      RemixCardStyler().shape(value);
  factory RemixCardStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixCardStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixCardStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixCardStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixCardStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixCardStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixCardStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixCardStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixCardStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixCardStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixCardStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixCardStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixCardStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixCardStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixCardStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixCardStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixCardStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixCardStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixCardStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixCardStyler().transform(value, alignment: alignment);

  RemixCardStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixCardStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixCardStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixCardStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixCardStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixCardStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixCardStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixCardStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixCardStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixCardStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixCardStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixCardStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixCardStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixCardStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixCardStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixCardStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixCardStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixCardStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixCardStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixCardStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixCardStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixCardStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixCardStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixCardStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixCardStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixCardStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixCardStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixCardStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixCardStyler backgroundImage(
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

  RemixCardStyler backgroundImageUrl(
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

  RemixCardStyler backgroundImageAsset(
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

  RemixCardStyler linearGradient({
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

  RemixCardStyler radialGradient({
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

  RemixCardStyler sweepGradient({
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

  RemixCardStyler foregroundLinearGradient({
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

  RemixCardStyler foregroundRadialGradient({
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

  RemixCardStyler foregroundSweepGradient({
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

  RemixCardStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixCardStyler container(BoxStyler value) {
    return merge(RemixCardStyler(container: value));
  }

  /// Sets the surface.
  RemixCardStyler surface(RemixSurfaceLayerMix value) {
    return merge(RemixCardStyler(surface: value));
  }

  /// Sets the overlay.
  RemixCardStyler overlay(RemixSurfaceLayerMix value) {
    return merge(RemixCardStyler(overlay: value));
  }

  /// Sets the animation configuration.
  @override
  RemixCardStyler animate(AnimationConfig value) {
    return merge(RemixCardStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixCardStyler variants(List<VariantStyle<RemixCardSpec>> value) {
    return merge(RemixCardStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixCardStyler wrap(WidgetModifierConfig value) {
    return merge(RemixCardStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixCardStyler modifier(WidgetModifierConfig value) {
    return merge(RemixCardStyler(modifier: value));
  }

  /// Merges with another [RemixCardStyler].
  @override
  RemixCardStyler merge(RemixCardStyler? other) {
    return RemixCardStyler.create(
      container: MixOps.merge($container, other?.$container),
      surface: MixOps.merge($surface, other?.$surface),
      overlay: MixOps.merge($overlay, other?.$overlay),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixCardSpec>] using [context].
  @override
  StyleSpec<RemixCardSpec> resolve(BuildContext context) {
    final spec = RemixCardSpec(
      container: MixOps.resolve(context, $container),
      surface: MixOps.resolve(context, $surface),
      overlay: MixOps.resolve(context, $overlay),
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
      ..add(DiagnosticsProperty('surface', $surface))
      ..add(DiagnosticsProperty('overlay', $overlay));
  }

  @override
  List<Object?> get props => [
    $container,
    $surface,
    $overlay,
    $animation,
    $modifier,
    $variants,
  ];
}
