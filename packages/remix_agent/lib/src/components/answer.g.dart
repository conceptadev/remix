// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$AgentAnswerSpec implements Spec<AgentAnswerSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get body;
  StyleSpec<FlexBoxSpec> get actions;
  StyleSpec<BoxSpec> get feedback;
  StyleSpec<TextSpec> get sourcesLabel;
  StyleSpec<IconSpec> get indicator;

  @override
  Type get type => AgentAnswerSpec;

  @override
  AgentAnswerSpec copyWith({
    StyleSpec<BoxSpec>? body,
    StyleSpec<FlexBoxSpec>? actions,
    StyleSpec<BoxSpec>? feedback,
    StyleSpec<TextSpec>? sourcesLabel,
    StyleSpec<IconSpec>? indicator,
  }) {
    return AgentAnswerSpec(
      body: body ?? this.body,
      actions: actions ?? this.actions,
      feedback: feedback ?? this.feedback,
      sourcesLabel: sourcesLabel ?? this.sourcesLabel,
      indicator: indicator ?? this.indicator,
    );
  }

  @override
  AgentAnswerSpec lerp(AgentAnswerSpec? other, double t) {
    return AgentAnswerSpec(
      body: body.lerp(other?.body, t),
      actions: actions.lerp(other?.actions, t),
      feedback: feedback.lerp(other?.feedback, t),
      sourcesLabel: sourcesLabel.lerp(other?.sourcesLabel, t),
      indicator: indicator.lerp(other?.indicator, t),
    );
  }

  @override
  List<Object?> get props => [body, actions, feedback, sourcesLabel, indicator];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AgentAnswerSpec &&
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
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(DiagnosticsProperty('feedback', feedback))
      ..add(DiagnosticsProperty('sourcesLabel', sourcesLabel))
      ..add(DiagnosticsProperty('indicator', indicator));
  }
}

@Deprecated(
  'Rename to `_\$AgentAnswerSpec` and migrate the class declaration to `class AgentAnswerSpec with _\$AgentAnswerSpec`. The `_\$AgentAnswerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$AgentAnswerSpecMethods = _$AgentAnswerSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class AgentAnswerStyler extends MixStyler<AgentAnswerStyler, AgentAnswerSpec> {
  final Prop<StyleSpec<BoxSpec>>? $body;
  final Prop<StyleSpec<FlexBoxSpec>>? $actions;
  final Prop<StyleSpec<BoxSpec>>? $feedback;
  final Prop<StyleSpec<TextSpec>>? $sourcesLabel;
  final Prop<StyleSpec<IconSpec>>? $indicator;

  const AgentAnswerStyler.create({
    Prop<StyleSpec<BoxSpec>>? body,
    Prop<StyleSpec<FlexBoxSpec>>? actions,
    Prop<StyleSpec<BoxSpec>>? feedback,
    Prop<StyleSpec<TextSpec>>? sourcesLabel,
    Prop<StyleSpec<IconSpec>>? indicator,
    super.variants,
    super.modifier,
    super.animation,
  }) : $body = body,
       $actions = actions,
       $feedback = feedback,
       $sourcesLabel = sourcesLabel,
       $indicator = indicator;

  AgentAnswerStyler({
    BoxStyler? body,
    FlexBoxStyler? actions,
    BoxStyler? feedback,
    TextStyler? sourcesLabel,
    IconStyler? indicator,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<AgentAnswerSpec>>? variants,
  }) : this.create(
         body: Prop.maybeMix(body),
         actions: Prop.maybeMix(actions),
         feedback: Prop.maybeMix(feedback),
         sourcesLabel: Prop.maybeMix(sourcesLabel),
         indicator: Prop.maybeMix(indicator),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory AgentAnswerStyler.body(BoxStyler value) =>
      AgentAnswerStyler().body(value);
  factory AgentAnswerStyler.actions(FlexBoxStyler value) =>
      AgentAnswerStyler().actions(value);
  factory AgentAnswerStyler.feedback(BoxStyler value) =>
      AgentAnswerStyler().feedback(value);
  factory AgentAnswerStyler.sourcesLabel(TextStyler value) =>
      AgentAnswerStyler().sourcesLabel(value);
  factory AgentAnswerStyler.indicator(IconStyler value) =>
      AgentAnswerStyler().indicator(value);

  /// Sets the body.
  AgentAnswerStyler body(BoxStyler value) {
    return merge(AgentAnswerStyler(body: value));
  }

  /// Sets the actions.
  AgentAnswerStyler actions(FlexBoxStyler value) {
    return merge(AgentAnswerStyler(actions: value));
  }

  /// Sets the feedback.
  AgentAnswerStyler feedback(BoxStyler value) {
    return merge(AgentAnswerStyler(feedback: value));
  }

  /// Sets the sourcesLabel.
  AgentAnswerStyler sourcesLabel(TextStyler value) {
    return merge(AgentAnswerStyler(sourcesLabel: value));
  }

  /// Sets the indicator.
  AgentAnswerStyler indicator(IconStyler value) {
    return merge(AgentAnswerStyler(indicator: value));
  }

  /// Sets the animation configuration.
  @override
  AgentAnswerStyler animate(AnimationConfig value) {
    return merge(AgentAnswerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  AgentAnswerStyler variants(List<VariantStyle<AgentAnswerSpec>> value) {
    return merge(AgentAnswerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  AgentAnswerStyler wrap(WidgetModifierConfig value) {
    return merge(AgentAnswerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  AgentAnswerStyler modifier(WidgetModifierConfig value) {
    return merge(AgentAnswerStyler(modifier: value));
  }

  AgentAnswer call({
    Key? key,
    required Widget child,
    Object? streamId,
    AgentAnswerStatus status = AgentAnswerStatus.streaming,
    VoidCallback? onCopy,
    VoidCallback? onRetry,
    RemixIconButtonIconBuilder? copyIconBuilder,
    RemixIconButtonIconBuilder? retryIconBuilder,
    AgentAnswerSourcesIndicatorBuilder? sourcesIndicatorBuilder,
    String copyLabel = 'Copy answer',
    String retryLabel = 'Retry answer',
    bool? showActions,
    Widget? feedback,
    Widget? sourcesContent,
    bool? sourcesExpanded,
    bool defaultSourcesExpanded = false,
    ValueChanged<bool>? onSourcesExpandedChanged,
    String sourcesLabel = 'Sources',
    String semanticLabel = 'Answer',
    CardStyler surfaceStyle = const CardStyler.create(),
    DisclosureStyler sourcesStyle = const DisclosureStyler.create(),
    IconButtonStyler copyStyle = const IconButtonStyler.create(),
    IconButtonStyler retryStyle = const IconButtonStyler.create(),
  }) {
    return AgentAnswer(
      key: key,
      style: this,
      child: child,
      streamId: streamId,
      status: status,
      onCopy: onCopy,
      onRetry: onRetry,
      copyIconBuilder: copyIconBuilder,
      retryIconBuilder: retryIconBuilder,
      sourcesIndicatorBuilder: sourcesIndicatorBuilder,
      copyLabel: copyLabel,
      retryLabel: retryLabel,
      showActions: showActions,
      feedback: feedback,
      sourcesContent: sourcesContent,
      sourcesExpanded: sourcesExpanded,
      defaultSourcesExpanded: defaultSourcesExpanded,
      onSourcesExpandedChanged: onSourcesExpandedChanged,
      sourcesLabel: sourcesLabel,
      semanticLabel: semanticLabel,
      surfaceStyle: surfaceStyle,
      sourcesStyle: sourcesStyle,
      copyStyle: copyStyle,
      retryStyle: retryStyle,
    );
  }

  /// Merges with another [AgentAnswerStyler].
  @override
  AgentAnswerStyler merge(AgentAnswerStyler? other) {
    return AgentAnswerStyler.create(
      body: MixOps.merge($body, other?.$body),
      actions: MixOps.merge($actions, other?.$actions),
      feedback: MixOps.merge($feedback, other?.$feedback),
      sourcesLabel: MixOps.merge($sourcesLabel, other?.$sourcesLabel),
      indicator: MixOps.merge($indicator, other?.$indicator),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<AgentAnswerSpec>] using [context].
  @override
  StyleSpec<AgentAnswerSpec> resolve(BuildContext context) {
    final spec = AgentAnswerSpec(
      body: MixOps.resolve(context, $body),
      actions: MixOps.resolve(context, $actions),
      feedback: MixOps.resolve(context, $feedback),
      sourcesLabel: MixOps.resolve(context, $sourcesLabel),
      indicator: MixOps.resolve(context, $indicator),
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
      ..add(DiagnosticsProperty('body', $body))
      ..add(DiagnosticsProperty('actions', $actions))
      ..add(DiagnosticsProperty('feedback', $feedback))
      ..add(DiagnosticsProperty('sourcesLabel', $sourcesLabel))
      ..add(DiagnosticsProperty('indicator', $indicator));
  }

  @override
  List<Object?> get props => [
    $body,
    $actions,
    $feedback,
    $sourcesLabel,
    $indicator,
    $animation,
    $modifier,
    $variants,
  ];
}
