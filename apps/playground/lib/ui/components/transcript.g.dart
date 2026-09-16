// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$PlaygroundTranscriptSpec
    implements Spec<PlaygroundTranscriptSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get viewport;
  StyleSpec<BoxSpec> get item;
  double? get spacing;

  @override
  Type get type => PlaygroundTranscriptSpec;

  @override
  PlaygroundTranscriptSpec copyWith({
    StyleSpec<BoxSpec>? viewport,
    StyleSpec<BoxSpec>? item,
    double? spacing,
  }) {
    return PlaygroundTranscriptSpec(
      viewport: viewport ?? this.viewport,
      item: item ?? this.item,
      spacing: spacing ?? this.spacing,
    );
  }

  @override
  PlaygroundTranscriptSpec lerp(PlaygroundTranscriptSpec? other, double t) {
    return PlaygroundTranscriptSpec(
      viewport: viewport.lerp(other?.viewport, t),
      item: item.lerp(other?.item, t),
      spacing: MixOps.lerp(spacing, other?.spacing, t),
    );
  }

  @override
  List<Object?> get props => [viewport, item, spacing];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlaygroundTranscriptSpec &&
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
      ..add(DiagnosticsProperty('viewport', viewport))
      ..add(DiagnosticsProperty('item', item))
      ..add(DoubleProperty('spacing', spacing));
  }
}

@Deprecated(
  'Rename to `_\$PlaygroundTranscriptSpec` and migrate the class declaration to `class PlaygroundTranscriptSpec with _\$PlaygroundTranscriptSpec`. The `_\$PlaygroundTranscriptSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$PlaygroundTranscriptSpecMethods = _$PlaygroundTranscriptSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class PlaygroundTranscriptStyler
    extends MixStyler<PlaygroundTranscriptStyler, PlaygroundTranscriptSpec>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<BoxSpec>>? $viewport;
  final Prop<StyleSpec<BoxSpec>>? $item;
  final Prop<double>? $spacing;

  const PlaygroundTranscriptStyler.create({
    Prop<StyleSpec<BoxSpec>>? viewport,
    Prop<StyleSpec<BoxSpec>>? item,
    Prop<double>? spacing,
    super.variants,
    super.modifier,
    super.animation,
  }) : $viewport = viewport,
       $item = item,
       $spacing = spacing;

  PlaygroundTranscriptStyler({
    BoxStyler? viewport,
    BoxStyler? item,
    double? spacing,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<PlaygroundTranscriptSpec>>? variants,
  }) : this.create(
         viewport: Prop.maybeMix(viewport),
         item: Prop.maybeMix(item),
         spacing: Prop.maybe(spacing),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory PlaygroundTranscriptStyler.viewport(BoxStyler value) =>
      PlaygroundTranscriptStyler().viewport(value);
  factory PlaygroundTranscriptStyler.item(BoxStyler value) =>
      PlaygroundTranscriptStyler().item(value);
  factory PlaygroundTranscriptStyler.spacing(double value) =>
      PlaygroundTranscriptStyler().spacing(value);

  @override
  Set<String> get $stylerFieldNames => const {
    'viewport',
    'item',
    'spacing',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the viewport.
  PlaygroundTranscriptStyler viewport(BoxStyler value) {
    return merge(PlaygroundTranscriptStyler(viewport: value));
  }

  /// Sets the item.
  PlaygroundTranscriptStyler item(BoxStyler value) {
    return merge(PlaygroundTranscriptStyler(item: value));
  }

  /// Sets the spacing.
  PlaygroundTranscriptStyler spacing(double value) {
    return merge(PlaygroundTranscriptStyler(spacing: value));
  }

  /// Sets the animation configuration.
  @override
  PlaygroundTranscriptStyler animate(AnimationConfig value) {
    return merge(PlaygroundTranscriptStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  PlaygroundTranscriptStyler variants(
    List<VariantStyle<PlaygroundTranscriptSpec>> value,
  ) {
    return merge(PlaygroundTranscriptStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  PlaygroundTranscriptStyler wrap(WidgetModifierConfig value) {
    return merge(PlaygroundTranscriptStyler(modifier: value));
  }

  /// Sets the widget modifier.
  PlaygroundTranscriptStyler modifier(WidgetModifierConfig value) {
    return merge(PlaygroundTranscriptStyler(modifier: value));
  }

  PlaygroundTranscript call({
    Key? key,
    required List<Widget> children,
    bool followOutput = true,
    double followThreshold = 48.0,
    bool busy = false,
    String busyLabel = 'Busy',
    String label = 'Conversation',
    ValueChanged<bool>? onFollowChanged,
    ScrollController? controller,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return PlaygroundTranscript(
      key: key,
      style: this,
      children: children,
      followOutput: followOutput,
      followThreshold: followThreshold,
      busy: busy,
      busyLabel: busyLabel,
      label: label,
      onFollowChanged: onFollowChanged,
      controller: controller,
      clipBehavior: clipBehavior,
    );
  }

  /// Merges with another [PlaygroundTranscriptStyler].
  @override
  PlaygroundTranscriptStyler merge(PlaygroundTranscriptStyler? other) {
    return PlaygroundTranscriptStyler.create(
      viewport: MixOps.merge($viewport, other?.$viewport),
      item: MixOps.merge($item, other?.$item),
      spacing: MixOps.merge($spacing, other?.$spacing),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<PlaygroundTranscriptSpec>] using [context].
  @override
  StyleSpec<PlaygroundTranscriptSpec> resolve(BuildContext context) {
    final spec = PlaygroundTranscriptSpec(
      viewport: MixOps.resolve(context, $viewport),
      item: MixOps.resolve(context, $item),
      spacing: MixOps.resolve(context, $spacing),
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
      ..add(DiagnosticsProperty('viewport', $viewport))
      ..add(DiagnosticsProperty('item', $item))
      ..add(DiagnosticsProperty('spacing', $spacing));
  }

  @override
  List<Object?> get props => [
    $viewport,
    $item,
    $spacing,
    $animation,
    $modifier,
    $variants,
  ];
}
