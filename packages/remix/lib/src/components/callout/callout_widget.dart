part of 'callout.dart';

/// The [RemixCallout] widget is used to display a message.
/// It can be customized using the [style] parameter to fit different design needs.
///
/// ## Example
///
/// ```dart
/// RemixCallout(child: Text('This is a callout message!'))
/// ```
class RemixCallout extends StatelessWidget {
  /// Creates a callout whose arbitrary [child] and optional [icon] inherit the
  /// resolved content themes.
  const RemixCallout({
    super.key,
    required this.child,
    this.icon,
    this.style = const RemixCalloutStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = RemixCalloutStyler.new;

  final Widget child;

  final Widget? icon;

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
        return remixSurfaceFlexBox(
          key: const ValueKey('remix-callout-surface'),
          styleSpec: spec.container,
          direction: Axis.horizontal,
          effects: spec.effects,
          children: [
            if (icon case final icon?)
              remixInheritedContentStyle(child: icon, icon: spec.icon),
            // ignore: avoid-flexible-outside-flex
            Flexible(
              fit: FlexFit.loose,
              child: remixInheritedContentStyle(
                child: child,
                text: spec.text,
                icon: spec.icon,
              ),
            ),
          ],
        );
      },
    );
  }
}
