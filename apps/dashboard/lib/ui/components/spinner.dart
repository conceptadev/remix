import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'spinner.g.dart';

/// Ui spinner size presets.
enum UiSpinnerSize { size1, size2, size3 }

/// Ui-themed preset for [RemixSpinner] using the inherited foreground color.
@MixWidget(target: RemixSpinner.new)
SpinnerStyler uiSpinnerStyle({
  UiSpinnerSize size = .size2,
  SpinnerStyler style = const SpinnerStyler.create(),
}) {
  return SpinnerStyler(
    opacity: 0.65,
    leafRadius: UiTokens.radius1(),
    duration: const Duration(milliseconds: 800),
  ).merge(_uiSpinnerSizeStyler(size)).merge(style);
}

SpinnerStyler _uiSpinnerSizeStyler(UiSpinnerSize size) {
  return switch (size) {
    .size1 => SpinnerStyler(size: UiTokens.space3()),
    .size2 => SpinnerStyler(size: UiTokens.space4()),
    .size3 => SpinnerStyler(size: UiTokens.spinnerSize3()),
  };
}
