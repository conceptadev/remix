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
///   style: SkeletonStyler().container(
///     BoxStyler().color(Colors.black12).borderRadius(.circular(4)),
///   ),
///   child: const Text('Jane Appleseed'),
/// )
/// ```
class RemixSkeleton extends StyleWidget<SkeletonSpec> {
  /// Creates a loading placeholder.
  const RemixSkeleton({
    Key? key,
    this.child,
    this.loading = true,
    Style<SkeletonSpec> style = const SkeletonStyler.create(),
    StyleSpec<SkeletonSpec>? styleSpec,
  }) : super(key: key, style: style, styleSpec: styleSpec);

  static final styleFrom = SkeletonStyler.new;

  /// The content the placeholder stands in for.
  ///
  /// When present it keeps sizing the skeleton in both states, so switching
  /// [loading] never changes the layout.
  final Widget? child;

  /// Whether to show the placeholder instead of [child].
  final bool loading;

  @override
  Widget build(BuildContext context, SkeletonSpec spec) {
    final child = this.child;
    if (child == null && !loading) return const SizedBox.shrink();
    if (child == null) return _SkeletonPulse(spec: spec);

    return ExcludeSemantics(
      // The single semantics control for both states. It sits outside the
      // Stack so it covers the pulse overlay as well as the hidden child.
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
              child: IgnorePointer(
                ignoring: loading,
                child: Opacity(
                  // Paint hiding only. The ExcludeSemantics wrapping the
                  // Stack is the accessibility control.
                  opacity: loading ? 0 : 1,
                  child: child,
                ),
              ),
            ),
          ),
          if (loading) Positioned.fill(child: _SkeletonPulse(spec: spec)),
        ],
      ),
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
    final fillPulse = _fillPulse(container.spec, widget.spec.pulseColor);

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
        // A fresh StyleSpec rather than copyWith, which cannot clear a field.
        // Any animation the caller put on the container has to be dropped
        // here: the pulse already animates this decoration, and an implicit
        // animation re-driven from a value that changes every tick chases the
        // pulse instead of tracking it, damping it so the fill never reaches
        // pulseColor. Modifiers still belong to the caller, so they carry over.
        styleSpec: StyleSpec(
          spec: container.spec.copyWith(
            decoration: fillPulse(_controller.value),
          ),
          widgetModifiers: container.widgetModifiers,
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

/// Builds the decoration for one pulse frame, or null when [box] has no fill
/// the pulse can visibly interpolate.
///
/// Interpolating the fill is only honest when the fill is what the container
/// actually shows. Anything painted over it can hide the animation completely:
/// a gradient replaces the fill, an image covers it, and a foreground
/// decoration paints on top of everything. Whether a given layer is opaque
/// enough to hide the fill cannot be decided reliably — a translucent color, a
/// gradient with clear stops, and a sparse image all look the same from here —
/// so every masked or non-plain paint falls through to the whole-surface
/// opacity pulse, which stays visible whatever the container paints.
Decoration Function(double t)? _fillPulse(BoxSpec box, Color? pulseColor) {
  if (pulseColor == null) return null;
  if (box.foregroundDecoration != null) return null;

  switch (box.decoration) {
    case final BoxDecoration base
        when base.gradient == null && base.image == null:
      final color = base.color;
      if (color == null) return null;

      return (t) => base.copyWith(color: Color.lerp(color, pulseColor, t));

    case final ShapeDecoration shape
        when shape.gradient == null && shape.image == null:
      final color = shape.color;
      if (color == null) return null;

      return (t) => ShapeDecoration(
        color: Color.lerp(color, pulseColor, t),
        shadows: shape.shadows,
        shape: shape.shape,
      );

    default:
      return null;
  }
}
