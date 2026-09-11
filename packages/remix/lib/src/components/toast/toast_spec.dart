part of 'toast.dart';

/// Resolved visual values for a [RemixToast].
///
/// [action] and [closeButton] deliberately hold *unresolved* styles, which the
/// toast hands to the composed [RemixButton] and [RemixIconButton] through
/// Mix's `StyleProvider` inheritance. Those controls own their interaction
/// state, so their styles must resolve against their own hover, focus, and
/// press states rather than the toast's.
@MixableSpec(
  target: RemixToast.new,
  extraStylerMixins: [RemixBoxStylerMixin, IconStyleMixin],
)
class ToastSpec with _$ToastSpec {
  /// Outer row: surface, padding, and the gap between icon, message, and
  /// controls.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  /// Column holding the title and description.
  @override
  final StyleSpec<FlexBoxSpec> content;

  @override
  final StyleSpec<TextSpec> title;

  @override
  final StyleSpec<TextSpec> description;

  /// The leading decorative icon.
  @override
  final StyleSpec<IconSpec> icon;

  /// Unresolved style inherited by the composed action button.
  @override
  final Style<ButtonSpec>? action;

  /// Unresolved style inherited by the composed close button.
  @override
  final Style<IconButtonSpec>? closeButton;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const ToastSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<FlexBoxSpec>? content,
    StyleSpec<TextSpec>? title,
    StyleSpec<TextSpec>? description,
    StyleSpec<IconSpec>? icon,
    this.action,
    this.closeButton,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       content = content ?? const StyleSpec(spec: FlexBoxSpec()),
       title = title ?? const StyleSpec(spec: TextSpec()),
       description = description ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  ToastSpec lerp(ToastSpec? other, double t) {
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
