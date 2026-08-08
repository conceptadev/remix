// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkbox.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$CheckboxSpec implements Spec<CheckboxSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<IconSpec> get indicator;
  StyleSpec<TextSpec> get label;
  double get labelSpacing;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => CheckboxSpec;

  @override
  CheckboxSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<TextSpec>? label,
    double? labelSpacing,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return CheckboxSpec(
      container: container ?? this.container,
      indicator: indicator ?? this.indicator,
      label: label ?? this.label,
      labelSpacing: labelSpacing ?? this.labelSpacing,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  CheckboxSpec lerp(CheckboxSpec? other, double t) {
    return CheckboxSpec(
      container: container.lerp(other?.container, t),
      indicator: indicator.lerp(other?.indicator, t),
      label: label.lerp(other?.label, t),
      labelSpacing: MixOps.lerp(labelSpacing, other?.labelSpacing, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [
    container,
    indicator,
    label,
    labelSpacing,
    containerEffects,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CheckboxSpec &&
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
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('label', label))
      ..add(DoubleProperty('labelSpacing', labelSpacing))
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$CheckboxSpec` and migrate the class declaration to `class CheckboxSpec with _\$CheckboxSpec`. The `_\$CheckboxSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$CheckboxSpecMethods = _$CheckboxSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class CheckboxStyler extends MixStyler<CheckboxStyler, CheckboxSpec>
    with RemixBoxStylerMixin<CheckboxStyler>, LabelStyleMixin<CheckboxStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<IconSpec>>? $indicator;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<double>? $labelSpacing;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const CheckboxStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<IconSpec>>? indicator,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<double>? labelSpacing,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $indicator = indicator,
       $label = label,
       $labelSpacing = labelSpacing,
       $containerEffects = containerEffects;

  CheckboxStyler({
    BoxStyler? container,
    IconStyler? indicator,
    TextStyler? label,
    double? labelSpacing,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<CheckboxSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         indicator: Prop.maybeMix(indicator),
         label: Prop.maybeMix(label),
         labelSpacing: Prop.maybe(labelSpacing),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory CheckboxStyler.container(BoxStyler value) =>
      CheckboxStyler().container(value);
  factory CheckboxStyler.indicator(IconStyler value) =>
      CheckboxStyler().indicator(value);
  factory CheckboxStyler.label(TextStyler value) =>
      CheckboxStyler().label(value);
  factory CheckboxStyler.labelSpacing(double value) =>
      CheckboxStyler().labelSpacing(value);
  factory CheckboxStyler.containerEffects(RemixBoxEffectsMix value) =>
      CheckboxStyler().containerEffects(value);
  factory CheckboxStyler.alignment(AlignmentGeometry value) =>
      CheckboxStyler().alignment(value);
  factory CheckboxStyler.padding(EdgeInsetsGeometryMix value) =>
      CheckboxStyler().padding(value);
  factory CheckboxStyler.margin(EdgeInsetsGeometryMix value) =>
      CheckboxStyler().margin(value);
  factory CheckboxStyler.constraints(BoxConstraintsMix value) =>
      CheckboxStyler().constraints(value);
  factory CheckboxStyler.decoration(DecorationMix value) =>
      CheckboxStyler().decoration(value);
  factory CheckboxStyler.foregroundDecoration(DecorationMix value) =>
      CheckboxStyler().foregroundDecoration(value);
  factory CheckboxStyler.clipBehavior(Clip value) =>
      CheckboxStyler().clipBehavior(value);
  factory CheckboxStyler.color(Color value) => CheckboxStyler().color(value);
  factory CheckboxStyler.gradient(GradientMix value) =>
      CheckboxStyler().gradient(value);
  factory CheckboxStyler.border(BoxBorderMix value) =>
      CheckboxStyler().border(value);
  factory CheckboxStyler.borderRadius(BorderRadiusGeometryMix value) =>
      CheckboxStyler().borderRadius(value);
  factory CheckboxStyler.elevation(ElevationShadow value) =>
      CheckboxStyler().elevation(value);
  factory CheckboxStyler.shadow(BoxShadowMix value) =>
      CheckboxStyler().shadow(value);
  factory CheckboxStyler.shadows(List<BoxShadowMix> value) =>
      CheckboxStyler().shadows(value);
  factory CheckboxStyler.width(double value) => CheckboxStyler().width(value);
  factory CheckboxStyler.height(double value) => CheckboxStyler().height(value);
  factory CheckboxStyler.size(double width, double height) =>
      CheckboxStyler().size(width, height);
  factory CheckboxStyler.minWidth(double value) =>
      CheckboxStyler().minWidth(value);
  factory CheckboxStyler.maxWidth(double value) =>
      CheckboxStyler().maxWidth(value);
  factory CheckboxStyler.minHeight(double value) =>
      CheckboxStyler().minHeight(value);
  factory CheckboxStyler.maxHeight(double value) =>
      CheckboxStyler().maxHeight(value);
  factory CheckboxStyler.scale(double scale, {Alignment alignment = .center}) =>
      CheckboxStyler().scale(scale, alignment: alignment);
  factory CheckboxStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => CheckboxStyler().rotate(radians, alignment: alignment);
  factory CheckboxStyler.translate(double x, double y, [double z = 0.0]) =>
      CheckboxStyler().translate(x, y, z);
  factory CheckboxStyler.skew(double skewX, double skewY) =>
      CheckboxStyler().skew(skewX, skewY);
  factory CheckboxStyler.textStyle(TextStyler value) =>
      CheckboxStyler().textStyle(value);
  factory CheckboxStyler.image(DecorationImageMix value) =>
      CheckboxStyler().image(value);
  factory CheckboxStyler.shape(ShapeBorderMix value) =>
      CheckboxStyler().shape(value);
  factory CheckboxStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => CheckboxStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory CheckboxStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => CheckboxStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory CheckboxStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => CheckboxStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory CheckboxStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => CheckboxStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory CheckboxStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => CheckboxStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory CheckboxStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => CheckboxStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory CheckboxStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => CheckboxStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory CheckboxStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => CheckboxStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory CheckboxStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => CheckboxStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory CheckboxStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => CheckboxStyler().transform(value, alignment: alignment);

  CheckboxStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  CheckboxStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  CheckboxStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  CheckboxStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  CheckboxStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  CheckboxStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  CheckboxStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  CheckboxStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  CheckboxStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  CheckboxStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  CheckboxStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  CheckboxStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  CheckboxStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  CheckboxStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  CheckboxStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  CheckboxStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  CheckboxStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  CheckboxStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  CheckboxStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  CheckboxStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  CheckboxStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  CheckboxStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  CheckboxStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  CheckboxStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  CheckboxStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  CheckboxStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  CheckboxStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  CheckboxStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  CheckboxStyler backgroundImage(
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

  CheckboxStyler backgroundImageUrl(
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

  CheckboxStyler backgroundImageAsset(
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

  CheckboxStyler linearGradient({
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

  CheckboxStyler radialGradient({
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

  CheckboxStyler sweepGradient({
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

  CheckboxStyler foregroundLinearGradient({
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

  CheckboxStyler foregroundRadialGradient({
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

  CheckboxStyler foregroundSweepGradient({
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

  CheckboxStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  CheckboxStyler container(BoxStyler value) {
    return merge(CheckboxStyler(container: value));
  }

  /// Sets the indicator.
  CheckboxStyler indicator(IconStyler value) {
    return merge(CheckboxStyler(indicator: value));
  }

  /// Sets the label.
  @override
  CheckboxStyler label(TextStyler value) {
    return merge(CheckboxStyler(label: value));
  }

  /// Sets the labelSpacing.
  CheckboxStyler labelSpacing(double value) {
    return merge(CheckboxStyler(labelSpacing: value));
  }

  /// Sets the containerEffects.
  CheckboxStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(CheckboxStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  CheckboxStyler animate(AnimationConfig value) {
    return merge(CheckboxStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  CheckboxStyler variants(List<VariantStyle<CheckboxSpec>> value) {
    return merge(CheckboxStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  CheckboxStyler wrap(WidgetModifierConfig value) {
    return merge(CheckboxStyler(modifier: value));
  }

  /// Sets the widget modifier.
  CheckboxStyler modifier(WidgetModifierConfig value) {
    return merge(CheckboxStyler(modifier: value));
  }

  /// Merges with another [CheckboxStyler].
  @override
  CheckboxStyler merge(CheckboxStyler? other) {
    return CheckboxStyler.create(
      container: MixOps.merge($container, other?.$container),
      indicator: MixOps.merge($indicator, other?.$indicator),
      label: MixOps.merge($label, other?.$label),
      labelSpacing: MixOps.merge($labelSpacing, other?.$labelSpacing),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<CheckboxSpec>] using [context].
  @override
  StyleSpec<CheckboxSpec> resolve(BuildContext context) {
    final spec = CheckboxSpec(
      container: MixOps.resolve(context, $container),
      indicator: MixOps.resolve(context, $indicator),
      label: MixOps.resolve(context, $label),
      labelSpacing: MixOps.resolve(context, $labelSpacing),
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
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('labelSpacing', $labelSpacing))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $indicator,
    $label,
    $labelSpacing,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
