// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spinner.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixSpinnerSpec implements Spec<RemixSpinnerSpec>, Diagnosticable {
  double? get size;
  Color? get color;
  double? get opacity;
  Radius? get leafRadius;
  Duration? get duration;

  @override
  Type get type => RemixSpinnerSpec;

  @override
  RemixSpinnerSpec copyWith({
    double? size,
    Color? color,
    double? opacity,
    Radius? leafRadius,
    Duration? duration,
  }) {
    return RemixSpinnerSpec(
      size: size ?? this.size,
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
      color: MixOps.lerp(color, other?.color, t),
      opacity: MixOps.lerp(opacity, other?.opacity, t),
      leafRadius: MixOps.lerpSnap(leafRadius, other?.leafRadius, t),
      duration: MixOps.lerpSnap(duration, other?.duration, t),
    );
  }

  @override
  List<Object?> get props => [size, color, opacity, leafRadius, duration];

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
  final Prop<Color>? $color;
  final Prop<double>? $opacity;
  final Prop<Radius>? $leafRadius;
  final Prop<Duration>? $duration;

  const RemixSpinnerStyler.create({
    Prop<double>? size,
    Prop<Color>? color,
    Prop<double>? opacity,
    Prop<Radius>? leafRadius,
    Prop<Duration>? duration,
    super.variants,
    super.modifier,
    super.animation,
  }) : $size = size,
       $color = color,
       $opacity = opacity,
       $leafRadius = leafRadius,
       $duration = duration;

  RemixSpinnerStyler({
    double? size,
    Color? color,
    double? opacity,
    Radius? leafRadius,
    Duration? duration,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixSpinnerSpec>>? variants,
  }) : this.create(
         size: Prop.maybe(size),
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
      ..add(DiagnosticsProperty('color', $color))
      ..add(DiagnosticsProperty('opacity', $opacity))
      ..add(DiagnosticsProperty('leafRadius', $leafRadius))
      ..add(DiagnosticsProperty('duration', $duration));
  }

  @override
  List<Object?> get props => [
    $size,
    $color,
    $opacity,
    $leafRadius,
    $duration,
    $animation,
    $modifier,
    $variants,
  ];
}
