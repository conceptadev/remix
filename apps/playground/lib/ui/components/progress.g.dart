// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Progress recipe.
///
/// Remix owns the geometry that maps a 0-1 value onto the filled width, and
/// the progress semantics; this recipe supplies the track, the indicator, and
/// the bar's weight.
///
/// The track is `muted` and the indicator is `primary`: the same pairing the
/// checked checkbox uses, so "how far along" reads in the accent the rest of
/// the application already uses for state.
///
/// Both the track and the indicator are fully rounded rather than sharing the
/// theme's control radius. The theme radius is authored for 32-40px controls;
/// on a 4px bar anything short of a full round reads as a rendering artifact.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it:
///
/// ```dart
/// PlaygroundProgress(
///   value: 0.4,
///   style: ProgressStyler().indicatorColor(PlaygroundTokens.destructive()),
/// )
/// ```
class PlaygroundProgress extends StatelessWidget {
  const PlaygroundProgress({
    super.key,
    this.size = .medium,
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  });

  final PlaygroundProgressSize size;

  final ProgressStyler style;

  final double value;

  final String? semanticsLabel;

  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return RemixProgress(
      key: this.key,
      style: playgroundProgressStyle(size: this.size, style: this.style),
      value: this.value,
      semanticsLabel: this.semanticsLabel,
      semanticsValue: this.semanticsValue,
    );
  }
}
