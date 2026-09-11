// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spinner.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixSpinner] using the inherited foreground color.
class FortalSpinner extends StatelessWidget {
  const FortalSpinner({
    super.key,
    this.size = .size2,
    this.style = const SpinnerStyler.create(),
    this.semanticsLabel,
    this.semanticsValue,
  });

  final FortalSpinnerSize size;

  final SpinnerStyler style;

  final String? semanticsLabel;

  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return RemixSpinner(
      key: this.key,
      style: fortalSpinnerStyle(size: this.size, style: this.style),
      semanticsLabel: this.semanticsLabel,
      semanticsValue: this.semanticsValue,
    );
  }
}
