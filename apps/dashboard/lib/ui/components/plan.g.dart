// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$UiPlanSpec implements Spec<UiPlanSpec>, Diagnosticable {
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
  Type get type => UiPlanSpec;

  @override
  UiPlanSpec copyWith({
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
    return UiPlanSpec(
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
  UiPlanSpec lerp(UiPlanSpec? other, double t) {
    return UiPlanSpec(
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
        other is UiPlanSpec &&
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
  'Rename to `_\$UiPlanSpec` and migrate the class declaration to `class UiPlanSpec with _\$UiPlanSpec`. The `_\$UiPlanSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$UiPlanSpecMethods = _$UiPlanSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class UiPlanStyler extends MixStyler<UiPlanStyler, UiPlanSpec>
    implements StylerFieldMetadata {
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

  const UiPlanStyler.create({
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

  UiPlanStyler({
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
    List<VariantStyle<UiPlanSpec>>? variants,
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

  factory UiPlanStyler.viewport(BoxStyler value) =>
      UiPlanStyler().viewport(value);
  factory UiPlanStyler.item(FlexBoxStyler value) => UiPlanStyler().item(value);
  factory UiPlanStyler.summaryTitle(TextStyler value) =>
      UiPlanStyler().summaryTitle(value);
  factory UiPlanStyler.itemTitle(TextStyler value) =>
      UiPlanStyler().itemTitle(value);
  factory UiPlanStyler.itemDetail(TextStyler value) =>
      UiPlanStyler().itemDetail(value);
  factory UiPlanStyler.count(TextStyler value) => UiPlanStyler().count(value);
  factory UiPlanStyler.indicator(IconStyler value) =>
      UiPlanStyler().indicator(value);
  factory UiPlanStyler.pendingItem(BoxStyler value) =>
      UiPlanStyler().pendingItem(value);
  factory UiPlanStyler.activeItem(BoxStyler value) =>
      UiPlanStyler().activeItem(value);
  factory UiPlanStyler.completedItem(BoxStyler value) =>
      UiPlanStyler().completedItem(value);
  factory UiPlanStyler.cancelledItem(BoxStyler value) =>
      UiPlanStyler().cancelledItem(value);
  factory UiPlanStyler.pendingStatus(IconStyler value) =>
      UiPlanStyler().pendingStatus(value);
  factory UiPlanStyler.activeStatus(IconStyler value) =>
      UiPlanStyler().activeStatus(value);
  factory UiPlanStyler.completedStatus(IconStyler value) =>
      UiPlanStyler().completedStatus(value);
  factory UiPlanStyler.cancelledStatus(IconStyler value) =>
      UiPlanStyler().cancelledStatus(value);

  @override
  Set<String> get $stylerFieldNames => const {
    'viewport',
    'item',
    'summaryTitle',
    'itemTitle',
    'itemDetail',
    'count',
    'indicator',
    'pendingItem',
    'activeItem',
    'completedItem',
    'cancelledItem',
    'pendingStatus',
    'activeStatus',
    'completedStatus',
    'cancelledStatus',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the viewport.
  UiPlanStyler viewport(BoxStyler value) {
    return merge(UiPlanStyler(viewport: value));
  }

  /// Sets the item.
  UiPlanStyler item(FlexBoxStyler value) {
    return merge(UiPlanStyler(item: value));
  }

  /// Sets the summaryTitle.
  UiPlanStyler summaryTitle(TextStyler value) {
    return merge(UiPlanStyler(summaryTitle: value));
  }

  /// Sets the itemTitle.
  UiPlanStyler itemTitle(TextStyler value) {
    return merge(UiPlanStyler(itemTitle: value));
  }

  /// Sets the itemDetail.
  UiPlanStyler itemDetail(TextStyler value) {
    return merge(UiPlanStyler(itemDetail: value));
  }

  /// Sets the count.
  UiPlanStyler count(TextStyler value) {
    return merge(UiPlanStyler(count: value));
  }

  /// Sets the indicator.
  UiPlanStyler indicator(IconStyler value) {
    return merge(UiPlanStyler(indicator: value));
  }

  /// Sets the pendingItem.
  UiPlanStyler pendingItem(BoxStyler value) {
    return merge(UiPlanStyler(pendingItem: value));
  }

  /// Sets the activeItem.
  UiPlanStyler activeItem(BoxStyler value) {
    return merge(UiPlanStyler(activeItem: value));
  }

  /// Sets the completedItem.
  UiPlanStyler completedItem(BoxStyler value) {
    return merge(UiPlanStyler(completedItem: value));
  }

  /// Sets the cancelledItem.
  UiPlanStyler cancelledItem(BoxStyler value) {
    return merge(UiPlanStyler(cancelledItem: value));
  }

  /// Sets the pendingStatus.
  UiPlanStyler pendingStatus(IconStyler value) {
    return merge(UiPlanStyler(pendingStatus: value));
  }

  /// Sets the activeStatus.
  UiPlanStyler activeStatus(IconStyler value) {
    return merge(UiPlanStyler(activeStatus: value));
  }

  /// Sets the completedStatus.
  UiPlanStyler completedStatus(IconStyler value) {
    return merge(UiPlanStyler(completedStatus: value));
  }

  /// Sets the cancelledStatus.
  UiPlanStyler cancelledStatus(IconStyler value) {
    return merge(UiPlanStyler(cancelledStatus: value));
  }

  /// Sets the animation configuration.
  @override
  UiPlanStyler animate(AnimationConfig value) {
    return merge(UiPlanStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  UiPlanStyler variants(List<VariantStyle<UiPlanSpec>> value) {
    return merge(UiPlanStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  UiPlanStyler wrap(WidgetModifierConfig value) {
    return merge(UiPlanStyler(modifier: value));
  }

  /// Sets the widget modifier.
  UiPlanStyler modifier(WidgetModifierConfig value) {
    return merge(UiPlanStyler(modifier: value));
  }

  UiPlan call({
    Key? key,
    required List<UiPlanItem> items,
    String title = 'Plan',
    String emptyLabel = 'No tasks yet',
    String semanticLabel = 'Task plan',
    bool collapseOnComplete = true,
    bool? expanded,
    bool defaultExpanded = true,
    ValueChanged<bool>? onExpandedChanged,
    UiPlanStatusBuilder? statusBuilder,
    UiPlanStatusLabelBuilder? statusLabelBuilder,
    UiPlanIndicatorBuilder? indicatorBuilder,
    bool followOutput = true,
    double followThreshold = 48,
    ValueChanged<bool>? onFollowChanged,
    DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
  }) {
    return UiPlan(
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

  /// Merges with another [UiPlanStyler].
  @override
  UiPlanStyler merge(UiPlanStyler? other) {
    return UiPlanStyler.create(
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

  /// Resolves to [StyleSpec<UiPlanSpec>] using [context].
  @override
  StyleSpec<UiPlanSpec> resolve(BuildContext context) {
    final spec = UiPlanSpec(
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
