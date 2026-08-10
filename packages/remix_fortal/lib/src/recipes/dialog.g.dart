// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixDialog].
///
/// The generated [FortalDialog] defaults to [FortalDialogSize.size3],
/// [FortalDialogAlign.center], a 600-pixel maximum width, and a modal dialog.
class FortalDialog extends StatelessWidget {
  const FortalDialog({
    super.key,
    this.size = FortalDialogSize.size3,
    this.align = FortalDialogAlign.center,
    this.child,
    this.title,
    this.description,
    this.actions,
    this.scrollable = false,
    this.modal = true,
    this.semanticLabel,
  });

  final FortalDialogSize size;

  final FortalDialogAlign align;

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
      style: fortalDialogStyle(size: this.size, align: this.align),
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
