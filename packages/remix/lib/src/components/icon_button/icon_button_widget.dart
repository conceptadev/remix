part of 'icon_button.dart';

/// Builds icon data with the resolved icon style.
typedef RemixIconButtonIconBuilder =
    Widget Function(BuildContext context, IconSpec spec, IconData? icon);

/// Builder for the loading indicator rendered by [RemixIconButton].
typedef RemixIconButtonLoadingBuilder =
    Widget Function(BuildContext context, RemixSpinnerSpec spec);

/// A square button accepting established [IconData] or arbitrary icon widgets.
class RemixIconButton extends StatelessWidget {
  const RemixIconButton({
    super.key,
    required this.icon,
    this.iconBuilder,
    this.semanticLabel,
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
  }) : assert(semanticLabel == null || semanticLabel != '');

  static final styleFrom = RemixIconButtonStyler.new;

  /// An [IconData] from the established API or an arbitrary icon [Widget].
  final Object icon;
  final RemixIconButtonIconBuilder? iconBuilder;
  final String? semanticLabel;
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

  Widget _buildIcon(BuildContext context, StyleSpec<IconSpec> styleSpec) {
    final icon = this.icon;
    if (iconBuilder case final builder?) {
      if (icon is! IconData) {
        throw ArgumentError.value(
          icon,
          'icon',
          'iconBuilder requires icon to be IconData.',
        );
      }
      return StyleSpecBuilder<IconSpec>(
        styleSpec: styleSpec,
        builder: (context, spec) => builder(context, spec, icon),
      );
    }
    return switch (icon) {
      IconData() => StyledIcon(icon: icon, styleSpec: styleSpec),
      Widget() => RemixDefaultContentStyle(child: icon, icon: styleSpec),
      _ => throw ArgumentError.value(
        icon,
        'icon',
        'Expected IconData or Widget.',
      ),
    };
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
      semanticLabel: semanticLabel ?? 'Icon Button',
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
            child: _buildIcon(context, spec.icon),
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
