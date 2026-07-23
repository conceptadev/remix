// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spinner.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixSpinnerSpec implements Spec<RemixSpinnerSpec>, Diagnosticable {
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
  Type get type => RemixSpinnerSpec;

  @override
  RemixSpinnerSpec copyWith({
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
    return RemixSpinnerSpec(
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
  RemixSpinnerSpec lerp(RemixSpinnerSpec? other, double t) {
    return RemixSpinnerSpec(
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
        other is RemixSpinnerSpec &&
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
  'Rename to `_\$RemixSpinnerSpec` and migrate the class declaration to `class RemixSpinnerSpec with _\$RemixSpinnerSpec`. The `_\$RemixSpinnerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixSpinnerSpecMethods = _$RemixSpinnerSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixSpinnerStyler
    extends MixStyler<RemixSpinnerStyler, RemixSpinnerSpec> {
  final Prop<double>? $size;
  final Prop<double>? $strokeWidth;
  final Prop<Color>? $indicatorColor;
  final Prop<Color>? $trackColor;
  final Prop<double>? $trackStrokeWidth;
  final Prop<Color>? $color;
  final Prop<double>? $opacity;
  final Prop<Radius>? $leafRadius;
  final Prop<Duration>? $duration;

  const RemixSpinnerStyler.create({
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

  RemixSpinnerStyler({
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
    List<VariantStyle<RemixSpinnerSpec>>? variants,
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

  factory RemixSpinnerStyler.size(double value) =>
      RemixSpinnerStyler().size(value);
  factory RemixSpinnerStyler.strokeWidth(double value) =>
      RemixSpinnerStyler().strokeWidth(value);
  factory RemixSpinnerStyler.indicatorColor(Color value) =>
      RemixSpinnerStyler().indicatorColor(value);
  factory RemixSpinnerStyler.trackColor(Color value) =>
      RemixSpinnerStyler().trackColor(value);
  factory RemixSpinnerStyler.trackStrokeWidth(double value) =>
      RemixSpinnerStyler().trackStrokeWidth(value);
  factory RemixSpinnerStyler.color(Color value) =>
      RemixSpinnerStyler().color(value);
  factory RemixSpinnerStyler.opacity(double value) =>
      RemixSpinnerStyler().opacity(value);
  factory RemixSpinnerStyler.leafRadius(Radius value) =>
      RemixSpinnerStyler().leafRadius(value);
  factory RemixSpinnerStyler.duration(Duration value) =>
      RemixSpinnerStyler().duration(value);

  /// Sets the size.
  RemixSpinnerStyler size(double value) {
    return merge(RemixSpinnerStyler(size: value));
  }

  /// Sets the strokeWidth.
  RemixSpinnerStyler strokeWidth(double value) {
    return merge(RemixSpinnerStyler(strokeWidth: value));
  }

  /// Sets the indicatorColor.
  RemixSpinnerStyler indicatorColor(Color value) {
    return merge(RemixSpinnerStyler(indicatorColor: value));
  }

  /// Sets the trackColor.
  RemixSpinnerStyler trackColor(Color value) {
    return merge(RemixSpinnerStyler(trackColor: value));
  }

  /// Sets the trackStrokeWidth.
  RemixSpinnerStyler trackStrokeWidth(double value) {
    return merge(RemixSpinnerStyler(trackStrokeWidth: value));
  }

  /// Sets the color.
  RemixSpinnerStyler color(Color value) {
    return merge(RemixSpinnerStyler(color: value));
  }

  /// Sets the opacity.
  RemixSpinnerStyler opacity(double value) {
    return merge(RemixSpinnerStyler(opacity: value));
  }

  /// Sets the leafRadius.
  RemixSpinnerStyler leafRadius(Radius value) {
    return merge(RemixSpinnerStyler(leafRadius: value));
  }

  /// Sets the duration.
  RemixSpinnerStyler duration(Duration value) {
    return merge(RemixSpinnerStyler(duration: value));
  }

  /// Sets the animation configuration.
  @override
  RemixSpinnerStyler animate(AnimationConfig value) {
    return merge(RemixSpinnerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixSpinnerStyler variants(List<VariantStyle<RemixSpinnerSpec>> value) {
    return merge(RemixSpinnerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixSpinnerStyler wrap(WidgetModifierConfig value) {
    return merge(RemixSpinnerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixSpinnerStyler modifier(WidgetModifierConfig value) {
    return merge(RemixSpinnerStyler(modifier: value));
  }

  /// Merges with another [RemixSpinnerStyler].
  @override
  RemixSpinnerStyler merge(RemixSpinnerStyler? other) {
    return RemixSpinnerStyler.create(
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

  /// Resolves to [StyleSpec<RemixSpinnerSpec>] using [context].
  @override
  StyleSpec<RemixSpinnerSpec> resolve(BuildContext context) {
    final spec = RemixSpinnerSpec(
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
