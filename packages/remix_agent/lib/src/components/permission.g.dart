// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$AgentPermissionSpec
    implements Spec<AgentPermissionSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get content;
  StyleSpec<FlexBoxSpec> get header;
  StyleSpec<FlexBoxSpec> get actions;
  StyleSpec<TextSpec> get title;
  StyleSpec<TextSpec> get tool;
  StyleSpec<TextSpec> get description;
  StyleSpec<TextSpec> get status;
  StyleSpec<TextSpec> get detailsLabel;
  StyleSpec<IconSpec> get toolIcon;
  StyleSpec<IconSpec> get statusIcon;
  StyleSpec<IconSpec> get indicator;
  StyleSpec<BoxSpec> get pendingStatus;
  StyleSpec<BoxSpec> get decidingStatus;
  StyleSpec<BoxSpec> get allowedStatus;
  StyleSpec<BoxSpec> get runningStatus;
  StyleSpec<BoxSpec> get completedStatus;
  StyleSpec<BoxSpec> get deniedStatus;
  StyleSpec<BoxSpec> get errorStatus;

  @override
  Type get type => AgentPermissionSpec;

  @override
  AgentPermissionSpec copyWith({
    StyleSpec<BoxSpec>? content,
    StyleSpec<FlexBoxSpec>? header,
    StyleSpec<FlexBoxSpec>? actions,
    StyleSpec<TextSpec>? title,
    StyleSpec<TextSpec>? tool,
    StyleSpec<TextSpec>? description,
    StyleSpec<TextSpec>? status,
    StyleSpec<TextSpec>? detailsLabel,
    StyleSpec<IconSpec>? toolIcon,
    StyleSpec<IconSpec>? statusIcon,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<BoxSpec>? pendingStatus,
    StyleSpec<BoxSpec>? decidingStatus,
    StyleSpec<BoxSpec>? allowedStatus,
    StyleSpec<BoxSpec>? runningStatus,
    StyleSpec<BoxSpec>? completedStatus,
    StyleSpec<BoxSpec>? deniedStatus,
    StyleSpec<BoxSpec>? errorStatus,
  }) {
    return AgentPermissionSpec(
      content: content ?? this.content,
      header: header ?? this.header,
      actions: actions ?? this.actions,
      title: title ?? this.title,
      tool: tool ?? this.tool,
      description: description ?? this.description,
      status: status ?? this.status,
      detailsLabel: detailsLabel ?? this.detailsLabel,
      toolIcon: toolIcon ?? this.toolIcon,
      statusIcon: statusIcon ?? this.statusIcon,
      indicator: indicator ?? this.indicator,
      pendingStatus: pendingStatus ?? this.pendingStatus,
      decidingStatus: decidingStatus ?? this.decidingStatus,
      allowedStatus: allowedStatus ?? this.allowedStatus,
      runningStatus: runningStatus ?? this.runningStatus,
      completedStatus: completedStatus ?? this.completedStatus,
      deniedStatus: deniedStatus ?? this.deniedStatus,
      errorStatus: errorStatus ?? this.errorStatus,
    );
  }

  @override
  AgentPermissionSpec lerp(AgentPermissionSpec? other, double t) {
    return AgentPermissionSpec(
      content: content.lerp(other?.content, t),
      header: header.lerp(other?.header, t),
      actions: actions.lerp(other?.actions, t),
      title: title.lerp(other?.title, t),
      tool: tool.lerp(other?.tool, t),
      description: description.lerp(other?.description, t),
      status: status.lerp(other?.status, t),
      detailsLabel: detailsLabel.lerp(other?.detailsLabel, t),
      toolIcon: toolIcon.lerp(other?.toolIcon, t),
      statusIcon: statusIcon.lerp(other?.statusIcon, t),
      indicator: indicator.lerp(other?.indicator, t),
      pendingStatus: pendingStatus.lerp(other?.pendingStatus, t),
      decidingStatus: decidingStatus.lerp(other?.decidingStatus, t),
      allowedStatus: allowedStatus.lerp(other?.allowedStatus, t),
      runningStatus: runningStatus.lerp(other?.runningStatus, t),
      completedStatus: completedStatus.lerp(other?.completedStatus, t),
      deniedStatus: deniedStatus.lerp(other?.deniedStatus, t),
      errorStatus: errorStatus.lerp(other?.errorStatus, t),
    );
  }

  @override
  List<Object?> get props => [
    content,
    header,
    actions,
    title,
    tool,
    description,
    status,
    detailsLabel,
    toolIcon,
    statusIcon,
    indicator,
    pendingStatus,
    decidingStatus,
    allowedStatus,
    runningStatus,
    completedStatus,
    deniedStatus,
    errorStatus,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AgentPermissionSpec &&
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
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('header', header))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('tool', tool))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('detailsLabel', detailsLabel))
      ..add(DiagnosticsProperty('toolIcon', toolIcon))
      ..add(DiagnosticsProperty('statusIcon', statusIcon))
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('pendingStatus', pendingStatus))
      ..add(DiagnosticsProperty('decidingStatus', decidingStatus))
      ..add(DiagnosticsProperty('allowedStatus', allowedStatus))
      ..add(DiagnosticsProperty('runningStatus', runningStatus))
      ..add(DiagnosticsProperty('completedStatus', completedStatus))
      ..add(DiagnosticsProperty('deniedStatus', deniedStatus))
      ..add(DiagnosticsProperty('errorStatus', errorStatus));
  }
}

@Deprecated(
  'Rename to `_\$AgentPermissionSpec` and migrate the class declaration to `class AgentPermissionSpec with _\$AgentPermissionSpec`. The `_\$AgentPermissionSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$AgentPermissionSpecMethods = _$AgentPermissionSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class AgentPermissionStyler
    extends MixStyler<AgentPermissionStyler, AgentPermissionSpec>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<BoxSpec>>? $content;
  final Prop<StyleSpec<FlexBoxSpec>>? $header;
  final Prop<StyleSpec<FlexBoxSpec>>? $actions;
  final Prop<StyleSpec<TextSpec>>? $title;
  final Prop<StyleSpec<TextSpec>>? $tool;
  final Prop<StyleSpec<TextSpec>>? $description;
  final Prop<StyleSpec<TextSpec>>? $status;
  final Prop<StyleSpec<TextSpec>>? $detailsLabel;
  final Prop<StyleSpec<IconSpec>>? $toolIcon;
  final Prop<StyleSpec<IconSpec>>? $statusIcon;
  final Prop<StyleSpec<IconSpec>>? $indicator;
  final Prop<StyleSpec<BoxSpec>>? $pendingStatus;
  final Prop<StyleSpec<BoxSpec>>? $decidingStatus;
  final Prop<StyleSpec<BoxSpec>>? $allowedStatus;
  final Prop<StyleSpec<BoxSpec>>? $runningStatus;
  final Prop<StyleSpec<BoxSpec>>? $completedStatus;
  final Prop<StyleSpec<BoxSpec>>? $deniedStatus;
  final Prop<StyleSpec<BoxSpec>>? $errorStatus;

  const AgentPermissionStyler.create({
    Prop<StyleSpec<BoxSpec>>? content,
    Prop<StyleSpec<FlexBoxSpec>>? header,
    Prop<StyleSpec<FlexBoxSpec>>? actions,
    Prop<StyleSpec<TextSpec>>? title,
    Prop<StyleSpec<TextSpec>>? tool,
    Prop<StyleSpec<TextSpec>>? description,
    Prop<StyleSpec<TextSpec>>? status,
    Prop<StyleSpec<TextSpec>>? detailsLabel,
    Prop<StyleSpec<IconSpec>>? toolIcon,
    Prop<StyleSpec<IconSpec>>? statusIcon,
    Prop<StyleSpec<IconSpec>>? indicator,
    Prop<StyleSpec<BoxSpec>>? pendingStatus,
    Prop<StyleSpec<BoxSpec>>? decidingStatus,
    Prop<StyleSpec<BoxSpec>>? allowedStatus,
    Prop<StyleSpec<BoxSpec>>? runningStatus,
    Prop<StyleSpec<BoxSpec>>? completedStatus,
    Prop<StyleSpec<BoxSpec>>? deniedStatus,
    Prop<StyleSpec<BoxSpec>>? errorStatus,
    super.variants,
    super.modifier,
    super.animation,
  }) : $content = content,
       $header = header,
       $actions = actions,
       $title = title,
       $tool = tool,
       $description = description,
       $status = status,
       $detailsLabel = detailsLabel,
       $toolIcon = toolIcon,
       $statusIcon = statusIcon,
       $indicator = indicator,
       $pendingStatus = pendingStatus,
       $decidingStatus = decidingStatus,
       $allowedStatus = allowedStatus,
       $runningStatus = runningStatus,
       $completedStatus = completedStatus,
       $deniedStatus = deniedStatus,
       $errorStatus = errorStatus;

  AgentPermissionStyler({
    BoxStyler? content,
    FlexBoxStyler? header,
    FlexBoxStyler? actions,
    TextStyler? title,
    TextStyler? tool,
    TextStyler? description,
    TextStyler? status,
    TextStyler? detailsLabel,
    IconStyler? toolIcon,
    IconStyler? statusIcon,
    IconStyler? indicator,
    BoxStyler? pendingStatus,
    BoxStyler? decidingStatus,
    BoxStyler? allowedStatus,
    BoxStyler? runningStatus,
    BoxStyler? completedStatus,
    BoxStyler? deniedStatus,
    BoxStyler? errorStatus,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<AgentPermissionSpec>>? variants,
  }) : this.create(
         content: Prop.maybeMix(content),
         header: Prop.maybeMix(header),
         actions: Prop.maybeMix(actions),
         title: Prop.maybeMix(title),
         tool: Prop.maybeMix(tool),
         description: Prop.maybeMix(description),
         status: Prop.maybeMix(status),
         detailsLabel: Prop.maybeMix(detailsLabel),
         toolIcon: Prop.maybeMix(toolIcon),
         statusIcon: Prop.maybeMix(statusIcon),
         indicator: Prop.maybeMix(indicator),
         pendingStatus: Prop.maybeMix(pendingStatus),
         decidingStatus: Prop.maybeMix(decidingStatus),
         allowedStatus: Prop.maybeMix(allowedStatus),
         runningStatus: Prop.maybeMix(runningStatus),
         completedStatus: Prop.maybeMix(completedStatus),
         deniedStatus: Prop.maybeMix(deniedStatus),
         errorStatus: Prop.maybeMix(errorStatus),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory AgentPermissionStyler.content(BoxStyler value) =>
      AgentPermissionStyler().content(value);
  factory AgentPermissionStyler.header(FlexBoxStyler value) =>
      AgentPermissionStyler().header(value);
  factory AgentPermissionStyler.actions(FlexBoxStyler value) =>
      AgentPermissionStyler().actions(value);
  factory AgentPermissionStyler.title(TextStyler value) =>
      AgentPermissionStyler().title(value);
  factory AgentPermissionStyler.tool(TextStyler value) =>
      AgentPermissionStyler().tool(value);
  factory AgentPermissionStyler.description(TextStyler value) =>
      AgentPermissionStyler().description(value);
  factory AgentPermissionStyler.status(TextStyler value) =>
      AgentPermissionStyler().status(value);
  factory AgentPermissionStyler.detailsLabel(TextStyler value) =>
      AgentPermissionStyler().detailsLabel(value);
  factory AgentPermissionStyler.toolIcon(IconStyler value) =>
      AgentPermissionStyler().toolIcon(value);
  factory AgentPermissionStyler.statusIcon(IconStyler value) =>
      AgentPermissionStyler().statusIcon(value);
  factory AgentPermissionStyler.indicator(IconStyler value) =>
      AgentPermissionStyler().indicator(value);
  factory AgentPermissionStyler.pendingStatus(BoxStyler value) =>
      AgentPermissionStyler().pendingStatus(value);
  factory AgentPermissionStyler.decidingStatus(BoxStyler value) =>
      AgentPermissionStyler().decidingStatus(value);
  factory AgentPermissionStyler.allowedStatus(BoxStyler value) =>
      AgentPermissionStyler().allowedStatus(value);
  factory AgentPermissionStyler.runningStatus(BoxStyler value) =>
      AgentPermissionStyler().runningStatus(value);
  factory AgentPermissionStyler.completedStatus(BoxStyler value) =>
      AgentPermissionStyler().completedStatus(value);
  factory AgentPermissionStyler.deniedStatus(BoxStyler value) =>
      AgentPermissionStyler().deniedStatus(value);
  factory AgentPermissionStyler.errorStatus(BoxStyler value) =>
      AgentPermissionStyler().errorStatus(value);

  @override
  Set<String> get $stylerFieldNames => const {
    'content',
    'header',
    'actions',
    'title',
    'tool',
    'description',
    'status',
    'detailsLabel',
    'toolIcon',
    'statusIcon',
    'indicator',
    'pendingStatus',
    'decidingStatus',
    'allowedStatus',
    'runningStatus',
    'completedStatus',
    'deniedStatus',
    'errorStatus',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the content.
  AgentPermissionStyler content(BoxStyler value) {
    return merge(AgentPermissionStyler(content: value));
  }

  /// Sets the header.
  AgentPermissionStyler header(FlexBoxStyler value) {
    return merge(AgentPermissionStyler(header: value));
  }

  /// Sets the actions.
  AgentPermissionStyler actions(FlexBoxStyler value) {
    return merge(AgentPermissionStyler(actions: value));
  }

  /// Sets the title.
  AgentPermissionStyler title(TextStyler value) {
    return merge(AgentPermissionStyler(title: value));
  }

  /// Sets the tool.
  AgentPermissionStyler tool(TextStyler value) {
    return merge(AgentPermissionStyler(tool: value));
  }

  /// Sets the description.
  AgentPermissionStyler description(TextStyler value) {
    return merge(AgentPermissionStyler(description: value));
  }

  /// Sets the status.
  AgentPermissionStyler status(TextStyler value) {
    return merge(AgentPermissionStyler(status: value));
  }

  /// Sets the detailsLabel.
  AgentPermissionStyler detailsLabel(TextStyler value) {
    return merge(AgentPermissionStyler(detailsLabel: value));
  }

  /// Sets the toolIcon.
  AgentPermissionStyler toolIcon(IconStyler value) {
    return merge(AgentPermissionStyler(toolIcon: value));
  }

  /// Sets the statusIcon.
  AgentPermissionStyler statusIcon(IconStyler value) {
    return merge(AgentPermissionStyler(statusIcon: value));
  }

  /// Sets the indicator.
  AgentPermissionStyler indicator(IconStyler value) {
    return merge(AgentPermissionStyler(indicator: value));
  }

  /// Sets the pendingStatus.
  AgentPermissionStyler pendingStatus(BoxStyler value) {
    return merge(AgentPermissionStyler(pendingStatus: value));
  }

  /// Sets the decidingStatus.
  AgentPermissionStyler decidingStatus(BoxStyler value) {
    return merge(AgentPermissionStyler(decidingStatus: value));
  }

  /// Sets the allowedStatus.
  AgentPermissionStyler allowedStatus(BoxStyler value) {
    return merge(AgentPermissionStyler(allowedStatus: value));
  }

  /// Sets the runningStatus.
  AgentPermissionStyler runningStatus(BoxStyler value) {
    return merge(AgentPermissionStyler(runningStatus: value));
  }

  /// Sets the completedStatus.
  AgentPermissionStyler completedStatus(BoxStyler value) {
    return merge(AgentPermissionStyler(completedStatus: value));
  }

  /// Sets the deniedStatus.
  AgentPermissionStyler deniedStatus(BoxStyler value) {
    return merge(AgentPermissionStyler(deniedStatus: value));
  }

  /// Sets the errorStatus.
  AgentPermissionStyler errorStatus(BoxStyler value) {
    return merge(AgentPermissionStyler(errorStatus: value));
  }

  /// Sets the animation configuration.
  @override
  AgentPermissionStyler animate(AnimationConfig value) {
    return merge(AgentPermissionStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  AgentPermissionStyler variants(
    List<VariantStyle<AgentPermissionSpec>> value,
  ) {
    return merge(AgentPermissionStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  AgentPermissionStyler wrap(WidgetModifierConfig value) {
    return merge(AgentPermissionStyler(modifier: value));
  }

  /// Sets the widget modifier.
  AgentPermissionStyler modifier(WidgetModifierConfig value) {
    return merge(AgentPermissionStyler(modifier: value));
  }

  AgentPermission call({
    Key? key,
    required String tool,
    Object? requestId,
    String title = 'Allow this tool to run?',
    String? description,
    AgentPermissionStatus status = AgentPermissionStatus.pending,
    List<RemixDataListItem> parameters = const [],
    bool showParameters = true,
    bool? detailsExpanded,
    bool defaultDetailsExpanded = false,
    ValueChanged<bool>? onDetailsExpandedChanged,
    VoidCallback? onAllowOnce,
    VoidCallback? onAlwaysAllow,
    VoidCallback? onDeny,
    AgentPermissionStatusLabelBuilder? statusLabelBuilder,
    AgentPermissionStatusBuilder? statusBuilder,
    AgentPermissionIndicatorBuilder? indicatorBuilder,
    String allowOnceLabel = 'Allow once',
    String alwaysAllowLabel = 'Always allow',
    String denyLabel = 'Deny',
    String detailsLabel = 'View details',
    String semanticLabel = 'Tool permission',
    Axis parameterOrientation = Axis.horizontal,
    CardStyler surfaceStyle = const CardStyler.create(),
    DisclosureStyler detailsStyle = const DisclosureStyler.create(),
    DataListStyler parametersStyle = const DataListStyler.create(),
    ButtonStyler allowOnceStyle = const ButtonStyler.create(),
    ButtonStyler alwaysAllowStyle = const ButtonStyler.create(),
    ButtonStyler denyStyle = const ButtonStyler.create(),
  }) {
    return AgentPermission(
      key: key,
      style: this,
      tool: tool,
      requestId: requestId,
      title: title,
      description: description,
      status: status,
      parameters: parameters,
      showParameters: showParameters,
      detailsExpanded: detailsExpanded,
      defaultDetailsExpanded: defaultDetailsExpanded,
      onDetailsExpandedChanged: onDetailsExpandedChanged,
      onAllowOnce: onAllowOnce,
      onAlwaysAllow: onAlwaysAllow,
      onDeny: onDeny,
      statusLabelBuilder: statusLabelBuilder,
      statusBuilder: statusBuilder,
      indicatorBuilder: indicatorBuilder,
      allowOnceLabel: allowOnceLabel,
      alwaysAllowLabel: alwaysAllowLabel,
      denyLabel: denyLabel,
      detailsLabel: detailsLabel,
      semanticLabel: semanticLabel,
      parameterOrientation: parameterOrientation,
      surfaceStyle: surfaceStyle,
      detailsStyle: detailsStyle,
      parametersStyle: parametersStyle,
      allowOnceStyle: allowOnceStyle,
      alwaysAllowStyle: alwaysAllowStyle,
      denyStyle: denyStyle,
    );
  }

  /// Merges with another [AgentPermissionStyler].
  @override
  AgentPermissionStyler merge(AgentPermissionStyler? other) {
    return AgentPermissionStyler.create(
      content: MixOps.merge($content, other?.$content),
      header: MixOps.merge($header, other?.$header),
      actions: MixOps.merge($actions, other?.$actions),
      title: MixOps.merge($title, other?.$title),
      tool: MixOps.merge($tool, other?.$tool),
      description: MixOps.merge($description, other?.$description),
      status: MixOps.merge($status, other?.$status),
      detailsLabel: MixOps.merge($detailsLabel, other?.$detailsLabel),
      toolIcon: MixOps.merge($toolIcon, other?.$toolIcon),
      statusIcon: MixOps.merge($statusIcon, other?.$statusIcon),
      indicator: MixOps.merge($indicator, other?.$indicator),
      pendingStatus: MixOps.merge($pendingStatus, other?.$pendingStatus),
      decidingStatus: MixOps.merge($decidingStatus, other?.$decidingStatus),
      allowedStatus: MixOps.merge($allowedStatus, other?.$allowedStatus),
      runningStatus: MixOps.merge($runningStatus, other?.$runningStatus),
      completedStatus: MixOps.merge($completedStatus, other?.$completedStatus),
      deniedStatus: MixOps.merge($deniedStatus, other?.$deniedStatus),
      errorStatus: MixOps.merge($errorStatus, other?.$errorStatus),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<AgentPermissionSpec>] using [context].
  @override
  StyleSpec<AgentPermissionSpec> resolve(BuildContext context) {
    final spec = AgentPermissionSpec(
      content: MixOps.resolve(context, $content),
      header: MixOps.resolve(context, $header),
      actions: MixOps.resolve(context, $actions),
      title: MixOps.resolve(context, $title),
      tool: MixOps.resolve(context, $tool),
      description: MixOps.resolve(context, $description),
      status: MixOps.resolve(context, $status),
      detailsLabel: MixOps.resolve(context, $detailsLabel),
      toolIcon: MixOps.resolve(context, $toolIcon),
      statusIcon: MixOps.resolve(context, $statusIcon),
      indicator: MixOps.resolve(context, $indicator),
      pendingStatus: MixOps.resolve(context, $pendingStatus),
      decidingStatus: MixOps.resolve(context, $decidingStatus),
      allowedStatus: MixOps.resolve(context, $allowedStatus),
      runningStatus: MixOps.resolve(context, $runningStatus),
      completedStatus: MixOps.resolve(context, $completedStatus),
      deniedStatus: MixOps.resolve(context, $deniedStatus),
      errorStatus: MixOps.resolve(context, $errorStatus),
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
      ..add(DiagnosticsProperty('content', $content))
      ..add(DiagnosticsProperty('header', $header))
      ..add(DiagnosticsProperty('actions', $actions))
      ..add(DiagnosticsProperty('title', $title))
      ..add(DiagnosticsProperty('tool', $tool))
      ..add(DiagnosticsProperty('description', $description))
      ..add(DiagnosticsProperty('status', $status))
      ..add(DiagnosticsProperty('detailsLabel', $detailsLabel))
      ..add(DiagnosticsProperty('toolIcon', $toolIcon))
      ..add(DiagnosticsProperty('statusIcon', $statusIcon))
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('pendingStatus', $pendingStatus))
      ..add(DiagnosticsProperty('decidingStatus', $decidingStatus))
      ..add(DiagnosticsProperty('allowedStatus', $allowedStatus))
      ..add(DiagnosticsProperty('runningStatus', $runningStatus))
      ..add(DiagnosticsProperty('completedStatus', $completedStatus))
      ..add(DiagnosticsProperty('deniedStatus', $deniedStatus))
      ..add(DiagnosticsProperty('errorStatus', $errorStatus));
  }

  @override
  List<Object?> get props => [
    $content,
    $header,
    $actions,
    $title,
    $tool,
    $description,
    $status,
    $detailsLabel,
    $toolIcon,
    $statusIcon,
    $indicator,
    $pendingStatus,
    $decidingStatus,
    $allowedStatus,
    $runningStatus,
    $completedStatus,
    $deniedStatus,
    $errorStatus,
    $animation,
    $modifier,
    $variants,
  ];
}
