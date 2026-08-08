// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$AvatarSpec implements Spec<AvatarSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => AvatarSpec;

  @override
  AvatarSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return AvatarSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  AvatarSpec lerp(AvatarSpec? other, double t) {
    return AvatarSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      icon: icon.lerp(other?.icon, t),
    );
  }

  @override
  List<Object?> get props => [container, label, icon];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AvatarSpec &&
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
      ..add(DiagnosticsProperty('icon', icon));
  }
}

@Deprecated(
  'Rename to `_\$AvatarSpec` and migrate the class declaration to `class AvatarSpec with _\$AvatarSpec`. The `_\$AvatarSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$AvatarSpecMethods = _$AvatarSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class AvatarStyler extends MixStyler<AvatarStyler, AvatarSpec>
    with
        RemixBoxStylerMixin<AvatarStyler>,
        LabelStyleMixin<AvatarStyler>,
        IconStyleMixin<AvatarStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const AvatarStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  AvatarStyler({
    BoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<AvatarSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory AvatarStyler.container(BoxStyler value) =>
      AvatarStyler().container(value);
  factory AvatarStyler.label(TextStyler value) => AvatarStyler().label(value);
  factory AvatarStyler.icon(IconStyler value) => AvatarStyler().icon(value);
  factory AvatarStyler.alignment(AlignmentGeometry value) =>
      AvatarStyler().alignment(value);
  factory AvatarStyler.padding(EdgeInsetsGeometryMix value) =>
      AvatarStyler().padding(value);
  factory AvatarStyler.margin(EdgeInsetsGeometryMix value) =>
      AvatarStyler().margin(value);
  factory AvatarStyler.constraints(BoxConstraintsMix value) =>
      AvatarStyler().constraints(value);
  factory AvatarStyler.decoration(DecorationMix value) =>
      AvatarStyler().decoration(value);
  factory AvatarStyler.foregroundDecoration(DecorationMix value) =>
      AvatarStyler().foregroundDecoration(value);
  factory AvatarStyler.clipBehavior(Clip value) =>
      AvatarStyler().clipBehavior(value);
  factory AvatarStyler.color(Color value) => AvatarStyler().color(value);
  factory AvatarStyler.gradient(GradientMix value) =>
      AvatarStyler().gradient(value);
  factory AvatarStyler.border(BoxBorderMix value) =>
      AvatarStyler().border(value);
  factory AvatarStyler.borderRadius(BorderRadiusGeometryMix value) =>
      AvatarStyler().borderRadius(value);
  factory AvatarStyler.elevation(ElevationShadow value) =>
      AvatarStyler().elevation(value);
  factory AvatarStyler.shadow(BoxShadowMix value) =>
      AvatarStyler().shadow(value);
  factory AvatarStyler.shadows(List<BoxShadowMix> value) =>
      AvatarStyler().shadows(value);
  factory AvatarStyler.width(double value) => AvatarStyler().width(value);
  factory AvatarStyler.height(double value) => AvatarStyler().height(value);
  factory AvatarStyler.size(double width, double height) =>
      AvatarStyler().size(width, height);
  factory AvatarStyler.minWidth(double value) => AvatarStyler().minWidth(value);
  factory AvatarStyler.maxWidth(double value) => AvatarStyler().maxWidth(value);
  factory AvatarStyler.minHeight(double value) =>
      AvatarStyler().minHeight(value);
  factory AvatarStyler.maxHeight(double value) =>
      AvatarStyler().maxHeight(value);
  factory AvatarStyler.scale(double scale, {Alignment alignment = .center}) =>
      AvatarStyler().scale(scale, alignment: alignment);
  factory AvatarStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => AvatarStyler().rotate(radians, alignment: alignment);
  factory AvatarStyler.translate(double x, double y, [double z = 0.0]) =>
      AvatarStyler().translate(x, y, z);
  factory AvatarStyler.skew(double skewX, double skewY) =>
      AvatarStyler().skew(skewX, skewY);
  factory AvatarStyler.textStyle(TextStyler value) =>
      AvatarStyler().textStyle(value);
  factory AvatarStyler.image(DecorationImageMix value) =>
      AvatarStyler().image(value);
  factory AvatarStyler.shape(ShapeBorderMix value) =>
      AvatarStyler().shape(value);
  factory AvatarStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => AvatarStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory AvatarStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => AvatarStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory AvatarStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => AvatarStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory AvatarStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => AvatarStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory AvatarStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => AvatarStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory AvatarStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => AvatarStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory AvatarStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => AvatarStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory AvatarStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => AvatarStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory AvatarStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => AvatarStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory AvatarStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => AvatarStyler().transform(value, alignment: alignment);

  AvatarStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  AvatarStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  AvatarStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  AvatarStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  AvatarStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  AvatarStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  AvatarStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  AvatarStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  AvatarStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  AvatarStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  AvatarStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  AvatarStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  AvatarStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  AvatarStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  AvatarStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  AvatarStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  AvatarStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  AvatarStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  AvatarStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  AvatarStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  AvatarStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  AvatarStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  AvatarStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  AvatarStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  AvatarStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  AvatarStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  AvatarStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  AvatarStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  AvatarStyler backgroundImage(
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

  AvatarStyler backgroundImageUrl(
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

  AvatarStyler backgroundImageAsset(
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

  AvatarStyler linearGradient({
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

  AvatarStyler radialGradient({
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

  AvatarStyler sweepGradient({
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

  AvatarStyler foregroundLinearGradient({
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

  AvatarStyler foregroundRadialGradient({
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

  AvatarStyler foregroundSweepGradient({
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

  AvatarStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  AvatarStyler container(BoxStyler value) {
    return merge(AvatarStyler(container: value));
  }

  /// Sets the label.
  @override
  AvatarStyler label(TextStyler value) {
    return merge(AvatarStyler(label: value));
  }

  /// Sets the icon.
  @override
  AvatarStyler icon(IconStyler value) {
    return merge(AvatarStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  AvatarStyler animate(AnimationConfig value) {
    return merge(AvatarStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  AvatarStyler variants(List<VariantStyle<AvatarSpec>> value) {
    return merge(AvatarStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  AvatarStyler wrap(WidgetModifierConfig value) {
    return merge(AvatarStyler(modifier: value));
  }

  /// Sets the widget modifier.
  AvatarStyler modifier(WidgetModifierConfig value) {
    return merge(AvatarStyler(modifier: value));
  }

  /// Merges with another [AvatarStyler].
  @override
  AvatarStyler merge(AvatarStyler? other) {
    return AvatarStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<AvatarSpec>] using [context].
  @override
  StyleSpec<AvatarSpec> resolve(BuildContext context) {
    final spec = AvatarSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      icon: MixOps.resolve(context, $icon),
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
      ..add(DiagnosticsProperty('icon', $icon));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $icon,
    $animation,
    $modifier,
    $variants,
  ];
}
