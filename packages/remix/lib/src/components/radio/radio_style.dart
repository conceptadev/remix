part of 'radio.dart';

/// Style configuration for [RemixRadio] container and selected indicator.
extension RemixRadioStylerRemixHelpers on RadioStyler {
  /// Creates a RemixRadio widget with this style applied.
  RemixRadio<T> call<T>({
    Key? key,
    required T value,
    bool enabled = true,
    bool toggleable = false,
    MouseCursor? mouseCursor,
    FocusNode? focusNode,
    bool autofocus = false,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixRadio(
      key: key,
      value: value,
      enabled: enabled,
      toggleable: toggleable,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      style: this,
    );
  }

  /// Sets fill color on the container.
  RadioStyler fillColor(Color value) {
    return merge(
      RadioStyler(
        container: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets the indicator's fill color.
  RadioStyler indicatorColor(Color value) {
    return merge(
      RadioStyler(
        indicator: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }
}
