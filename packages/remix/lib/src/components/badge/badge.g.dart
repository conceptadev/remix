// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$BadgeSpec implements Spec<BadgeSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<TextSpec> get label;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => BadgeSpec;

  @override
  BadgeSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return BadgeSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  BadgeSpec lerp(BadgeSpec? other, double t) {
    return BadgeSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [container, label, containerEffects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BadgeSpec &&
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
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$BadgeSpec` and migrate the class declaration to `class BadgeSpec with _\$BadgeSpec`. The `_\$BadgeSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$BadgeSpecMethods = _$BadgeSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed Badge with the Radix size, variant, and override contract.
class FortalBadge extends StatelessWidget {
  const FortalBadge({
    super.key,
    this.variant = .soft,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  });

  const FortalBadge.solid({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.solid;

  const FortalBadge.soft({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.soft;

  const FortalBadge.surface({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.surface;

  const FortalBadge.outline({
    super.key,
    this.size = .size1,
    this.highContrast = false,
    this.label,
    this.child,
    this.labelBuilder,
  }) : variant = FortalBadgeVariant.outline;

  final FortalBadgeVariant variant;

  final FortalBadgeSize size;

  final bool highContrast;

  final String? label;

  final Widget? child;

  final RemixBadgeLabelBuilder? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return RemixBadge(
      key: this.key,
      style: fortalBadgeStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      label: this.label,
      child: this.child,
      labelBuilder: this.labelBuilder,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class BadgeStyler extends MixStyler<BadgeStyler, BadgeSpec>
    with RemixBoxStylerMixin<BadgeStyler>, LabelStyleMixin<BadgeStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const BadgeStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $containerEffects = containerEffects;

  BadgeStyler({
    BoxStyler? container,
    TextStyler? label,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<BadgeSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory BadgeStyler.container(BoxStyler value) =>
      BadgeStyler().container(value);
  factory BadgeStyler.label(TextStyler value) => BadgeStyler().label(value);
  factory BadgeStyler.containerEffects(RemixBoxEffectsMix value) =>
      BadgeStyler().containerEffects(value);
  factory BadgeStyler.alignment(AlignmentGeometry value) =>
      BadgeStyler().alignment(value);
  factory BadgeStyler.padding(EdgeInsetsGeometryMix value) =>
      BadgeStyler().padding(value);
  factory BadgeStyler.margin(EdgeInsetsGeometryMix value) =>
      BadgeStyler().margin(value);
  factory BadgeStyler.constraints(BoxConstraintsMix value) =>
      BadgeStyler().constraints(value);
  factory BadgeStyler.decoration(DecorationMix value) =>
      BadgeStyler().decoration(value);
  factory BadgeStyler.foregroundDecoration(DecorationMix value) =>
      BadgeStyler().foregroundDecoration(value);
  factory BadgeStyler.clipBehavior(Clip value) =>
      BadgeStyler().clipBehavior(value);
  factory BadgeStyler.color(Color value) => BadgeStyler().color(value);
  factory BadgeStyler.gradient(GradientMix value) =>
      BadgeStyler().gradient(value);
  factory BadgeStyler.border(BoxBorderMix value) => BadgeStyler().border(value);
  factory BadgeStyler.borderRadius(BorderRadiusGeometryMix value) =>
      BadgeStyler().borderRadius(value);
  factory BadgeStyler.elevation(ElevationShadow value) =>
      BadgeStyler().elevation(value);
  factory BadgeStyler.shadow(BoxShadowMix value) => BadgeStyler().shadow(value);
  factory BadgeStyler.shadows(List<BoxShadowMix> value) =>
      BadgeStyler().shadows(value);
  factory BadgeStyler.width(double value) => BadgeStyler().width(value);
  factory BadgeStyler.height(double value) => BadgeStyler().height(value);
  factory BadgeStyler.size(double width, double height) =>
      BadgeStyler().size(width, height);
  factory BadgeStyler.minWidth(double value) => BadgeStyler().minWidth(value);
  factory BadgeStyler.maxWidth(double value) => BadgeStyler().maxWidth(value);
  factory BadgeStyler.minHeight(double value) => BadgeStyler().minHeight(value);
  factory BadgeStyler.maxHeight(double value) => BadgeStyler().maxHeight(value);
  factory BadgeStyler.scale(double scale, {Alignment alignment = .center}) =>
      BadgeStyler().scale(scale, alignment: alignment);
  factory BadgeStyler.rotate(double radians, {Alignment alignment = .center}) =>
      BadgeStyler().rotate(radians, alignment: alignment);
  factory BadgeStyler.translate(double x, double y, [double z = 0.0]) =>
      BadgeStyler().translate(x, y, z);
  factory BadgeStyler.skew(double skewX, double skewY) =>
      BadgeStyler().skew(skewX, skewY);
  factory BadgeStyler.textStyle(TextStyler value) =>
      BadgeStyler().textStyle(value);
  factory BadgeStyler.image(DecorationImageMix value) =>
      BadgeStyler().image(value);
  factory BadgeStyler.shape(ShapeBorderMix value) => BadgeStyler().shape(value);
  factory BadgeStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => BadgeStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory BadgeStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => BadgeStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory BadgeStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => BadgeStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory BadgeStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => BadgeStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory BadgeStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => BadgeStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory BadgeStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => BadgeStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory BadgeStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => BadgeStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory BadgeStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => BadgeStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory BadgeStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => BadgeStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory BadgeStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => BadgeStyler().transform(value, alignment: alignment);

  BadgeStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  BadgeStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  BadgeStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  BadgeStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  BadgeStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  BadgeStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  BadgeStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  BadgeStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  BadgeStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  BadgeStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  BadgeStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  BadgeStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  BadgeStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  BadgeStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  BadgeStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  BadgeStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  BadgeStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  BadgeStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  BadgeStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  BadgeStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  BadgeStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  BadgeStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  BadgeStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  BadgeStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  BadgeStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  BadgeStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  BadgeStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  BadgeStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  BadgeStyler backgroundImage(
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

  BadgeStyler backgroundImageUrl(
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

  BadgeStyler backgroundImageAsset(
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

  BadgeStyler linearGradient({
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

  BadgeStyler radialGradient({
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

  BadgeStyler sweepGradient({
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

  BadgeStyler foregroundLinearGradient({
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

  BadgeStyler foregroundRadialGradient({
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

  BadgeStyler foregroundSweepGradient({
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

  BadgeStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  BadgeStyler container(BoxStyler value) {
    return merge(BadgeStyler(container: value));
  }

  /// Sets the label.
  @override
  BadgeStyler label(TextStyler value) {
    return merge(BadgeStyler(label: value));
  }

  /// Sets the containerEffects.
  BadgeStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(BadgeStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  BadgeStyler animate(AnimationConfig value) {
    return merge(BadgeStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  BadgeStyler variants(List<VariantStyle<BadgeSpec>> value) {
    return merge(BadgeStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  BadgeStyler wrap(WidgetModifierConfig value) {
    return merge(BadgeStyler(modifier: value));
  }

  /// Sets the widget modifier.
  BadgeStyler modifier(WidgetModifierConfig value) {
    return merge(BadgeStyler(modifier: value));
  }

  /// Merges with another [BadgeStyler].
  @override
  BadgeStyler merge(BadgeStyler? other) {
    return BadgeStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<BadgeSpec>] using [context].
  @override
  StyleSpec<BadgeSpec> resolve(BuildContext context) {
    final spec = BadgeSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      containerEffects: MixOps.resolve(context, $containerEffects),
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
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
