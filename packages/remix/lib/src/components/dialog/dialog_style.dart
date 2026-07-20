part of 'dialog.dart';

/// Style configuration for [RemixDialog] container, title, description, and actions.
extension RemixDialogStylerRemixHelpers on RemixDialogStyler {
  /// Sets the background color of the dialog.
  RemixDialogStyler backgroundColor(Color value) {
    return merge(
      RemixDialogStyler(
        container: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Creates a [RemixDialog] widget with this style applied.
  RemixDialog call({
    Key? key,
    Widget? child,
    String? title,
    String? description,
    List<Widget>? actions,
    bool modal = true,
    String? semanticLabel,
    RemixDialogAlignment alignment = RemixDialogAlignment.center,
    double? width,
    double? minWidth,
    double? maxWidth,
    double? height,
    double? minHeight,
    double? maxHeight,
    EdgeInsetsGeometry insetPadding = EdgeInsets.zero,
  }) {
    return RemixDialog(
      key: key,
      title: title,
      description: description,
      actions: actions,
      modal: modal,
      semanticLabel: semanticLabel,
      alignment: alignment,
      width: width,
      minWidth: minWidth,
      maxWidth: maxWidth,
      height: height,
      minHeight: minHeight,
      maxHeight: maxHeight,
      insetPadding: insetPadding,
      style: this,
      child: child,
    );
  }
}
