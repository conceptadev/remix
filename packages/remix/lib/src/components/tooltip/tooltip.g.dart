// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tooltip.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$TooltipSpec implements Spec<TooltipSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<TextSpec> get label;
  Duration? get waitDuration;
  Duration? get showDuration;
  Duration? get dismissDuration;

  @override
  Type get type => TooltipSpec;

  @override
  TooltipSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    Duration? waitDuration,
    Duration? showDuration,
    Duration? dismissDuration,
  }) {
    return TooltipSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      waitDuration: waitDuration ?? this.waitDuration,
      showDuration: showDuration ?? this.showDuration,
      dismissDuration: dismissDuration ?? this.dismissDuration,
    );
  }

  @override
  TooltipSpec lerp(TooltipSpec? other, double t) {
    return TooltipSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      waitDuration: MixOps.lerpSnap(waitDuration, other?.waitDuration, t),
      showDuration: MixOps.lerpSnap(showDuration, other?.showDuration, t),
      dismissDuration: MixOps.lerpSnap(
        dismissDuration,
        other?.dismissDuration,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [
    container,
    label,
    waitDuration,
    showDuration,
    dismissDuration,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TooltipSpec &&
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
      ..add(DiagnosticsProperty('dismissDuration', dismissDuration));
  }
}

@Deprecated(
  'Rename to `_\$TooltipSpec` and migrate the class declaration to `class TooltipSpec with _\$TooltipSpec`. The `_\$TooltipSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$TooltipSpecMethods = _$TooltipSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixTooltip].
class FortalTooltip extends StatelessWidget {
  const FortalTooltip({
    super.key,
    required this.tooltipChild,
    required this.child,
    this.tooltipSemantics,
    this.positioning = const OverlayPositionConfig(),
  });

  final Widget tooltipChild;

  final Widget child;

  final String? tooltipSemantics;

  final OverlayPositionConfig positioning;

  @override
  Widget build(BuildContext context) {
    return RemixTooltip(
      key: this.key,
      style: fortalTooltipStyle(),
      tooltipChild: this.tooltipChild,
      child: this.child,
      tooltipSemantics: this.tooltipSemantics,
      positioning: this.positioning,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class TooltipStyler extends MixStyler<TooltipStyler, TooltipSpec>
    with RemixBoxStylerMixin<TooltipStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<Duration>? $waitDuration;
  final Prop<Duration>? $showDuration;
  final Prop<Duration>? $dismissDuration;

  const TooltipStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<Duration>? waitDuration,
    Prop<Duration>? showDuration,
    Prop<Duration>? dismissDuration,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $waitDuration = waitDuration,
       $showDuration = showDuration,
       $dismissDuration = dismissDuration;

  TooltipStyler({
    BoxStyler? container,
    TextStyler? label,
    Duration? waitDuration,
    Duration? showDuration,
    Duration? dismissDuration,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<TooltipSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         waitDuration: Prop.maybe(waitDuration),
         showDuration: Prop.maybe(showDuration),
         dismissDuration: Prop.maybe(dismissDuration),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory TooltipStyler.container(BoxStyler value) =>
      TooltipStyler().container(value);
  factory TooltipStyler.label(TextStyler value) => TooltipStyler().label(value);
  factory TooltipStyler.waitDuration(Duration value) =>
      TooltipStyler().waitDuration(value);
  factory TooltipStyler.showDuration(Duration value) =>
      TooltipStyler().showDuration(value);
  factory TooltipStyler.dismissDuration(Duration value) =>
      TooltipStyler().dismissDuration(value);
  factory TooltipStyler.alignment(AlignmentGeometry value) =>
      TooltipStyler().alignment(value);
  factory TooltipStyler.padding(EdgeInsetsGeometryMix value) =>
      TooltipStyler().padding(value);
  factory TooltipStyler.margin(EdgeInsetsGeometryMix value) =>
      TooltipStyler().margin(value);
  factory TooltipStyler.constraints(BoxConstraintsMix value) =>
      TooltipStyler().constraints(value);
  factory TooltipStyler.decoration(DecorationMix value) =>
      TooltipStyler().decoration(value);
  factory TooltipStyler.foregroundDecoration(DecorationMix value) =>
      TooltipStyler().foregroundDecoration(value);
  factory TooltipStyler.clipBehavior(Clip value) =>
      TooltipStyler().clipBehavior(value);
  factory TooltipStyler.color(Color value) => TooltipStyler().color(value);
  factory TooltipStyler.gradient(GradientMix value) =>
      TooltipStyler().gradient(value);
  factory TooltipStyler.border(BoxBorderMix value) =>
      TooltipStyler().border(value);
  factory TooltipStyler.borderRadius(BorderRadiusGeometryMix value) =>
      TooltipStyler().borderRadius(value);
  factory TooltipStyler.elevation(ElevationShadow value) =>
      TooltipStyler().elevation(value);
  factory TooltipStyler.shadow(BoxShadowMix value) =>
      TooltipStyler().shadow(value);
  factory TooltipStyler.shadows(List<BoxShadowMix> value) =>
      TooltipStyler().shadows(value);
  factory TooltipStyler.width(double value) => TooltipStyler().width(value);
  factory TooltipStyler.height(double value) => TooltipStyler().height(value);
  factory TooltipStyler.size(double width, double height) =>
      TooltipStyler().size(width, height);
  factory TooltipStyler.minWidth(double value) =>
      TooltipStyler().minWidth(value);
  factory TooltipStyler.maxWidth(double value) =>
      TooltipStyler().maxWidth(value);
  factory TooltipStyler.minHeight(double value) =>
      TooltipStyler().minHeight(value);
  factory TooltipStyler.maxHeight(double value) =>
      TooltipStyler().maxHeight(value);
  factory TooltipStyler.scale(double scale, {Alignment alignment = .center}) =>
      TooltipStyler().scale(scale, alignment: alignment);
  factory TooltipStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => TooltipStyler().rotate(radians, alignment: alignment);
  factory TooltipStyler.translate(double x, double y, [double z = 0.0]) =>
      TooltipStyler().translate(x, y, z);
  factory TooltipStyler.skew(double skewX, double skewY) =>
      TooltipStyler().skew(skewX, skewY);
  factory TooltipStyler.textStyle(TextStyler value) =>
      TooltipStyler().textStyle(value);
  factory TooltipStyler.image(DecorationImageMix value) =>
      TooltipStyler().image(value);
  factory TooltipStyler.shape(ShapeBorderMix value) =>
      TooltipStyler().shape(value);
  factory TooltipStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TooltipStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TooltipStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TooltipStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TooltipStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TooltipStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TooltipStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TooltipStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TooltipStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TooltipStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TooltipStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TooltipStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TooltipStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TooltipStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TooltipStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TooltipStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TooltipStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TooltipStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TooltipStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => TooltipStyler().transform(value, alignment: alignment);

  TooltipStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  TooltipStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  TooltipStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  TooltipStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  TooltipStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  TooltipStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  TooltipStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  TooltipStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  TooltipStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  TooltipStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  TooltipStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  TooltipStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  TooltipStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  TooltipStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  TooltipStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  TooltipStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  TooltipStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  TooltipStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  TooltipStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  TooltipStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  TooltipStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  TooltipStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  TooltipStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  TooltipStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  TooltipStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  TooltipStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  TooltipStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  TooltipStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  TooltipStyler backgroundImage(
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

  TooltipStyler backgroundImageUrl(
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

  TooltipStyler backgroundImageAsset(
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

  TooltipStyler linearGradient({
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

  TooltipStyler radialGradient({
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

  TooltipStyler sweepGradient({
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

  TooltipStyler foregroundLinearGradient({
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

  TooltipStyler foregroundRadialGradient({
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

  TooltipStyler foregroundSweepGradient({
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

  TooltipStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  TooltipStyler container(BoxStyler value) {
    return merge(TooltipStyler(container: value));
  }

  /// Sets the label.
  TooltipStyler label(TextStyler value) {
    return merge(TooltipStyler(label: value));
  }

  /// Sets the waitDuration.
  TooltipStyler waitDuration(Duration value) {
    return merge(TooltipStyler(waitDuration: value));
  }

  /// Sets the showDuration.
  TooltipStyler showDuration(Duration value) {
    return merge(TooltipStyler(showDuration: value));
  }

  /// Sets the dismissDuration.
  TooltipStyler dismissDuration(Duration value) {
    return merge(TooltipStyler(dismissDuration: value));
  }

  /// Sets the animation configuration.
  @override
  TooltipStyler animate(AnimationConfig value) {
    return merge(TooltipStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  TooltipStyler variants(List<VariantStyle<TooltipSpec>> value) {
    return merge(TooltipStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  TooltipStyler wrap(WidgetModifierConfig value) {
    return merge(TooltipStyler(modifier: value));
  }

  /// Sets the widget modifier.
  TooltipStyler modifier(WidgetModifierConfig value) {
    return merge(TooltipStyler(modifier: value));
  }

  /// Merges with another [TooltipStyler].
  @override
  TooltipStyler merge(TooltipStyler? other) {
    return TooltipStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      waitDuration: MixOps.merge($waitDuration, other?.$waitDuration),
      showDuration: MixOps.merge($showDuration, other?.$showDuration),
      dismissDuration: MixOps.merge($dismissDuration, other?.$dismissDuration),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<TooltipSpec>] using [context].
  @override
  StyleSpec<TooltipSpec> resolve(BuildContext context) {
    final spec = TooltipSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      waitDuration: MixOps.resolve(context, $waitDuration),
      showDuration: MixOps.resolve(context, $showDuration),
      dismissDuration: MixOps.resolve(context, $dismissDuration),
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
      ..add(DiagnosticsProperty('dismissDuration', $dismissDuration));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $waitDuration,
    $showDuration,
    $dismissDuration,
    $animation,
    $modifier,
    $variants,
  ];
}
