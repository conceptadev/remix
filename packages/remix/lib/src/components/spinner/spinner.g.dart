// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spinner.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$SpinnerSpec implements Spec<SpinnerSpec>, Diagnosticable {
  double? get size;
  double? get strokeWidth;
  Color? get indicatorColor;
  Color? get trackColor;
  double? get trackStrokeWidth;
  Color? get color;
  double? get opacity;
  Radius? get leafRadius;
  Duration? get duration;

  @override
  Type get type => SpinnerSpec;

  @override
  SpinnerSpec copyWith({
    double? size,
    double? strokeWidth,
    Color? indicatorColor,
    Color? trackColor,
    double? trackStrokeWidth,
    Color? color,
    double? opacity,
    Radius? leafRadius,
    Duration? duration,
  }) {
    return SpinnerSpec(
      size: size ?? this.size,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      trackColor: trackColor ?? this.trackColor,
      trackStrokeWidth: trackStrokeWidth ?? this.trackStrokeWidth,
      color: color ?? this.color,
      opacity: opacity ?? this.opacity,
      leafRadius: leafRadius ?? this.leafRadius,
      duration: duration ?? this.duration,
    );
  }

  @override
  SpinnerSpec lerp(SpinnerSpec? other, double t) {
    return SpinnerSpec(
      size: MixOps.lerp(size, other?.size, t),
      strokeWidth: MixOps.lerp(strokeWidth, other?.strokeWidth, t),
      indicatorColor: MixOps.lerp(indicatorColor, other?.indicatorColor, t),
      trackColor: MixOps.lerp(trackColor, other?.trackColor, t),
      trackStrokeWidth: MixOps.lerp(
        trackStrokeWidth,
        other?.trackStrokeWidth,
        t,
      ),
      color: MixOps.lerp(color, other?.color, t),
      opacity: MixOps.lerp(opacity, other?.opacity, t),
      leafRadius: MixOps.lerpSnap(leafRadius, other?.leafRadius, t),
      duration: MixOps.lerpSnap(duration, other?.duration, t),
    );
  }

  @override
  List<Object?> get props => [
    size,
    strokeWidth,
    indicatorColor,
    trackColor,
    trackStrokeWidth,
    color,
    opacity,
    leafRadius,
    duration,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpinnerSpec &&
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
      ..add(DoubleProperty('size', size))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(ColorProperty('indicatorColor', indicatorColor))
      ..add(ColorProperty('trackColor', trackColor))
      ..add(DoubleProperty('trackStrokeWidth', trackStrokeWidth))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('opacity', opacity))
      ..add(DiagnosticsProperty('leafRadius', leafRadius))
      ..add(DiagnosticsProperty('duration', duration));
  }
}

@Deprecated(
  'Rename to `_\$SpinnerSpec` and migrate the class declaration to `class SpinnerSpec with _\$SpinnerSpec`. The `_\$SpinnerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SpinnerSpecMethods = _$SpinnerSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class SpinnerStyler extends MixStyler<SpinnerStyler, SpinnerSpec> {
  final Prop<double>? $size;
  final Prop<double>? $strokeWidth;
  final Prop<Color>? $indicatorColor;
  final Prop<Color>? $trackColor;
  final Prop<double>? $trackStrokeWidth;
  final Prop<Color>? $color;
  final Prop<double>? $opacity;
  final Prop<Radius>? $leafRadius;
  final Prop<Duration>? $duration;

  const SpinnerStyler.create({
    Prop<double>? size,
    Prop<double>? strokeWidth,
    Prop<Color>? indicatorColor,
    Prop<Color>? trackColor,
    Prop<double>? trackStrokeWidth,
    Prop<Color>? color,
    Prop<double>? opacity,
    Prop<Radius>? leafRadius,
    Prop<Duration>? duration,
    super.variants,
    super.modifier,
    super.animation,
  }) : $size = size,
       $strokeWidth = strokeWidth,
       $indicatorColor = indicatorColor,
       $trackColor = trackColor,
       $trackStrokeWidth = trackStrokeWidth,
       $color = color,
       $opacity = opacity,
       $leafRadius = leafRadius,
       $duration = duration;

  SpinnerStyler({
    double? size,
    double? strokeWidth,
    Color? indicatorColor,
    Color? trackColor,
    double? trackStrokeWidth,
    Color? color,
    double? opacity,
    Radius? leafRadius,
    Duration? duration,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SpinnerSpec>>? variants,
  }) : this.create(
         size: Prop.maybe(size),
         strokeWidth: Prop.maybe(strokeWidth),
         indicatorColor: Prop.maybe(indicatorColor),
         trackColor: Prop.maybe(trackColor),
         trackStrokeWidth: Prop.maybe(trackStrokeWidth),
         color: Prop.maybe(color),
         opacity: Prop.maybe(opacity),
         leafRadius: Prop.maybe(leafRadius),
         duration: Prop.maybe(duration),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SpinnerStyler.size(double value) => SpinnerStyler().size(value);
  factory SpinnerStyler.strokeWidth(double value) =>
      SpinnerStyler().strokeWidth(value);
  factory SpinnerStyler.indicatorColor(Color value) =>
      SpinnerStyler().indicatorColor(value);
  factory SpinnerStyler.trackColor(Color value) =>
      SpinnerStyler().trackColor(value);
  factory SpinnerStyler.trackStrokeWidth(double value) =>
      SpinnerStyler().trackStrokeWidth(value);
  factory SpinnerStyler.color(Color value) => SpinnerStyler().color(value);
  factory SpinnerStyler.opacity(double value) => SpinnerStyler().opacity(value);
  factory SpinnerStyler.leafRadius(Radius value) =>
      SpinnerStyler().leafRadius(value);
  factory SpinnerStyler.duration(Duration value) =>
      SpinnerStyler().duration(value);

  /// Sets the size.
  SpinnerStyler size(double value) {
    return merge(SpinnerStyler(size: value));
  }

  /// Sets the strokeWidth.
  SpinnerStyler strokeWidth(double value) {
    return merge(SpinnerStyler(strokeWidth: value));
  }

  /// Sets the indicatorColor.
  SpinnerStyler indicatorColor(Color value) {
    return merge(SpinnerStyler(indicatorColor: value));
  }

  /// Sets the trackColor.
  SpinnerStyler trackColor(Color value) {
    return merge(SpinnerStyler(trackColor: value));
  }

  /// Sets the trackStrokeWidth.
  SpinnerStyler trackStrokeWidth(double value) {
    return merge(SpinnerStyler(trackStrokeWidth: value));
  }

  /// Sets the color.
  SpinnerStyler color(Color value) {
    return merge(SpinnerStyler(color: value));
  }

  /// Sets the opacity.
  SpinnerStyler opacity(double value) {
    return merge(SpinnerStyler(opacity: value));
  }

  /// Sets the leafRadius.
  SpinnerStyler leafRadius(Radius value) {
    return merge(SpinnerStyler(leafRadius: value));
  }

  /// Sets the duration.
  SpinnerStyler duration(Duration value) {
    return merge(SpinnerStyler(duration: value));
  }

  /// Sets the animation configuration.
  @override
  SpinnerStyler animate(AnimationConfig value) {
    return merge(SpinnerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SpinnerStyler variants(List<VariantStyle<SpinnerSpec>> value) {
    return merge(SpinnerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SpinnerStyler wrap(WidgetModifierConfig value) {
    return merge(SpinnerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SpinnerStyler modifier(WidgetModifierConfig value) {
    return merge(SpinnerStyler(modifier: value));
  }

  RemixSpinner call({
    Key? key,
    String? semanticsLabel,
    String? semanticsValue,
  }) {
    return RemixSpinner(
      key: key,
      style: this,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
    );
  }

  /// Merges with another [SpinnerStyler].
  @override
  SpinnerStyler merge(SpinnerStyler? other) {
    return SpinnerStyler.create(
      size: MixOps.merge($size, other?.$size),
      strokeWidth: MixOps.merge($strokeWidth, other?.$strokeWidth),
      indicatorColor: MixOps.merge($indicatorColor, other?.$indicatorColor),
      trackColor: MixOps.merge($trackColor, other?.$trackColor),
      trackStrokeWidth: MixOps.merge(
        $trackStrokeWidth,
        other?.$trackStrokeWidth,
      ),
      color: MixOps.merge($color, other?.$color),
      opacity: MixOps.merge($opacity, other?.$opacity),
      leafRadius: MixOps.merge($leafRadius, other?.$leafRadius),
      duration: MixOps.merge($duration, other?.$duration),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SpinnerSpec>] using [context].
  @override
  StyleSpec<SpinnerSpec> resolve(BuildContext context) {
    final spec = SpinnerSpec(
      size: MixOps.resolve(context, $size),
      strokeWidth: MixOps.resolve(context, $strokeWidth),
      indicatorColor: MixOps.resolve(context, $indicatorColor),
      trackColor: MixOps.resolve(context, $trackColor),
      trackStrokeWidth: MixOps.resolve(context, $trackStrokeWidth),
      color: MixOps.resolve(context, $color),
      opacity: MixOps.resolve(context, $opacity),
      leafRadius: MixOps.resolve(context, $leafRadius),
      duration: MixOps.resolve(context, $duration),
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
      ..add(DiagnosticsProperty('size', $size))
      ..add(DiagnosticsProperty('strokeWidth', $strokeWidth))
      ..add(DiagnosticsProperty('indicatorColor', $indicatorColor))
      ..add(DiagnosticsProperty('trackColor', $trackColor))
      ..add(DiagnosticsProperty('trackStrokeWidth', $trackStrokeWidth))
      ..add(DiagnosticsProperty('color', $color))
      ..add(DiagnosticsProperty('opacity', $opacity))
      ..add(DiagnosticsProperty('leafRadius', $leafRadius))
      ..add(DiagnosticsProperty('duration', $duration));
  }

  @override
  List<Object?> get props => [
    $size,
    $strokeWidth,
    $indicatorColor,
    $trackColor,
    $trackStrokeWidth,
    $color,
    $opacity,
    $leafRadius,
    $duration,
    $animation,
    $modifier,
    $variants,
  ];
}
