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
    this.semanticsLabel,
    this.semanticsValue,
  });

  final FortalSpinnerSize size;

  final String? semanticsLabel;

  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return RemixSpinner(
      key: this.key,
      style: fortalSpinnerStyle(size: this.size),
      semanticsLabel: this.semanticsLabel,
      semanticsValue: this.semanticsValue,
    );
  }
}
