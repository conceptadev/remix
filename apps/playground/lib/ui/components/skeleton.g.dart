// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skeleton.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Skeleton recipe.
///
/// A skeleton is a placeholder that keeps a layout the right shape while its
/// content loads. Remix owns the pulse animation, the semantics, and the rule
/// that a wrapped child keeps sizing the placeholder in both states; this
/// recipe supplies only the two colors and the tempo.
///
/// It takes no size. A skeleton is measured by the content it stands in for —
/// either the child it wraps, or explicit constraints on the caller's own
/// [style]:
///
/// ```dart
/// PlaygroundSkeleton(
///   style: SkeletonStyler().container(BoxStyler().size(160, 20)),
/// )
/// ```
///
/// The pulse runs between `muted` and `accent`, the theme's two neutral
/// surfaces, so a loading block reads as scenery rather than as content. Both
/// tokens shift with light and dark, and a theme that wants a stronger pulse
/// only widens the gap between them.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
class PlaygroundSkeleton extends StatelessWidget {
  const PlaygroundSkeleton({
    super.key,
    this.style = const SkeletonStyler.create(),
    this.child,
    this.loading = true,
  });

  final SkeletonStyler style;

  final Widget? child;

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return RemixSkeleton(
      key: this.key,
      style: playgroundSkeletonStyle(style: this.style),
      child: this.child,
      loading: this.loading,
    );
  }
}
