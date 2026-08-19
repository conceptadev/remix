part of 'icon_button.dart';

/// Builds icon data with the resolved icon style.
typedef RemixIconButtonIconBuilder =
    Widget Function(BuildContext context, IconSpec spec, IconData? icon);

/// Builder for the loading indicator rendered by [RemixIconButton].
typedef RemixIconButtonLoadingBuilder =
    Widget Function(BuildContext context, SpinnerSpec spec);

/// A square button that renders typed [IconData].
///
/// Use [iconBuilder] when custom icon composition is needed.
class RemixIconButton extends StatelessWidget {
  const RemixIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    this.iconBuilder,
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
    this.style = const IconButtonStyler.create(),
    this.styleSpec,
  }) : assert(
         icon != null || iconBuilder != null,
         'Either icon or iconBuilder must be provided.',
       ),
       assert(
         semanticLabel != '',
         'RemixIconButton.semanticLabel must be a nonblank accessible name.',
       );

  static final styleFrom = IconButtonStyler.new;

  /// The icon rendered by the button.
  ///
  /// May be null when [iconBuilder] supplies the icon widget.
  final IconData? icon;
  final RemixIconButtonIconBuilder? iconBuilder;

  /// Accessible name for this icon-only control.
  ///
  /// Required and must be nonblank. A generic fallback cannot describe the
  /// action, so callers supply the name that screen readers should announce.
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

  /// Whether to hide the complete control from the semantic tree.
  final bool excludeSemantics;
  final MouseCursor mouseCursor;
  final IconButtonStyler style;
  final IconButtonSpec? styleSpec;

  Widget _buildIcon(BuildContext context, StyleSpec<IconSpec> styleSpec) {
    if (iconBuilder case final builder?) {
      return StyleSpecBuilder<IconSpec>(
        styleSpec: styleSpec,
        builder: (context, spec) => builder(context, spec, icon),
      );
    }
    return StyledIcon(icon: icon!, styleSpec: styleSpec);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      semanticLabel.trim().isNotEmpty,
      'RemixIconButton.semanticLabel must be a nonblank accessible name.',
    );
    return NakedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      enabled: enabled && !loading,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      builder: (context, _, _) => RemixStyleSpecBuilder<IconButtonSpec>(
        style: style,
        styleSpec: styleSpec,
        controller: NakedButtonState.controllerOf(context),
        builder: (context, spec) {
          final content = Visibility(
            visible: !loading,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: _buildIcon(context, spec.icon),
          );
          final button = RemixBoxWithEffects(
            key: const ValueKey('remix-icon-button-surface'),
            styleSpec: spec.container,
            containerEffects: spec.containerEffects,
            child: content,
          );
          final spinner = StyleSpecBuilder<SpinnerSpec>(
            styleSpec: spec.spinner,
            builder: (context, spinnerSpec) => loadingBuilder == null
                ? RemixSpinner(styleSpec: spinnerSpec)
                : loadingBuilder!(context, spinnerSpec),
          );

          return ExcludeSemantics(
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
