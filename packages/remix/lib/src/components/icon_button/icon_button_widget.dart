part of 'icon_button.dart';

/// Builder for the loading indicator rendered by [RemixIconButton].
typedef RemixIconButtonLoadingBuilder =
    Widget Function(BuildContext context, RemixSpinnerSpec spec);

/// A square button whose arbitrary [child] inherits the resolved icon theme.
class RemixIconButton extends StatelessWidget {
  const RemixIconButton({
    super.key,
    required this.child,
    required this.semanticLabel,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
    this.style = const RemixIconButtonStyler.create(),
    this.styleSpec,
  }) : assert(semanticLabel != '');

  static final styleFrom = RemixIconButtonStyler.new;

  final Widget child;
  final String semanticLabel;
  final RemixIconButtonLoadingBuilder? loadingBuilder;
  final bool loading;
  final bool enabled;
  final bool enableFeedback;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticHint;
  final bool excludeSemantics;
  final MouseCursor mouseCursor;
  final RemixIconButtonStyler style;
  final RemixIconButtonSpec? styleSpec;

  bool get _isEnabled =>
      enabled && !loading && (onPressed != null || onLongPress != null);

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
      builder: (context, _, _) => RemixStyleSpecBuilder<RemixIconButtonSpec>(
        style: style,
        styleSpec: styleSpec,
        controller: NakedButtonState.controllerOf(context),
        builder: (context, spec) {
          final content = Visibility(
            visible: !loading,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            maintainSemantics: true,
            child: RemixDefaultContentStyle(child: child, icon: spec.icon),
          );
          final button = RemixBoxWithEffects(
            key: const ValueKey('remix-icon-button-surface'),
            styleSpec: spec.container,
            containerEffects: spec.containerEffects,
            child: content,
          );
          final spinner = loadingBuilder == null
              ? RemixSpinner(styleSpec: spec.spinner.spec)
              : loadingBuilder!(context, spec.spinner.spec);

          return Semantics(
            excludeSemantics: true,
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
        },
      ),
    );
  }
}
