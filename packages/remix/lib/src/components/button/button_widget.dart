part of 'button.dart';

/// Builder for the loading indicator rendered by [RemixButton].
typedef RemixButtonLoadingBuilder =
    Widget Function(BuildContext context, RemixSpinnerSpec spec);

/// A pressable button whose arbitrary content inherits its resolved text and
/// icon styles.
class RemixButton extends StatelessWidget {
  const RemixButton({
    super.key,
    required this.child,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
    this.style = const ButtonStyler.create(),
    this.styleSpec,
  });

  static ButtonStyler composeStyle(ButtonStyler style) =>
      .mainAxisSize(.min).merge(style);

  static final styleFrom = ButtonStyler.new;

  final Widget child;
  final RemixButtonLoadingBuilder? loadingBuilder;
  final bool loading;
  final bool enabled;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool enableFeedback;
  final bool autofocus;
  final String? semanticLabel;
  final String? semanticHint;
  final bool excludeSemantics;
  final MouseCursor mouseCursor;
  final ButtonStyler style;
  final RemixButtonSpec? styleSpec;

  bool get _isEnabled =>
      enabled && !loading && (onPressed != null || onLongPress != null);

  Widget _buildContent(BuildContext context, RemixButtonSpec spec) {
    final content = remixInheritedContentStyle(
      child: child,
      text: spec.label,
      icon: spec.icon,
    );
    final hiddenContent = Visibility(
      visible: !loading,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      maintainSemantics: true,
      child: content,
    );
    final button = RemixSurfaceFlexBox(
      styleSpec: spec.container,
      direction: Axis.horizontal,
      surface: spec.surface,
      overlay: spec.overlay,
      children: [hiddenContent],
    );
    final spinner = loadingBuilder == null
        ? RemixSpinner(styleSpec: spec.spinner.spec)
        : loadingBuilder!(context, spec.spinner.spec);

    return Semantics(
      excludeSemantics: semanticLabel != null,
      liveRegion: loading,
      hint: semanticHint,
      child: Stack(
        alignment: Alignment.center,
        children: [
          button,
          if (loading) Positioned.fill(child: Center(child: spinner)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NakedButton(
      onPressed: _isEnabled ? onPressed : null,
      onLongPress: _isEnabled ? onLongPress : null,
      enabled: _isEnabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      builder: (context, _, _) => RemixStyleSpecBuilder<RemixButtonSpec>(
        style: composeStyle(style),
        styleSpec: styleSpec,
        controller: NakedButtonState.controllerOf(context),
        builder: _buildContent,
      ),
    );
  }
}
