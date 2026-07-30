part of 'button.dart';

/// Builder function for customizing button text rendering.
typedef RemixButtonTextBuilder =
    Widget Function(BuildContext context, TextSpec spec, String text);

/// Builder function for customizing button icon rendering (leading or trailing).
typedef RemixButtonIconBuilder =
    Widget Function(BuildContext context, IconSpec spec, IconData? icon);

/// Builder function for customizing button loading state rendering.
typedef RemixButtonLoadingBuilder =
    Widget Function(BuildContext context, RemixSpinnerSpec spec);

/// A customizable button component that supports text with optional leading and trailing icons,
/// loading states, and styling. The button integrates with the Mix styling system
/// and follows Remix design patterns. For icon-only buttons, use RemixIconButton instead.
///
/// ## Examples
///
/// ```dart
/// // Basic button
/// RemixButton(
///   label: 'Click Me',
///   onPressed: () => debugPrint('Button pressed!'),
/// )
///
/// // Button with leading icon
/// RemixButton(
///   label: 'Save Changes',
///   leadingIcon: Icons.save,
///   onPressed: () => debugPrint('Save pressed!'),
/// )
///
/// // Button with trailing icon
/// RemixButton(
///   label: 'Next',
///   trailingIcon: Icons.arrow_forward,
///   onPressed: () => debugPrint('Next pressed!'),
/// )
///
/// // Button with both icons
/// RemixButton(
///   label: 'Send',
///   leadingIcon: Icons.send,
///   trailingIcon: Icons.check,
///   onPressed: () => debugPrint('Send pressed!'),
/// )
///
/// // Loading button
/// RemixButton(
///   label: 'Processing',
///   loading: true,
///   onPressed: () => debugPrint('Processing...'),
/// )
/// ```
///
class RemixButton extends StatelessWidget {
  /// Creates a Remix button.
  ///
  /// The [label] parameter is required and specifies the button text.
  /// Use builders to customize rendering of specific parts.
  const RemixButton({
    super.key,
    required this.label,
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
  });

  /// Composes widget-owned defaults with an incoming Button style.
  ///
  /// Protocol and inspection tooling should project this effective style so
  /// it observes the same layout defaults as [build].
  static ButtonStyler composeStyle(ButtonStyler style) =>
      .mainAxisSize(.min).merge(style);

  static final styleFrom = ButtonStyler.new;

  /// Whether the button is in a loading state.
  ///
  /// When true, the button will display a spinner and become non-interactive.
  /// The spinner can be customized via [loadingBuilder].
  final bool loading;

  /// Whether the button is enabled.
  ///
  /// When false, the button will be disabled regardless of other conditions.
  /// Defaults to true.
  final bool enabled;

  /// Callback function called when the button is pressed.
  ///
  /// If null, the button will be considered disabled.
  final VoidCallback? onPressed;

  /// Callback function called when the button is long pressed.
  final VoidCallback? onLongPress;

  /// Optional focus node to control the button's focus behavior.
  final FocusNode? focusNode;

  /// Whether to provide feedback when the button is pressed.
  ///
  /// Defaults to true.
  final bool enableFeedback;

  /// Whether the button should automatically request focus when it is created.
  final bool autofocus;

  /// The label text to display in the button.
  /// If [textBuilder] is provided, this is ignored.
  final String label;

  /// The leading icon to display in the button (before the text).
  /// If [leadingIconBuilder] is provided, this is ignored.
  final IconData? leadingIcon;

  /// The trailing icon to display in the button (after the text).
  /// If [trailingIconBuilder] is provided, this is ignored.
  final IconData? trailingIcon;

  /// Builder for customizing the text rendering.
  final RemixButtonTextBuilder? textBuilder;

  /// Builder for customizing the leading icon rendering.
  final RemixButtonIconBuilder? leadingIconBuilder;

  /// Builder for customizing the trailing icon rendering.
  final RemixButtonIconBuilder? trailingIconBuilder;

  /// Builder for customizing the loading state rendering.
  final RemixButtonLoadingBuilder? loadingBuilder;

  /// The semantic label for the button.
  ///
  /// Used by screen readers to describe the button.
  final String? semanticLabel;

  /// The semantic hint for the button.
  ///
  /// Provides additional context about what will happen when the button is activated.
  final String? semanticHint;

  /// Whether to exclude child semantics.
  ///
  /// When true, the semantics of child widgets will be excluded.
  /// Defaults to false.
  final bool excludeSemantics;

  /// Cursor when hovering over the button.
  ///
  /// Defaults to [SystemMouseCursors.click] when enabled.
  final MouseCursor mouseCursor;

  /// The style configuration for the button.
  final ButtonStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixButtonSpec? styleSpec;

  bool get _isEnabled => enabled && !loading && onPressed != null;

  ButtonStyler _buildStyle() => composeStyle(style);

  Widget _buildContent(BuildContext context, RemixButtonSpec spec) {
    Widget? leadingIconWidget;
    Widget? trailingIconWidget;

    if (leadingIcon != null || leadingIconBuilder != null) {
      leadingIconWidget = leadingIconBuilder == null
          ? StyledIcon(icon: leadingIcon, styleSpec: spec.icon)
          : StyleSpecBuilder(
              styleSpec: spec.icon,
              builder: (context, iconSpec) =>
                  leadingIconBuilder!(context, iconSpec, leadingIcon),
            );
    }

    if (trailingIcon != null || trailingIconBuilder != null) {
      trailingIconWidget = trailingIconBuilder == null
          ? StyledIcon(icon: trailingIcon, styleSpec: spec.icon)
          : StyleSpecBuilder(
              styleSpec: spec.icon,
              builder: (context, iconSpec) =>
                  trailingIconBuilder!(context, iconSpec, trailingIcon),
            );
    }

    // Build text widget
    final textWidget = textBuilder == null
        ? StyledText(label, styleSpec: spec.label)
        : StyleSpecBuilder(
            styleSpec: spec.label,
            builder: (context, textSpec) =>
                textBuilder!(context, textSpec, label),
          );

    // Build spinner (used when loading)
    final spinner = loadingBuilder == null
        ? StyleSpecBuilder(
            styleSpec: spec.spinner,
            builder: (context, spinnerSpec) =>
                RemixSpinner(styleSpec: spinnerSpec),
          )
        : StyleSpecBuilder(styleSpec: spec.spinner, builder: loadingBuilder!);

    final hasBothIcons =
        leadingIconWidget != null && trailingIconWidget != null;
    final explicitAlignment = spec.iconAlignment;
    final children = hasBothIcons || explicitAlignment == null
        ? <Widget>[?leadingIconWidget, textWidget, ?trailingIconWidget]
        : switch (explicitAlignment) {
            .start => <Widget>[
              ?leadingIconWidget,
              ?trailingIconWidget,
              textWidget,
            ],
            .end => <Widget>[
              textWidget,
              ?leadingIconWidget,
              ?trailingIconWidget,
            ],
          };
    final rowChildren = children
        .map(
          (e) => Visibility(
            visible: !loading,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: e,
          ),
        )
        .toList();

    // Create content row with visibility control for loading state
    final contentRow = RemixFlexBoxWithEffects(
      styleSpec: spec.container,
      direction: Axis.horizontal,
      containerEffects: spec.containerEffects,
      children: rowChildren,
    );

    // Layer spinner above the content while keeping size stable.
    final layered = Stack(
      alignment: .center,
      children: [contentRow, if (loading) spinner],
    );

    return MergeSemantics(
      child: Semantics(
        excludeSemantics: excludeSemantics,
        liveRegion: loading,
        label: semanticLabel ?? label,
        hint: semanticHint,
        child: layered,
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
      semanticLabel: semanticLabel ?? label,
      builder: (context, _, _) {
        return RemixStyleSpecBuilder<RemixButtonSpec>(
          style: _buildStyle(),
          styleSpec: styleSpec,
          controller: NakedButtonState.controllerOf(context),
          builder: _buildContent,
        );
      },
    );
  }
}
