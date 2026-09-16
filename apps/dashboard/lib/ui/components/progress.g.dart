// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed preset for [RemixProgress].
class UiProgress extends StatelessWidget {
  const UiProgress({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  });

  const UiProgress.classic({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  }) : variant = UiProgressVariant.classic;

  const UiProgress.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  }) : variant = UiProgressVariant.surface;

  const UiProgress.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  }) : variant = UiProgressVariant.soft;

  final UiProgressVariant variant;

  final UiProgressSize size;

  final bool highContrast;

  final ProgressStyler style;

  final double value;

  final String? semanticsLabel;

  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return RemixProgress(
      key: this.key,
      style: uiProgressStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
        style: this.style,
      ),
      value: this.value,
      semanticsLabel: this.semanticsLabel,
      semanticsValue: this.semanticsValue,
    );
  }
}
