// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed preset for [RemixDialog].
///
/// The generated [UiDialog] defaults to [UiDialogSize.size3],
/// [UiDialogAlign.center], fills up to 600 logical pixels, preserves safe
/// viewport insets, and is modal.
class UiDialog extends StatelessWidget {
  const UiDialog({
    super.key,
    this.size = UiDialogSize.size3,
    this.align = UiDialogAlign.center,
    this.style = const DialogStyler.create(),
    this.child,
    this.title,
    this.description,
    this.actions,
    this.scrollable = false,
    this.modal = true,
    this.semanticLabel,
  });

  final UiDialogSize size;

  final UiDialogAlign align;

  final DialogStyler style;

  final Widget? child;

  final String? title;

  final String? description;

  final List<Widget>? actions;

  final bool scrollable;

  final bool modal;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return RemixDialog(
      key: this.key,
      style: uiDialogStyle(
        size: this.size,
        align: this.align,
        style: this.style,
      ),
      child: this.child,
      title: this.title,
      description: this.description,
      actions: this.actions,
      scrollable: this.scrollable,
      modal: this.modal,
      semanticLabel: this.semanticLabel,
    );
  }
}
