// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composer.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$AgentComposerSpec implements Spec<AgentComposerSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get toolbar;

  @override
  Type get type => AgentComposerSpec;

  @override
  AgentComposerSpec copyWith({StyleSpec<FlexBoxSpec>? toolbar}) {
    return AgentComposerSpec(toolbar: toolbar ?? this.toolbar);
  }

  @override
  AgentComposerSpec lerp(AgentComposerSpec? other, double t) {
    return AgentComposerSpec(toolbar: toolbar.lerp(other?.toolbar, t));
  }

  @override
  List<Object?> get props => [toolbar];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AgentComposerSpec &&
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
  'Rename to `_\$AgentComposerSpec` and migrate the class declaration to `class AgentComposerSpec with _\$AgentComposerSpec`. The `_\$AgentComposerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$AgentComposerSpecMethods = _$AgentComposerSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class AgentComposerStyler
    extends MixStyler<AgentComposerStyler, AgentComposerSpec> {
  final Prop<StyleSpec<FlexBoxSpec>>? $toolbar;

  const AgentComposerStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? toolbar,
    super.variants,
    super.modifier,
    super.animation,
  }) : $toolbar = toolbar;

  AgentComposerStyler({
    FlexBoxStyler? toolbar,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<AgentComposerSpec>>? variants,
  }) : this.create(
         toolbar: Prop.maybeMix(toolbar),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory AgentComposerStyler.toolbar(FlexBoxStyler value) =>
      AgentComposerStyler().toolbar(value);

  /// Sets the toolbar.
  AgentComposerStyler toolbar(FlexBoxStyler value) {
    return merge(AgentComposerStyler(toolbar: value));
  }

  /// Sets the animation configuration.
  @override
  AgentComposerStyler animate(AnimationConfig value) {
    return merge(AgentComposerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  AgentComposerStyler variants(List<VariantStyle<AgentComposerSpec>> value) {
    return merge(AgentComposerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  AgentComposerStyler wrap(WidgetModifierConfig value) {
    return merge(AgentComposerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  AgentComposerStyler modifier(WidgetModifierConfig value) {
    return merge(AgentComposerStyler(modifier: value));
  }

  AgentComposer call({
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
    return AgentComposer(
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

  /// Merges with another [AgentComposerStyler].
  @override
  AgentComposerStyler merge(AgentComposerStyler? other) {
    return AgentComposerStyler.create(
      toolbar: MixOps.merge($toolbar, other?.$toolbar),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<AgentComposerSpec>] using [context].
  @override
  StyleSpec<AgentComposerSpec> resolve(BuildContext context) {
    final spec = AgentComposerSpec(toolbar: MixOps.resolve(context, $toolbar));

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
