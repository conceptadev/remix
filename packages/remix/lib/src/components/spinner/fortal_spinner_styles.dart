part of 'spinner.dart';

/// Fortal spinner size presets.
enum FortalSpinnerSize { size1, size2, size3 }

/// Fortal-themed preset for [RemixSpinner].
RemixSpinnerStyler fortalSpinnerStyler({FortalSpinnerSize size = .size2}) {
  return RemixSpinnerStyler(
    opacity: 0.65,
    leafRadius: FortalTokens.radius1(),
    duration: const Duration(milliseconds: 800),
  ).merge(_fortalSpinnerSizeStyler(size));
}

RemixSpinnerStyler _fortalSpinnerSizeStyler(FortalSpinnerSize size) {
  return switch (size) {
    .size1 => RemixSpinnerStyler(size: FortalTokens.space3()),
    .size2 => RemixSpinnerStyler(size: FortalTokens.space4()),
    .size3 => RemixSpinnerStyler(size: FortalTokens.spinnerSize3()),
  };
}

/// Fortal-themed spinner using the inherited foreground color.
class FortalSpinner extends StatelessWidget {
  const FortalSpinner({
    super.key,
    this.size = .size2,
    this.loading = true,
    this.child,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final FortalSpinnerSize size;
  final bool loading;
  final Widget? child;
  final String? semanticLabel;
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) => fortalSpinnerStyler(size: size).call(
    key: key,
    loading: loading,
    child: child,
    semanticLabel: semanticLabel,
    excludeSemantics: excludeSemantics,
  );
}
