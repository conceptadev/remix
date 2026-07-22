part of 'dialog.dart';

/// Resolved visual properties for a [RemixDialog].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixDialogSpec with _$RemixDialogSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  @MixableField(setterType: RemixSurfaceEffectsMix)
  final RemixSurfaceEffectsSpec? effects;
  @override
  final StyleSpec<TextSpec> title;
  @override
  final StyleSpec<TextSpec> description;
  @override
  final StyleSpec<FlexBoxSpec> actions;

  const RemixDialogSpec({
    StyleSpec<BoxSpec>? container,
    this.effects,
    StyleSpec<TextSpec>? title,
    StyleSpec<TextSpec>? description,
    StyleSpec<FlexBoxSpec>? actions,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       title = title ?? const StyleSpec(spec: TextSpec()),
       description = description ?? const StyleSpec(spec: TextSpec()),
       actions = actions ?? const StyleSpec(spec: FlexBoxSpec());

  @override
  RemixDialogSpec lerp(RemixDialogSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      effects: RemixSurfaceEffectsSpec.lerpNullable(effects, other.effects, t),
    );
  }
}
