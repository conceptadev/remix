part of 'select.dart';

/// Style configuration for [RemixSelect] trigger and menu overlay.
extension RemixSelectStylerRemixHelpers on RemixSelectStyler {
  /// Creates a [RemixSelect] widget with this style applied.
  ///
  /// Example:
  /// ```dart
  /// RemixSelectStyler()
  ///   .trigger(...)
  ///   .menuContainer(...)
  ///   .call<String>(
  ///     trigger: RemixSelectTrigger(placeholder: 'Select an option'),
  ///     items: [
  ///       RemixSelectItem(value: 'apple', label: 'Apple'),
  ///       RemixSelectItem(value: 'banana', label: 'Banana'),
  ///     ],
  ///   )
  /// ```
  RemixSelect<T> call<T>({
    Key? key,
    required RemixSelectTrigger trigger,
    required List<RemixSelectItem<T>> items,
    T? selectedValue,
    OverlayPositionConfig positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
    ),
    ValueChanged<T?>? onChanged,
    VoidCallback? onOpen,
    VoidCallback? onClose,
    bool enabled = true,
    bool closeOnSelect = true,
    String? semanticLabel,
    FocusNode? focusNode,
  }) {
    return RemixSelect(
      key: key,
      trigger: trigger,
      items: items,
      selectedValue: selectedValue,
      positioning: positioning,
      onChanged: onChanged,
      onOpen: onOpen,
      onClose: onClose,
      enabled: enabled,
      semanticLabel: semanticLabel,
      closeOnSelect: closeOnSelect,
      focusNode: focusNode,
      style: this,
    );
  }
}

/// Style configuration for the visible [RemixSelect] trigger.
extension RemixSelectTriggerStylerRemixHelpers on RemixSelectTriggerStyler {
  RemixSelectTriggerStyler flex(FlexStyler value) {
    return merge(
      RemixSelectTriggerStyler(container: FlexBoxStyler().flex(value)),
    );
  }
}

/// Style configuration for an item in a [RemixSelect] menu.
extension RemixSelectMenuItemStylerRemixHelpers on RemixSelectMenuItemStyler {
  /// Sets label styling (delegates to text for consistency with mixin)
  RemixSelectMenuItemStyler label(TextStyler value) {
    return text(value);
  }

  RemixSelectMenuItemStyler labelStyle(TextStyleMix value) {
    return label(TextStyler(style: value));
  }

  RemixSelectMenuItemStyler labelColor(Color value) {
    return label(TextStyler(style: TextStyleMix(color: value)));
  }

  RemixSelectMenuItemStyler labelFontSize(double value) {
    return label(TextStyler(style: TextStyleMix(fontSize: value)));
  }

  RemixSelectMenuItemStyler labelFontWeight(FontWeight value) {
    return label(TextStyler(style: TextStyleMix(fontWeight: value)));
  }

  RemixSelectMenuItemStyler labelFontStyle(FontStyle value) {
    return label(TextStyler(style: TextStyleMix(fontStyle: value)));
  }

  RemixSelectMenuItemStyler labelLetterSpacing(double value) {
    return label(TextStyler(style: TextStyleMix(letterSpacing: value)));
  }

  RemixSelectMenuItemStyler labelDecoration(TextDecoration value) {
    return label(TextStyler(style: TextStyleMix(decoration: value)));
  }

  RemixSelectMenuItemStyler labelFontFamily(String value) {
    return label(TextStyler(style: TextStyleMix(fontFamily: value)));
  }

  RemixSelectMenuItemStyler labelHeight(double value) {
    return label(TextStyler(style: TextStyleMix(height: value)));
  }

  RemixSelectMenuItemStyler labelWordSpacing(double value) {
    return label(TextStyler(style: TextStyleMix(wordSpacing: value)));
  }

  RemixSelectMenuItemStyler labelDecorationColor(Color value) {
    return label(TextStyler(style: TextStyleMix(decorationColor: value)));
  }

  RemixSelectMenuItemStyler flex(FlexStyler value) {
    return merge(
      RemixSelectMenuItemStyler(container: FlexBoxStyler().flex(value)),
    );
  }
}
