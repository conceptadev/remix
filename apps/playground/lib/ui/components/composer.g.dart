// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composer.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$PlaygroundComposerSpec
    implements Spec<PlaygroundComposerSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get toolbar;

  @override
  Type get type => PlaygroundComposerSpec;

  @override
  PlaygroundComposerSpec copyWith({StyleSpec<FlexBoxSpec>? toolbar}) {
    return PlaygroundComposerSpec(toolbar: toolbar ?? this.toolbar);
  }

  @override
  PlaygroundComposerSpec lerp(PlaygroundComposerSpec? other, double t) {
    return PlaygroundComposerSpec(toolbar: toolbar.lerp(other?.toolbar, t));
  }

  @override
  List<Object?> get props => [toolbar];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlaygroundComposerSpec &&
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
    properties.add(DiagnosticsProperty('toolbar', toolbar));
  }
}

@Deprecated(
  'Rename to `_\$PlaygroundComposerSpec` and migrate the class declaration to `class PlaygroundComposerSpec with _\$PlaygroundComposerSpec`. The `_\$PlaygroundComposerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$PlaygroundComposerSpecMethods = _$PlaygroundComposerSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class PlaygroundComposerStyler
    extends MixStyler<PlaygroundComposerStyler, PlaygroundComposerSpec>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<FlexBoxSpec>>? $toolbar;

  const PlaygroundComposerStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? toolbar,
    super.variants,
    super.modifier,
    super.animation,
  }) : $toolbar = toolbar;

  PlaygroundComposerStyler({
    FlexBoxStyler? toolbar,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<PlaygroundComposerSpec>>? variants,
  }) : this.create(
         toolbar: Prop.maybeMix(toolbar),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory PlaygroundComposerStyler.toolbar(FlexBoxStyler value) =>
      PlaygroundComposerStyler().toolbar(value);

  @override
  Set<String> get $stylerFieldNames => const {
    'toolbar',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the toolbar.
  PlaygroundComposerStyler toolbar(FlexBoxStyler value) {
    return merge(PlaygroundComposerStyler(toolbar: value));
  }

  /// Sets the animation configuration.
  @override
  PlaygroundComposerStyler animate(AnimationConfig value) {
    return merge(PlaygroundComposerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  PlaygroundComposerStyler variants(
    List<VariantStyle<PlaygroundComposerSpec>> value,
  ) {
    return merge(PlaygroundComposerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  PlaygroundComposerStyler wrap(WidgetModifierConfig value) {
    return merge(PlaygroundComposerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  PlaygroundComposerStyler modifier(WidgetModifierConfig value) {
    return merge(PlaygroundComposerStyler(modifier: value));
  }

  PlaygroundComposer call({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmit,
    VoidCallback? onStop,
    bool running = false,
    bool enabled = true,
    bool? canSubmit,
    bool clearOnSubmit = true,
    bool autofocus = false,
    String hintText = 'Message',
    String semanticLabel = 'Message',
    int minLines = 2,
    int maxLines = 8,
    Widget? leading,
    Widget? trailing,
    RemixIconButtonIconBuilder? submitIconBuilder,
    RemixIconButtonIconBuilder? stopIconBuilder,
    String submitLabel = 'Send',
    String stopLabel = 'Stop',
    CardStyler surfaceStyle = const CardStyler.create(),
    TextFieldStyler fieldStyle = const TextFieldStyler.create(),
    IconButtonStyler submitStyle = const IconButtonStyler.create(),
    IconButtonStyler stopStyle = const IconButtonStyler.create(),
  }) {
    return PlaygroundComposer(
      key: key,
      style: this,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmit: onSubmit,
      onStop: onStop,
      running: running,
      enabled: enabled,
      canSubmit: canSubmit,
      clearOnSubmit: clearOnSubmit,
      autofocus: autofocus,
      hintText: hintText,
      semanticLabel: semanticLabel,
      minLines: minLines,
      maxLines: maxLines,
      leading: leading,
      trailing: trailing,
      submitIconBuilder: submitIconBuilder,
      stopIconBuilder: stopIconBuilder,
      submitLabel: submitLabel,
      stopLabel: stopLabel,
      surfaceStyle: surfaceStyle,
      fieldStyle: fieldStyle,
      submitStyle: submitStyle,
      stopStyle: stopStyle,
    );
  }

  /// Merges with another [PlaygroundComposerStyler].
  @override
  PlaygroundComposerStyler merge(PlaygroundComposerStyler? other) {
    return PlaygroundComposerStyler.create(
      toolbar: MixOps.merge($toolbar, other?.$toolbar),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<PlaygroundComposerSpec>] using [context].
  @override
  StyleSpec<PlaygroundComposerSpec> resolve(BuildContext context) {
    final spec = PlaygroundComposerSpec(
      toolbar: MixOps.resolve(context, $toolbar),
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
    properties.add(DiagnosticsProperty('toolbar', $toolbar));
  }

  @override
  List<Object?> get props => [$toolbar, $animation, $modifier, $variants];
}
