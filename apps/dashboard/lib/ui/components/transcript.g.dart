// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$UiTranscriptSpec implements Spec<UiTranscriptSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get viewport;
  StyleSpec<BoxSpec> get item;
  double? get spacing;

  @override
  Type get type => UiTranscriptSpec;

  @override
  UiTranscriptSpec copyWith({
    StyleSpec<BoxSpec>? viewport,
    StyleSpec<BoxSpec>? item,
    double? spacing,
  }) {
    return UiTranscriptSpec(
      viewport: viewport ?? this.viewport,
      item: item ?? this.item,
      spacing: spacing ?? this.spacing,
    );
  }

  @override
  UiTranscriptSpec lerp(UiTranscriptSpec? other, double t) {
    return UiTranscriptSpec(
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
        other is UiTranscriptSpec &&
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
  'Rename to `_\$UiTranscriptSpec` and migrate the class declaration to `class UiTranscriptSpec with _\$UiTranscriptSpec`. The `_\$UiTranscriptSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$UiTranscriptSpecMethods = _$UiTranscriptSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class UiTranscriptStyler extends MixStyler<UiTranscriptStyler, UiTranscriptSpec>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<BoxSpec>>? $viewport;
  final Prop<StyleSpec<BoxSpec>>? $item;
  final Prop<double>? $spacing;

  const UiTranscriptStyler.create({
    Prop<StyleSpec<BoxSpec>>? viewport,
    Prop<StyleSpec<BoxSpec>>? item,
    Prop<double>? spacing,
    super.variants,
    super.modifier,
    super.animation,
  }) : $viewport = viewport,
       $item = item,
       $spacing = spacing;

  UiTranscriptStyler({
    BoxStyler? viewport,
    BoxStyler? item,
    double? spacing,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<UiTranscriptSpec>>? variants,
  }) : this.create(
         viewport: Prop.maybeMix(viewport),
         item: Prop.maybeMix(item),
         spacing: Prop.maybe(spacing),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory UiTranscriptStyler.viewport(BoxStyler value) =>
      UiTranscriptStyler().viewport(value);
  factory UiTranscriptStyler.item(BoxStyler value) =>
      UiTranscriptStyler().item(value);
  factory UiTranscriptStyler.spacing(double value) =>
      UiTranscriptStyler().spacing(value);

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
  UiTranscriptStyler viewport(BoxStyler value) {
    return merge(UiTranscriptStyler(viewport: value));
  }

  /// Sets the item.
  UiTranscriptStyler item(BoxStyler value) {
    return merge(UiTranscriptStyler(item: value));
  }

  /// Sets the spacing.
  UiTranscriptStyler spacing(double value) {
    return merge(UiTranscriptStyler(spacing: value));
  }

  /// Sets the animation configuration.
  @override
  UiTranscriptStyler animate(AnimationConfig value) {
    return merge(UiTranscriptStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  UiTranscriptStyler variants(List<VariantStyle<UiTranscriptSpec>> value) {
    return merge(UiTranscriptStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  UiTranscriptStyler wrap(WidgetModifierConfig value) {
    return merge(UiTranscriptStyler(modifier: value));
  }

  /// Sets the widget modifier.
  UiTranscriptStyler modifier(WidgetModifierConfig value) {
    return merge(UiTranscriptStyler(modifier: value));
  }

  UiTranscript call({
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
    return UiTranscript(
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

  /// Merges with another [UiTranscriptStyler].
  @override
  UiTranscriptStyler merge(UiTranscriptStyler? other) {
    return UiTranscriptStyler.create(
      viewport: MixOps.merge($viewport, other?.$viewport),
      item: MixOps.merge($item, other?.$item),
      spacing: MixOps.merge($spacing, other?.$spacing),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<UiTranscriptSpec>] using [context].
  @override
  StyleSpec<UiTranscriptSpec> resolve(BuildContext context) {
    final spec = UiTranscriptSpec(
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
