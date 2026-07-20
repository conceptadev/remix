part of 'spinner.dart';

/// An eight-leaf loading indicator that can replace content without changing
/// its layout.
///
/// When [loading] is false, [child] is returned unchanged. While loading, the
/// child remains laid out but is hidden, inert, and excluded from semantics;
/// the spinner is centered over the same bounds.
class RemixSpinner extends StatelessWidget {
  const RemixSpinner({
    super.key,
    this.loading = true,
    this.child,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const RemixSpinnerStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = RemixSpinnerStyler.new;

  /// Whether the spinner replaces [child].
  final bool loading;

  /// Optional content whose layout is preserved while loading.
  final Widget? child;

  /// Accessibility label announced with the loading-spinner role.
  final String? semanticLabel;

  /// Whether to hide the loading indicator from accessibility.
  final bool excludeSemantics;

  /// Visual style for the spinner leaves.
  final RemixSpinnerStyler style;

  /// Optional resolved style that bypasses [style].
  final RemixSpinnerSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    if (!loading) return child ?? const SizedBox.shrink();

    return RemixStyleSpecBuilder<RemixSpinnerSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) => _SpinnerSpecWidget(
        spec: spec,
        semanticLabel: semanticLabel,
        excludeSemantics: excludeSemantics,
        child: child,
      ),
    );
  }
}

class _SpinnerSpecWidget extends StatefulWidget {
  const _SpinnerSpecWidget({
    required this.spec,
    required this.semanticLabel,
    required this.excludeSemantics,
    required this.child,
  });

  final RemixSpinnerSpec spec;
  final String? semanticLabel;
  final bool excludeSemantics;
  final Widget? child;

  @override
  State<_SpinnerSpecWidget> createState() => _SpinnerSpecWidgetState();
}

class _SpinnerSpecWidgetState extends State<_SpinnerSpecWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  bool _animationsDisabled = false;

  Duration get _duration =>
      widget.spec.duration ?? const Duration(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    _validateDuration(_duration);
    controller = AnimationController(duration: _duration, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disabled = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (_animationsDisabled == disabled &&
        (disabled || controller.isAnimating)) {
      return;
    }
    _animationsDisabled = disabled;
    if (disabled) {
      controller
        ..stop()
        ..value = 0;
    } else {
      controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _SpinnerSpecWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldDuration =
        oldWidget.spec.duration ?? const Duration(milliseconds: 800);
    if (oldDuration != _duration) {
      _validateDuration(_duration);
      controller.duration = _duration;
      if (!_animationsDisabled) controller.repeat();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spec = widget.spec;
    final size = spec.size ?? 24;
    final opacity = spec.opacity ?? 0.65;
    final leafRadius = spec.leafRadius ?? const Radius.circular(2);
    _validateVisuals(size: size, opacity: opacity, leafRadius: leafRadius);
    final color =
        spec.color ??
        IconTheme.of(context).color ??
        DefaultTextStyle.of(context).style.color ??
        const Color(0xFF000000);

    Widget spinner = CustomPaint(
      size: Size.square(size),
      painter: RemixSpinnerPainter(
        animation: controller,
        color: color,
        opacity: opacity,
        leafRadius: leafRadius,
      ),
    );
    spinner = widget.excludeSemantics
        ? ExcludeSemantics(child: spinner)
        : Semantics(
            container: true,
            role: ui.SemanticsRole.loadingSpinner,
            label: widget.semanticLabel,
            child: spinner,
          );

    final child = widget.child;
    if (child == null) return spinner;

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        ExcludeSemantics(
          child: IgnorePointer(child: Opacity(opacity: 0, child: child)),
        ),
        Positioned.fill(
          child: IgnorePointer(child: Center(child: spinner)),
        ),
      ],
    );
  }
}

void _validateDuration(Duration duration) {
  if (duration <= Duration.zero) {
    throw ArgumentError.value(
      duration,
      'duration',
      'Spinner duration must be positive.',
    );
  }
}

void _validateVisuals({
  required double size,
  required double opacity,
  required Radius leafRadius,
}) {
  if (!size.isFinite || size < 0) {
    throw ArgumentError.value(size, 'size', 'Spinner size must be finite.');
  }
  if (!opacity.isFinite || opacity < 0 || opacity > 1) {
    throw ArgumentError.value(
      opacity,
      'opacity',
      'Spinner opacity must be between zero and one.',
    );
  }
  if (!leafRadius.x.isFinite ||
      !leafRadius.y.isFinite ||
      leafRadius.x < 0 ||
      leafRadius.y < 0) {
    throw ArgumentError.value(
      leafRadius,
      'leafRadius',
      'Spinner leaf radius must be finite and non-negative.',
    );
  }
}
