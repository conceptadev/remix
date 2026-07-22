part of 'badge.dart';

/// A badge widget that displays compact text or custom content.
///
/// Badges are used to display small amounts of information, such as
/// notification counts, status indicators, or labels.
///
/// ## Example
///
/// ```dart
/// RemixBadge(child: Text('New'))
/// ```
class RemixBadge extends StatelessWidget {
  /// Creates a badge whose arbitrary [child] inherits the resolved badge text
  /// and icon themes.
  const RemixBadge({
    super.key,
    required this.child,
    this.style = const RemixBadgeStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = RemixBadgeStyler.new;

  final Widget child;

  /// The style configuration for the badge.
  final RemixBadgeStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixBadgeSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<RemixBadgeSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        final foreground = spec.label.spec.style?.color;
        final content = remixInheritedContentStyle(
          child: child,
          text: spec.label,
          icon: StyleSpec(spec: IconSpec(color: foreground)),
        );
        return remixSurfaceBox(
          styleSpec: spec.container,
          effects: spec.effects,
          child: content,
        );
      },
    );
  }
}
