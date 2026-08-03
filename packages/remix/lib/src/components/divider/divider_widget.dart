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
    this.style = const DividerStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = DividerStyler.new;

  /// The style configuration for the divider.
  final DividerStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final DividerSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<DividerSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        return Box(styleSpec: spec.container);
      },
    );
  }
}
