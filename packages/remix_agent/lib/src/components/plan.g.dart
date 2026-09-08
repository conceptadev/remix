// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$AgentPlanSpec implements Spec<AgentPlanSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get viewport;
  StyleSpec<FlexBoxSpec> get item;
  StyleSpec<TextSpec> get summaryTitle;
  StyleSpec<TextSpec> get itemTitle;
  StyleSpec<TextSpec> get itemDetail;
  StyleSpec<TextSpec> get count;
  StyleSpec<IconSpec> get indicator;
  StyleSpec<BoxSpec> get pendingItem;
  StyleSpec<BoxSpec> get activeItem;
  StyleSpec<BoxSpec> get completedItem;
  StyleSpec<BoxSpec> get cancelledItem;
  StyleSpec<IconSpec> get pendingStatus;
  StyleSpec<IconSpec> get activeStatus;
  StyleSpec<IconSpec> get completedStatus;
  StyleSpec<IconSpec> get cancelledStatus;

  @override
  Type get type => AgentPlanSpec;

  @override
  AgentPlanSpec copyWith({
    StyleSpec<BoxSpec>? viewport,
    StyleSpec<FlexBoxSpec>? item,
    StyleSpec<TextSpec>? summaryTitle,
    StyleSpec<TextSpec>? itemTitle,
    StyleSpec<TextSpec>? itemDetail,
    StyleSpec<TextSpec>? count,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<BoxSpec>? pendingItem,
    StyleSpec<BoxSpec>? activeItem,
    StyleSpec<BoxSpec>? completedItem,
    StyleSpec<BoxSpec>? cancelledItem,
    StyleSpec<IconSpec>? pendingStatus,
    StyleSpec<IconSpec>? activeStatus,
    StyleSpec<IconSpec>? completedStatus,
    StyleSpec<IconSpec>? cancelledStatus,
  }) {
    return AgentPlanSpec(
      viewport: viewport ?? this.viewport,
      item: item ?? this.item,
      summaryTitle: summaryTitle ?? this.summaryTitle,
      itemTitle: itemTitle ?? this.itemTitle,
      itemDetail: itemDetail ?? this.itemDetail,
      count: count ?? this.count,
      indicator: indicator ?? this.indicator,
      pendingItem: pendingItem ?? this.pendingItem,
      activeItem: activeItem ?? this.activeItem,
      completedItem: completedItem ?? this.completedItem,
      cancelledItem: cancelledItem ?? this.cancelledItem,
      pendingStatus: pendingStatus ?? this.pendingStatus,
      activeStatus: activeStatus ?? this.activeStatus,
      completedStatus: completedStatus ?? this.completedStatus,
      cancelledStatus: cancelledStatus ?? this.cancelledStatus,
    );
  }

  @override
  AgentPlanSpec lerp(AgentPlanSpec? other, double t) {
    return AgentPlanSpec(
      viewport: viewport.lerp(other?.viewport, t),
      item: item.lerp(other?.item, t),
      summaryTitle: summaryTitle.lerp(other?.summaryTitle, t),
      itemTitle: itemTitle.lerp(other?.itemTitle, t),
      itemDetail: itemDetail.lerp(other?.itemDetail, t),
      count: count.lerp(other?.count, t),
      indicator: indicator.lerp(other?.indicator, t),
      pendingItem: pendingItem.lerp(other?.pendingItem, t),
      activeItem: activeItem.lerp(other?.activeItem, t),
      completedItem: completedItem.lerp(other?.completedItem, t),
      cancelledItem: cancelledItem.lerp(other?.cancelledItem, t),
      pendingStatus: pendingStatus.lerp(other?.pendingStatus, t),
      activeStatus: activeStatus.lerp(other?.activeStatus, t),
      completedStatus: completedStatus.lerp(other?.completedStatus, t),
      cancelledStatus: cancelledStatus.lerp(other?.cancelledStatus, t),
    );
  }

  @override
  List<Object?> get props => [
    viewport,
    item,
    summaryTitle,
    itemTitle,
    itemDetail,
    count,
    indicator,
    pendingItem,
    activeItem,
    completedItem,
    cancelledItem,
    pendingStatus,
    activeStatus,
    completedStatus,
    cancelledStatus,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AgentPlanSpec &&
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
      ..add(DiagnosticsProperty('count', count))
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('pendingItem', pendingItem))
      ..add(DiagnosticsProperty('activeItem', activeItem))
      ..add(DiagnosticsProperty('completedItem', completedItem))
      ..add(DiagnosticsProperty('cancelledItem', cancelledItem))
      ..add(DiagnosticsProperty('pendingStatus', pendingStatus))
      ..add(DiagnosticsProperty('activeStatus', activeStatus))
      ..add(DiagnosticsProperty('completedStatus', completedStatus))
      ..add(DiagnosticsProperty('cancelledStatus', cancelledStatus));
  }
}

@Deprecated(
  'Rename to `_\$AgentPlanSpec` and migrate the class declaration to `class AgentPlanSpec with _\$AgentPlanSpec`. The `_\$AgentPlanSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$AgentPlanSpecMethods = _$AgentPlanSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class AgentPlanStyler extends MixStyler<AgentPlanStyler, AgentPlanSpec> {
  final Prop<StyleSpec<BoxSpec>>? $viewport;
  final Prop<StyleSpec<FlexBoxSpec>>? $item;
  final Prop<StyleSpec<TextSpec>>? $summaryTitle;
  final Prop<StyleSpec<TextSpec>>? $itemTitle;
  final Prop<StyleSpec<TextSpec>>? $itemDetail;
  final Prop<StyleSpec<TextSpec>>? $count;
  final Prop<StyleSpec<IconSpec>>? $indicator;
  final Prop<StyleSpec<BoxSpec>>? $pendingItem;
  final Prop<StyleSpec<BoxSpec>>? $activeItem;
  final Prop<StyleSpec<BoxSpec>>? $completedItem;
  final Prop<StyleSpec<BoxSpec>>? $cancelledItem;
  final Prop<StyleSpec<IconSpec>>? $pendingStatus;
  final Prop<StyleSpec<IconSpec>>? $activeStatus;
  final Prop<StyleSpec<IconSpec>>? $completedStatus;
  final Prop<StyleSpec<IconSpec>>? $cancelledStatus;

  const AgentPlanStyler.create({
    Prop<StyleSpec<BoxSpec>>? viewport,
    Prop<StyleSpec<FlexBoxSpec>>? item,
    Prop<StyleSpec<TextSpec>>? summaryTitle,
    Prop<StyleSpec<TextSpec>>? itemTitle,
    Prop<StyleSpec<TextSpec>>? itemDetail,
    Prop<StyleSpec<TextSpec>>? count,
    Prop<StyleSpec<IconSpec>>? indicator,
    Prop<StyleSpec<BoxSpec>>? pendingItem,
    Prop<StyleSpec<BoxSpec>>? activeItem,
    Prop<StyleSpec<BoxSpec>>? completedItem,
    Prop<StyleSpec<BoxSpec>>? cancelledItem,
    Prop<StyleSpec<IconSpec>>? pendingStatus,
    Prop<StyleSpec<IconSpec>>? activeStatus,
    Prop<StyleSpec<IconSpec>>? completedStatus,
    Prop<StyleSpec<IconSpec>>? cancelledStatus,
    super.variants,
    super.modifier,
    super.animation,
  }) : $viewport = viewport,
       $item = item,
       $summaryTitle = summaryTitle,
       $itemTitle = itemTitle,
       $itemDetail = itemDetail,
       $count = count,
       $indicator = indicator,
       $pendingItem = pendingItem,
       $activeItem = activeItem,
       $completedItem = completedItem,
       $cancelledItem = cancelledItem,
       $pendingStatus = pendingStatus,
       $activeStatus = activeStatus,
       $completedStatus = completedStatus,
       $cancelledStatus = cancelledStatus;

  AgentPlanStyler({
    BoxStyler? viewport,
    FlexBoxStyler? item,
    TextStyler? summaryTitle,
    TextStyler? itemTitle,
    TextStyler? itemDetail,
    TextStyler? count,
    IconStyler? indicator,
    BoxStyler? pendingItem,
    BoxStyler? activeItem,
    BoxStyler? completedItem,
    BoxStyler? cancelledItem,
    IconStyler? pendingStatus,
    IconStyler? activeStatus,
    IconStyler? completedStatus,
    IconStyler? cancelledStatus,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<AgentPlanSpec>>? variants,
  }) : this.create(
         viewport: Prop.maybeMix(viewport),
         item: Prop.maybeMix(item),
         summaryTitle: Prop.maybeMix(summaryTitle),
         itemTitle: Prop.maybeMix(itemTitle),
         itemDetail: Prop.maybeMix(itemDetail),
         count: Prop.maybeMix(count),
         indicator: Prop.maybeMix(indicator),
         pendingItem: Prop.maybeMix(pendingItem),
         activeItem: Prop.maybeMix(activeItem),
         completedItem: Prop.maybeMix(completedItem),
         cancelledItem: Prop.maybeMix(cancelledItem),
         pendingStatus: Prop.maybeMix(pendingStatus),
         activeStatus: Prop.maybeMix(activeStatus),
         completedStatus: Prop.maybeMix(completedStatus),
         cancelledStatus: Prop.maybeMix(cancelledStatus),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory AgentPlanStyler.viewport(BoxStyler value) =>
      AgentPlanStyler().viewport(value);
  factory AgentPlanStyler.item(FlexBoxStyler value) =>
      AgentPlanStyler().item(value);
  factory AgentPlanStyler.summaryTitle(TextStyler value) =>
      AgentPlanStyler().summaryTitle(value);
  factory AgentPlanStyler.itemTitle(TextStyler value) =>
      AgentPlanStyler().itemTitle(value);
  factory AgentPlanStyler.itemDetail(TextStyler value) =>
      AgentPlanStyler().itemDetail(value);
  factory AgentPlanStyler.count(TextStyler value) =>
      AgentPlanStyler().count(value);
  factory AgentPlanStyler.indicator(IconStyler value) =>
      AgentPlanStyler().indicator(value);
  factory AgentPlanStyler.pendingItem(BoxStyler value) =>
      AgentPlanStyler().pendingItem(value);
  factory AgentPlanStyler.activeItem(BoxStyler value) =>
      AgentPlanStyler().activeItem(value);
  factory AgentPlanStyler.completedItem(BoxStyler value) =>
      AgentPlanStyler().completedItem(value);
  factory AgentPlanStyler.cancelledItem(BoxStyler value) =>
      AgentPlanStyler().cancelledItem(value);
  factory AgentPlanStyler.pendingStatus(IconStyler value) =>
      AgentPlanStyler().pendingStatus(value);
  factory AgentPlanStyler.activeStatus(IconStyler value) =>
      AgentPlanStyler().activeStatus(value);
  factory AgentPlanStyler.completedStatus(IconStyler value) =>
      AgentPlanStyler().completedStatus(value);
  factory AgentPlanStyler.cancelledStatus(IconStyler value) =>
      AgentPlanStyler().cancelledStatus(value);

  /// Sets the viewport.
  AgentPlanStyler viewport(BoxStyler value) {
    return merge(AgentPlanStyler(viewport: value));
  }

  /// Sets the item.
  AgentPlanStyler item(FlexBoxStyler value) {
    return merge(AgentPlanStyler(item: value));
  }

  /// Sets the summaryTitle.
  AgentPlanStyler summaryTitle(TextStyler value) {
    return merge(AgentPlanStyler(summaryTitle: value));
  }

  /// Sets the itemTitle.
  AgentPlanStyler itemTitle(TextStyler value) {
    return merge(AgentPlanStyler(itemTitle: value));
  }

  /// Sets the itemDetail.
  AgentPlanStyler itemDetail(TextStyler value) {
    return merge(AgentPlanStyler(itemDetail: value));
  }

  /// Sets the count.
  AgentPlanStyler count(TextStyler value) {
    return merge(AgentPlanStyler(count: value));
  }

  /// Sets the indicator.
  AgentPlanStyler indicator(IconStyler value) {
    return merge(AgentPlanStyler(indicator: value));
  }

  /// Sets the pendingItem.
  AgentPlanStyler pendingItem(BoxStyler value) {
    return merge(AgentPlanStyler(pendingItem: value));
  }

  /// Sets the activeItem.
  AgentPlanStyler activeItem(BoxStyler value) {
    return merge(AgentPlanStyler(activeItem: value));
  }

  /// Sets the completedItem.
  AgentPlanStyler completedItem(BoxStyler value) {
    return merge(AgentPlanStyler(completedItem: value));
  }

  /// Sets the cancelledItem.
  AgentPlanStyler cancelledItem(BoxStyler value) {
    return merge(AgentPlanStyler(cancelledItem: value));
  }

  /// Sets the pendingStatus.
  AgentPlanStyler pendingStatus(IconStyler value) {
    return merge(AgentPlanStyler(pendingStatus: value));
  }

  /// Sets the activeStatus.
  AgentPlanStyler activeStatus(IconStyler value) {
    return merge(AgentPlanStyler(activeStatus: value));
  }

  /// Sets the completedStatus.
  AgentPlanStyler completedStatus(IconStyler value) {
    return merge(AgentPlanStyler(completedStatus: value));
  }

  /// Sets the cancelledStatus.
  AgentPlanStyler cancelledStatus(IconStyler value) {
    return merge(AgentPlanStyler(cancelledStatus: value));
  }

  /// Sets the animation configuration.
  @override
  AgentPlanStyler animate(AnimationConfig value) {
    return merge(AgentPlanStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  AgentPlanStyler variants(List<VariantStyle<AgentPlanSpec>> value) {
    return merge(AgentPlanStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  AgentPlanStyler wrap(WidgetModifierConfig value) {
    return merge(AgentPlanStyler(modifier: value));
  }

  /// Sets the widget modifier.
  AgentPlanStyler modifier(WidgetModifierConfig value) {
    return merge(AgentPlanStyler(modifier: value));
  }

  AgentPlan call({
    Key? key,
    required List<AgentPlanItem> items,
    String title = 'Plan',
    String emptyLabel = 'No tasks yet',
    String semanticLabel = 'Task plan',
    bool collapseOnComplete = true,
    bool? expanded,
    bool defaultExpanded = true,
    ValueChanged<bool>? onExpandedChanged,
    AgentPlanStatusBuilder? statusBuilder,
    AgentPlanStatusLabelBuilder? statusLabelBuilder,
    AgentPlanIndicatorBuilder? indicatorBuilder,
    bool followOutput = true,
    double followThreshold = 48,
    ValueChanged<bool>? onFollowChanged,
    DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
  }) {
    return AgentPlan(
      key: key,
      style: this,
      items: items,
      title: title,
      emptyLabel: emptyLabel,
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

  /// Merges with another [AgentPlanStyler].
  @override
  AgentPlanStyler merge(AgentPlanStyler? other) {
    return AgentPlanStyler.create(
      viewport: MixOps.merge($viewport, other?.$viewport),
      item: MixOps.merge($item, other?.$item),
      summaryTitle: MixOps.merge($summaryTitle, other?.$summaryTitle),
      itemTitle: MixOps.merge($itemTitle, other?.$itemTitle),
      itemDetail: MixOps.merge($itemDetail, other?.$itemDetail),
      count: MixOps.merge($count, other?.$count),
      indicator: MixOps.merge($indicator, other?.$indicator),
      pendingItem: MixOps.merge($pendingItem, other?.$pendingItem),
      activeItem: MixOps.merge($activeItem, other?.$activeItem),
      completedItem: MixOps.merge($completedItem, other?.$completedItem),
      cancelledItem: MixOps.merge($cancelledItem, other?.$cancelledItem),
      pendingStatus: MixOps.merge($pendingStatus, other?.$pendingStatus),
      activeStatus: MixOps.merge($activeStatus, other?.$activeStatus),
      completedStatus: MixOps.merge($completedStatus, other?.$completedStatus),
      cancelledStatus: MixOps.merge($cancelledStatus, other?.$cancelledStatus),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<AgentPlanSpec>] using [context].
  @override
  StyleSpec<AgentPlanSpec> resolve(BuildContext context) {
    final spec = AgentPlanSpec(
      viewport: MixOps.resolve(context, $viewport),
      item: MixOps.resolve(context, $item),
      summaryTitle: MixOps.resolve(context, $summaryTitle),
      itemTitle: MixOps.resolve(context, $itemTitle),
      itemDetail: MixOps.resolve(context, $itemDetail),
      count: MixOps.resolve(context, $count),
      indicator: MixOps.resolve(context, $indicator),
      pendingItem: MixOps.resolve(context, $pendingItem),
      activeItem: MixOps.resolve(context, $activeItem),
      completedItem: MixOps.resolve(context, $completedItem),
      cancelledItem: MixOps.resolve(context, $cancelledItem),
      pendingStatus: MixOps.resolve(context, $pendingStatus),
      activeStatus: MixOps.resolve(context, $activeStatus),
      completedStatus: MixOps.resolve(context, $completedStatus),
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
      ..add(DiagnosticsProperty('viewport', $viewport))
      ..add(DiagnosticsProperty('item', $item))
      ..add(DiagnosticsProperty('summaryTitle', $summaryTitle))
      ..add(DiagnosticsProperty('itemTitle', $itemTitle))
      ..add(DiagnosticsProperty('itemDetail', $itemDetail))
      ..add(DiagnosticsProperty('count', $count))
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('pendingItem', $pendingItem))
      ..add(DiagnosticsProperty('activeItem', $activeItem))
      ..add(DiagnosticsProperty('completedItem', $completedItem))
      ..add(DiagnosticsProperty('cancelledItem', $cancelledItem))
      ..add(DiagnosticsProperty('pendingStatus', $pendingStatus))
      ..add(DiagnosticsProperty('activeStatus', $activeStatus))
      ..add(DiagnosticsProperty('completedStatus', $completedStatus))
      ..add(DiagnosticsProperty('cancelledStatus', $cancelledStatus));
  }

  @override
  List<Object?> get props => [
    $viewport,
    $item,
    $summaryTitle,
    $itemTitle,
    $itemDetail,
    $count,
    $indicator,
    $pendingItem,
    $activeItem,
    $completedItem,
    $cancelledItem,
    $pendingStatus,
    $activeStatus,
    $completedStatus,
    $cancelledStatus,
    $animation,
    $modifier,
    $variants,
  ];
}
