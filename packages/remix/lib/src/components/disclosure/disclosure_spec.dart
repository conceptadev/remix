part of 'disclosure.dart';

/// Resolved visual properties for a [RemixDisclosure].
@MixableSpec(
  target: RemixDisclosure.new,
  extraStylerMixins: [RemixBoxStylerMixin],
)
class DisclosureSpec with _$DisclosureSpec {
  /// Outer container around the trigger and content.
  @override
  final StyleSpec<BoxSpec> container;

  /// Layered fills, strokes, and backdrop blur painted with [container].
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  /// Interactive trigger surface.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> trigger;

  /// Inline content panel revealed by the trigger.
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

  @override
  DisclosureSpec lerp(DisclosureSpec? other, double t) {
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

/// Backward-compatible name for [DisclosureSpec].
///
/// The generated style API is based on [DisclosureSpec], so resolved values use
/// `DisclosureSpec` as their runtime type.
typedef RemixDisclosureSpec = DisclosureSpec;
