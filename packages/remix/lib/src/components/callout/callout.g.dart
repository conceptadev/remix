// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callout.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixCalloutSpec implements Spec<RemixCalloutSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get text;
  StyleSpec<IconSpec> get icon;
  RemixSurfaceEffectsSpec? get effects;

  @override
  Type get type => RemixCalloutSpec;

  @override
  RemixCalloutSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    StyleSpec<IconSpec>? icon,
    RemixSurfaceEffectsSpec? effects,
  }) {
    return RemixCalloutSpec(
      container: container ?? this.container,
      text: text ?? this.text,
      icon: icon ?? this.icon,
      effects: effects ?? this.effects,
    );
  }

  @override
  RemixCalloutSpec lerp(RemixCalloutSpec? other, double t) {
    return RemixCalloutSpec(
      container: container.lerp(other?.container, t),
      text: text.lerp(other?.text, t),
      icon: icon.lerp(other?.icon, t),
      effects: MixOps.lerpSnap(effects, other?.effects, t),
    );
  }

  @override
  List<Object?> get props => [container, text, icon, effects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixCalloutSpec &&
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
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('effects', effects));
  }
}

@Deprecated(
  'Rename to `_\$RemixCalloutSpec` and migrate the class declaration to `class RemixCalloutSpec with _\$RemixCalloutSpec`. The `_\$RemixCalloutSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixCalloutSpecMethods = _$RemixCalloutSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixCalloutStyler extends MixStyler<RemixCalloutStyler, RemixCalloutSpec>
    with
        RemixBoxStylerMixin<RemixCalloutStyler>,
        IconStyleMixin<RemixCalloutStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $text;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<RemixSurfaceEffectsSpec>? $effects;

  const RemixCalloutStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? text,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<RemixSurfaceEffectsSpec>? effects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $text = text,
       $icon = icon,
       $effects = effects;

  RemixCalloutStyler({
    FlexBoxStyler? container,
    TextStyler? text,
    IconStyler? icon,
    RemixSurfaceEffectsMix? effects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixCalloutSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         text: Prop.maybeMix(text),
         icon: Prop.maybeMix(icon),
         effects: Prop.maybeMix(effects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixCalloutStyler.container(FlexBoxStyler value) =>
      RemixCalloutStyler().container(value);
  factory RemixCalloutStyler.text(TextStyler value) =>
      RemixCalloutStyler().text(value);
  factory RemixCalloutStyler.icon(IconStyler value) =>
      RemixCalloutStyler().icon(value);
  factory RemixCalloutStyler.effects(RemixSurfaceEffectsMix value) =>
      RemixCalloutStyler().effects(value);
  factory RemixCalloutStyler.color(Color value) =>
      RemixCalloutStyler().color(value);
  factory RemixCalloutStyler.gradient(GradientMix value) =>
      RemixCalloutStyler().gradient(value);
  factory RemixCalloutStyler.border(BoxBorderMix value) =>
      RemixCalloutStyler().border(value);
  factory RemixCalloutStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixCalloutStyler().borderRadius(value);
  factory RemixCalloutStyler.elevation(ElevationShadow value) =>
      RemixCalloutStyler().elevation(value);
  factory RemixCalloutStyler.shadow(BoxShadowMix value) =>
      RemixCalloutStyler().shadow(value);
  factory RemixCalloutStyler.shadows(List<BoxShadowMix> value) =>
      RemixCalloutStyler().shadows(value);
  factory RemixCalloutStyler.width(double value) =>
      RemixCalloutStyler().width(value);
  factory RemixCalloutStyler.height(double value) =>
      RemixCalloutStyler().height(value);
  factory RemixCalloutStyler.size(double width, double height) =>
      RemixCalloutStyler().size(width, height);
  factory RemixCalloutStyler.minWidth(double value) =>
      RemixCalloutStyler().minWidth(value);
  factory RemixCalloutStyler.maxWidth(double value) =>
      RemixCalloutStyler().maxWidth(value);
  factory RemixCalloutStyler.minHeight(double value) =>
      RemixCalloutStyler().minHeight(value);
  factory RemixCalloutStyler.maxHeight(double value) =>
      RemixCalloutStyler().maxHeight(value);
  factory RemixCalloutStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixCalloutStyler().scale(scale, alignment: alignment);
  factory RemixCalloutStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixCalloutStyler().rotate(radians, alignment: alignment);
  factory RemixCalloutStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixCalloutStyler().translate(x, y, z);
  factory RemixCalloutStyler.skew(double skewX, double skewY) =>
      RemixCalloutStyler().skew(skewX, skewY);
  factory RemixCalloutStyler.textStyle(TextStyler value) =>
      RemixCalloutStyler().textStyle(value);
  factory RemixCalloutStyler.image(DecorationImageMix value) =>
      RemixCalloutStyler().image(value);
  factory RemixCalloutStyler.shape(ShapeBorderMix value) =>
      RemixCalloutStyler().shape(value);
  factory RemixCalloutStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixCalloutStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixCalloutStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixCalloutStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixCalloutStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixCalloutStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixCalloutStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixCalloutStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixCalloutStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixCalloutStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixCalloutStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixCalloutStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixCalloutStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixCalloutStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixCalloutStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixCalloutStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixCalloutStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixCalloutStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixCalloutStyler.row() => RemixCalloutStyler().row();
  factory RemixCalloutStyler.column() => RemixCalloutStyler().column();
  factory RemixCalloutStyler.alignment(AlignmentGeometry value) =>
      RemixCalloutStyler().alignment(value);
  factory RemixCalloutStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixCalloutStyler().padding(value);
  factory RemixCalloutStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixCalloutStyler().margin(value);
  factory RemixCalloutStyler.constraints(BoxConstraintsMix value) =>
      RemixCalloutStyler().constraints(value);
  factory RemixCalloutStyler.decoration(DecorationMix value) =>
      RemixCalloutStyler().decoration(value);
  factory RemixCalloutStyler.foregroundDecoration(DecorationMix value) =>
      RemixCalloutStyler().foregroundDecoration(value);
  factory RemixCalloutStyler.clipBehavior(Clip value) =>
      RemixCalloutStyler().clipBehavior(value);
  factory RemixCalloutStyler.direction(Axis value) =>
      RemixCalloutStyler().direction(value);
  factory RemixCalloutStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixCalloutStyler().mainAxisAlignment(value);
  factory RemixCalloutStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixCalloutStyler().crossAxisAlignment(value);
  factory RemixCalloutStyler.mainAxisSize(MainAxisSize value) =>
      RemixCalloutStyler().mainAxisSize(value);
  factory RemixCalloutStyler.spacing(double value) =>
      RemixCalloutStyler().spacing(value);
  factory RemixCalloutStyler.verticalDirection(VerticalDirection value) =>
      RemixCalloutStyler().verticalDirection(value);
  factory RemixCalloutStyler.textDirection(TextDirection value) =>
      RemixCalloutStyler().textDirection(value);
  factory RemixCalloutStyler.textBaseline(TextBaseline value) =>
      RemixCalloutStyler().textBaseline(value);
  factory RemixCalloutStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixCalloutStyler().transform(value, alignment: alignment);

  RemixCalloutStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixCalloutStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixCalloutStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixCalloutStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixCalloutStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixCalloutStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixCalloutStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixCalloutStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixCalloutStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixCalloutStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixCalloutStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixCalloutStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixCalloutStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixCalloutStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixCalloutStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixCalloutStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixCalloutStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixCalloutStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixCalloutStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixCalloutStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixCalloutStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixCalloutStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  RemixCalloutStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  RemixCalloutStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  RemixCalloutStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  RemixCalloutStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().radialGradient(
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

  RemixCalloutStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().sweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  RemixCalloutStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  RemixCalloutStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundRadialGradient(
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

  RemixCalloutStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundSweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  RemixCalloutStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixCalloutStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixCalloutStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixCalloutStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixCalloutStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixCalloutStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixCalloutStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixCalloutStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixCalloutStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixCalloutStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixCalloutStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixCalloutStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixCalloutStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixCalloutStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixCalloutStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixCalloutStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixCalloutStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixCalloutStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixCalloutStyler container(FlexBoxStyler value) {
    return merge(RemixCalloutStyler(container: value));
  }

  /// Sets the text.
  RemixCalloutStyler text(TextStyler value) {
    return merge(RemixCalloutStyler(text: value));
  }

  /// Sets the icon.
  @override
  RemixCalloutStyler icon(IconStyler value) {
    return merge(RemixCalloutStyler(icon: value));
  }

  /// Sets the effects.
  RemixCalloutStyler effects(RemixSurfaceEffectsMix value) {
    return merge(RemixCalloutStyler(effects: value));
  }

  /// Sets the animation configuration.
  @override
  RemixCalloutStyler animate(AnimationConfig value) {
    return merge(RemixCalloutStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixCalloutStyler variants(List<VariantStyle<RemixCalloutSpec>> value) {
    return merge(RemixCalloutStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixCalloutStyler wrap(WidgetModifierConfig value) {
    return merge(RemixCalloutStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixCalloutStyler modifier(WidgetModifierConfig value) {
    return merge(RemixCalloutStyler(modifier: value));
  }

  /// Merges with another [RemixCalloutStyler].
  @override
  RemixCalloutStyler merge(RemixCalloutStyler? other) {
    return RemixCalloutStyler.create(
      container: MixOps.merge($container, other?.$container),
      text: MixOps.merge($text, other?.$text),
      icon: MixOps.merge($icon, other?.$icon),
      effects: MixOps.merge($effects, other?.$effects),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixCalloutSpec>] using [context].
  @override
  StyleSpec<RemixCalloutSpec> resolve(BuildContext context) {
    final spec = RemixCalloutSpec(
      container: MixOps.resolve(context, $container),
      text: MixOps.resolve(context, $text),
      icon: MixOps.resolve(context, $icon),
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
      ..add(DiagnosticsProperty('text', $text))
      ..add(DiagnosticsProperty('icon', $icon))
      ..add(DiagnosticsProperty('effects', $effects));
  }

  @override
  List<Object?> get props => [
    $container,
    $text,
    $icon,
    $effects,
    $animation,
    $modifier,
    $variants,
  ];
}
