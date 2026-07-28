part of 'spinner.dart';

/// The [RemixSpinner] widget is used to display a loading spinner.
/// It can be customized using the [style] parameter to fit different design needs.
///
/// ## Examples
///
/// ```dart
/// // Basic spinner
/// RemixSpinner()
///
/// // Custom spinner with track
/// RemixSpinner(
///   style: RemixSpinnerStyler(
///     size: 32,
///     indicatorColor: Colors.blue,
///     trackColor: Colors.blue.withValues(alpha: 0.2),
///   ),
/// )
/// ```
class RemixSpinner extends StatelessWidget {
  const RemixSpinner({
    super.key,
    this.semanticsLabel,
    this.semanticsValue,
    this.style = const RemixSpinnerStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = RemixSpinnerStyler.new;

  /// The accessible name exposed when this spinner is not decorative.
  final String? semanticsLabel;

  /// Optional status text exposed with [semanticsLabel].
  ///
  /// Ignored when [semanticsLabel] is null.
  final String? semanticsValue;

  /// The style configuration for the spinner.
  final RemixSpinnerStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixSpinnerSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    final spinner = RemixStyleSpecBuilder<RemixSpinnerSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) => _SpinnerSpecWidget(spec: spec),
    );

    if (semanticsLabel == null) return spinner;

    return Semantics(
      role: SemanticsRole.loadingSpinner,
      label: semanticsLabel,
      value: semanticsValue,
      child: spinner,
    );
  }
}

class _SpinnerSpecWidget extends StatefulWidget {
  const _SpinnerSpecWidget({required this.spec});

  final RemixSpinnerSpec spec;

  @override
  State createState() => _SpinnerSpecWidgetState();
}

class _SpinnerSpecWidgetState extends State<_SpinnerSpecWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.spec.duration ?? const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant _SpinnerSpecWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newDuration =
        widget.spec.duration ?? const Duration(milliseconds: 1000);
    final oldDuration =
        oldWidget.spec.duration ?? const Duration(milliseconds: 1000);
    if (oldDuration != newDuration) {
      controller.duration = newDuration;
      controller.repeat();
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
    final indicatorColor =
        spec.indicatorColor ?? Theme.of(context).colorScheme.primary;
    final trackColor = spec.trackColor;
    final strokeWidth = spec.strokeWidth ?? 1.5;
    final size = spec.size ?? 24;

    final painter = RemixSpinnerPainter(
      animation: controller,
      strokeWidth: strokeWidth,
      indicatorColor: indicatorColor,
      trackColor: trackColor,
      trackStrokeWidth: spec.trackStrokeWidth,
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(painter: painter, size: Size(size, size));
      },
    );
  }
}

Widget createSpinnerWidget(RemixSpinnerSpec spec) {
  return _SpinnerSpecWidget(spec: spec);
}
