part of 'segmented_control.dart';

/// Resolved visual properties for a [RemixSegmentedControl].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class SegmentedControlSpec with _$SegmentedControlSpec {
  /// Layout and decoration for the persistent control track.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  /// Main-axis sizing for the equal-segment track layout.
  @override
  final MainAxisSize? mainAxisSize;

  /// Space between adjacent segments.
  @override
  final double? spacing;

  /// Default visual style for every segment.
  @override
  final StyleSpec<SegmentedControlItemSpec> item;

  const SegmentedControlSpec({
    StyleSpec<BoxSpec>? container,
    this.mainAxisSize,
    this.spacing,
    StyleSpec<SegmentedControlItemSpec>? item,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       item = item ?? const StyleSpec(spec: SegmentedControlItemSpec());
}

/// Resolved visual properties for one segment.
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class SegmentedControlItemSpec with _$SegmentedControlItemSpec {
  /// Decoration and box layout for the segment surface.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  /// Space between the optional icon and label.
  @override
  final double? spacing;

  /// Text style for the optional label.
  @override
  final StyleSpec<TextSpec> label;

  /// Icon style for the optional icon.
  @override
  final StyleSpec<IconSpec> icon;

  /// Paint-only effects for the segment surface.
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const SegmentedControlItemSpec({
    StyleSpec<BoxSpec>? container,
    this.spacing,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  SegmentedControlItemSpec lerp(SegmentedControlItemSpec? other, double t) {
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
