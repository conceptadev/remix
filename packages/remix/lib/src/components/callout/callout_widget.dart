part of 'callout.dart';

/// A message row with optional text, icon, or custom content.
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
    this.style = const CalloutStyler.create(),
    this.styleSpec,
  }) : text = text,
       child = child,
       assert(
         text != null || child != null,
         'Provide either text or child to RemixCallout.',
       );

  static final styleFrom = CalloutStyler.new;

  /// The text to display in the callout.
  final String? text;

  /// The icon to display in the callout.
  final IconData? icon;

  /// Optional custom child content for the callout body.
  final Widget? child;

  /// The style configuration for the callout.
  final CalloutStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final CalloutSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<CalloutSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        if (child != null) {
          return RemixFlexBoxAdapter(
            styleSpec: spec.container,
            direction: Axis.horizontal,
            containerEffects: spec.containerEffects,
            children: [
              // RowBox resolves to a Flex. A loose fit gives custom content a
              // bounded maximum width without forcing it to fill the callout.
              Flexible(child: child!),
            ],
          );
        }

        final List<Widget> children = [];

        if (icon != null || spec.icon.spec.icon != null) {
          children.add(StyledIcon(icon: icon, styleSpec: spec.icon));
        }

        if (text?.isNotEmpty == true) {
          children.add(
            // RowBox resolves to a Flex. A loose fit lets text wrap while
            // preserving its intrinsic width for short messages.
            Flexible(child: StyledText(text!, styleSpec: spec.text)),
          );
        }

        return RemixFlexBoxAdapter(
          styleSpec: spec.container,
          direction: Axis.horizontal,
          containerEffects: spec.containerEffects,
          children: children,
        );
      },
    );
  }
}
