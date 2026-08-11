import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'spinner.g.dart';

/// Fortal spinner size presets.
enum FortalSpinnerSize { size1, size2, size3 }

/// Fortal-themed preset for [RemixSpinner] using the inherited foreground color.
@MixWidget(target: RemixSpinner.new)
SpinnerStyler fortalSpinnerStyle({FortalSpinnerSize size = .size2}) {
  return SpinnerStyler(
    opacity: 0.65,
    leafRadius: FortalTokens.radius1(),
    duration: const Duration(milliseconds: 800),
  ).merge(_fortalSpinnerSizeStyler(size));
}

SpinnerStyler _fortalSpinnerSizeStyler(FortalSpinnerSize size) {
  return switch (size) {
    .size1 => SpinnerStyler(size: FortalTokens.space3()),
    .size2 => SpinnerStyler(size: FortalTokens.space4()),
    .size3 => SpinnerStyler(size: FortalTokens.spinnerSize3()),
  };
}
