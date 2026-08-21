// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skeleton.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$SkeletonSpec implements Spec<SkeletonSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  Color? get pulseColor;
  Duration? get duration;

  @override
  Type get type => SkeletonSpec;

  @override
  SkeletonSpec copyWith({
    StyleSpec<BoxSpec>? container,
    Color? pulseColor,
    Duration? duration,
  }) {
    return SkeletonSpec(
      container: container ?? this.container,
      pulseColor: pulseColor ?? this.pulseColor,
      duration: duration ?? this.duration,
    );
  }

  @override
  SkeletonSpec lerp(SkeletonSpec? other, double t) {
    return SkeletonSpec(
      container: container.lerp(other?.container, t),
      pulseColor: MixOps.lerp(pulseColor, other?.pulseColor, t),
      duration: MixOps.lerpSnap(duration, other?.duration, t),
    );
  }

  @override
  List<Object?> get props => [container, pulseColor, duration];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SkeletonSpec &&
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
      ..add(ColorProperty('pulseColor', pulseColor))
      ..add(DiagnosticsProperty('duration', duration));
  }
}

@Deprecated(
  'Rename to `_\$SkeletonSpec` and migrate the class declaration to `class SkeletonSpec with _\$SkeletonSpec`. The `_\$SkeletonSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SkeletonSpecMethods = _$SkeletonSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class SkeletonStyler extends MixStyler<SkeletonStyler, SkeletonSpec>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<Color>? $pulseColor;
  final Prop<Duration>? $duration;

  const SkeletonStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<Color>? pulseColor,
    Prop<Duration>? duration,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $pulseColor = pulseColor,
       $duration = duration;

  SkeletonStyler({
    BoxStyler? container,
    Color? pulseColor,
    Duration? duration,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SkeletonSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         pulseColor: Prop.maybe(pulseColor),
         duration: Prop.maybe(duration),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SkeletonStyler.container(BoxStyler value) =>
      SkeletonStyler().container(value);
  factory SkeletonStyler.pulseColor(Color value) =>
      SkeletonStyler().pulseColor(value);
  factory SkeletonStyler.duration(Duration value) =>
      SkeletonStyler().duration(value);

  @override
  Set<String> get $stylerFieldNames => const {
    'container',
    'pulseColor',
    'duration',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the container.
  SkeletonStyler container(BoxStyler value) {
    return merge(SkeletonStyler(container: value));
  }

  /// Sets the pulseColor.
  SkeletonStyler pulseColor(Color value) {
    return merge(SkeletonStyler(pulseColor: value));
  }

  /// Sets the duration.
  SkeletonStyler duration(Duration value) {
    return merge(SkeletonStyler(duration: value));
  }

  /// Sets the animation configuration.
  @override
  SkeletonStyler animate(AnimationConfig value) {
    return merge(SkeletonStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SkeletonStyler variants(List<VariantStyle<SkeletonSpec>> value) {
    return merge(SkeletonStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SkeletonStyler wrap(WidgetModifierConfig value) {
    return merge(SkeletonStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SkeletonStyler modifier(WidgetModifierConfig value) {
    return merge(SkeletonStyler(modifier: value));
  }

  RemixSkeleton call({Key? key, Widget? child, bool loading = true}) {
    return RemixSkeleton(key: key, style: this, child: child, loading: loading);
  }

  /// Merges with another [SkeletonStyler].
  @override
  SkeletonStyler merge(SkeletonStyler? other) {
    return SkeletonStyler.create(
      container: MixOps.merge($container, other?.$container),
      pulseColor: MixOps.merge($pulseColor, other?.$pulseColor),
      duration: MixOps.merge($duration, other?.$duration),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SkeletonSpec>] using [context].
  @override
  StyleSpec<SkeletonSpec> resolve(BuildContext context) {
    final spec = SkeletonSpec(
      container: MixOps.resolve(context, $container),
      pulseColor: MixOps.resolve(context, $pulseColor),
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
      ..add(DiagnosticsProperty('container', $container))
      ..add(DiagnosticsProperty('pulseColor', $pulseColor))
      ..add(DiagnosticsProperty('duration', $duration));
  }

  @override
  List<Object?> get props => [
    $container,
    $pulseColor,
    $duration,
    $animation,
    $modifier,
    $variants,
  ];
}
