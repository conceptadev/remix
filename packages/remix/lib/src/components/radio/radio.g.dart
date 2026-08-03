// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RadioSpec implements Spec<RadioSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get indicator;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => RadioSpec;

  @override
  RadioSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? indicator,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return RadioSpec(
      container: container ?? this.container,
      indicator: indicator ?? this.indicator,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  RadioSpec lerp(RadioSpec? other, double t) {
    return RadioSpec(
      container: container.lerp(other?.container, t),
      indicator: indicator.lerp(other?.indicator, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [container, indicator, containerEffects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RadioSpec &&
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
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$RadioSpec` and migrate the class declaration to `class RadioSpec with _\$RadioSpec`. The `_\$RadioSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RadioSpecMethods = _$RadioSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixRadio].
class FortalRadio<T> extends StatelessWidget {
  const FortalRadio({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.highContrast = false,
    required this.value,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  });

  /// Raised treatment with Radix's classic shadow and gradient layers.
  const FortalRadio.classic({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.value,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  }) : variant = FortalRadioVariant.classic;

  /// Surface treatment with neutral border.
  const FortalRadio.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.value,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  }) : variant = FortalRadioVariant.surface;

  /// Soft accent treatment.
  const FortalRadio.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.value,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  }) : variant = FortalRadioVariant.soft;

  final FortalRadioVariant variant;

  final FortalRadioSize size;

  final bool highContrast;

  final T value;

  final bool enabled;

  final bool toggleable;

  final MouseCursor? mouseCursor;

  final FocusNode? focusNode;

  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return RemixRadio<T>(
      key: this.key,
      style: fortalRadioStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      value: this.value,
      enabled: this.enabled,
      toggleable: this.toggleable,
      mouseCursor: this.mouseCursor,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RadioStyler extends MixStyler<RadioStyler, RadioSpec>
    with RemixBoxStylerMixin<RadioStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $indicator;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const RadioStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? indicator,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $indicator = indicator,
       $containerEffects = containerEffects;

  RadioStyler({
    BoxStyler? container,
    BoxStyler? indicator,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RadioSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         indicator: Prop.maybeMix(indicator),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RadioStyler.container(BoxStyler value) =>
      RadioStyler().container(value);
  factory RadioStyler.indicator(BoxStyler value) =>
      RadioStyler().indicator(value);
  factory RadioStyler.containerEffects(RemixBoxEffectsMix value) =>
      RadioStyler().containerEffects(value);
  factory RadioStyler.alignment(AlignmentGeometry value) =>
      RadioStyler().alignment(value);
  factory RadioStyler.padding(EdgeInsetsGeometryMix value) =>
      RadioStyler().padding(value);
  factory RadioStyler.margin(EdgeInsetsGeometryMix value) =>
      RadioStyler().margin(value);
  factory RadioStyler.constraints(BoxConstraintsMix value) =>
      RadioStyler().constraints(value);
  factory RadioStyler.decoration(DecorationMix value) =>
      RadioStyler().decoration(value);
  factory RadioStyler.foregroundDecoration(DecorationMix value) =>
      RadioStyler().foregroundDecoration(value);
  factory RadioStyler.clipBehavior(Clip value) =>
      RadioStyler().clipBehavior(value);
  factory RadioStyler.color(Color value) => RadioStyler().color(value);
  factory RadioStyler.gradient(GradientMix value) =>
      RadioStyler().gradient(value);
  factory RadioStyler.border(BoxBorderMix value) => RadioStyler().border(value);
  factory RadioStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RadioStyler().borderRadius(value);
  factory RadioStyler.elevation(ElevationShadow value) =>
      RadioStyler().elevation(value);
  factory RadioStyler.shadow(BoxShadowMix value) => RadioStyler().shadow(value);
  factory RadioStyler.shadows(List<BoxShadowMix> value) =>
      RadioStyler().shadows(value);
  factory RadioStyler.width(double value) => RadioStyler().width(value);
  factory RadioStyler.height(double value) => RadioStyler().height(value);
  factory RadioStyler.size(double width, double height) =>
      RadioStyler().size(width, height);
  factory RadioStyler.minWidth(double value) => RadioStyler().minWidth(value);
  factory RadioStyler.maxWidth(double value) => RadioStyler().maxWidth(value);
  factory RadioStyler.minHeight(double value) => RadioStyler().minHeight(value);
  factory RadioStyler.maxHeight(double value) => RadioStyler().maxHeight(value);
  factory RadioStyler.scale(double scale, {Alignment alignment = .center}) =>
      RadioStyler().scale(scale, alignment: alignment);
  factory RadioStyler.rotate(double radians, {Alignment alignment = .center}) =>
      RadioStyler().rotate(radians, alignment: alignment);
  factory RadioStyler.translate(double x, double y, [double z = 0.0]) =>
      RadioStyler().translate(x, y, z);
  factory RadioStyler.skew(double skewX, double skewY) =>
      RadioStyler().skew(skewX, skewY);
  factory RadioStyler.textStyle(TextStyler value) =>
      RadioStyler().textStyle(value);
  factory RadioStyler.image(DecorationImageMix value) =>
      RadioStyler().image(value);
  factory RadioStyler.shape(ShapeBorderMix value) => RadioStyler().shape(value);
  factory RadioStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RadioStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RadioStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RadioStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RadioStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RadioStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RadioStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RadioStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RadioStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RadioStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RadioStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RadioStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RadioStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RadioStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RadioStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RadioStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RadioStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RadioStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RadioStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RadioStyler().transform(value, alignment: alignment);

  RadioStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RadioStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RadioStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RadioStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RadioStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RadioStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RadioStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RadioStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RadioStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RadioStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RadioStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RadioStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RadioStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RadioStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RadioStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RadioStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RadioStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RadioStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RadioStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RadioStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RadioStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RadioStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RadioStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RadioStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RadioStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RadioStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RadioStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RadioStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RadioStyler backgroundImage(
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

  RadioStyler backgroundImageUrl(
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

  RadioStyler backgroundImageAsset(
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

  RadioStyler linearGradient({
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

  RadioStyler radialGradient({
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

  RadioStyler sweepGradient({
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

  RadioStyler foregroundLinearGradient({
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

  RadioStyler foregroundRadialGradient({
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

  RadioStyler foregroundSweepGradient({
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

  RadioStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RadioStyler container(BoxStyler value) {
    return merge(RadioStyler(container: value));
  }

  /// Sets the indicator.
  RadioStyler indicator(BoxStyler value) {
    return merge(RadioStyler(indicator: value));
  }

  /// Sets the containerEffects.
  RadioStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(RadioStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  RadioStyler animate(AnimationConfig value) {
    return merge(RadioStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RadioStyler variants(List<VariantStyle<RadioSpec>> value) {
    return merge(RadioStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RadioStyler wrap(WidgetModifierConfig value) {
    return merge(RadioStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RadioStyler modifier(WidgetModifierConfig value) {
    return merge(RadioStyler(modifier: value));
  }

  /// Merges with another [RadioStyler].
  @override
  RadioStyler merge(RadioStyler? other) {
    return RadioStyler.create(
      container: MixOps.merge($container, other?.$container),
      indicator: MixOps.merge($indicator, other?.$indicator),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RadioSpec>] using [context].
  @override
  StyleSpec<RadioSpec> resolve(BuildContext context) {
    final spec = RadioSpec(
      container: MixOps.resolve(context, $container),
      indicator: MixOps.resolve(context, $indicator),
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
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $indicator,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
