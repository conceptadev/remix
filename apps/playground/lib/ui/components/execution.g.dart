// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$PlaygroundExecutionSpec
    implements Spec<PlaygroundExecutionSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get header;
  StyleSpec<BoxSpec> get output;
  StyleSpec<FlexBoxSpec> get actions;
  StyleSpec<TextSpec> get tool;
  StyleSpec<TextSpec> get title;
  StyleSpec<TextSpec> get meta;
  StyleSpec<TextSpec> get status;
  StyleSpec<IconSpec> get toolIcon;
  StyleSpec<IconSpec> get statusIcon;
  StyleSpec<IconSpec> get indicator;
  StyleSpec<BoxSpec> get runningStatus;
  StyleSpec<BoxSpec> get successStatus;
  StyleSpec<BoxSpec> get errorStatus;
  StyleSpec<BoxSpec> get cancelledStatus;

  @override
  Type get type => PlaygroundExecutionSpec;

  @override
  PlaygroundExecutionSpec copyWith({
    StyleSpec<FlexBoxSpec>? header,
    StyleSpec<BoxSpec>? output,
    StyleSpec<FlexBoxSpec>? actions,
    StyleSpec<TextSpec>? tool,
    StyleSpec<TextSpec>? title,
    StyleSpec<TextSpec>? meta,
    StyleSpec<TextSpec>? status,
    StyleSpec<IconSpec>? toolIcon,
    StyleSpec<IconSpec>? statusIcon,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<BoxSpec>? runningStatus,
    StyleSpec<BoxSpec>? successStatus,
    StyleSpec<BoxSpec>? errorStatus,
    StyleSpec<BoxSpec>? cancelledStatus,
  }) {
    return PlaygroundExecutionSpec(
      header: header ?? this.header,
      output: output ?? this.output,
      actions: actions ?? this.actions,
      tool: tool ?? this.tool,
      title: title ?? this.title,
      meta: meta ?? this.meta,
      status: status ?? this.status,
      toolIcon: toolIcon ?? this.toolIcon,
      statusIcon: statusIcon ?? this.statusIcon,
      indicator: indicator ?? this.indicator,
      runningStatus: runningStatus ?? this.runningStatus,
      successStatus: successStatus ?? this.successStatus,
      errorStatus: errorStatus ?? this.errorStatus,
      cancelledStatus: cancelledStatus ?? this.cancelledStatus,
    );
  }

  @override
  PlaygroundExecutionSpec lerp(PlaygroundExecutionSpec? other, double t) {
    return PlaygroundExecutionSpec(
      header: header.lerp(other?.header, t),
      output: output.lerp(other?.output, t),
      actions: actions.lerp(other?.actions, t),
      tool: tool.lerp(other?.tool, t),
      title: title.lerp(other?.title, t),
      meta: meta.lerp(other?.meta, t),
      status: status.lerp(other?.status, t),
      toolIcon: toolIcon.lerp(other?.toolIcon, t),
      statusIcon: statusIcon.lerp(other?.statusIcon, t),
      indicator: indicator.lerp(other?.indicator, t),
      runningStatus: runningStatus.lerp(other?.runningStatus, t),
      successStatus: successStatus.lerp(other?.successStatus, t),
      errorStatus: errorStatus.lerp(other?.errorStatus, t),
      cancelledStatus: cancelledStatus.lerp(other?.cancelledStatus, t),
    );
  }

  @override
  List<Object?> get props => [
    header,
    output,
    actions,
    tool,
    title,
    meta,
    status,
    toolIcon,
    statusIcon,
    indicator,
    runningStatus,
    successStatus,
    errorStatus,
    cancelledStatus,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlaygroundExecutionSpec &&
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
      ..add(DiagnosticsProperty('header', header))
      ..add(DiagnosticsProperty('output', output))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(DiagnosticsProperty('tool', tool))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('meta', meta))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('toolIcon', toolIcon))
      ..add(DiagnosticsProperty('statusIcon', statusIcon))
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('runningStatus', runningStatus))
      ..add(DiagnosticsProperty('successStatus', successStatus))
      ..add(DiagnosticsProperty('errorStatus', errorStatus))
      ..add(DiagnosticsProperty('cancelledStatus', cancelledStatus));
  }
}

@Deprecated(
  'Rename to `_\$PlaygroundExecutionSpec` and migrate the class declaration to `class PlaygroundExecutionSpec with _\$PlaygroundExecutionSpec`. The `_\$PlaygroundExecutionSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$PlaygroundExecutionSpecMethods = _$PlaygroundExecutionSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class PlaygroundExecutionStyler
    extends MixStyler<PlaygroundExecutionStyler, PlaygroundExecutionSpec>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<FlexBoxSpec>>? $header;
  final Prop<StyleSpec<BoxSpec>>? $output;
  final Prop<StyleSpec<FlexBoxSpec>>? $actions;
  final Prop<StyleSpec<TextSpec>>? $tool;
  final Prop<StyleSpec<TextSpec>>? $title;
  final Prop<StyleSpec<TextSpec>>? $meta;
  final Prop<StyleSpec<TextSpec>>? $status;
  final Prop<StyleSpec<IconSpec>>? $toolIcon;
  final Prop<StyleSpec<IconSpec>>? $statusIcon;
  final Prop<StyleSpec<IconSpec>>? $indicator;
  final Prop<StyleSpec<BoxSpec>>? $runningStatus;
  final Prop<StyleSpec<BoxSpec>>? $successStatus;
  final Prop<StyleSpec<BoxSpec>>? $errorStatus;
  final Prop<StyleSpec<BoxSpec>>? $cancelledStatus;

  const PlaygroundExecutionStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? header,
    Prop<StyleSpec<BoxSpec>>? output,
    Prop<StyleSpec<FlexBoxSpec>>? actions,
    Prop<StyleSpec<TextSpec>>? tool,
    Prop<StyleSpec<TextSpec>>? title,
    Prop<StyleSpec<TextSpec>>? meta,
    Prop<StyleSpec<TextSpec>>? status,
    Prop<StyleSpec<IconSpec>>? toolIcon,
    Prop<StyleSpec<IconSpec>>? statusIcon,
    Prop<StyleSpec<IconSpec>>? indicator,
    Prop<StyleSpec<BoxSpec>>? runningStatus,
    Prop<StyleSpec<BoxSpec>>? successStatus,
    Prop<StyleSpec<BoxSpec>>? errorStatus,
    Prop<StyleSpec<BoxSpec>>? cancelledStatus,
    super.variants,
    super.modifier,
    super.animation,
  }) : $header = header,
       $output = output,
       $actions = actions,
       $tool = tool,
       $title = title,
       $meta = meta,
       $status = status,
       $toolIcon = toolIcon,
       $statusIcon = statusIcon,
       $indicator = indicator,
       $runningStatus = runningStatus,
       $successStatus = successStatus,
       $errorStatus = errorStatus,
       $cancelledStatus = cancelledStatus;

  PlaygroundExecutionStyler({
    FlexBoxStyler? header,
    BoxStyler? output,
    FlexBoxStyler? actions,
    TextStyler? tool,
    TextStyler? title,
    TextStyler? meta,
    TextStyler? status,
    IconStyler? toolIcon,
    IconStyler? statusIcon,
    IconStyler? indicator,
    BoxStyler? runningStatus,
    BoxStyler? successStatus,
    BoxStyler? errorStatus,
    BoxStyler? cancelledStatus,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<PlaygroundExecutionSpec>>? variants,
  }) : this.create(
         header: Prop.maybeMix(header),
         output: Prop.maybeMix(output),
         actions: Prop.maybeMix(actions),
         tool: Prop.maybeMix(tool),
         title: Prop.maybeMix(title),
         meta: Prop.maybeMix(meta),
         status: Prop.maybeMix(status),
         toolIcon: Prop.maybeMix(toolIcon),
         statusIcon: Prop.maybeMix(statusIcon),
         indicator: Prop.maybeMix(indicator),
         runningStatus: Prop.maybeMix(runningStatus),
         successStatus: Prop.maybeMix(successStatus),
         errorStatus: Prop.maybeMix(errorStatus),
         cancelledStatus: Prop.maybeMix(cancelledStatus),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory PlaygroundExecutionStyler.header(FlexBoxStyler value) =>
      PlaygroundExecutionStyler().header(value);
  factory PlaygroundExecutionStyler.output(BoxStyler value) =>
      PlaygroundExecutionStyler().output(value);
  factory PlaygroundExecutionStyler.actions(FlexBoxStyler value) =>
      PlaygroundExecutionStyler().actions(value);
  factory PlaygroundExecutionStyler.tool(TextStyler value) =>
      PlaygroundExecutionStyler().tool(value);
  factory PlaygroundExecutionStyler.title(TextStyler value) =>
      PlaygroundExecutionStyler().title(value);
  factory PlaygroundExecutionStyler.meta(TextStyler value) =>
      PlaygroundExecutionStyler().meta(value);
  factory PlaygroundExecutionStyler.status(TextStyler value) =>
      PlaygroundExecutionStyler().status(value);
  factory PlaygroundExecutionStyler.toolIcon(IconStyler value) =>
      PlaygroundExecutionStyler().toolIcon(value);
  factory PlaygroundExecutionStyler.statusIcon(IconStyler value) =>
      PlaygroundExecutionStyler().statusIcon(value);
  factory PlaygroundExecutionStyler.indicator(IconStyler value) =>
      PlaygroundExecutionStyler().indicator(value);
  factory PlaygroundExecutionStyler.runningStatus(BoxStyler value) =>
      PlaygroundExecutionStyler().runningStatus(value);
  factory PlaygroundExecutionStyler.successStatus(BoxStyler value) =>
      PlaygroundExecutionStyler().successStatus(value);
  factory PlaygroundExecutionStyler.errorStatus(BoxStyler value) =>
      PlaygroundExecutionStyler().errorStatus(value);
  factory PlaygroundExecutionStyler.cancelledStatus(BoxStyler value) =>
      PlaygroundExecutionStyler().cancelledStatus(value);

  @override
  Set<String> get $stylerFieldNames => const {
    'header',
    'output',
    'actions',
    'tool',
    'title',
    'meta',
    'status',
    'toolIcon',
    'statusIcon',
    'indicator',
    'runningStatus',
    'successStatus',
    'errorStatus',
    'cancelledStatus',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the header.
  PlaygroundExecutionStyler header(FlexBoxStyler value) {
    return merge(PlaygroundExecutionStyler(header: value));
  }

  /// Sets the output.
  PlaygroundExecutionStyler output(BoxStyler value) {
    return merge(PlaygroundExecutionStyler(output: value));
  }

  /// Sets the actions.
  PlaygroundExecutionStyler actions(FlexBoxStyler value) {
    return merge(PlaygroundExecutionStyler(actions: value));
  }

  /// Sets the tool.
  PlaygroundExecutionStyler tool(TextStyler value) {
    return merge(PlaygroundExecutionStyler(tool: value));
  }

  /// Sets the title.
  PlaygroundExecutionStyler title(TextStyler value) {
    return merge(PlaygroundExecutionStyler(title: value));
  }

  /// Sets the meta.
  PlaygroundExecutionStyler meta(TextStyler value) {
    return merge(PlaygroundExecutionStyler(meta: value));
  }

  /// Sets the status.
  PlaygroundExecutionStyler status(TextStyler value) {
    return merge(PlaygroundExecutionStyler(status: value));
  }

  /// Sets the toolIcon.
  PlaygroundExecutionStyler toolIcon(IconStyler value) {
    return merge(PlaygroundExecutionStyler(toolIcon: value));
  }

  /// Sets the statusIcon.
  PlaygroundExecutionStyler statusIcon(IconStyler value) {
    return merge(PlaygroundExecutionStyler(statusIcon: value));
  }

  /// Sets the indicator.
  PlaygroundExecutionStyler indicator(IconStyler value) {
    return merge(PlaygroundExecutionStyler(indicator: value));
  }

  /// Sets the runningStatus.
  PlaygroundExecutionStyler runningStatus(BoxStyler value) {
    return merge(PlaygroundExecutionStyler(runningStatus: value));
  }

  /// Sets the successStatus.
  PlaygroundExecutionStyler successStatus(BoxStyler value) {
    return merge(PlaygroundExecutionStyler(successStatus: value));
  }

  /// Sets the errorStatus.
  PlaygroundExecutionStyler errorStatus(BoxStyler value) {
    return merge(PlaygroundExecutionStyler(errorStatus: value));
  }

  /// Sets the cancelledStatus.
  PlaygroundExecutionStyler cancelledStatus(BoxStyler value) {
    return merge(PlaygroundExecutionStyler(cancelledStatus: value));
  }

  /// Sets the animation configuration.
  @override
  PlaygroundExecutionStyler animate(AnimationConfig value) {
    return merge(PlaygroundExecutionStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  PlaygroundExecutionStyler variants(
    List<VariantStyle<PlaygroundExecutionSpec>> value,
  ) {
    return merge(PlaygroundExecutionStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  PlaygroundExecutionStyler wrap(WidgetModifierConfig value) {
    return merge(PlaygroundExecutionStyler(modifier: value));
  }

  /// Sets the widget modifier.
  PlaygroundExecutionStyler modifier(WidgetModifierConfig value) {
    return merge(PlaygroundExecutionStyler(modifier: value));
  }

  PlaygroundExecution call({
    Key? key,
    required String tool,
    required String title,
    required Widget child,
    PlaygroundExecutionStatus status = PlaygroundExecutionStatus.running,
    String? meta,
    Widget? icon,
    VoidCallback? onCopy,
    VoidCallback? onRetry,
    RemixIconButtonIconBuilder? copyIconBuilder,
    RemixIconButtonIconBuilder? retryIconBuilder,
    PlaygroundExecutionIndicatorBuilder? indicatorBuilder,
    PlaygroundExecutionStatusBuilder? statusBuilder,
    PlaygroundExecutionStatusLabelBuilder? statusLabelBuilder,
    String copyLabel = 'Copy output',
    String retryLabel = 'Retry execution',
    String outputLabel = 'Tool output',
    bool showActions = true,
    bool collapseOnComplete = true,
    bool? expanded,
    bool defaultExpanded = true,
    ValueChanged<bool>? onExpandedChanged,
    String semanticLabel = 'Tool execution',
    CardStyler surfaceStyle = const CardStyler.create(),
    DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
    IconButtonStyler copyStyle = const IconButtonStyler.create(),
    IconButtonStyler retryStyle = const IconButtonStyler.create(),
  }) {
    return PlaygroundExecution(
      key: key,
      style: this,
      tool: tool,
      title: title,
      child: child,
      status: status,
      meta: meta,
      icon: icon,
      onCopy: onCopy,
      onRetry: onRetry,
      copyIconBuilder: copyIconBuilder,
      retryIconBuilder: retryIconBuilder,
      indicatorBuilder: indicatorBuilder,
      statusBuilder: statusBuilder,
      statusLabelBuilder: statusLabelBuilder,
      copyLabel: copyLabel,
      retryLabel: retryLabel,
      outputLabel: outputLabel,
      showActions: showActions,
      collapseOnComplete: collapseOnComplete,
      expanded: expanded,
      defaultExpanded: defaultExpanded,
      onExpandedChanged: onExpandedChanged,
      semanticLabel: semanticLabel,
      surfaceStyle: surfaceStyle,
      disclosureStyle: disclosureStyle,
      copyStyle: copyStyle,
      retryStyle: retryStyle,
    );
  }

  /// Merges with another [PlaygroundExecutionStyler].
  @override
  PlaygroundExecutionStyler merge(PlaygroundExecutionStyler? other) {
    return PlaygroundExecutionStyler.create(
      header: MixOps.merge($header, other?.$header),
      output: MixOps.merge($output, other?.$output),
      actions: MixOps.merge($actions, other?.$actions),
      tool: MixOps.merge($tool, other?.$tool),
      title: MixOps.merge($title, other?.$title),
      meta: MixOps.merge($meta, other?.$meta),
      status: MixOps.merge($status, other?.$status),
      toolIcon: MixOps.merge($toolIcon, other?.$toolIcon),
      statusIcon: MixOps.merge($statusIcon, other?.$statusIcon),
      indicator: MixOps.merge($indicator, other?.$indicator),
      runningStatus: MixOps.merge($runningStatus, other?.$runningStatus),
      successStatus: MixOps.merge($successStatus, other?.$successStatus),
      errorStatus: MixOps.merge($errorStatus, other?.$errorStatus),
      cancelledStatus: MixOps.merge($cancelledStatus, other?.$cancelledStatus),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<PlaygroundExecutionSpec>] using [context].
  @override
  StyleSpec<PlaygroundExecutionSpec> resolve(BuildContext context) {
    final spec = PlaygroundExecutionSpec(
      header: MixOps.resolve(context, $header),
      output: MixOps.resolve(context, $output),
      actions: MixOps.resolve(context, $actions),
      tool: MixOps.resolve(context, $tool),
      title: MixOps.resolve(context, $title),
      meta: MixOps.resolve(context, $meta),
      status: MixOps.resolve(context, $status),
      toolIcon: MixOps.resolve(context, $toolIcon),
      statusIcon: MixOps.resolve(context, $statusIcon),
      indicator: MixOps.resolve(context, $indicator),
      runningStatus: MixOps.resolve(context, $runningStatus),
      successStatus: MixOps.resolve(context, $successStatus),
      errorStatus: MixOps.resolve(context, $errorStatus),
      cancelledStatus: MixOps.resolve(context, $cancelledStatus),
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
      ..add(DiagnosticsProperty('header', $header))
      ..add(DiagnosticsProperty('output', $output))
      ..add(DiagnosticsProperty('actions', $actions))
      ..add(DiagnosticsProperty('tool', $tool))
      ..add(DiagnosticsProperty('title', $title))
      ..add(DiagnosticsProperty('meta', $meta))
      ..add(DiagnosticsProperty('status', $status))
      ..add(DiagnosticsProperty('toolIcon', $toolIcon))
      ..add(DiagnosticsProperty('statusIcon', $statusIcon))
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('runningStatus', $runningStatus))
      ..add(DiagnosticsProperty('successStatus', $successStatus))
      ..add(DiagnosticsProperty('errorStatus', $errorStatus))
      ..add(DiagnosticsProperty('cancelledStatus', $cancelledStatus));
  }

  @override
  List<Object?> get props => [
    $header,
    $output,
    $actions,
    $tool,
    $title,
    $meta,
    $status,
    $toolIcon,
    $statusIcon,
    $indicator,
    $runningStatus,
    $successStatus,
    $errorStatus,
    $cancelledStatus,
    $animation,
    $modifier,
    $variants,
  ];
}
