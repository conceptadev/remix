part of 'progress.dart';

/// The [RemixProgress] widget is used to display a progress bar that indicates a
/// completion value between zero and [max]. A null value is indeterminate.
/// It can be customized using the
/// [style] parameter to fit different design needs.
///
/// ## Example
///
/// ```dart
/// RemixProgress(
///   value: 50,
/// )
/// ```
class RemixProgress extends StatelessWidget {
  const RemixProgress({
    super.key,
    this.value,
    this.max = 100,
    this.duration = const Duration(seconds: 5),
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const RemixProgressStyler.create(),
    this.styleSpec,
  }) : assert(
         max > 0 && max < double.infinity,
         'Progress max must be finite and greater than zero.',
       ),
       assert(
         value == null || (value >= 0 && value <= max),
         'Progress value must be between zero and max.',
       );

  static final styleFrom = RemixProgressStyler.new;

  /// Current progress. Null represents an indeterminate operation.
  final double? value;

  /// Maximum determinate progress value.
  final double max;

  /// Duration of the initial indeterminate growth animation.
  final Duration duration;

  final String? semanticLabel;
  final bool excludeSemantics;

  /// The style configuration for the progress bar.
  final RemixProgressStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixProgressSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<RemixProgressSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        final track = Box(styleSpec: spec.track);
        final indicator = _RemixProgressIndicator(
          value: value,
          max: max,
          duration: duration,
          styleSpec: spec.indicator,
          surface: spec.indicatorSurface,
          overlay: spec.indicatorOverlay,
        );
        final progress = RemixSurfaceBox(
          styleSpec: spec.container,
          surface: spec.surface,
          overlay: spec.overlay,
          child: Stack(
            children: [
              track,
              Positioned.fill(child: indicator),
            ],
          ),
        );
        if (excludeSemantics) return ExcludeSemantics(child: progress);
        if (value case final determinate?) {
          return Semantics(
            container: true,
            role: ui.SemanticsRole.progressBar,
            label: semanticLabel,
            value: _semanticNumber(determinate),
            minValue: '0',
            maxValue: _semanticNumber(max),
            child: progress,
          );
        }
        return Semantics(
          container: true,
          role: ui.SemanticsRole.loadingSpinner,
          label: semanticLabel,
          child: progress,
        );
      },
    );
  }
}

class _RemixProgressIndicator extends StatefulWidget {
  const _RemixProgressIndicator({
    required this.value,
    required this.max,
    required this.duration,
    required this.styleSpec,
    this.surface,
    this.overlay,
  });

  final double? value;
  final double max;
  final Duration duration;
  final StyleSpec<BoxSpec> styleSpec;
  final RemixSurfaceLayerSpec? surface;
  final RemixSurfaceLayerSpec? overlay;

  @override
  State<_RemixProgressIndicator> createState() =>
      _RemixProgressIndicatorState();
}

class _RemixProgressIndicatorState extends State<_RemixProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _indeterminateGrowth;
  bool? _animationsDisabled;

  @override
  void initState() {
    super.initState();
    _validateDuration(widget.duration);
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _indeterminateGrowth = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.01, end: 0.1), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.1, end: 0.6), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 0.9), weight: 10),
      TweenSequenceItem(tween: ConstantTween(0.9), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1), weight: 50),
    ]).animate(_controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disabled = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (_animationsDisabled == disabled) return;

    _animationsDisabled = disabled;
    _syncIndeterminateAnimation(restart: true);
  }

  @override
  void didUpdateWidget(covariant _RemixProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _validateDuration(widget.duration);
      _controller.duration = widget.duration;
    }
    if (oldWidget.value != null && widget.value == null) {
      _syncIndeterminateAnimation(restart: true);
    } else if (oldWidget.value == null && widget.value != null) {
      _controller.stop();
    }
  }

  void _syncIndeterminateAnimation({required bool restart}) {
    if (widget.value != null) {
      _controller.stop();
      return;
    }
    if (_animationsDisabled ?? false) {
      _controller
        ..stop()
        ..value = 1;
      return;
    }
    if (restart || !_controller.isAnimating) {
      _controller.forward(from: restart ? 0 : _controller.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    if (value != null) {
      return _buildIndicator((value / widget.max).clamp(0, 1));
    }
    return AnimatedBuilder(
      animation: _indeterminateGrowth,
      builder: (context, _) => _buildIndicator(_indeterminateGrowth.value),
    );
  }

  Widget _buildIndicator(double fraction) => Align(
    alignment: Alignment.centerLeft,
    child: FractionallySizedBox(
      widthFactor: fraction,
      heightFactor: 1,
      child: RemixSurfaceBox(
        styleSpec: widget.styleSpec,
        surface: widget.surface,
        overlay: widget.overlay,
      ),
    ),
  );
}

void _validateDuration(Duration duration) {
  if (duration <= Duration.zero) {
    throw ArgumentError.value(
      duration,
      'duration',
      'Progress duration must be positive.',
    );
  }
}

String _semanticNumber(double value) => value == value.truncateToDouble()
    ? value.toInt().toString()
    : value.toString();
