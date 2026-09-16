// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$UiAnswerSpec implements Spec<UiAnswerSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get body;
  StyleSpec<FlexBoxSpec> get actions;
  StyleSpec<BoxSpec> get feedback;
  StyleSpec<TextSpec> get sourcesLabel;
  StyleSpec<IconSpec> get indicator;

  @override
  Type get type => UiAnswerSpec;

  @override
  UiAnswerSpec copyWith({
    StyleSpec<BoxSpec>? body,
    StyleSpec<FlexBoxSpec>? actions,
    StyleSpec<BoxSpec>? feedback,
    StyleSpec<TextSpec>? sourcesLabel,
    StyleSpec<IconSpec>? indicator,
  }) {
    return UiAnswerSpec(
      body: body ?? this.body,
      actions: actions ?? this.actions,
      feedback: feedback ?? this.feedback,
      sourcesLabel: sourcesLabel ?? this.sourcesLabel,
      indicator: indicator ?? this.indicator,
    );
  }

  @override
  UiAnswerSpec lerp(UiAnswerSpec? other, double t) {
    return UiAnswerSpec(
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
        other is UiAnswerSpec &&
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
  'Rename to `_\$UiAnswerSpec` and migrate the class declaration to `class UiAnswerSpec with _\$UiAnswerSpec`. The `_\$UiAnswerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$UiAnswerSpecMethods = _$UiAnswerSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class UiAnswerStyler extends MixStyler<UiAnswerStyler, UiAnswerSpec>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<BoxSpec>>? $body;
  final Prop<StyleSpec<FlexBoxSpec>>? $actions;
  final Prop<StyleSpec<BoxSpec>>? $feedback;
  final Prop<StyleSpec<TextSpec>>? $sourcesLabel;
  final Prop<StyleSpec<IconSpec>>? $indicator;

  const UiAnswerStyler.create({
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

  UiAnswerStyler({
    BoxStyler? body,
    FlexBoxStyler? actions,
    BoxStyler? feedback,
    TextStyler? sourcesLabel,
    IconStyler? indicator,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<UiAnswerSpec>>? variants,
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

  factory UiAnswerStyler.body(BoxStyler value) => UiAnswerStyler().body(value);
  factory UiAnswerStyler.actions(FlexBoxStyler value) =>
      UiAnswerStyler().actions(value);
  factory UiAnswerStyler.feedback(BoxStyler value) =>
      UiAnswerStyler().feedback(value);
  factory UiAnswerStyler.sourcesLabel(TextStyler value) =>
      UiAnswerStyler().sourcesLabel(value);
  factory UiAnswerStyler.indicator(IconStyler value) =>
      UiAnswerStyler().indicator(value);

  @override
  Set<String> get $stylerFieldNames => const {
    'body',
    'actions',
    'feedback',
    'sourcesLabel',
    'indicator',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the body.
  UiAnswerStyler body(BoxStyler value) {
    return merge(UiAnswerStyler(body: value));
  }

  /// Sets the actions.
  UiAnswerStyler actions(FlexBoxStyler value) {
    return merge(UiAnswerStyler(actions: value));
  }

  /// Sets the feedback.
  UiAnswerStyler feedback(BoxStyler value) {
    return merge(UiAnswerStyler(feedback: value));
  }

  /// Sets the sourcesLabel.
  UiAnswerStyler sourcesLabel(TextStyler value) {
    return merge(UiAnswerStyler(sourcesLabel: value));
  }

  /// Sets the indicator.
  UiAnswerStyler indicator(IconStyler value) {
    return merge(UiAnswerStyler(indicator: value));
  }

  /// Sets the animation configuration.
  @override
  UiAnswerStyler animate(AnimationConfig value) {
    return merge(UiAnswerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  UiAnswerStyler variants(List<VariantStyle<UiAnswerSpec>> value) {
    return merge(UiAnswerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  UiAnswerStyler wrap(WidgetModifierConfig value) {
    return merge(UiAnswerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  UiAnswerStyler modifier(WidgetModifierConfig value) {
    return merge(UiAnswerStyler(modifier: value));
  }

  UiAnswer call({
    Key? key,
    required Widget child,
    Object? streamId,
    UiAnswerStatus status = UiAnswerStatus.streaming,
    VoidCallback? onCopy,
    VoidCallback? onRetry,
    RemixIconButtonIconBuilder? copyIconBuilder,
    RemixIconButtonIconBuilder? retryIconBuilder,
    UiAnswerSourcesIndicatorBuilder? sourcesIndicatorBuilder,
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
    return UiAnswer(
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

  /// Merges with another [UiAnswerStyler].
  @override
  UiAnswerStyler merge(UiAnswerStyler? other) {
    return UiAnswerStyler.create(
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

  /// Resolves to [StyleSpec<UiAnswerSpec>] using [context].
  @override
  StyleSpec<UiAnswerSpec> resolve(BuildContext context) {
    final spec = UiAnswerSpec(
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
