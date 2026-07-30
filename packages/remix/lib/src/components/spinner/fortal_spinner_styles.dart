part of 'spinner.dart';

/// Fortal spinner size presets.
enum FortalSpinnerSize { size1, size2, size3 }

/// Fortal-themed preset for [RemixSpinner] using the inherited foreground color.
@MixWidget(target: RemixSpinner.new)
RemixSpinnerStyler fortalSpinnerStyle({FortalSpinnerSize size = .size2}) {
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
