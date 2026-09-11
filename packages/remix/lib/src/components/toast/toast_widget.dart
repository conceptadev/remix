part of 'toast.dart';

/// A stateless notification surface: an optional icon, a title, an optional
/// description, an optional action, and an optional close button.
///
/// [RemixToastScope] builds one for every visible toast and owns its
/// lifetime. Build it directly for custom presenters or static previews.
///
/// ## Example
///
/// ```dart
/// RemixToast(
///   title: 'Draft saved',
///   action: RemixToastAction(label: 'Undo', onPressed: undo),
///   onDismiss: dismiss,
///   dismissLabel: 'Dismiss notification',
/// )
/// ```
class RemixToast extends StatelessWidget {
  const RemixToast({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.action,
    this.onDismiss,
    this.dismissLabel,
    this.excludeMessageSemantics = false,
    this.style = const ToastStyler.create(),
    this.styleSpec,
  }) : assert(
         onDismiss == null || dismissLabel != null,
         'A RemixToast with onDismiss needs a localized dismissLabel.',
       );

  static final styleFrom = ToastStyler.new;

  /// Composes widget-owned layout defaults with an incoming Toast style.
  static ToastStyler composeStyle(ToastStyler style) => ToastStyler()
      .container(
        FlexBoxStyler()
            .mainAxisSize(MainAxisSize.min)
            .crossAxisAlignment(CrossAxisAlignment.center),
      )
      .content(
        FlexBoxStyler()
            .mainAxisSize(MainAxisSize.min)
            .crossAxisAlignment(CrossAxisAlignment.start),
      )
      .merge(style);

  final String title;

  final String? description;

  /// A decorative leading icon; always excluded from semantics.
  final IconData? icon;

  final RemixToastAction? action;

  /// Called by the close button. The button is shown only when non-null.
  final VoidCallback? onDismiss;

  /// The close button's localized accessible name. Required with [onDismiss].
  final String? dismissLabel;

  /// Whether to hide [title] and [description] from semantics.
  ///
  /// [RemixToastScope] sets this because its status or alert node already
  /// announces the message; leave it false for standalone toasts.
  final bool excludeMessageSemantics;

  final ToastStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final ToastSpec? styleSpec;

  static Widget _inheritStyle<S extends Spec<S>>(
    Style<S>? style,
    Widget child,
  ) {
    return style == null ? child : StyleProvider<S>(style: style, child: child);
  }

  Widget _buildContent(BuildContext context, ToastSpec spec) {
    Widget message = ColumnBox(
      styleSpec: spec.content,
      children: [
        StyledText(title, styleSpec: spec.title),
        if (description case final description?)
          StyledText(description, styleSpec: spec.description),
      ],
    );
    if (excludeMessageSemantics) message = ExcludeSemantics(child: message);

    final action = this.action;
    final onDismiss = this.onDismiss;

    return RemixFlexBoxAdapter(
      styleSpec: spec.container,
      direction: Axis.horizontal,
      containerEffects: spec.containerEffects,
      children: [
        if (icon != null || spec.icon.spec.icon != null)
          ExcludeSemantics(
            child: StyledIcon(icon: icon, styleSpec: spec.icon),
          ),
        // A loose fit lets long messages wrap while short ones keep their
        // intrinsic width.
        Flexible(child: message),
        if (action != null)
          _inheritStyle<ButtonSpec>(
            spec.action,
            RemixButton(label: action.label, onPressed: action.onPressed),
          ),
        if (onDismiss != null)
          _inheritStyle<IconButtonSpec>(
            spec.closeButton,
            RemixIconButton(
              icon: null,
              iconBuilder: (context, iconSpec, _) => RemixPathIcon(
                glyph: RemixPathGlyph.cross,
                styleSpec: StyleSpec(spec: iconSpec),
              ),
              semanticLabel: dismissLabel!,
              onPressed: onDismiss,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<ToastSpec>(
      style: composeStyle(style),
      styleSpec: styleSpec,
      builder: _buildContent,
    );
  }
}
