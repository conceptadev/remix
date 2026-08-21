part of 'disclosure.dart';

/// Resolved visual properties for a [RemixDisclosure].
@MixableSpec(
  target: RemixDisclosure.new,
  extraStylerMixins: [RemixBoxStylerMixin],
)
class DisclosureSpec with _$DisclosureSpec {
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

/// Backward-compatible name for [DisclosureSpec].
///
/// The generated style API is based on [DisclosureSpec], so resolved values use
/// `DisclosureSpec` as their runtime type.
typedef RemixDisclosureSpec = DisclosureSpec;
