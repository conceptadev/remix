// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$UiExecutionSpec implements Spec<UiExecutionSpec>, Diagnosticable {
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
  Type get type => UiExecutionSpec;

  @override
  UiExecutionSpec copyWith({
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
    return UiExecutionSpec(
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
  UiExecutionSpec lerp(UiExecutionSpec? other, double t) {
    return UiExecutionSpec(
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
        other is UiExecutionSpec &&
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
  'Rename to `_\$UiExecutionSpec` and migrate the class declaration to `class UiExecutionSpec with _\$UiExecutionSpec`. The `_\$UiExecutionSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$UiExecutionSpecMethods = _$UiExecutionSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class UiExecutionStyler extends MixStyler<UiExecutionStyler, UiExecutionSpec>
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

  const UiExecutionStyler.create({
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

  UiExecutionStyler({
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
    List<VariantStyle<UiExecutionSpec>>? variants,
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

  factory UiExecutionStyler.header(FlexBoxStyler value) =>
      UiExecutionStyler().header(value);
  factory UiExecutionStyler.output(BoxStyler value) =>
      UiExecutionStyler().output(value);
  factory UiExecutionStyler.actions(FlexBoxStyler value) =>
      UiExecutionStyler().actions(value);
  factory UiExecutionStyler.tool(TextStyler value) =>
      UiExecutionStyler().tool(value);
  factory UiExecutionStyler.title(TextStyler value) =>
      UiExecutionStyler().title(value);
  factory UiExecutionStyler.meta(TextStyler value) =>
      UiExecutionStyler().meta(value);
  factory UiExecutionStyler.status(TextStyler value) =>
      UiExecutionStyler().status(value);
  factory UiExecutionStyler.toolIcon(IconStyler value) =>
      UiExecutionStyler().toolIcon(value);
  factory UiExecutionStyler.statusIcon(IconStyler value) =>
      UiExecutionStyler().statusIcon(value);
  factory UiExecutionStyler.indicator(IconStyler value) =>
      UiExecutionStyler().indicator(value);
  factory UiExecutionStyler.runningStatus(BoxStyler value) =>
      UiExecutionStyler().runningStatus(value);
  factory UiExecutionStyler.successStatus(BoxStyler value) =>
      UiExecutionStyler().successStatus(value);
  factory UiExecutionStyler.errorStatus(BoxStyler value) =>
      UiExecutionStyler().errorStatus(value);
  factory UiExecutionStyler.cancelledStatus(BoxStyler value) =>
      UiExecutionStyler().cancelledStatus(value);

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
  UiExecutionStyler header(FlexBoxStyler value) {
    return merge(UiExecutionStyler(header: value));
  }

  /// Sets the output.
  UiExecutionStyler output(BoxStyler value) {
    return merge(UiExecutionStyler(output: value));
  }

  /// Sets the actions.
  UiExecutionStyler actions(FlexBoxStyler value) {
    return merge(UiExecutionStyler(actions: value));
  }

  /// Sets the tool.
  UiExecutionStyler tool(TextStyler value) {
    return merge(UiExecutionStyler(tool: value));
  }

  /// Sets the title.
  UiExecutionStyler title(TextStyler value) {
    return merge(UiExecutionStyler(title: value));
  }

  /// Sets the meta.
  UiExecutionStyler meta(TextStyler value) {
    return merge(UiExecutionStyler(meta: value));
  }

  /// Sets the status.
  UiExecutionStyler status(TextStyler value) {
    return merge(UiExecutionStyler(status: value));
  }

  /// Sets the toolIcon.
  UiExecutionStyler toolIcon(IconStyler value) {
    return merge(UiExecutionStyler(toolIcon: value));
  }

  /// Sets the statusIcon.
  UiExecutionStyler statusIcon(IconStyler value) {
    return merge(UiExecutionStyler(statusIcon: value));
  }

  /// Sets the indicator.
  UiExecutionStyler indicator(IconStyler value) {
    return merge(UiExecutionStyler(indicator: value));
  }

  /// Sets the runningStatus.
  UiExecutionStyler runningStatus(BoxStyler value) {
    return merge(UiExecutionStyler(runningStatus: value));
  }

  /// Sets the successStatus.
  UiExecutionStyler successStatus(BoxStyler value) {
    return merge(UiExecutionStyler(successStatus: value));
  }

  /// Sets the errorStatus.
  UiExecutionStyler errorStatus(BoxStyler value) {
    return merge(UiExecutionStyler(errorStatus: value));
  }

  /// Sets the cancelledStatus.
  UiExecutionStyler cancelledStatus(BoxStyler value) {
    return merge(UiExecutionStyler(cancelledStatus: value));
  }

  /// Sets the animation configuration.
  @override
  UiExecutionStyler animate(AnimationConfig value) {
    return merge(UiExecutionStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  UiExecutionStyler variants(List<VariantStyle<UiExecutionSpec>> value) {
    return merge(UiExecutionStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  UiExecutionStyler wrap(WidgetModifierConfig value) {
    return merge(UiExecutionStyler(modifier: value));
  }

  /// Sets the widget modifier.
  UiExecutionStyler modifier(WidgetModifierConfig value) {
    return merge(UiExecutionStyler(modifier: value));
  }

  UiExecution call({
    Key? key,
    required String tool,
    required String title,
    required Widget child,
    UiExecutionStatus status = UiExecutionStatus.running,
    String? meta,
    Widget? icon,
    VoidCallback? onCopy,
    VoidCallback? onRetry,
    RemixIconButtonIconBuilder? copyIconBuilder,
    RemixIconButtonIconBuilder? retryIconBuilder,
    UiExecutionIndicatorBuilder? indicatorBuilder,
    UiExecutionStatusBuilder? statusBuilder,
    UiExecutionStatusLabelBuilder? statusLabelBuilder,
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
    return UiExecution(
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

  /// Merges with another [UiExecutionStyler].
  @override
  UiExecutionStyler merge(UiExecutionStyler? other) {
    return UiExecutionStyler.create(
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

  /// Resolves to [StyleSpec<UiExecutionSpec>] using [context].
  @override
  StyleSpec<UiExecutionSpec> resolve(BuildContext context) {
    final spec = UiExecutionSpec(
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
