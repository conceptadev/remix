part of 'spinner.dart';

/// Style builder for [RemixSpinner].
///
/// Use this class to customize spinner size, current-color override, opacity,
/// leaf radius, duration, and Mix variants.
extension RemixSpinnerStylerRemixHelpers on RemixSpinnerStyler {
  RemixSpinner call({
    Key? key,
    bool loading = true,
    Widget? child,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixSpinner(
      key: key,
      loading: loading,
      child: child,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      style: this,
    );
  }
}
