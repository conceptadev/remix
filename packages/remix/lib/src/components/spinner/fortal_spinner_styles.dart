part of 'spinner.dart';

/// Fortal spinner size presets.
enum FortalSpinnerSize { size1, size2, size3 }

/// Fortal-themed preset for [RemixSpinner].
RemixSpinnerStyler fortalSpinnerStyler({FortalSpinnerSize size = .size2}) {
  return RemixSpinnerStyler(
    indicatorColor: FortalTokens.accent9(),
    duration: const Duration(milliseconds: 800),
  ).merge(_fortalSpinnerSizeStyler(size));
}

RemixSpinnerStyler _fortalSpinnerSizeStyler(FortalSpinnerSize size) {
  return switch (size) {
    .size1 => RemixSpinnerStyler(size: 16.0, strokeWidth: 1.5),
    .size2 => RemixSpinnerStyler(size: 20.0, strokeWidth: 2.0),
    .size3 => RemixSpinnerStyler(size: 24.0, strokeWidth: 2.5),
  };
}

/// Fortal-themed preset for [RemixSpinner].
class FortalSpinner extends StatelessWidget {
  const FortalSpinner({super.key, this.size = .size2, this.color});

  final FortalSpinnerSize size;

  /// Optional accent color override for this spinner subtree.
  final FortalAccentColor? color;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      child: fortalSpinnerStyler(size: this.size).call(key: this.key),
    );
  }
}
