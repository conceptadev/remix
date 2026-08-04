part of 'skeleton.dart';

/// One forward pulse leg when [SkeletonSpec.duration] is absent.
const _defaultPulseLeg = Duration(milliseconds: 1000);

/// Lowest opacity reached by the generic pulse fallback.
///
/// Only used when the container resolves no fill color to interpolate, so the
/// placeholder still reads as animated without inventing a color policy.
const _fallbackPulseOpacity = 0.5;

/// A decorative loading placeholder that preserves the geometry of its child.
///
/// While [loading] the child stays mounted so its intrinsic size and local
/// state survive, but it cannot be painted, tapped, focused, read by
/// assistive technology, or ticked. Set [loading] to false to hand the child
/// back its normal behavior without remounting it.
///
/// There is deliberately no Naked primitive behind this widget. Naked
/// primitives exist to own an interaction contract; Skeleton has none to own —
/// it exists to *remove* interaction from whatever it wraps. The one piece of
/// behavior it does own, an animation controller reacting to reduced motion,
/// follows `spinner/spinner_widget.dart`.
///
/// A skeleton is decorative and exposes no loading or progress semantics.
/// Applications that need to announce loading should render their own labelled
/// status region beside it.
///
/// ## Example
///
/// ```dart
/// RemixSkeleton(
///   loading: isLoading,
///   style: SkeletonStyler().color(Colors.black12).borderRounded(4),
///   child: const Text('Jane Appleseed'),
/// )
/// ```
class RemixSkeleton extends StatelessWidget {
  /// Creates a loading placeholder.
  const RemixSkeleton({
    super.key,
    this.child,
    this.loading = true,
    this.style = const SkeletonStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = SkeletonStyler.new;

  /// The content the placeholder stands in for.
  ///
  /// When present it keeps sizing the skeleton in both states, so switching
  /// [loading] never changes the layout.
  final Widget? child;

  /// Whether to show the placeholder instead of [child].
  final bool loading;

  /// The style configuration for the skeleton.
  final SkeletonStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final SkeletonSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    final child = this.child;
    if (child == null && !loading) return const SizedBox.shrink();

    return RemixStyleSpecBuilder<SkeletonSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        if (child == null) return _SkeletonPulse(spec: spec);

        return ExcludeSemantics(
          // Defense in depth: whatever the loading branch renders, including
          // the pulse overlay, stays out of the semantics tree.
          excluding: loading,
          child: Stack(
            // Provably a no-op: the single non-positioned child sizes the
            // stack, so there is nothing left to align. Spelling it
            // non-directionally keeps a decorative placeholder from requiring
            // an ambient Directionality.
            alignment: Alignment.topLeft,
            fit: StackFit.passthrough,
            children: [
              // One wrapper chain, one child slot, both states. Only the flags
              // change, so the child element — and its local state — survives
              // every loading toggle, and mounting the pulse sibling below
              // never reparents it.
              TickerMode(
                enabled: !loading,
                child: ExcludeFocus(
                  // Also releases focus already held inside the child:
                  // FocusNode.descendantsAreFocusable unfocuses on the way down.
                  excluding: loading,
                  child: ExcludeSemantics(
                    excluding: loading,
                    child: IgnorePointer(
                      ignoring: loading,
                      child: Opacity(
                        // Paint hiding only. ExcludeSemantics above is the
                        // accessibility control.
                        opacity: loading ? 0 : 1,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
              if (loading) Positioned.fill(child: _SkeletonPulse(spec: spec)),
            ],
          ),
        );
      },
    );
  }
}

/// The animated placeholder surface.
///
/// Mounted only while loading, and only ever as a sibling of the child.
class _SkeletonPulse extends StatefulWidget {
  const _SkeletonPulse({required this.spec});

  final SkeletonSpec spec;

  @override
  State<_SkeletonPulse> createState() => _SkeletonPulseState();
}

class _SkeletonPulseState extends State<_SkeletonPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Unlike Spinner the controller does not start here: reduced motion is a
    // dependency, so didChangeDependencies owns every start and stop.
    _controller = AnimationController(
      duration: _resolveLeg(widget.spec.duration),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncMotion();
  }

  @override
  void didUpdateWidget(covariant _SkeletonPulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    final leg = _resolveLeg(widget.spec.duration);
    if (_controller.duration == leg) return;

    // Retune in place. Replacing the controller would drop the current phase
    // and restart the pulse from its base frame.
    _controller.duration = leg;
    if (_controller.isAnimating) _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _syncMotion() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
      // Deterministic base frame, so a static placeholder always paints the
      // container exactly as styled.
      _controller.value = _controller.lowerBound;

      return;
    }

    if (!_controller.isAnimating) _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    final container = widget.spec.container;
    final fillPulse = _fillPulse(
      container.spec.decoration,
      widget.spec.pulseColor,
    );

    if (fillPulse == null) {
      // Nothing to interpolate, so fade the resolved container instead. The
      // caller's own opacity modifier renders inside Box, which makes the two
      // opacities compose rather than one replacing the other.
      return AnimatedBuilder(
        animation: _controller,
        child: Box(styleSpec: container),
        builder: (context, child) => Opacity(
          opacity: lerpDouble(1, _fallbackPulseOpacity, _controller.value)!,
          child: child,
        ),
      );
    }

    // Paint-only interpolation: the constraints, padding, and shape of the
    // container are untouched, so no pulse frame can change layout.
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Box(
        styleSpec: container.copyWith(
          spec: container.spec.copyWith(
            decoration: fillPulse(_controller.value),
          ),
        ),
      ),
    );
  }
}

Duration _resolveLeg(Duration? value) {
  if (value == null) return _defaultPulseLeg;
  assert(
    value > Duration.zero,
    'SkeletonSpec.duration must be greater than zero.',
  );

  return value > Duration.zero ? value : _defaultPulseLeg;
}

/// Builds the decoration for one pulse frame, or null when this decoration has
/// no fill the pulse can interpolate.
///
/// Falling through to null is the honest answer for a decoration whose paint is
/// not a plain fill: a gradient draws over the fill color, so lerping it would
/// animate nothing, and a color cannot be recovered from an image or a
/// third-party decoration at all. Those cases take the opacity pulse, which is
/// visible whatever the container paints.
Decoration Function(double t)? _fillPulse(
  Decoration? decoration,
  Color? pulseColor,
) {
  if (pulseColor == null) return null;

  switch (decoration) {
    case final BoxDecoration box when box.gradient == null:
      final color = box.color;
      if (color == null) return null;

      return (t) => box.copyWith(color: Color.lerp(color, pulseColor, t));

    case final ShapeDecoration shape when shape.gradient == null:
      final color = shape.color;
      if (color == null) return null;

      return (t) => ShapeDecoration(
        color: Color.lerp(color, pulseColor, t),
        image: shape.image,
        shadows: shape.shadows,
        shape: shape.shape,
      );

    default:
      return null;
  }
}
