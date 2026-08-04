part of 'skeleton.dart';

/// Resolved visual values for a [RemixSkeleton] placeholder.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class SkeletonSpec with _$SkeletonSpec {
  /// The placeholder surface.
  ///
  /// Owns explicit width/height/constraints, the base fill, decoration,
  /// radius, and any opacity modifier the caller attached.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  /// The alternate fill the pulse animates toward.
  ///
  /// When [container] also resolves a plain fill color, the pulse interpolates
  /// between the two. When it does not — no fill color, or a gradient painting
  /// over one — the pulse instead fades the whole resolved container between
  /// full and half opacity, which multiplies rather than replaces an opacity
  /// the caller already applied to [container].
  @override
  final Color? pulseColor;

  /// The length of one forward pulse leg.
  ///
  /// Defaults to 1000 ms. The reverse leg takes the same time.
  @override
  final Duration? duration;

  const SkeletonSpec({
    StyleSpec<BoxSpec>? container,
    this.pulseColor,
    this.duration,
  }) : container = container ?? const StyleSpec(spec: BoxSpec());
}
