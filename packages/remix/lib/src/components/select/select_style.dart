part of 'select.dart';

/// Style configuration for [RemixSelect] trigger and menu overlay.
extension RemixSelectStylerRemixHelpers on RemixSelectStyler {
  /// Creates a [RemixSelect] widget with this style applied.
  ///
  /// Example:
  /// ```dart
  /// RemixSelectStyler()
  ///   .trigger(...)
  ///   .content(...)
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
    required List<RemixSelectItemData<T>> items,
    T? selectedValue,
    OverlayPositionConfig positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
      sideOffset: 4,
    ),
    ValueChanged<T?>? onChanged,
    VoidCallback? onOpen,
    VoidCallback? onClose,
    bool? open,
    ValueChanged<bool>? onOpenChanged,
    bool enabled = true,
    bool closeOnSelect = true,
    String? semanticLabel,
    FocusNode? focusNode,
    RemixSelectPartWrapper? triggerWrapper,
    RemixSelectPartWrapper? contentWrapper,
    RemixSelectIconBuilder? triggerChevronBuilder,
    RemixSelectIconBuilder? itemIndicatorBuilder,
  }) {
    return RemixSelect<T>(
      key: key,
      trigger: trigger,
      items: items,
      selectedValue: selectedValue,
      positioning: positioning,
      onChanged: onChanged,
      onOpen: onOpen,
      onClose: onClose,
      open: open,
      onOpenChanged: onOpenChanged,
      enabled: enabled,
      semanticLabel: semanticLabel,
      closeOnSelect: closeOnSelect,
      focusNode: focusNode,
      triggerWrapper: triggerWrapper,
      contentWrapper: contentWrapper,
      triggerChevronBuilder: triggerChevronBuilder,
      itemIndicatorBuilder: itemIndicatorBuilder,
      style: this,
    );
  }

  /// Creates a select with grouped, labeled, or separated content.
  RemixSelect<T> structured<T>({
    Key? key,
    required RemixSelectTrigger trigger,
    required List<RemixSelectItemData<T>> items,
    T? selectedValue,
    OverlayPositionConfig positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
      sideOffset: 4,
    ),
    ValueChanged<T?>? onChanged,
    VoidCallback? onOpen,
    VoidCallback? onClose,
    bool? open,
    ValueChanged<bool>? onOpenChanged,
    bool enabled = true,
    bool closeOnSelect = true,
    String? semanticLabel,
    FocusNode? focusNode,
    RemixSelectPartWrapper? triggerWrapper,
    RemixSelectPartWrapper? contentWrapper,
    RemixSelectIconBuilder? triggerChevronBuilder,
    RemixSelectIconBuilder? itemIndicatorBuilder,
  }) {
    return RemixSelect<T>.structured(
      key: key,
      trigger: trigger,
      items: items,
      selectedValue: selectedValue,
      positioning: positioning,
      onChanged: onChanged,
      onOpen: onOpen,
      onClose: onClose,
      open: open,
      onOpenChanged: onOpenChanged,
      enabled: enabled,
      semanticLabel: semanticLabel,
      closeOnSelect: closeOnSelect,
      focusNode: focusNode,
      triggerWrapper: triggerWrapper,
      contentWrapper: contentWrapper,
      triggerChevronBuilder: triggerChevronBuilder,
      itemIndicatorBuilder: itemIndicatorBuilder,
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

/// Text conveniences for non-selectable labels in select content.
extension RemixSelectLabelStylerRemixHelpers on RemixSelectLabelStyler {
  RemixSelectLabelStyler label(TextStyler value) => text(value);

  RemixSelectLabelStyler labelStyle(TextStyleMix value) {
    return label(TextStyler(style: value));
  }

  RemixSelectLabelStyler labelColor(Color value) {
    return label(TextStyler(style: TextStyleMix(color: value)));
  }
}
