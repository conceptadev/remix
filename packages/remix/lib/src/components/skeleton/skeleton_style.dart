part of 'skeleton.dart';

/// Style configuration for a [RemixSkeleton] placeholder.
extension RemixSkeletonStylerRemixHelpers on SkeletonStyler {
  /// Creates a [RemixSkeleton] widget with this style applied.
  RemixSkeleton call({Key? key, Widget? child, bool loading = true}) {
    return RemixSkeleton(key: key, loading: loading, style: this, child: child);
  }
}
