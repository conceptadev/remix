part of 'callout.dart';

/// The [RemixCallout] widget is used to display a message.
/// It can be customized using the [style] parameter to fit different design needs.
///
/// ## Example
///
/// ```dart
/// RemixCallout(text: 'This is a callout message!')
/// ```
class RemixCallout extends StatelessWidget {
  /// Creates a callout with established [text] and [icon] values or arbitrary
  /// [child] and [iconWidget] content.
  const RemixCallout({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.iconWidget,
    this.style = const RemixCalloutStyler.create(),
    this.styleSpec,
  }) : assert(
         text != null || child != null,
         'Provide either text or child to RemixCallout.',
       );

  static final styleFrom = RemixCalloutStyler.new;

  final String? text;
  final Widget? child;
  final IconData? icon;
  final Widget? iconWidget;

  /// The style configuration for the callout.
  final RemixCalloutStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixCalloutSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<RemixCalloutSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        final resolvedIcon = iconWidget != null
            ? RemixDefaultContentStyle(child: iconWidget!, icon: spec.icon)
            : icon != null || spec.icon.spec.icon != null
            ? StyledIcon(icon: icon, styleSpec: spec.icon)
            : null;
        final content = child != null
            ? RemixDefaultContentStyle(
                text: spec.text,
                icon: spec.icon,
                child: child!,
              )
            : StyledText(text!, styleSpec: spec.text);
        return RemixFlexBoxWithEffects(
          key: const ValueKey('remix-callout-surface'),
          styleSpec: spec.container,
          direction: Axis.horizontal,
          containerEffects: spec.containerEffects,
          children: [
            if (resolvedIcon != null) resolvedIcon,
            // ignore: avoid-flexible-outside-flex
            Flexible(fit: FlexFit.loose, child: content),
          ],
        );
      },
    );
  }
}
