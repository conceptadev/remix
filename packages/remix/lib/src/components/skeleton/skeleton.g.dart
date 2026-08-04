// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skeleton.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$SkeletonSpec implements Spec<SkeletonSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  Color? get pulseColor;
  Duration? get duration;

  @override
  Type get type => SkeletonSpec;

  @override
  SkeletonSpec copyWith({
    StyleSpec<BoxSpec>? container,
    Color? pulseColor,
    Duration? duration,
  }) {
    return SkeletonSpec(
      container: container ?? this.container,
      pulseColor: pulseColor ?? this.pulseColor,
      duration: duration ?? this.duration,
    );
  }

  @override
  SkeletonSpec lerp(SkeletonSpec? other, double t) {
    return SkeletonSpec(
      container: container.lerp(other?.container, t),
      pulseColor: MixOps.lerp(pulseColor, other?.pulseColor, t),
      duration: MixOps.lerpSnap(duration, other?.duration, t),
    );
  }

  @override
  List<Object?> get props => [container, pulseColor, duration];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SkeletonSpec &&
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
      ..add(ColorProperty('pulseColor', pulseColor))
      ..add(DiagnosticsProperty('duration', duration));
  }
}

@Deprecated(
  'Rename to `_\$SkeletonSpec` and migrate the class declaration to `class SkeletonSpec with _\$SkeletonSpec`. The `_\$SkeletonSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SkeletonSpecMethods = _$SkeletonSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class SkeletonStyler extends MixStyler<SkeletonStyler, SkeletonSpec>
    with RemixBoxStylerMixin<SkeletonStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<Color>? $pulseColor;
  final Prop<Duration>? $duration;

  const SkeletonStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<Color>? pulseColor,
    Prop<Duration>? duration,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $pulseColor = pulseColor,
       $duration = duration;

  SkeletonStyler({
    BoxStyler? container,
    Color? pulseColor,
    Duration? duration,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SkeletonSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         pulseColor: Prop.maybe(pulseColor),
         duration: Prop.maybe(duration),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SkeletonStyler.container(BoxStyler value) =>
      SkeletonStyler().container(value);
  factory SkeletonStyler.pulseColor(Color value) =>
      SkeletonStyler().pulseColor(value);
  factory SkeletonStyler.duration(Duration value) =>
      SkeletonStyler().duration(value);
  factory SkeletonStyler.alignment(AlignmentGeometry value) =>
      SkeletonStyler().alignment(value);
  factory SkeletonStyler.padding(EdgeInsetsGeometryMix value) =>
      SkeletonStyler().padding(value);
  factory SkeletonStyler.margin(EdgeInsetsGeometryMix value) =>
      SkeletonStyler().margin(value);
  factory SkeletonStyler.constraints(BoxConstraintsMix value) =>
      SkeletonStyler().constraints(value);
  factory SkeletonStyler.decoration(DecorationMix value) =>
      SkeletonStyler().decoration(value);
  factory SkeletonStyler.foregroundDecoration(DecorationMix value) =>
      SkeletonStyler().foregroundDecoration(value);
  factory SkeletonStyler.clipBehavior(Clip value) =>
      SkeletonStyler().clipBehavior(value);
  factory SkeletonStyler.color(Color value) => SkeletonStyler().color(value);
  factory SkeletonStyler.gradient(GradientMix value) =>
      SkeletonStyler().gradient(value);
  factory SkeletonStyler.border(BoxBorderMix value) =>
      SkeletonStyler().border(value);
  factory SkeletonStyler.borderRadius(BorderRadiusGeometryMix value) =>
      SkeletonStyler().borderRadius(value);
  factory SkeletonStyler.elevation(ElevationShadow value) =>
      SkeletonStyler().elevation(value);
  factory SkeletonStyler.shadow(BoxShadowMix value) =>
      SkeletonStyler().shadow(value);
  factory SkeletonStyler.shadows(List<BoxShadowMix> value) =>
      SkeletonStyler().shadows(value);
  factory SkeletonStyler.width(double value) => SkeletonStyler().width(value);
  factory SkeletonStyler.height(double value) => SkeletonStyler().height(value);
  factory SkeletonStyler.size(double width, double height) =>
      SkeletonStyler().size(width, height);
  factory SkeletonStyler.minWidth(double value) =>
      SkeletonStyler().minWidth(value);
  factory SkeletonStyler.maxWidth(double value) =>
      SkeletonStyler().maxWidth(value);
  factory SkeletonStyler.minHeight(double value) =>
      SkeletonStyler().minHeight(value);
  factory SkeletonStyler.maxHeight(double value) =>
      SkeletonStyler().maxHeight(value);
  factory SkeletonStyler.scale(double scale, {Alignment alignment = .center}) =>
      SkeletonStyler().scale(scale, alignment: alignment);
  factory SkeletonStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SkeletonStyler().rotate(radians, alignment: alignment);
  factory SkeletonStyler.translate(double x, double y, [double z = 0.0]) =>
      SkeletonStyler().translate(x, y, z);
  factory SkeletonStyler.skew(double skewX, double skewY) =>
      SkeletonStyler().skew(skewX, skewY);
  factory SkeletonStyler.textStyle(TextStyler value) =>
      SkeletonStyler().textStyle(value);
  factory SkeletonStyler.image(DecorationImageMix value) =>
      SkeletonStyler().image(value);
  factory SkeletonStyler.shape(ShapeBorderMix value) =>
      SkeletonStyler().shape(value);
  factory SkeletonStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SkeletonStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SkeletonStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SkeletonStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SkeletonStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SkeletonStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SkeletonStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SkeletonStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SkeletonStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SkeletonStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SkeletonStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SkeletonStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SkeletonStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SkeletonStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SkeletonStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SkeletonStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SkeletonStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SkeletonStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SkeletonStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SkeletonStyler().transform(value, alignment: alignment);

  SkeletonStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  SkeletonStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  SkeletonStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  SkeletonStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  SkeletonStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  SkeletonStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  SkeletonStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  SkeletonStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  SkeletonStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  SkeletonStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  SkeletonStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  SkeletonStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  SkeletonStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  SkeletonStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  SkeletonStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  SkeletonStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  SkeletonStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  SkeletonStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  SkeletonStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  SkeletonStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  SkeletonStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  SkeletonStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  SkeletonStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  SkeletonStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  SkeletonStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  SkeletonStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  SkeletonStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  SkeletonStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  SkeletonStyler backgroundImage(
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

  SkeletonStyler backgroundImageUrl(
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

  SkeletonStyler backgroundImageAsset(
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

  SkeletonStyler linearGradient({
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

  SkeletonStyler radialGradient({
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

  SkeletonStyler sweepGradient({
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

  SkeletonStyler foregroundLinearGradient({
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

  SkeletonStyler foregroundRadialGradient({
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

  SkeletonStyler foregroundSweepGradient({
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

  SkeletonStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  SkeletonStyler container(BoxStyler value) {
    return merge(SkeletonStyler(container: value));
  }

  /// Sets the pulseColor.
  SkeletonStyler pulseColor(Color value) {
    return merge(SkeletonStyler(pulseColor: value));
  }

  /// Sets the duration.
  SkeletonStyler duration(Duration value) {
    return merge(SkeletonStyler(duration: value));
  }

  /// Sets the animation configuration.
  @override
  SkeletonStyler animate(AnimationConfig value) {
    return merge(SkeletonStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SkeletonStyler variants(List<VariantStyle<SkeletonSpec>> value) {
    return merge(SkeletonStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SkeletonStyler wrap(WidgetModifierConfig value) {
    return merge(SkeletonStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SkeletonStyler modifier(WidgetModifierConfig value) {
    return merge(SkeletonStyler(modifier: value));
  }

  /// Merges with another [SkeletonStyler].
  @override
  SkeletonStyler merge(SkeletonStyler? other) {
    return SkeletonStyler.create(
      container: MixOps.merge($container, other?.$container),
      pulseColor: MixOps.merge($pulseColor, other?.$pulseColor),
      duration: MixOps.merge($duration, other?.$duration),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SkeletonSpec>] using [context].
  @override
  StyleSpec<SkeletonSpec> resolve(BuildContext context) {
    final spec = SkeletonSpec(
      container: MixOps.resolve(context, $container),
      pulseColor: MixOps.resolve(context, $pulseColor),
      duration: MixOps.resolve(context, $duration),
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
      ..add(DiagnosticsProperty('pulseColor', $pulseColor))
      ..add(DiagnosticsProperty('duration', $duration));
  }

  @override
  List<Object?> get props => [
    $container,
    $pulseColor,
    $duration,
    $animation,
    $modifier,
    $variants,
  ];
}
