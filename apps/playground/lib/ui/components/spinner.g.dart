// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spinner.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Spinner recipe.
///
/// The spinner is the one component here that is pure motion: Remix owns the
/// eight-leaf geometry, the animation, and the progress semantics, and this
/// recipe supplies only its size, color, and tempo.
///
/// The content color is `foreground` rather than `primary`. A spinner most
/// often replaces text while something loads, so it should read at the same
/// weight as the text it stands in for.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
class PlaygroundSpinner extends StatelessWidget {
  const PlaygroundSpinner({
    super.key,
    this.style = const SpinnerStyler.create(),
    this.semanticsLabel,
    this.semanticsValue,
  });

  final SpinnerStyler style;

  final String? semanticsLabel;

  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return RemixSpinner(
      key: this.key,
      style: playgroundSpinnerStyle(style: this.style),
      semanticsLabel: this.semanticsLabel,
      semanticsValue: this.semanticsValue,
    );
  }
}
