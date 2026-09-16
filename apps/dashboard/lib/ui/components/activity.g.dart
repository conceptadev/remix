// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$UiActivitySpec implements Spec<UiActivitySpec>, Diagnosticable {
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
  StyleSpec<IconSpec> get pendingStatus;
  StyleSpec<IconSpec> get activeStatus;
  StyleSpec<IconSpec> get completedStatus;

  @override
  Type get type => UiActivitySpec;

  @override
  UiActivitySpec copyWith({
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
    StyleSpec<IconSpec>? pendingStatus,
    StyleSpec<IconSpec>? activeStatus,
    StyleSpec<IconSpec>? completedStatus,
  }) {
    return UiActivitySpec(
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
      pendingStatus: pendingStatus ?? this.pendingStatus,
      activeStatus: activeStatus ?? this.activeStatus,
      completedStatus: completedStatus ?? this.completedStatus,
    );
  }

  @override
  UiActivitySpec lerp(UiActivitySpec? other, double t) {
    return UiActivitySpec(
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
    count,
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
        other is UiActivitySpec &&
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
      ..add(DiagnosticsProperty('pendingStatus', pendingStatus))
      ..add(DiagnosticsProperty('activeStatus', activeStatus))
      ..add(DiagnosticsProperty('completedStatus', completedStatus));
  }
}

@Deprecated(
  'Rename to `_\$UiActivitySpec` and migrate the class declaration to `class UiActivitySpec with _\$UiActivitySpec`. The `_\$UiActivitySpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$UiActivitySpecMethods = _$UiActivitySpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class UiActivityStyler extends MixStyler<UiActivityStyler, UiActivitySpec>
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
  final Prop<StyleSpec<IconSpec>>? $pendingStatus;
  final Prop<StyleSpec<IconSpec>>? $activeStatus;
  final Prop<StyleSpec<IconSpec>>? $completedStatus;

  const UiActivityStyler.create({
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
       $count = count,
       $indicator = indicator,
       $pendingItem = pendingItem,
       $activeItem = activeItem,
       $completedItem = completedItem,
       $pendingStatus = pendingStatus,
       $activeStatus = activeStatus,
       $completedStatus = completedStatus;

  UiActivityStyler({
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
    IconStyler? pendingStatus,
    IconStyler? activeStatus,
    IconStyler? completedStatus,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<UiActivitySpec>>? variants,
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
         pendingStatus: Prop.maybeMix(pendingStatus),
         activeStatus: Prop.maybeMix(activeStatus),
         completedStatus: Prop.maybeMix(completedStatus),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory UiActivityStyler.viewport(BoxStyler value) =>
      UiActivityStyler().viewport(value);
  factory UiActivityStyler.item(FlexBoxStyler value) =>
      UiActivityStyler().item(value);
  factory UiActivityStyler.summaryTitle(TextStyler value) =>
      UiActivityStyler().summaryTitle(value);
  factory UiActivityStyler.itemTitle(TextStyler value) =>
      UiActivityStyler().itemTitle(value);
  factory UiActivityStyler.itemDetail(TextStyler value) =>
      UiActivityStyler().itemDetail(value);
  factory UiActivityStyler.count(TextStyler value) =>
      UiActivityStyler().count(value);
  factory UiActivityStyler.indicator(IconStyler value) =>
      UiActivityStyler().indicator(value);
  factory UiActivityStyler.pendingItem(BoxStyler value) =>
      UiActivityStyler().pendingItem(value);
  factory UiActivityStyler.activeItem(BoxStyler value) =>
      UiActivityStyler().activeItem(value);
  factory UiActivityStyler.completedItem(BoxStyler value) =>
      UiActivityStyler().completedItem(value);
  factory UiActivityStyler.pendingStatus(IconStyler value) =>
      UiActivityStyler().pendingStatus(value);
  factory UiActivityStyler.activeStatus(IconStyler value) =>
      UiActivityStyler().activeStatus(value);
  factory UiActivityStyler.completedStatus(IconStyler value) =>
      UiActivityStyler().completedStatus(value);

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
    'pendingStatus',
    'activeStatus',
    'completedStatus',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the viewport.
  UiActivityStyler viewport(BoxStyler value) {
    return merge(UiActivityStyler(viewport: value));
  }

  /// Sets the item.
  UiActivityStyler item(FlexBoxStyler value) {
    return merge(UiActivityStyler(item: value));
  }

  /// Sets the summaryTitle.
  UiActivityStyler summaryTitle(TextStyler value) {
    return merge(UiActivityStyler(summaryTitle: value));
  }

  /// Sets the itemTitle.
  UiActivityStyler itemTitle(TextStyler value) {
    return merge(UiActivityStyler(itemTitle: value));
  }

  /// Sets the itemDetail.
  UiActivityStyler itemDetail(TextStyler value) {
    return merge(UiActivityStyler(itemDetail: value));
  }

  /// Sets the count.
  UiActivityStyler count(TextStyler value) {
    return merge(UiActivityStyler(count: value));
  }

  /// Sets the indicator.
  UiActivityStyler indicator(IconStyler value) {
    return merge(UiActivityStyler(indicator: value));
  }

  /// Sets the pendingItem.
  UiActivityStyler pendingItem(BoxStyler value) {
    return merge(UiActivityStyler(pendingItem: value));
  }

  /// Sets the activeItem.
  UiActivityStyler activeItem(BoxStyler value) {
    return merge(UiActivityStyler(activeItem: value));
  }

  /// Sets the completedItem.
  UiActivityStyler completedItem(BoxStyler value) {
    return merge(UiActivityStyler(completedItem: value));
  }

  /// Sets the pendingStatus.
  UiActivityStyler pendingStatus(IconStyler value) {
    return merge(UiActivityStyler(pendingStatus: value));
  }

  /// Sets the activeStatus.
  UiActivityStyler activeStatus(IconStyler value) {
    return merge(UiActivityStyler(activeStatus: value));
  }

  /// Sets the completedStatus.
  UiActivityStyler completedStatus(IconStyler value) {
    return merge(UiActivityStyler(completedStatus: value));
  }

  /// Sets the animation configuration.
  @override
  UiActivityStyler animate(AnimationConfig value) {
    return merge(UiActivityStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  UiActivityStyler variants(List<VariantStyle<UiActivitySpec>> value) {
    return merge(UiActivityStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  UiActivityStyler wrap(WidgetModifierConfig value) {
    return merge(UiActivityStyler(modifier: value));
  }

  /// Sets the widget modifier.
  UiActivityStyler modifier(WidgetModifierConfig value) {
    return merge(UiActivityStyler(modifier: value));
  }

  UiActivity call({
    Key? key,
    required List<UiActivityItem> items,
    UiRunStatus status = UiRunStatus.working,
    String title = 'Activity',
    String semanticLabel = 'Activity',
    bool collapseOnComplete = true,
    bool? expanded,
    bool defaultExpanded = true,
    ValueChanged<bool>? onExpandedChanged,
    UiActivityStatusBuilder? statusBuilder,
    UiActivityStatusLabelBuilder? statusLabelBuilder,
    UiActivityIndicatorBuilder? indicatorBuilder,
    bool followOutput = true,
    double followThreshold = 48,
    ValueChanged<bool>? onFollowChanged,
    DisclosureStyler disclosureStyle = const DisclosureStyler.create(),
  }) {
    return UiActivity(
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

  /// Merges with another [UiActivityStyler].
  @override
  UiActivityStyler merge(UiActivityStyler? other) {
    return UiActivityStyler.create(
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
      pendingStatus: MixOps.merge($pendingStatus, other?.$pendingStatus),
      activeStatus: MixOps.merge($activeStatus, other?.$activeStatus),
      completedStatus: MixOps.merge($completedStatus, other?.$completedStatus),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<UiActivitySpec>] using [context].
  @override
  StyleSpec<UiActivitySpec> resolve(BuildContext context) {
    final spec = UiActivitySpec(
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
      ..add(DiagnosticsProperty('count', $count))
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
    $count,
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
