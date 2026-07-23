part of 'button.dart';

/// Builds the text content rendered by [RemixButton].
typedef RemixButtonTextBuilder =
    Widget Function(BuildContext context, TextSpec spec, String text);

/// Builds a leading or trailing icon rendered by [RemixButton].
typedef RemixButtonIconBuilder =
    Widget Function(BuildContext context, IconSpec spec, IconData? icon);

/// Builder for the loading indicator rendered by [RemixButton].
typedef RemixButtonLoadingBuilder =
    Widget Function(BuildContext context, RemixSpinnerSpec spec);

/// A pressable button with either an established text-and-icon composition or
/// arbitrary content that inherits the resolved text and icon styles.
class RemixButton extends StatelessWidget {
  const RemixButton({
    super.key,
    String? label,
    this.child,
    this.leadingIcon,
    this.trailingIcon,
    this.textBuilder,
    this.leadingIconBuilder,
    this.trailingIconBuilder,
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
  }) : _label = label,
       assert(
         (label == null) != (child == null),
         'Provide exactly one of label or child.',
       );

  /// Creates a button with arbitrary content that inherits resolved styles.
  const RemixButton.custom({
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
  }) : _label = null,
       leadingIcon = null,
       trailingIcon = null,
       textBuilder = null,
       leadingIconBuilder = null,
       trailingIconBuilder = null;

  static ButtonStyler composeStyle(ButtonStyler style) =>
      .mainAxisSize(.min).merge(style);

  static final styleFrom = ButtonStyler.new;

  /// Arbitrary button content. Use [label] for the established text API.
  final Widget? child;

  final String? _label;

  /// The established text label.
  String get label => _label!;

  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final RemixButtonTextBuilder? textBuilder;
  final RemixButtonIconBuilder? leadingIconBuilder;
  final RemixButtonIconBuilder? trailingIconBuilder;
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

  Widget? _buildIcon(
    BuildContext context,
    StyleSpec<IconSpec> styleSpec,
    IconData? icon,
    RemixButtonIconBuilder? builder,
  ) {
    if (icon == null && builder == null) return null;
    if (builder == null) return StyledIcon(icon: icon, styleSpec: styleSpec);
    return StyleSpecBuilder<IconSpec>(
      styleSpec: styleSpec,
      builder: (context, spec) => builder(context, spec, icon),
    );
  }

  Widget _buildLegacyContent(BuildContext context, RemixButtonSpec spec) {
    final leading = _buildIcon(
      context,
      spec.icon,
      leadingIcon,
      leadingIconBuilder,
    );
    final trailing = _buildIcon(
      context,
      spec.icon,
      trailingIcon,
      trailingIconBuilder,
    );
    final text = textBuilder == null
        ? StyledText(label, styleSpec: spec.label)
        : StyleSpecBuilder<TextSpec>(
            styleSpec: spec.label,
            builder: (context, textSpec) =>
                textBuilder!(context, textSpec, label),
          );
    final hasBothIcons = leading != null && trailing != null;
    final children = hasBothIcons || spec.iconAlignment == null
        ? <Widget>[?leading, text, ?trailing]
        : switch (spec.iconAlignment!) {
            .start => <Widget>[?leading, ?trailing, text],
            .end => <Widget>[text, ?leading, ?trailing],
          };
    return RemixFlexBoxWithEffects(
      key: const ValueKey('remix-button-surface'),
      styleSpec: spec.container,
      direction: Axis.horizontal,
      containerEffects: spec.containerEffects,
      children: children,
    );
  }

  Widget _buildContent(BuildContext context, RemixButtonSpec spec) {
    final content = child == null
        ? _buildLegacyContent(context, spec)
        : RemixFlexBoxWithEffects(
            key: const ValueKey('remix-button-surface'),
            styleSpec: spec.container,
            direction: Axis.horizontal,
            containerEffects: spec.containerEffects,
            children: [
              RemixDefaultContentStyle(
                text: spec.label,
                icon: spec.icon,
                child: child!,
              ),
            ],
          );
    final hiddenContent = Visibility(
      visible: !loading,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      maintainSemantics: true,
      child: content,
    );
    final spinner = StyleSpecBuilder<RemixSpinnerSpec>(
      styleSpec: spec.spinner,
      builder: (context, spinnerSpec) => loadingBuilder == null
          ? RemixSpinner(styleSpec: spinnerSpec)
          : loadingBuilder!(context, spinnerSpec),
    );

    return Semantics(
      excludeSemantics: semanticLabel != null || child == null,
      liveRegion: loading,
      hint: semanticHint,
      child: Stack(
        alignment: Alignment.center,
        children: [
          hiddenContent,
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
      semanticLabel: semanticLabel ?? (child == null ? label : null),
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
