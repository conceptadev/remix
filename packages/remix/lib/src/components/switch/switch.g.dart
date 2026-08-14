// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$SwitchSpec implements Spec<SwitchSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get thumb;
  RemixBoxEffectsSpec? get trackEffects;
  RemixBoxEffectsSpec? get thumbEffects;

  @override
  Type get type => SwitchSpec;

  @override
  SwitchSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? thumb,
    RemixBoxEffectsSpec? trackEffects,
    RemixBoxEffectsSpec? thumbEffects,
  }) {
    return SwitchSpec(
      container: container ?? this.container,
      thumb: thumb ?? this.thumb,
      trackEffects: trackEffects ?? this.trackEffects,
      thumbEffects: thumbEffects ?? this.thumbEffects,
    );
  }

  @override
  SwitchSpec lerp(SwitchSpec? other, double t) {
    return SwitchSpec(
      container: container.lerp(other?.container, t),
      thumb: thumb.lerp(other?.thumb, t),
      trackEffects: MixOps.lerpSnap(trackEffects, other?.trackEffects, t),
      thumbEffects: MixOps.lerpSnap(thumbEffects, other?.thumbEffects, t),
    );
  }

  @override
  List<Object?> get props => [container, thumb, trackEffects, thumbEffects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SwitchSpec &&
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
      ..add(DiagnosticsProperty('trackEffects', trackEffects))
      ..add(DiagnosticsProperty('thumbEffects', thumbEffects));
  }
}

@Deprecated(
  'Rename to `_\$SwitchSpec` and migrate the class declaration to `class SwitchSpec with _\$SwitchSpec`. The `_\$SwitchSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SwitchSpecMethods = _$SwitchSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class SwitchStyler extends MixStyler<SwitchStyler, SwitchSpec>
    with RemixBoxStylerMixin<SwitchStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $thumb;
  final Prop<RemixBoxEffectsSpec>? $trackEffects;
  final Prop<RemixBoxEffectsSpec>? $thumbEffects;

  const SwitchStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? thumb,
    Prop<RemixBoxEffectsSpec>? trackEffects,
    Prop<RemixBoxEffectsSpec>? thumbEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $thumb = thumb,
       $trackEffects = trackEffects,
       $thumbEffects = thumbEffects;

  SwitchStyler({
    BoxStyler? container,
    BoxStyler? thumb,
    RemixBoxEffectsMix? trackEffects,
    RemixBoxEffectsMix? thumbEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SwitchSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         thumb: Prop.maybeMix(thumb),
         trackEffects: Prop.maybeMix(trackEffects),
         thumbEffects: Prop.maybeMix(thumbEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SwitchStyler.container(BoxStyler value) =>
      SwitchStyler().container(value);
  factory SwitchStyler.thumb(BoxStyler value) => SwitchStyler().thumb(value);
  factory SwitchStyler.trackEffects(RemixBoxEffectsMix value) =>
      SwitchStyler().trackEffects(value);
  factory SwitchStyler.thumbEffects(RemixBoxEffectsMix value) =>
      SwitchStyler().thumbEffects(value);
  factory SwitchStyler.alignment(AlignmentGeometry value) =>
      SwitchStyler().alignment(value);
  factory SwitchStyler.padding(EdgeInsetsGeometryMix value) =>
      SwitchStyler().padding(value);
  factory SwitchStyler.margin(EdgeInsetsGeometryMix value) =>
      SwitchStyler().margin(value);
  factory SwitchStyler.constraints(BoxConstraintsMix value) =>
      SwitchStyler().constraints(value);
  factory SwitchStyler.decoration(DecorationMix value) =>
      SwitchStyler().decoration(value);
  factory SwitchStyler.foregroundDecoration(DecorationMix value) =>
      SwitchStyler().foregroundDecoration(value);
  factory SwitchStyler.clipBehavior(Clip value) =>
      SwitchStyler().clipBehavior(value);
  factory SwitchStyler.color(Color value) => SwitchStyler().color(value);
  factory SwitchStyler.gradient(GradientMix value) =>
      SwitchStyler().gradient(value);
  factory SwitchStyler.border(BoxBorderMix value) =>
      SwitchStyler().border(value);
  factory SwitchStyler.borderRadius(BorderRadiusGeometryMix value) =>
      SwitchStyler().borderRadius(value);
  factory SwitchStyler.elevation(ElevationShadow value) =>
      SwitchStyler().elevation(value);
  factory SwitchStyler.shadow(BoxShadowMix value) =>
      SwitchStyler().shadow(value);
  factory SwitchStyler.shadows(List<BoxShadowMix> value) =>
      SwitchStyler().shadows(value);
  factory SwitchStyler.width(double value) => SwitchStyler().width(value);
  factory SwitchStyler.height(double value) => SwitchStyler().height(value);
  factory SwitchStyler.size(double width, double height) =>
      SwitchStyler().size(width, height);
  factory SwitchStyler.minWidth(double value) => SwitchStyler().minWidth(value);
  factory SwitchStyler.maxWidth(double value) => SwitchStyler().maxWidth(value);
  factory SwitchStyler.minHeight(double value) =>
      SwitchStyler().minHeight(value);
  factory SwitchStyler.maxHeight(double value) =>
      SwitchStyler().maxHeight(value);
  factory SwitchStyler.scale(double scale, {Alignment alignment = .center}) =>
      SwitchStyler().scale(scale, alignment: alignment);
  factory SwitchStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SwitchStyler().rotate(radians, alignment: alignment);
  factory SwitchStyler.translate(double x, double y, [double z = 0.0]) =>
      SwitchStyler().translate(x, y, z);
  factory SwitchStyler.skew(double skewX, double skewY) =>
      SwitchStyler().skew(skewX, skewY);
  factory SwitchStyler.textStyle(TextStyler value) =>
      SwitchStyler().textStyle(value);
  factory SwitchStyler.image(DecorationImageMix value) =>
      SwitchStyler().image(value);
  factory SwitchStyler.shape(ShapeBorderMix value) =>
      SwitchStyler().shape(value);
  factory SwitchStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SwitchStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SwitchStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SwitchStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SwitchStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SwitchStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SwitchStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SwitchStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SwitchStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SwitchStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SwitchStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SwitchStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SwitchStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SwitchStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SwitchStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SwitchStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SwitchStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SwitchStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SwitchStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SwitchStyler().transform(value, alignment: alignment);

  SwitchStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  SwitchStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  SwitchStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  SwitchStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  SwitchStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  SwitchStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  SwitchStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  SwitchStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  SwitchStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  SwitchStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  SwitchStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  SwitchStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  SwitchStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  SwitchStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  SwitchStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  SwitchStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  SwitchStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  SwitchStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  SwitchStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  SwitchStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  SwitchStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  SwitchStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  SwitchStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  SwitchStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  SwitchStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  SwitchStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  SwitchStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  SwitchStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  SwitchStyler backgroundImage(
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

  SwitchStyler backgroundImageUrl(
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

  SwitchStyler backgroundImageAsset(
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

  SwitchStyler linearGradient({
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

  SwitchStyler radialGradient({
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

  SwitchStyler sweepGradient({
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

  SwitchStyler foregroundLinearGradient({
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

  SwitchStyler foregroundRadialGradient({
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

  SwitchStyler foregroundSweepGradient({
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

  SwitchStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  SwitchStyler container(BoxStyler value) {
    return merge(SwitchStyler(container: value));
  }

  /// Sets the thumb.
  SwitchStyler thumb(BoxStyler value) {
    return merge(SwitchStyler(thumb: value));
  }

  /// Sets the trackEffects.
  SwitchStyler trackEffects(RemixBoxEffectsMix value) {
    return merge(SwitchStyler(trackEffects: value));
  }

  /// Sets the thumbEffects.
  SwitchStyler thumbEffects(RemixBoxEffectsMix value) {
    return merge(SwitchStyler(thumbEffects: value));
  }

  /// Sets the animation configuration.
  @override
  SwitchStyler animate(AnimationConfig value) {
    return merge(SwitchStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SwitchStyler variants(List<VariantStyle<SwitchSpec>> value) {
    return merge(SwitchStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SwitchStyler wrap(WidgetModifierConfig value) {
    return merge(SwitchStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SwitchStyler modifier(WidgetModifierConfig value) {
    return merge(SwitchStyler(modifier: value));
  }

  RemixSwitch call({
    Key? key,
    required bool selected,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    String? semanticLabel,
    bool excludeSemantics = false,
    MouseCursor mouseCursor = SystemMouseCursors.click,
  }) {
    return RemixSwitch(
      key: key,
      style: this,
      selected: selected,
      onChanged: onChanged,
      enabled: enabled,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      mouseCursor: mouseCursor,
    );
  }

  /// Merges with another [SwitchStyler].
  @override
  SwitchStyler merge(SwitchStyler? other) {
    return SwitchStyler.create(
      container: MixOps.merge($container, other?.$container),
      thumb: MixOps.merge($thumb, other?.$thumb),
      trackEffects: MixOps.merge($trackEffects, other?.$trackEffects),
      thumbEffects: MixOps.merge($thumbEffects, other?.$thumbEffects),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SwitchSpec>] using [context].
  @override
  StyleSpec<SwitchSpec> resolve(BuildContext context) {
    final spec = SwitchSpec(
      container: MixOps.resolve(context, $container),
      thumb: MixOps.resolve(context, $thumb),
      trackEffects: MixOps.resolve(context, $trackEffects),
      thumbEffects: MixOps.resolve(context, $thumbEffects),
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
      ..add(DiagnosticsProperty('trackEffects', $trackEffects))
      ..add(DiagnosticsProperty('thumbEffects', $thumbEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $thumb,
    $trackEffects,
    $thumbEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
