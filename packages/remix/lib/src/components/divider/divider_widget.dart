part of 'divider.dart';

/// A divider is a thin line that groups content in lists and layouts.
///
/// Dividers help to organize content by visually separating it into groups.
///
/// This example shows how to use a [RemixDivider] in a list of items.
///
/// ```dart
/// Column(
///   children: const <Widget>[
///     Text('Item 1'),
///     RemixDivider(),
///     Text('Item 2'),
///     RemixDivider(),
///     Text('Item 3'),
///   ],
/// )
/// ```
class RemixDivider extends StatelessWidget {
  /// Creates a Remix divider.
  const RemixDivider({
    super.key,
    this.orientation = Axis.horizontal,
    this.decorative = true,
    this.semanticLabel,
    this.style = const RemixDividerStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = RemixDividerStyler.new;

  /// Direction of the separator line.
  final Axis orientation;

  /// Whether assistive technologies should ignore this divider.
  final bool decorative;

  /// Accessible name used when [decorative] is false.
  ///
  /// Flutter has no separator semantics role, so `separator` is used when no
  /// explicit label is provided.
  final String? semanticLabel;

  /// The style configuration for the divider.
  final RemixDividerStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixDividerSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<RemixDividerSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        Widget divider = Box(styleSpec: spec.container);
        if (spec.thickness case final thickness?) {
          divider = SizedBox(
            width: orientation == Axis.vertical ? thickness : null,
            height: orientation == Axis.horizontal ? thickness : null,
            child: divider,
          );
        }
        if (decorative) return ExcludeSemantics(child: divider);
        return Semantics(
          container: true,
          label: semanticLabel ?? 'separator',
          child: divider,
        );
      },
    );
  }
}
