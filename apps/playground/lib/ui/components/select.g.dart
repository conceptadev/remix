// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Select recipe.
///
/// Remix owns the rendering, the overlay, keyboard traversal, the open and
/// close behavior, and the listbox accessibility semantics; this recipe
/// supplies the trigger, the floating panel, and the option rows.
///
/// One recipe covers all three, because `SelectSpec` carries them as fields:
/// `trigger`, `content` with `menuContainer`, and `item`. An option in a loop
/// therefore cannot be left unstyled.
///
/// The trigger is styled as a field rather than as a button — same border,
/// same radius, same heights as the text field — because that is what it is.
/// The panel matches the menu's, so a select and a menu opened side by side
/// do not read as two systems.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the trigger's focus ring has to be
/// declared as a focus fragment too.
class PlaygroundSelect<T> extends StatelessWidget {
  const PlaygroundSelect({
    super.key,
    this.style = const SelectStyler.create(),
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

  final SelectStyler style;

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
      style: playgroundSelectStyle(style: this.style),
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
