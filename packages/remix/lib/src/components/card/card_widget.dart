part of 'card.dart';

/// A Material Design card component.
///
/// A card is a sheet of Material used to represent some related information,
/// for example an album, a geographical location, a meal, contact details, etc.
///
/// This is a Remix version of the standard Material Card widget, with customizable styling.
///
/// ## Example
///
/// ```dart
/// RemixCard(
///   child: Padding(
///     padding: const EdgeInsets.all(16.0),
///     child: Text('This is a card'),
///   ),
/// )
/// ```
class RemixCard extends StatelessWidget {
  /// Creates a Material Design card.
  const RemixCard({
    super.key,
    this.child,
    this.style = const RemixCardStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = RemixCardStyler.new;

  /// The widget below this widget in the tree.
  ///
  /// This widget can only have one child. To lay out multiple children, let this widget's child be a widget such as [RowBox], [ColumnBox], or [StackBox], which have a children property, and then provide the children to that widget.
  final Widget? child;

  /// The style configuration for the card.
  final RemixCardStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixCardSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<RemixCardSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        return RemixBoxWithEffects(
          styleSpec: spec.container,
          containerEffects: spec.containerEffects,
          child: child,
        );
      },
    );
  }
}
