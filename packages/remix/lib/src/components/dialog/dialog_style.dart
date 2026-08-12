part of 'dialog.dart';

/// Style configuration for [RemixDialog] container, title, description, and actions.
extension RemixDialogStylerRemixHelpers on DialogStyler {
  /// Creates a [RemixDialog] widget with this style applied.
  RemixDialog call({
    Key? key,
    Widget? child,
    String? title,
    String? description,
    List<Widget>? actions,
    bool scrollable = false,
    bool modal = true,
    String? semanticLabel,
  }) {
    return RemixDialog(
      key: key,
      title: title,
      description: description,
      actions: actions,
      scrollable: scrollable,
      modal: modal,
      semanticLabel: semanticLabel,
      style: this,
      child: child,
    );
  }
}
