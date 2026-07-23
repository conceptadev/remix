// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tooltip.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixTooltipSpec implements Spec<RemixTooltipSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<TextSpec> get label;
  Duration? get waitDuration;
  Duration? get showDuration;
  Duration? get dismissDuration;
  Color? get arrowColor;

  @override
  Type get type => RemixTooltipSpec;

  @override
  RemixTooltipSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    Duration? waitDuration,
    Duration? showDuration,
    Duration? dismissDuration,
    Color? arrowColor,
  }) {
    return RemixTooltipSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      waitDuration: waitDuration ?? this.waitDuration,
      showDuration: showDuration ?? this.showDuration,
      dismissDuration: dismissDuration ?? this.dismissDuration,
      arrowColor: arrowColor ?? this.arrowColor,
    );
  }

  @override
  RemixTooltipSpec lerp(RemixTooltipSpec? other, double t) {
    return RemixTooltipSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      waitDuration: MixOps.lerpSnap(waitDuration, other?.waitDuration, t),
      showDuration: MixOps.lerpSnap(showDuration, other?.showDuration, t),
      dismissDuration: MixOps.lerpSnap(
        dismissDuration,
        other?.dismissDuration,
        t,
      ),
      arrowColor: MixOps.lerp(arrowColor, other?.arrowColor, t),
    );
  }

  @override
  List<Object?> get props => [
    container,
    label,
    waitDuration,
    showDuration,
    dismissDuration,
    arrowColor,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixTooltipSpec &&
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
      ..add(DiagnosticsProperty('waitDuration', waitDuration))
      ..add(DiagnosticsProperty('showDuration', showDuration))
      ..add(DiagnosticsProperty('dismissDuration', dismissDuration))
      ..add(ColorProperty('arrowColor', arrowColor));
  }
}

@Deprecated(
  'Rename to `_\$RemixTooltipSpec` and migrate the class declaration to `class RemixTooltipSpec with _\$RemixTooltipSpec`. The `_\$RemixTooltipSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixTooltipSpecMethods = _$RemixTooltipSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixTooltipStyler extends MixStyler<RemixTooltipStyler, RemixTooltipSpec>
    with RemixBoxStylerMixin<RemixTooltipStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<Duration>? $waitDuration;
  final Prop<Duration>? $showDuration;
  final Prop<Duration>? $dismissDuration;
  final Prop<Color>? $arrowColor;

  const RemixTooltipStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<Duration>? waitDuration,
    Prop<Duration>? showDuration,
    Prop<Duration>? dismissDuration,
    Prop<Color>? arrowColor,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $waitDuration = waitDuration,
       $showDuration = showDuration,
       $dismissDuration = dismissDuration,
       $arrowColor = arrowColor;

  RemixTooltipStyler({
    BoxStyler? container,
    TextStyler? label,
    Duration? waitDuration,
    Duration? showDuration,
    Duration? dismissDuration,
    Color? arrowColor,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixTooltipSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         waitDuration: Prop.maybe(waitDuration),
         showDuration: Prop.maybe(showDuration),
         dismissDuration: Prop.maybe(dismissDuration),
         arrowColor: Prop.maybe(arrowColor),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixTooltipStyler.container(BoxStyler value) =>
      RemixTooltipStyler().container(value);
  factory RemixTooltipStyler.label(TextStyler value) =>
      RemixTooltipStyler().label(value);
  factory RemixTooltipStyler.waitDuration(Duration value) =>
      RemixTooltipStyler().waitDuration(value);
  factory RemixTooltipStyler.showDuration(Duration value) =>
      RemixTooltipStyler().showDuration(value);
  factory RemixTooltipStyler.dismissDuration(Duration value) =>
      RemixTooltipStyler().dismissDuration(value);
  factory RemixTooltipStyler.arrowColor(Color value) =>
      RemixTooltipStyler().arrowColor(value);
  factory RemixTooltipStyler.alignment(AlignmentGeometry value) =>
      RemixTooltipStyler().alignment(value);
  factory RemixTooltipStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixTooltipStyler().padding(value);
  factory RemixTooltipStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixTooltipStyler().margin(value);
  factory RemixTooltipStyler.constraints(BoxConstraintsMix value) =>
      RemixTooltipStyler().constraints(value);
  factory RemixTooltipStyler.decoration(DecorationMix value) =>
      RemixTooltipStyler().decoration(value);
  factory RemixTooltipStyler.foregroundDecoration(DecorationMix value) =>
      RemixTooltipStyler().foregroundDecoration(value);
  factory RemixTooltipStyler.clipBehavior(Clip value) =>
      RemixTooltipStyler().clipBehavior(value);
  factory RemixTooltipStyler.color(Color value) =>
      RemixTooltipStyler().color(value);
  factory RemixTooltipStyler.gradient(GradientMix value) =>
      RemixTooltipStyler().gradient(value);
  factory RemixTooltipStyler.border(BoxBorderMix value) =>
      RemixTooltipStyler().border(value);
  factory RemixTooltipStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixTooltipStyler().borderRadius(value);
  factory RemixTooltipStyler.elevation(ElevationShadow value) =>
      RemixTooltipStyler().elevation(value);
  factory RemixTooltipStyler.shadow(BoxShadowMix value) =>
      RemixTooltipStyler().shadow(value);
  factory RemixTooltipStyler.shadows(List<BoxShadowMix> value) =>
      RemixTooltipStyler().shadows(value);
  factory RemixTooltipStyler.width(double value) =>
      RemixTooltipStyler().width(value);
  factory RemixTooltipStyler.height(double value) =>
      RemixTooltipStyler().height(value);
  factory RemixTooltipStyler.size(double width, double height) =>
      RemixTooltipStyler().size(width, height);
  factory RemixTooltipStyler.minWidth(double value) =>
      RemixTooltipStyler().minWidth(value);
  factory RemixTooltipStyler.maxWidth(double value) =>
      RemixTooltipStyler().maxWidth(value);
  factory RemixTooltipStyler.minHeight(double value) =>
      RemixTooltipStyler().minHeight(value);
  factory RemixTooltipStyler.maxHeight(double value) =>
      RemixTooltipStyler().maxHeight(value);
  factory RemixTooltipStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixTooltipStyler().scale(scale, alignment: alignment);
  factory RemixTooltipStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixTooltipStyler().rotate(radians, alignment: alignment);
  factory RemixTooltipStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixTooltipStyler().translate(x, y, z);
  factory RemixTooltipStyler.skew(double skewX, double skewY) =>
      RemixTooltipStyler().skew(skewX, skewY);
  factory RemixTooltipStyler.textStyle(TextStyler value) =>
      RemixTooltipStyler().textStyle(value);
  factory RemixTooltipStyler.image(DecorationImageMix value) =>
      RemixTooltipStyler().image(value);
  factory RemixTooltipStyler.shape(ShapeBorderMix value) =>
      RemixTooltipStyler().shape(value);
  factory RemixTooltipStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTooltipStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTooltipStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTooltipStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTooltipStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTooltipStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTooltipStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTooltipStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTooltipStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTooltipStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTooltipStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTooltipStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTooltipStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTooltipStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTooltipStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTooltipStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTooltipStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTooltipStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTooltipStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixTooltipStyler().transform(value, alignment: alignment);

  RemixTooltipStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixTooltipStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixTooltipStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixTooltipStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixTooltipStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixTooltipStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixTooltipStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixTooltipStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixTooltipStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixTooltipStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixTooltipStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixTooltipStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixTooltipStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixTooltipStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixTooltipStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixTooltipStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixTooltipStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixTooltipStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixTooltipStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixTooltipStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixTooltipStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixTooltipStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixTooltipStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixTooltipStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixTooltipStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixTooltipStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixTooltipStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixTooltipStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixTooltipStyler backgroundImage(
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

  RemixTooltipStyler backgroundImageUrl(
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

  RemixTooltipStyler backgroundImageAsset(
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

  RemixTooltipStyler linearGradient({
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

  RemixTooltipStyler radialGradient({
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

  RemixTooltipStyler sweepGradient({
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

  RemixTooltipStyler foregroundLinearGradient({
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

  RemixTooltipStyler foregroundRadialGradient({
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

  RemixTooltipStyler foregroundSweepGradient({
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

  RemixTooltipStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixTooltipStyler container(BoxStyler value) {
    return merge(RemixTooltipStyler(container: value));
  }

  /// Sets the label.
  RemixTooltipStyler label(TextStyler value) {
    return merge(RemixTooltipStyler(label: value));
  }

  /// Sets the waitDuration.
  RemixTooltipStyler waitDuration(Duration value) {
    return merge(RemixTooltipStyler(waitDuration: value));
  }

  /// Sets the showDuration.
  RemixTooltipStyler showDuration(Duration value) {
    return merge(RemixTooltipStyler(showDuration: value));
  }

  /// Sets the dismissDuration.
  RemixTooltipStyler dismissDuration(Duration value) {
    return merge(RemixTooltipStyler(dismissDuration: value));
  }

  /// Sets the arrowColor.
  RemixTooltipStyler arrowColor(Color value) {
    return merge(RemixTooltipStyler(arrowColor: value));
  }

  /// Sets the animation configuration.
  @override
  RemixTooltipStyler animate(AnimationConfig value) {
    return merge(RemixTooltipStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixTooltipStyler variants(List<VariantStyle<RemixTooltipSpec>> value) {
    return merge(RemixTooltipStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixTooltipStyler wrap(WidgetModifierConfig value) {
    return merge(RemixTooltipStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixTooltipStyler modifier(WidgetModifierConfig value) {
    return merge(RemixTooltipStyler(modifier: value));
  }

  /// Merges with another [RemixTooltipStyler].
  @override
  RemixTooltipStyler merge(RemixTooltipStyler? other) {
    return RemixTooltipStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      waitDuration: MixOps.merge($waitDuration, other?.$waitDuration),
      showDuration: MixOps.merge($showDuration, other?.$showDuration),
      dismissDuration: MixOps.merge($dismissDuration, other?.$dismissDuration),
      arrowColor: MixOps.merge($arrowColor, other?.$arrowColor),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixTooltipSpec>] using [context].
  @override
  StyleSpec<RemixTooltipSpec> resolve(BuildContext context) {
    final spec = RemixTooltipSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      waitDuration: MixOps.resolve(context, $waitDuration),
      showDuration: MixOps.resolve(context, $showDuration),
      dismissDuration: MixOps.resolve(context, $dismissDuration),
      arrowColor: MixOps.resolve(context, $arrowColor),
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
      ..add(DiagnosticsProperty('waitDuration', $waitDuration))
      ..add(DiagnosticsProperty('showDuration', $showDuration))
      ..add(DiagnosticsProperty('dismissDuration', $dismissDuration))
      ..add(DiagnosticsProperty('arrowColor', $arrowColor));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $waitDuration,
    $showDuration,
    $dismissDuration,
    $arrowColor,
    $animation,
    $modifier,
    $variants,
  ];
}
