// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Progress recipe.
///
/// Remix owns the geometry that maps a 0-1 value onto the filled width, and
/// the progress semantics; this recipe supplies the track and the indicator.
///
/// One weight, not a scale. A progress bar has no size relationship to the
/// controls around it — it spans its container and is read by length rather
/// than by height — so the sizes this recipe used to offer were three numbers
/// with nothing to anchor them. shadcn ships `h-2` and nothing else, and this
/// is that bar. A call site that wants a different weight sets `.height(...)`
/// through [style], which is one line and says what it means.
///
/// The track is `muted` and the indicator is `primary`: the same pairing the
/// checked checkbox uses, so "how far along" reads in the accent the rest of
/// the application already uses for state.
///
/// Both are fully rounded rather than sharing the theme's control radius. The
/// theme radius is authored for 32-40px controls; on an 8px bar anything
/// short of a full round reads as a rendering artifact.
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
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  });

  final ProgressStyler style;

  final double value;

  final String? semanticsLabel;

  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return RemixProgress(
      key: this.key,
      style: playgroundProgressStyle(style: this.style),
      value: this.value,
      semanticsLabel: this.semanticsLabel,
      semanticsValue: this.semanticsValue,
    );
  }
}
