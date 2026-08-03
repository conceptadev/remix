part of 'tabs.dart';

/// Resolved visual values for a [RemixTabBar].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class TabBarSpec with _$TabBarSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  const TabBarSpec({StyleSpec<FlexBoxSpec>? container})
    : container = container ?? const StyleSpec(spec: FlexBoxSpec());
}

/// Backward-compatible name for [TabBarSpec].
///
/// The generated style API is based on [TabBarSpec], so resolved values use
/// `TabBarSpec` as their runtime type.
typedef RemixTabBarSpec = TabBarSpec;

/// Resolved visual values for an individual [RemixTab].
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class TabSpec with _$TabSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  final StyleSpec<IconSpec> icon;

  const TabSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}

/// Backward-compatible name for [TabSpec].
///
/// The generated style API is based on [TabSpec], so resolved values use
/// `TabSpec` as their runtime type.
typedef RemixTabSpec = TabSpec;

/// Resolved visual values for a [RemixTabView].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class TabViewSpec with _$TabViewSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  const TabViewSpec({StyleSpec<BoxSpec>? container})
    : container = container ?? const StyleSpec(spec: BoxSpec());
}

/// Backward-compatible name for [TabViewSpec].
///
/// The generated style API is based on [TabViewSpec], so resolved values use
/// `TabViewSpec` as their runtime type.
typedef RemixTabViewSpec = TabViewSpec;
