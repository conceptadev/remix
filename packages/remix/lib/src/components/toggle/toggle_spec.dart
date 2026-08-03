part of 'toggle.dart';

/// Resolved visual properties for a [RemixToggle].
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class ToggleSpec with _$ToggleSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  final StyleSpec<IconSpec> icon;

  const ToggleSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}

/// Backward-compatible name for [ToggleSpec].
///
/// The generated style API is based on [ToggleSpec], so resolved values use
/// `ToggleSpec` as their runtime type.
typedef RemixToggleSpec = ToggleSpec;
