// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixProgress].
class FortalProgress extends StatelessWidget {
  const FortalProgress({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  });

  const FortalProgress.classic({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  }) : variant = FortalProgressVariant.classic;

  const FortalProgress.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  }) : variant = FortalProgressVariant.surface;

  const FortalProgress.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ProgressStyler.create(),
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
  }) : variant = FortalProgressVariant.soft;

  final FortalProgressVariant variant;

  final FortalProgressSize size;

  final bool highContrast;

  final ProgressStyler style;

  final double value;

  final String? semanticsLabel;

  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return RemixProgress(
      key: this.key,
      style: fortalProgressStyle(
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
