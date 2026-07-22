// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popover.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixPopoverSpec implements Spec<RemixPopoverSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixSurfaceEffectsSpec? get effects;

  @override
  Type get type => RemixPopoverSpec;

  @override
  RemixPopoverSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixSurfaceEffectsSpec? effects,
  }) {
    return RemixPopoverSpec(
      container: container ?? this.container,
      effects: effects ?? this.effects,
    );
  }

  @override
  RemixPopoverSpec lerp(RemixPopoverSpec? other, double t) {
    return RemixPopoverSpec(
      container: container.lerp(other?.container, t),
      effects: MixOps.lerpSnap(effects, other?.effects, t),
    );
  }

  @override
  List<Object?> get props => [container, effects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixPopoverSpec &&
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
      ..add(DiagnosticsProperty('effects', effects));
  }
}

@Deprecated(
  'Rename to `_\$RemixPopoverSpec` and migrate the class declaration to `class RemixPopoverSpec with _\$RemixPopoverSpec`. The `_\$RemixPopoverSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixPopoverSpecMethods = _$RemixPopoverSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixPopoverStyler extends MixStyler<RemixPopoverStyler, RemixPopoverSpec>
    with RemixBoxStylerMixin<RemixPopoverStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixSurfaceEffectsSpec>? $effects;

  const RemixPopoverStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixSurfaceEffectsSpec>? effects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $effects = effects;

  RemixPopoverStyler({
    BoxStyler? container,
    RemixSurfaceEffectsMix? effects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixPopoverSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         effects: Prop.maybeMix(effects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixPopoverStyler.container(BoxStyler value) =>
      RemixPopoverStyler().container(value);
  factory RemixPopoverStyler.effects(RemixSurfaceEffectsMix value) =>
      RemixPopoverStyler().effects(value);
  factory RemixPopoverStyler.alignment(AlignmentGeometry value) =>
      RemixPopoverStyler().alignment(value);
  factory RemixPopoverStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixPopoverStyler().padding(value);
  factory RemixPopoverStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixPopoverStyler().margin(value);
  factory RemixPopoverStyler.constraints(BoxConstraintsMix value) =>
      RemixPopoverStyler().constraints(value);
  factory RemixPopoverStyler.decoration(DecorationMix value) =>
      RemixPopoverStyler().decoration(value);
  factory RemixPopoverStyler.foregroundDecoration(DecorationMix value) =>
      RemixPopoverStyler().foregroundDecoration(value);
  factory RemixPopoverStyler.clipBehavior(Clip value) =>
      RemixPopoverStyler().clipBehavior(value);
  factory RemixPopoverStyler.color(Color value) =>
      RemixPopoverStyler().color(value);
  factory RemixPopoverStyler.gradient(GradientMix value) =>
      RemixPopoverStyler().gradient(value);
  factory RemixPopoverStyler.border(BoxBorderMix value) =>
      RemixPopoverStyler().border(value);
  factory RemixPopoverStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixPopoverStyler().borderRadius(value);
  factory RemixPopoverStyler.elevation(ElevationShadow value) =>
      RemixPopoverStyler().elevation(value);
  factory RemixPopoverStyler.shadow(BoxShadowMix value) =>
      RemixPopoverStyler().shadow(value);
  factory RemixPopoverStyler.shadows(List<BoxShadowMix> value) =>
      RemixPopoverStyler().shadows(value);
  factory RemixPopoverStyler.width(double value) =>
      RemixPopoverStyler().width(value);
  factory RemixPopoverStyler.height(double value) =>
      RemixPopoverStyler().height(value);
  factory RemixPopoverStyler.size(double width, double height) =>
      RemixPopoverStyler().size(width, height);
  factory RemixPopoverStyler.minWidth(double value) =>
      RemixPopoverStyler().minWidth(value);
  factory RemixPopoverStyler.maxWidth(double value) =>
      RemixPopoverStyler().maxWidth(value);
  factory RemixPopoverStyler.minHeight(double value) =>
      RemixPopoverStyler().minHeight(value);
  factory RemixPopoverStyler.maxHeight(double value) =>
      RemixPopoverStyler().maxHeight(value);
  factory RemixPopoverStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixPopoverStyler().scale(scale, alignment: alignment);
  factory RemixPopoverStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixPopoverStyler().rotate(radians, alignment: alignment);
  factory RemixPopoverStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixPopoverStyler().translate(x, y, z);
  factory RemixPopoverStyler.skew(double skewX, double skewY) =>
      RemixPopoverStyler().skew(skewX, skewY);
  factory RemixPopoverStyler.textStyle(TextStyler value) =>
      RemixPopoverStyler().textStyle(value);
  factory RemixPopoverStyler.image(DecorationImageMix value) =>
      RemixPopoverStyler().image(value);
  factory RemixPopoverStyler.shape(ShapeBorderMix value) =>
      RemixPopoverStyler().shape(value);
  factory RemixPopoverStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixPopoverStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixPopoverStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixPopoverStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixPopoverStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixPopoverStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixPopoverStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixPopoverStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixPopoverStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixPopoverStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixPopoverStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixPopoverStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixPopoverStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixPopoverStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixPopoverStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixPopoverStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixPopoverStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixPopoverStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixPopoverStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixPopoverStyler().transform(value, alignment: alignment);

  RemixPopoverStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixPopoverStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixPopoverStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixPopoverStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixPopoverStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixPopoverStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixPopoverStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixPopoverStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixPopoverStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixPopoverStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixPopoverStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixPopoverStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixPopoverStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixPopoverStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixPopoverStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixPopoverStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixPopoverStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixPopoverStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixPopoverStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixPopoverStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixPopoverStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixPopoverStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixPopoverStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixPopoverStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixPopoverStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixPopoverStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixPopoverStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixPopoverStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixPopoverStyler backgroundImage(
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

  RemixPopoverStyler backgroundImageUrl(
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

  RemixPopoverStyler backgroundImageAsset(
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

  RemixPopoverStyler linearGradient({
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

  RemixPopoverStyler radialGradient({
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

  RemixPopoverStyler sweepGradient({
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

  RemixPopoverStyler foregroundLinearGradient({
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

  RemixPopoverStyler foregroundRadialGradient({
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

  RemixPopoverStyler foregroundSweepGradient({
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

  RemixPopoverStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixPopoverStyler container(BoxStyler value) {
    return merge(RemixPopoverStyler(container: value));
  }

  /// Sets the effects.
  RemixPopoverStyler effects(RemixSurfaceEffectsMix value) {
    return merge(RemixPopoverStyler(effects: value));
  }

  /// Sets the animation configuration.
  @override
  RemixPopoverStyler animate(AnimationConfig value) {
    return merge(RemixPopoverStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixPopoverStyler variants(List<VariantStyle<RemixPopoverSpec>> value) {
    return merge(RemixPopoverStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixPopoverStyler wrap(WidgetModifierConfig value) {
    return merge(RemixPopoverStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixPopoverStyler modifier(WidgetModifierConfig value) {
    return merge(RemixPopoverStyler(modifier: value));
  }

  /// Merges with another [RemixPopoverStyler].
  @override
  RemixPopoverStyler merge(RemixPopoverStyler? other) {
    return RemixPopoverStyler.create(
      container: MixOps.merge($container, other?.$container),
      effects: MixOps.merge($effects, other?.$effects),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixPopoverSpec>] using [context].
  @override
  StyleSpec<RemixPopoverSpec> resolve(BuildContext context) {
    final spec = RemixPopoverSpec(
      container: MixOps.resolve(context, $container),
      effects: MixOps.resolve(context, $effects),
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
      ..add(DiagnosticsProperty('effects', $effects));
  }

  @override
  List<Object?> get props => [
    $container,
    $effects,
    $animation,
    $modifier,
    $variants,
  ];
}
