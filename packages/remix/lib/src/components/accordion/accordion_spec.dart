part of 'accordion.dart';

/// Resolved visual properties for a [RemixAccordion].
@MixableSpec(
  target: RemixAccordion.new,
  extraStylerMixins: [RemixBoxStylerMixin],
)
class AccordionSpec with _$AccordionSpec {
  /// Outer panel: radius, border, fill, and clipping shared by [trigger] and
  /// [content].
  ///
  /// Not [forwardStyler]-forwarded: [trigger] already forwards the top-level
  /// Box shorthand (`.color()`, `.borderRadius()`, ...), and a spec cannot
  /// forward two fields without colliding. Reach [container] explicitly.
  @override
  final StyleSpec<BoxSpec> container;

  /// Layered fills, strokes, and backdrop blur painted with [container].
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> trigger;
  @override
  final StyleSpec<IconSpec> leadingIcon;
  @override
  final StyleSpec<TextSpec> title;
  @override
  final StyleSpec<IconSpec> trailingIcon;
  @override
  final StyleSpec<BoxSpec> content;

  const AccordionSpec({
    StyleSpec<BoxSpec>? container,
    this.containerEffects,
    StyleSpec<FlexBoxSpec>? trigger,
    StyleSpec<IconSpec>? leadingIcon,
    StyleSpec<TextSpec>? title,
    StyleSpec<IconSpec>? trailingIcon,
    StyleSpec<BoxSpec>? content,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       trigger = trigger ?? const StyleSpec(spec: FlexBoxSpec()),
       leadingIcon = leadingIcon ?? const StyleSpec(spec: IconSpec()),
       title = title ?? const StyleSpec(spec: TextSpec()),
       trailingIcon = trailingIcon ?? const StyleSpec(spec: IconSpec()),
       content = content ?? const StyleSpec(spec: BoxSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  AccordionSpec lerp(AccordionSpec? other, double t) {
    if (other == null) return this;
    final generated = super.lerp(other, t);

    return generated.copyWith(
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
    );
  }
}

/// Backward-compatible name for [AccordionSpec].
///
/// The generated style API is based on [AccordionSpec], so resolved values use
/// `AccordionSpec` as their runtime type.
typedef RemixAccordionSpec = AccordionSpec;
