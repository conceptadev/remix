// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skeleton.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal recipe for [RemixSkeleton].
///
/// The pulse starts and rests on `grayA3` before moving toward `grayA4`;
/// Radix's CSS `alternate-reverse` phase starts from `grayA4`.
class FortalSkeleton extends StatelessWidget {
  const FortalSkeleton({super.key, this.child, this.loading = true});

  final Widget? child;

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return RemixSkeleton(
      key: this.key,
      style: fortalSkeletonStyle(),
      child: this.child,
      loading: this.loading,
    );
  }
}
