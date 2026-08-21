part of 'disclosure.dart';

/// Resolved visual properties for a [RemixDisclosure].
@MixableSpec(
  target: RemixDisclosure.new,
  extraStylerMixins: [RemixBoxStylerMixin],
)
class DisclosureSpec with _$DisclosureSpec {
  /// Outer panel. Not forwarded — top-level Box shorthand goes to [trigger].
  @override
  final StyleSpec<BoxSpec> container;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> trigger;

  @override
  final StyleSpec<BoxSpec> content;

  const DisclosureSpec({
    StyleSpec<BoxSpec>? container,
    this.containerEffects,
    StyleSpec<BoxSpec>? trigger,
    StyleSpec<BoxSpec>? content,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       trigger = trigger ?? const StyleSpec(spec: BoxSpec()),
       content = content ?? const StyleSpec(spec: BoxSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  DisclosureSpec lerp(DisclosureSpec? other, double t) {
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

typedef RemixDisclosureSpec = DisclosureSpec;
