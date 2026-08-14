part of 'link.dart';

/// Style configuration for [RemixLink] container and label text.
extension RemixLinkStylerRemixHelpers on LinkStyler {
  /// Creates a [RemixLink] widget with this style applied.
  RemixLink call({
    Key? key,
    String? label,
    Widget? child,
    VoidCallback? onPressed,
    bool enabled = true,
    Uri? linkUrl,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableFeedback = true,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    String? semanticLabel,
    String? semanticHint,
    bool excludeSemantics = false,
  }) => RemixLink(
    key: key,
    label: label,
    child: child,
    onPressed: onPressed,
    enabled: enabled,
    linkUrl: linkUrl,
    focusNode: focusNode,
    autofocus: autofocus,
    enableFeedback: enableFeedback,
    mouseCursor: mouseCursor,
    semanticLabel: semanticLabel,
    semanticHint: semanticHint,
    excludeSemantics: excludeSemantics,
    style: this,
  );
}
