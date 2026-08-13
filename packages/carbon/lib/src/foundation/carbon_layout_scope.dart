import 'package:flutter/widgets.dart';

import '../tokens/generated/carbon_layout.g.dart';
import '../tokens/carbon_token_types.dart';

/// Carbon contextual sizes (`xs`–`2xl`).
///
/// Each component declares the subset it supports plus a default, and clamps an
/// inherited size into that range — mirroring Carbon's `layout.use()` behavior.
enum CarbonSize {
  xs,
  sm,
  md,
  lg,
  xl,
  x2l;

  /// Default control height in logical pixels (from `@carbon/layout` sizes).
  double get height => carbonControlSizePx[_key]!;

  String get _key => switch (this) {
    .xs => 'xSmall',
    .sm => 'small',
    .md => 'medium',
    .lg => 'large',
    .xl => 'xLarge',
    .x2l => 'xxLarge',
  };

  /// Clamps this size into the inclusive `[min, max]` range.
  CarbonSize clampTo(CarbonSize min, CarbonSize max) {
    return switch (index.clamp(min.index, max.index).toInt()) {
      0 => .xs,
      1 => .sm,
      2 => .md,
      3 => .lg,
      4 => .xl,
      _ => .x2l,
    };
  }
}

/// Provides a contextual [CarbonSize] to a subtree.
///
/// ```dart
/// CarbonLayoutScope(
///   size: CarbonSize.sm,
///   child: content,
/// )
/// ```
class CarbonLayoutScope extends StatelessWidget {
  const CarbonLayoutScope({super.key, this.size, required this.child});

  /// Overrides the inherited size; inherits (or defaults to `md`) when null.
  final CarbonSize? size;

  final Widget child;

  /// The nearest contextual size, or null when there is no enclosing scope.
  ///
  /// Components with their own Carbon default size (e.g. Button's `lg`) use
  /// this to distinguish "no scope" from "scope chose the default".
  static CarbonSize? maybeSizeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_CarbonLayoutInherited>()
      ?.size;

  /// The nearest contextual size, defaulting to `md`.
  static CarbonSize sizeOf(BuildContext context) => maybeSizeOf(context) ?? .md;

  @override
  Widget build(BuildContext context) {
    return _CarbonLayoutInherited(
      size: size ?? CarbonLayoutScope.sizeOf(context),
      child: child,
    );
  }
}

/// The active Carbon breakpoint for a viewport [width] (logical pixels).
///
/// Returns the largest breakpoint whose minimum width has been reached.
CarbonBreakpointData carbonBreakpointFor(double width) {
  CarbonBreakpointData? active;
  for (final bp in carbonBreakpoints) {
    active ??= bp;
    if (width >= bp.width) active = bp;
  }

  return active ??
      (throw StateError('The generated Carbon breakpoint list is empty.'));
}

class _CarbonLayoutInherited extends InheritedWidget {
  const _CarbonLayoutInherited({required this.size, required super.child});

  final CarbonSize size;

  @override
  bool updateShouldNotify(_CarbonLayoutInherited oldWidget) =>
      oldWidget.size != size;
}
