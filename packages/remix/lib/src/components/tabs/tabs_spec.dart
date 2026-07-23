part of 'tabs.dart';

/// Resolved visual values for a [RemixTabBar].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixTabBarSpec with _$RemixTabBarSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  const RemixTabBarSpec({StyleSpec<FlexBoxSpec>? container})
    : container = container ?? const StyleSpec(spec: FlexBoxSpec());
}

/// Resolved visual values for an individual [RemixTab].
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class RemixTabSpec with _$RemixTabSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  final StyleSpec<IconSpec> icon;

  const RemixTabSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}

/// Resolved visual values for a [RemixTabView].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixTabViewSpec with _$RemixTabViewSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  const RemixTabViewSpec({StyleSpec<BoxSpec>? container})
    : container = container ?? const StyleSpec(spec: BoxSpec());
}
