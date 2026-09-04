// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed Select with Radix-owned trigger and content configuration.
class FortalSelect<T> extends StatelessWidget {
  const FortalSelect({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.closeOnSelect = true,
    this.focusNode,
  });

  const FortalSelect.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.closeOnSelect = true,
    this.focusNode,
  }) : variant = FortalSelectVariant.surface;

  const FortalSelect.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.closeOnSelect = true,
    this.focusNode,
  }) : variant = FortalSelectVariant.soft;

  const FortalSelect.ghost({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.closeOnSelect = true,
    this.focusNode,
  }) : variant = FortalSelectVariant.ghost;

  final FortalSelectVariant variant;

  final FortalSelectSize size;

  final bool highContrast;

  final RemixSelectTrigger trigger;

  final List<RemixSelectItem<T>> items;

  final T? selectedValue;

  final OverlayPositionConfig positioning;

  final ValueChanged<T?>? onChanged;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;

  final bool enabled;

  final MouseCursor mouseCursor;

  final String? semanticLabel;

  final bool closeOnSelect;

  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return RemixSelect<T>(
      key: this.key,
      style: fortalSelectStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      trigger: this.trigger,
      items: this.items,
      selectedValue: this.selectedValue,
      positioning: this.positioning,
      onChanged: this.onChanged,
      onOpen: this.onOpen,
      onClose: this.onClose,
      enabled: this.enabled,
      mouseCursor: this.mouseCursor,
      semanticLabel: this.semanticLabel,
      closeOnSelect: this.closeOnSelect,
      focusNode: this.focusNode,
    );
  }
}
