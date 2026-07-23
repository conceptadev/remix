part of 'menu.dart';

/// Resolved visual properties for [RemixMenuTrigger].
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class RemixMenuTriggerSpec with _$RemixMenuTriggerSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  @override
  final StyleSpec<TextSpec> label;

  @override
  final StyleSpec<IconSpec> icon;

  const RemixMenuTriggerSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}

/// Resolved visual properties for a [RemixMenu].
///
/// The menu spec owns the overlay, default item, and divider styles
/// used when rendering the menu and its popup content.
@MixableSpec()
class RemixMenuSpec with _$RemixMenuSpec {
  /// Style for the compatibility trigger content.
  @override
  final StyleSpec<RemixMenuTriggerSpec> trigger;

  /// Layout and decoration for the popup overlay.
  @override
  final StyleSpec<FlexBoxSpec> overlay;

  /// Paint layers behind the popup overlay, inside its margin.
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  /// Default style spec applied to menu items.
  @override
  final StyleSpec<RemixMenuItemSpec> item;

  /// Default style spec applied to noninteractive menu labels.
  @override
  final StyleSpec<RemixMenuItemSpec> label;

  /// Default style spec applied to menu dividers.
  @override
  final StyleSpec<RemixDividerSpec> divider;

  /// Creates a menu spec with default empty child specs.
  const RemixMenuSpec({
    StyleSpec<RemixMenuTriggerSpec>? trigger,
    StyleSpec<FlexBoxSpec>? overlay,
    this.containerEffects,
    StyleSpec<RemixMenuItemSpec>? item,
    StyleSpec<RemixMenuItemSpec>? label,
    StyleSpec<RemixDividerSpec>? divider,
  }) : trigger = trigger ?? const StyleSpec(spec: RemixMenuTriggerSpec()),
       overlay = overlay ?? const StyleSpec(spec: FlexBoxSpec()),
       item = item ?? const StyleSpec(spec: RemixMenuItemSpec()),
       label = label ?? const StyleSpec(spec: RemixMenuItemSpec()),
       divider = divider ?? const StyleSpec(spec: RemixDividerSpec());

  @override
  RemixMenuSpec lerp(RemixMenuSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
    );
  }
}

/// Resolved visual properties for a [RemixMenuAction].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixMenuItemSpec with _$RemixMenuItemSpec {
  /// Layout and decoration for the item row.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  /// Text style for the item label.
  @override
  final StyleSpec<TextSpec> label;

  /// Icon style for the optional leading icon.
  @override
  final StyleSpec<IconSpec> leadingIcon;

  /// Icon style for the optional trailing icon.
  @override
  final StyleSpec<IconSpec> trailingIcon;

  /// Layout for the checked indicator column.
  @override
  final StyleSpec<BoxSpec> indicator;

  /// Icon style for checkbox and radio indicators.
  @override
  final StyleSpec<IconSpec> indicatorIcon;

  /// Leading inset for panels without checkable items.
  @override
  final double? leadingInset;

  /// Leading inset for every row in a panel containing checkable items.
  @override
  final double? checkableLeadingInset;

  /// Trailing inset for the row content.
  @override
  final double? trailingInset;

  /// Extra top spacing when a label immediately follows an action row.
  @override
  final double? adjacentItemSpacing;

  /// Creates an item spec with default empty child specs.
  const RemixMenuItemSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? leadingIcon,
    StyleSpec<IconSpec>? trailingIcon,
    StyleSpec<BoxSpec>? indicator,
    StyleSpec<IconSpec>? indicatorIcon,
    this.leadingInset,
    this.checkableLeadingInset,
    this.trailingInset,
    this.adjacentItemSpacing,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       leadingIcon = leadingIcon ?? const StyleSpec(spec: IconSpec()),
       trailingIcon = trailingIcon ?? const StyleSpec(spec: IconSpec()),
       indicator = indicator ?? const StyleSpec(spec: BoxSpec()),
       indicatorIcon = indicatorIcon ?? const StyleSpec(spec: IconSpec());
}
