// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$AgentActivitySpec implements Spec<AgentActivitySpec>, Diagnosticable {
  StyleSpec<BoxSpec> get viewport;
  StyleSpec<FlexBoxSpec> get item;
  StyleSpec<TextSpec> get summaryTitle;
  StyleSpec<TextSpec> get itemTitle;
  StyleSpec<TextSpec> get itemDetail;
  StyleSpec<IconSpec> get indicator;
  StyleSpec<BoxSpec> get pendingItem;
  StyleSpec<BoxSpec> get activeItem;
  StyleSpec<BoxSpec> get completedItem;
  StyleSpec<IconSpec> get pendingStatus;
  StyleSpec<IconSpec> get activeStatus;
  StyleSpec<IconSpec> get completedStatus;

  @override
  Type get type => AgentActivitySpec;

  @override
  AgentActivitySpec copyWith({
    StyleSpec<BoxSpec>? viewport,
    StyleSpec<FlexBoxSpec>? item,
    StyleSpec<TextSpec>? summaryTitle,
    StyleSpec<TextSpec>? itemTitle,
    StyleSpec<TextSpec>? itemDetail,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<BoxSpec>? pendingItem,
    StyleSpec<BoxSpec>? activeItem,
    StyleSpec<BoxSpec>? completedItem,
    StyleSpec<IconSpec>? pendingStatus,
    StyleSpec<IconSpec>? activeStatus,
    StyleSpec<IconSpec>? completedStatus,
  }) {
    return AgentActivitySpec(
      viewport: viewport ?? this.viewport,
      item: item ?? this.item,
      summaryTitle: summaryTitle ?? this.summaryTitle,
      itemTitle: itemTitle ?? this.itemTitle,
      itemDetail: itemDetail ?? this.itemDetail,
      indicator: indicator ?? this.indicator,
      pendingItem: pendingItem ?? this.pendingItem,
      activeItem: activeItem ?? this.activeItem,
      completedItem: completedItem ?? this.completedItem,
      pendingStatus: pendingStatus ?? this.pendingStatus,
      activeStatus: activeStatus ?? this.activeStatus,
      completedStatus: completedStatus ?? this.completedStatus,
    );
  }

  @override
  AgentActivitySpec lerp(AgentActivitySpec? other, double t) {
    return AgentActivitySpec(
      viewport: viewport.lerp(other?.viewport, t),
      item: item.lerp(other?.item, t),
      summaryTitle: summaryTitle.lerp(other?.summaryTitle, t),
      itemTitle: itemTitle.lerp(other?.itemTitle, t),
      itemDetail: itemDetail.lerp(other?.itemDetail, t),
      indicator: indicator.lerp(other?.indicator, t),
      pendingItem: pendingItem.lerp(other?.pendingItem, t),
      activeItem: activeItem.lerp(other?.activeItem, t),
      completedItem: completedItem.lerp(other?.completedItem, t),
      pendingStatus: pendingStatus.lerp(other?.pendingStatus, t),
      activeStatus: activeStatus.lerp(other?.activeStatus, t),
      completedStatus: completedStatus.lerp(other?.completedStatus, t),
    );
  }

  @override
  List<Object?> get props => [
    viewport,
    item,
    summaryTitle,
    itemTitle,
    itemDetail,
    indicator,
    pendingItem,
    activeItem,
    completedItem,
    pendingStatus,
    activeStatus,
    completedStatus,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AgentActivitySpec &&
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
      ..add(DiagnosticsProperty('summaryTitle', summaryTitle))
      ..add(DiagnosticsProperty('itemTitle', itemTitle))
      ..add(DiagnosticsProperty('itemDetail', itemDetail))
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('pendingItem', pendingItem))
      ..add(DiagnosticsProperty('activeItem', activeItem))
      ..add(DiagnosticsProperty('completedItem', completedItem))
      ..add(DiagnosticsProperty('pendingStatus', pendingStatus))
      ..add(DiagnosticsProperty('activeStatus', activeStatus))
      ..add(DiagnosticsProperty('completedStatus', completedStatus));
  }
}

@Deprecated(
  'Rename to `_\$AgentActivitySpec` and migrate the class declaration to `class AgentActivitySpec with _\$AgentActivitySpec`. The `_\$AgentActivitySpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$AgentActivitySpecMethods = _$AgentActivitySpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class AgentActivityStyler
    extends MixStyler<AgentActivityStyler, AgentActivitySpec> {
  final Prop<StyleSpec<BoxSpec>>? $viewport;
  final Prop<StyleSpec<FlexBoxSpec>>? $item;
  final Prop<StyleSpec<TextSpec>>? $summaryTitle;
  final Prop<StyleSpec<TextSpec>>? $itemTitle;
  final Prop<StyleSpec<TextSpec>>? $itemDetail;
  final Prop<StyleSpec<IconSpec>>? $indicator;
  final Prop<StyleSpec<BoxSpec>>? $pendingItem;
  final Prop<StyleSpec<BoxSpec>>? $activeItem;
  final Prop<StyleSpec<BoxSpec>>? $completedItem;
  final Prop<StyleSpec<IconSpec>>? $pendingStatus;
  final Prop<StyleSpec<IconSpec>>? $activeStatus;
  final Prop<StyleSpec<IconSpec>>? $completedStatus;

  const AgentActivityStyler.create({
    Prop<StyleSpec<BoxSpec>>? viewport,
    Prop<StyleSpec<FlexBoxSpec>>? item,
    Prop<StyleSpec<TextSpec>>? summaryTitle,
    Prop<StyleSpec<TextSpec>>? itemTitle,
    Prop<StyleSpec<TextSpec>>? itemDetail,
    Prop<StyleSpec<IconSpec>>? indicator,
    Prop<StyleSpec<BoxSpec>>? pendingItem,
    Prop<StyleSpec<BoxSpec>>? activeItem,
    Prop<StyleSpec<BoxSpec>>? completedItem,
    Prop<StyleSpec<IconSpec>>? pendingStatus,
    Prop<StyleSpec<IconSpec>>? activeStatus,
    Prop<StyleSpec<IconSpec>>? completedStatus,
    super.variants,
    super.modifier,
    super.animation,
  }) : $viewport = viewport,
       $item = item,
       $summaryTitle = summaryTitle,
       $itemTitle = itemTitle,
       $itemDetail = itemDetail,
       $indicator = indicator,
       $pendingItem = pendingItem,
       $activeItem = activeItem,
       $completedItem = completedItem,
       $pendingStatus = pendingStatus,
       $activeStatus = activeStatus,
       $completedStatus = completedStatus;

  AgentActivityStyler({
    BoxStyler? viewport,
    FlexBoxStyler? item,
    TextStyler? summaryTitle,
    TextStyler? itemTitle,
    TextStyler? itemDetail,
    IconStyler? indicator,
    BoxStyler? pendingItem,
    BoxStyler? activeItem,
    BoxStyler? completedItem,
    IconStyler? pendingStatus,
    IconStyler? activeStatus,
    IconStyler? completedStatus,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<AgentActivitySpec>>? variants,
  }) : this.create(
         viewport: Prop.maybeMix(viewport),
         item: Prop.maybeMix(item),
         summaryTitle: Prop.maybeMix(summaryTitle),
         itemTitle: Prop.maybeMix(itemTitle),
         itemDetail: Prop.maybeMix(itemDetail),
         indicator: Prop.maybeMix(indicator),
         pendingItem: Prop.maybeMix(pendingItem),
         activeItem: Prop.maybeMix(activeItem),
         completedItem: Prop.maybeMix(completedItem),
         pendingStatus: Prop.maybeMix(pendingStatus),
         activeStatus: Prop.maybeMix(activeStatus),
         completedStatus: Prop.maybeMix(completedStatus),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory AgentActivityStyler.viewport(BoxStyler value) =>
      AgentActivityStyler().viewport(value);
  factory AgentActivityStyler.item(FlexBoxStyler value) =>
      AgentActivityStyler().item(value);
  factory AgentActivityStyler.summaryTitle(TextStyler value) =>
      AgentActivityStyler().summaryTitle(value);
  factory AgentActivityStyler.itemTitle(TextStyler value) =>
      AgentActivityStyler().itemTitle(value);
  factory AgentActivityStyler.itemDetail(TextStyler value) =>
      AgentActivityStyler().itemDetail(value);
  factory AgentActivityStyler.indicator(IconStyler value) =>
      AgentActivityStyler().indicator(value);
  factory AgentActivityStyler.pendingItem(BoxStyler value) =>
      AgentActivityStyler().pendingItem(value);
  factory AgentActivityStyler.activeItem(BoxStyler value) =>
      AgentActivityStyler().activeItem(value);
  factory AgentActivityStyler.completedItem(BoxStyler value) =>
      AgentActivityStyler().completedItem(value);
  factory AgentActivityStyler.pendingStatus(IconStyler value) =>
      AgentActivityStyler().pendingStatus(value);
  factory AgentActivityStyler.activeStatus(IconStyler value) =>
      AgentActivityStyler().activeStatus(value);
  factory AgentActivityStyler.completedStatus(IconStyler value) =>
      AgentActivityStyler().completedStatus(value);

  /// Sets the viewport.
  AgentActivityStyler viewport(BoxStyler value) {
    return merge(AgentActivityStyler(viewport: value));
  }

  /// Sets the item.
  AgentActivityStyler item(FlexBoxStyler value) {
    return merge(AgentActivityStyler(item: value));
  }

  /// Sets the summaryTitle.
  AgentActivityStyler summaryTitle(TextStyler value) {
    return merge(AgentActivityStyler(summaryTitle: value));
  }

  /// Sets the itemTitle.
  AgentActivityStyler itemTitle(TextStyler value) {
    return merge(AgentActivityStyler(itemTitle: value));
  }

  /// Sets the itemDetail.
  AgentActivityStyler itemDetail(TextStyler value) {
    return merge(AgentActivityStyler(itemDetail: value));
  }

  /// Sets the indicator.
  AgentActivityStyler indicator(IconStyler value) {
    return merge(AgentActivityStyler(indicator: value));
  }

  /// Sets the pendingItem.
  AgentActivityStyler pendingItem(BoxStyler value) {
    return merge(AgentActivityStyler(pendingItem: value));
  }

  /// Sets the activeItem.
  AgentActivityStyler activeItem(BoxStyler value) {
    return merge(AgentActivityStyler(activeItem: value));
  }

  /// Sets the completedItem.
  AgentActivityStyler completedItem(BoxStyler value) {
    return merge(AgentActivityStyler(completedItem: value));
  }

  /// Sets the pendingStatus.
  AgentActivityStyler pendingStatus(IconStyler value) {
    return merge(AgentActivityStyler(pendingStatus: value));
  }

  /// Sets the activeStatus.
  AgentActivityStyler activeStatus(IconStyler value) {
    return merge(AgentActivityStyler(activeStatus: value));
  }

  /// Sets the completedStatus.
  AgentActivityStyler completedStatus(IconStyler value) {
    return merge(AgentActivityStyler(completedStatus: value));
  }

  /// Sets the animation configuration.
  @override
  AgentActivityStyler animate(AnimationConfig value) {
    return merge(AgentActivityStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  AgentActivityStyler variants(List<VariantStyle<AgentActivitySpec>> value) {
    return merge(AgentActivityStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  AgentActivityStyler wrap(WidgetModifierConfig value) {
    return merge(AgentActivityStyler(modifier: value));
  }

  /// Sets the widget modifier.
  AgentActivityStyler modifier(WidgetModifierConfig value) {
    return merge(AgentActivityStyler(modifier: value));
  }

  AgentActivity call({
    Key? key,
    required List<AgentActivityItem> items,
    AgentRunStatus status = AgentRunStatus.working,
    String title = 'Activity',
    String semanticLabel = 'Activity',
    bool collapseOnComplete = true,
    bool? expanded,
    bool defaultExpanded = true,
    ValueChanged<bool>? onExpandedChanged,
    AgentActivityStatusBuilder? statusBuilder,
    AgentActivityStatusLabelBuilder? statusLabelBuilder,
    AgentActivityIndicatorBuilder? indicatorBuilder,
    bool followOutput = true,
    double followThreshold = 48,
    ValueChanged<bool>? onFollowChanged,
    DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
  }) {
    return AgentActivity(
      key: key,
      style: this,
      items: items,
      status: status,
      title: title,
      semanticLabel: semanticLabel,
      collapseOnComplete: collapseOnComplete,
      expanded: expanded,
      defaultExpanded: defaultExpanded,
      onExpandedChanged: onExpandedChanged,
      statusBuilder: statusBuilder,
      statusLabelBuilder: statusLabelBuilder,
      indicatorBuilder: indicatorBuilder,
      followOutput: followOutput,
      followThreshold: followThreshold,
      onFollowChanged: onFollowChanged,
      disclosureStyle: disclosureStyle,
    );
  }

  /// Merges with another [AgentActivityStyler].
  @override
  AgentActivityStyler merge(AgentActivityStyler? other) {
    return AgentActivityStyler.create(
      viewport: MixOps.merge($viewport, other?.$viewport),
      item: MixOps.merge($item, other?.$item),
      summaryTitle: MixOps.merge($summaryTitle, other?.$summaryTitle),
      itemTitle: MixOps.merge($itemTitle, other?.$itemTitle),
      itemDetail: MixOps.merge($itemDetail, other?.$itemDetail),
      indicator: MixOps.merge($indicator, other?.$indicator),
      pendingItem: MixOps.merge($pendingItem, other?.$pendingItem),
      activeItem: MixOps.merge($activeItem, other?.$activeItem),
      completedItem: MixOps.merge($completedItem, other?.$completedItem),
      pendingStatus: MixOps.merge($pendingStatus, other?.$pendingStatus),
      activeStatus: MixOps.merge($activeStatus, other?.$activeStatus),
      completedStatus: MixOps.merge($completedStatus, other?.$completedStatus),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<AgentActivitySpec>] using [context].
  @override
  StyleSpec<AgentActivitySpec> resolve(BuildContext context) {
    final spec = AgentActivitySpec(
      viewport: MixOps.resolve(context, $viewport),
      item: MixOps.resolve(context, $item),
      summaryTitle: MixOps.resolve(context, $summaryTitle),
      itemTitle: MixOps.resolve(context, $itemTitle),
      itemDetail: MixOps.resolve(context, $itemDetail),
      indicator: MixOps.resolve(context, $indicator),
      pendingItem: MixOps.resolve(context, $pendingItem),
      activeItem: MixOps.resolve(context, $activeItem),
      completedItem: MixOps.resolve(context, $completedItem),
      pendingStatus: MixOps.resolve(context, $pendingStatus),
      activeStatus: MixOps.resolve(context, $activeStatus),
      completedStatus: MixOps.resolve(context, $completedStatus),
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
      ..add(DiagnosticsProperty('summaryTitle', $summaryTitle))
      ..add(DiagnosticsProperty('itemTitle', $itemTitle))
      ..add(DiagnosticsProperty('itemDetail', $itemDetail))
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('pendingItem', $pendingItem))
      ..add(DiagnosticsProperty('activeItem', $activeItem))
      ..add(DiagnosticsProperty('completedItem', $completedItem))
      ..add(DiagnosticsProperty('pendingStatus', $pendingStatus))
      ..add(DiagnosticsProperty('activeStatus', $activeStatus))
      ..add(DiagnosticsProperty('completedStatus', $completedStatus));
  }

  @override
  List<Object?> get props => [
    $viewport,
    $item,
    $summaryTitle,
    $itemTitle,
    $itemDetail,
    $indicator,
    $pendingItem,
    $activeItem,
    $completedItem,
    $pendingStatus,
    $activeStatus,
    $completedStatus,
    $animation,
    $modifier,
    $variants,
  ];
}
