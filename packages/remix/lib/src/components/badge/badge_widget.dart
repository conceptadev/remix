part of 'badge.dart';

/// Builds badge label content with its resolved text style.
typedef RemixBadgeLabelBuilder =
    Widget Function(BuildContext context, TextSpec spec, String label);

/// A badge widget that displays compact text or custom content.
///
/// Badges are used to display small amounts of information, such as
/// notification counts, status indicators, or labels.
///
/// ## Example
///
/// ```dart
/// RemixBadge(label: 'New')
/// ```
class RemixBadge extends StatelessWidget {
  /// Creates a text badge with [label] or an arbitrary-content badge with
  /// [child]. Arbitrary content inherits the resolved text and icon themes.
  const RemixBadge({
    super.key,
    this.label,
    this.child,
    this.labelBuilder,
    this.style = const RemixBadgeStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = RemixBadgeStyler.new;

  final String? label;
  final Widget? child;
  final RemixBadgeLabelBuilder? labelBuilder;

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
        final resolvedLabel = label ?? '';
        final content = child == null
            ? labelBuilder == null
                  ? StyledText(resolvedLabel, styleSpec: spec.label)
                  : StyleSpecBuilder<TextSpec>(
                      styleSpec: spec.label,
                      builder: (context, textSpec) =>
                          labelBuilder!(context, textSpec, resolvedLabel),
                    )
            : RemixDefaultContentStyle(
                text: spec.label,
                icon: StyleSpec(spec: IconSpec(color: foreground)),
                child: child!,
              );
        return RemixBoxWithEffects(
          styleSpec: spec.container,
          containerEffects: spec.containerEffects,
          child: content,
        );
      },
    );
  }
}
