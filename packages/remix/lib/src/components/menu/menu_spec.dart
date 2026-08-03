part of 'menu.dart';

/// Resolved visual properties for [RemixMenuTrigger].
///
/// This spec styles the trigger content only. The interactive trigger behavior
/// is provided by the underlying Naked menu button.
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class MenuTriggerSpec with _$MenuTriggerSpec {
  /// Layout and decoration for the trigger content row.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  /// Text style for the trigger label.
  @override
  final StyleSpec<TextSpec> label;

  /// Icon style for the optional trigger icon.
  @override
  final StyleSpec<IconSpec> icon;

  /// Creates a trigger spec with default empty child specs.
  const MenuTriggerSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}

/// Backward-compatible name for [MenuTriggerSpec].
///
/// The generated trigger style API is based on [MenuTriggerSpec], so resolved
/// values use `MenuTriggerSpec` as their runtime type.
typedef RemixMenuTriggerSpec = MenuTriggerSpec;

/// Resolved visual properties for a [RemixMenu].
///
/// The menu spec owns the trigger, overlay, default item, and divider styles
/// used when rendering the menu and its popup content.
@MixableSpec()
class MenuSpec with _$MenuSpec {
  /// Style spec for the trigger content.
  @override
  final StyleSpec<MenuTriggerSpec> trigger;

  /// Layout and decoration for the popup overlay.
  @override
  final StyleSpec<FlexBoxSpec> overlay;

  /// Paint layers behind the popup overlay.
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  /// Default style spec applied to menu items.
  @override
  final StyleSpec<MenuItemSpec> item;

  /// Default style spec applied to menu dividers.
  @override
  final StyleSpec<RemixDividerSpec> divider;

  /// Creates a menu spec with default empty child specs.
  const MenuSpec({
    StyleSpec<MenuTriggerSpec>? trigger,
    StyleSpec<FlexBoxSpec>? overlay,
    this.containerEffects,
    StyleSpec<MenuItemSpec>? item,
    StyleSpec<RemixDividerSpec>? divider,
  }) : trigger = trigger ?? const StyleSpec(spec: MenuTriggerSpec()),
       overlay = overlay ?? const StyleSpec(spec: FlexBoxSpec()),
       item = item ?? const StyleSpec(spec: MenuItemSpec()),
       divider = divider ?? const StyleSpec(spec: RemixDividerSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  MenuSpec lerp(MenuSpec? other, double t) {
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

/// Backward-compatible name for [MenuSpec].
///
/// The generated menu style API is based on [MenuSpec], so resolved values use
/// `MenuSpec` as their runtime type.
typedef RemixMenuSpec = MenuSpec;

/// Resolved visual properties for a [RemixMenuItem].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class MenuItemSpec with _$MenuItemSpec {
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

  /// Creates an item spec with default empty child specs.
  const MenuItemSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? leadingIcon,
    StyleSpec<IconSpec>? trailingIcon,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       leadingIcon = leadingIcon ?? const StyleSpec(spec: IconSpec()),
       trailingIcon = trailingIcon ?? const StyleSpec(spec: IconSpec());
}

/// Backward-compatible name for [MenuItemSpec].
///
/// The generated item style API is based on [MenuItemSpec], so resolved values
/// use `MenuItemSpec` as their runtime type.
typedef RemixMenuItemSpec = MenuItemSpec;
