// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Dialog recipe.
///
/// Remix owns the rendering, the modal barrier, focus trapping, the escape
/// and barrier dismissal rules, and the dialog accessibility semantics; this
/// recipe supplies the panel, the two text roles, and the action row.
///
/// It is a popover with a title: the same `background` fill, `border`
/// hairline, and lift, sized wider and padded more because a dialog holds a
/// decision rather than a control. The two are deliberately separate files —
/// they have separate update stories, and sharing a surface helper would make
/// every change to one a change to the other.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
class PlaygroundDialog extends StatelessWidget {
  const PlaygroundDialog({
    super.key,
    this.style = const DialogStyler.create(),
    this.child,
    this.title,
    this.description,
    this.actions,
    this.scrollable = false,
    this.modal = true,
    this.semanticLabel,
  });

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
      style: playgroundDialogStyle(style: this.style),
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
