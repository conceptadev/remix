part of 'callout.dart';

/// The [RemixCallout] widget is used to display a message.
/// It can be customized using the [style] parameter to fit different design needs.
///
/// ## Example
///
/// ```dart
/// RemixCallout(
///   text: 'This is a callout message!',
/// )
/// ```
class RemixCallout extends StatelessWidget {
  /// Creates a callout widget with optional text, icon, or custom [child]. At
  /// least one of [text] or [child] must be provided.
  const RemixCallout({
    super.key,
    String? text,
    this.icon,
    Widget? child,
    this.style = const RemixCalloutStyler.create(),
    this.styleSpec,
  }) : text = text,
       child = child,
       assert(
         text != null || child != null,
         'Provide either text or child to RemixCallout.',
       );

  static final styleFrom = RemixCalloutStyler.new;

  /// The text to display in the callout.
  final String? text;

  /// The icon to display in the callout.
  final IconData? icon;

  /// Optional custom child content for the callout body.
  final Widget? child;

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
        // For raw constructor, use provided child directly
        if (child != null) {
          return RemixFlexBoxWithEffects(
            styleSpec: spec.container,
            direction: Axis.horizontal,
            containerEffects: spec.containerEffects,
            children: [
              // RowBox resolves to a Flex. A loose fit gives custom content a
              // bounded maximum width without forcing it to fill the callout.
              // ignore: avoid-flexible-outside-flex
              Flexible(child: child!),
            ],
          );
        }

        // Build the callout content with text and optional icon
        final List<Widget> children = [];

        // Add icon if present
        if (icon != null || spec.icon.spec.icon != null) {
          children.add(StyledIcon(icon: icon, styleSpec: spec.icon));
        }

        // Add text if present
        if (text?.isNotEmpty == true) {
          children.add(
            // RowBox resolves to a Flex. A loose fit lets text wrap while
            // preserving its intrinsic width for short messages.
            // ignore: avoid-flexible-outside-flex
            Flexible(child: StyledText(text!, styleSpec: spec.text)),
          );
        }

        return RemixFlexBoxWithEffects(
          styleSpec: spec.container,
          direction: Axis.horizontal,
          containerEffects: spec.containerEffects,
          children: children,
        );
      },
    );
  }
}
