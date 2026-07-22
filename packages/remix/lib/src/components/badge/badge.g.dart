// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixBadgeSpec implements Spec<RemixBadgeSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<TextSpec> get label;
  RemixSurfaceEffectsSpec? get effects;

  @override
  Type get type => RemixBadgeSpec;

  @override
  RemixBadgeSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    RemixSurfaceEffectsSpec? effects,
  }) {
    return RemixBadgeSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      effects: effects ?? this.effects,
    );
  }

  @override
  RemixBadgeSpec lerp(RemixBadgeSpec? other, double t) {
    return RemixBadgeSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      effects: MixOps.lerpSnap(effects, other?.effects, t),
    );
  }

  @override
  List<Object?> get props => [container, label, effects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixBadgeSpec &&
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
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('effects', effects));
  }
}

@Deprecated(
  'Rename to `_\$RemixBadgeSpec` and migrate the class declaration to `class RemixBadgeSpec with _\$RemixBadgeSpec`. The `_\$RemixBadgeSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixBadgeSpecMethods = _$RemixBadgeSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixBadgeStyler extends MixStyler<RemixBadgeStyler, RemixBadgeSpec>
    with
        RemixBoxStylerMixin<RemixBadgeStyler>,
        LabelStyleMixin<RemixBadgeStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<RemixSurfaceEffectsSpec>? $effects;

  const RemixBadgeStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<RemixSurfaceEffectsSpec>? effects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $effects = effects;

  RemixBadgeStyler({
    BoxStyler? container,
    TextStyler? label,
    RemixSurfaceEffectsMix? effects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixBadgeSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         effects: Prop.maybeMix(effects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixBadgeStyler.container(BoxStyler value) =>
      RemixBadgeStyler().container(value);
  factory RemixBadgeStyler.label(TextStyler value) =>
      RemixBadgeStyler().label(value);
  factory RemixBadgeStyler.effects(RemixSurfaceEffectsMix value) =>
      RemixBadgeStyler().effects(value);
  factory RemixBadgeStyler.alignment(AlignmentGeometry value) =>
      RemixBadgeStyler().alignment(value);
  factory RemixBadgeStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixBadgeStyler().padding(value);
  factory RemixBadgeStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixBadgeStyler().margin(value);
  factory RemixBadgeStyler.constraints(BoxConstraintsMix value) =>
      RemixBadgeStyler().constraints(value);
  factory RemixBadgeStyler.decoration(DecorationMix value) =>
      RemixBadgeStyler().decoration(value);
  factory RemixBadgeStyler.foregroundDecoration(DecorationMix value) =>
      RemixBadgeStyler().foregroundDecoration(value);
  factory RemixBadgeStyler.clipBehavior(Clip value) =>
      RemixBadgeStyler().clipBehavior(value);
  factory RemixBadgeStyler.color(Color value) =>
      RemixBadgeStyler().color(value);
  factory RemixBadgeStyler.gradient(GradientMix value) =>
      RemixBadgeStyler().gradient(value);
  factory RemixBadgeStyler.border(BoxBorderMix value) =>
      RemixBadgeStyler().border(value);
  factory RemixBadgeStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixBadgeStyler().borderRadius(value);
  factory RemixBadgeStyler.elevation(ElevationShadow value) =>
      RemixBadgeStyler().elevation(value);
  factory RemixBadgeStyler.shadow(BoxShadowMix value) =>
      RemixBadgeStyler().shadow(value);
  factory RemixBadgeStyler.shadows(List<BoxShadowMix> value) =>
      RemixBadgeStyler().shadows(value);
  factory RemixBadgeStyler.width(double value) =>
      RemixBadgeStyler().width(value);
  factory RemixBadgeStyler.height(double value) =>
      RemixBadgeStyler().height(value);
  factory RemixBadgeStyler.size(double width, double height) =>
      RemixBadgeStyler().size(width, height);
  factory RemixBadgeStyler.minWidth(double value) =>
      RemixBadgeStyler().minWidth(value);
  factory RemixBadgeStyler.maxWidth(double value) =>
      RemixBadgeStyler().maxWidth(value);
  factory RemixBadgeStyler.minHeight(double value) =>
      RemixBadgeStyler().minHeight(value);
  factory RemixBadgeStyler.maxHeight(double value) =>
      RemixBadgeStyler().maxHeight(value);
  factory RemixBadgeStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixBadgeStyler().scale(scale, alignment: alignment);
  factory RemixBadgeStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixBadgeStyler().rotate(radians, alignment: alignment);
  factory RemixBadgeStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixBadgeStyler().translate(x, y, z);
  factory RemixBadgeStyler.skew(double skewX, double skewY) =>
      RemixBadgeStyler().skew(skewX, skewY);
  factory RemixBadgeStyler.textStyle(TextStyler value) =>
      RemixBadgeStyler().textStyle(value);
  factory RemixBadgeStyler.image(DecorationImageMix value) =>
      RemixBadgeStyler().image(value);
  factory RemixBadgeStyler.shape(ShapeBorderMix value) =>
      RemixBadgeStyler().shape(value);
  factory RemixBadgeStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixBadgeStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixBadgeStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixBadgeStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixBadgeStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixBadgeStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixBadgeStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixBadgeStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixBadgeStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixBadgeStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixBadgeStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixBadgeStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixBadgeStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixBadgeStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixBadgeStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixBadgeStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixBadgeStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixBadgeStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixBadgeStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixBadgeStyler().transform(value, alignment: alignment);

  RemixBadgeStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixBadgeStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixBadgeStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixBadgeStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixBadgeStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixBadgeStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixBadgeStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixBadgeStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixBadgeStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixBadgeStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixBadgeStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixBadgeStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixBadgeStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixBadgeStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixBadgeStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixBadgeStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixBadgeStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixBadgeStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixBadgeStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixBadgeStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixBadgeStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixBadgeStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixBadgeStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixBadgeStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixBadgeStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixBadgeStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixBadgeStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixBadgeStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixBadgeStyler backgroundImage(
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

  RemixBadgeStyler backgroundImageUrl(
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

  RemixBadgeStyler backgroundImageAsset(
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

  RemixBadgeStyler linearGradient({
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

  RemixBadgeStyler radialGradient({
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

  RemixBadgeStyler sweepGradient({
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

  RemixBadgeStyler foregroundLinearGradient({
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

  RemixBadgeStyler foregroundRadialGradient({
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

  RemixBadgeStyler foregroundSweepGradient({
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

  RemixBadgeStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixBadgeStyler container(BoxStyler value) {
    return merge(RemixBadgeStyler(container: value));
  }

  /// Sets the label.
  @override
  RemixBadgeStyler label(TextStyler value) {
    return merge(RemixBadgeStyler(label: value));
  }

  /// Sets the effects.
  RemixBadgeStyler effects(RemixSurfaceEffectsMix value) {
    return merge(RemixBadgeStyler(effects: value));
  }

  /// Sets the animation configuration.
  @override
  RemixBadgeStyler animate(AnimationConfig value) {
    return merge(RemixBadgeStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixBadgeStyler variants(List<VariantStyle<RemixBadgeSpec>> value) {
    return merge(RemixBadgeStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixBadgeStyler wrap(WidgetModifierConfig value) {
    return merge(RemixBadgeStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixBadgeStyler modifier(WidgetModifierConfig value) {
    return merge(RemixBadgeStyler(modifier: value));
  }

  /// Merges with another [RemixBadgeStyler].
  @override
  RemixBadgeStyler merge(RemixBadgeStyler? other) {
    return RemixBadgeStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      effects: MixOps.merge($effects, other?.$effects),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixBadgeSpec>] using [context].
  @override
  StyleSpec<RemixBadgeSpec> resolve(BuildContext context) {
    final spec = RemixBadgeSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
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
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('effects', $effects));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $effects,
    $animation,
    $modifier,
    $variants,
  ];
}
