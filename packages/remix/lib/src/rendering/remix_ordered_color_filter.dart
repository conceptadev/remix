import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

/// CSS color-filter functions used by the pinned Radix recipes.
enum RemixCssColorFilterFunction { brightness, contrast, saturate }

/// One ordered CSS color-filter function.
///
/// CSS filter functions operate on non-premultiplied sRGB values. The matrices
/// here are the Filter Effects Level 1 equivalents, expressed in Flutter's
/// 0-255 translation convention.
@immutable
final class RemixCssColorFilterOperation with Equatable {
  const RemixCssColorFilterOperation.brightness(this.amount)
    : function = .brightness,
      assert(amount >= 0);

  const RemixCssColorFilterOperation.contrast(this.amount)
    : function = .contrast,
      assert(amount >= 0);

  const RemixCssColorFilterOperation.saturate(this.amount)
    : function = .saturate,
      assert(amount >= 0);

  final RemixCssColorFilterFunction function;
  final double amount;

  /// Identity value used when interpolating a missing CSS filter function.
  RemixCssColorFilterOperation get identity => switch (function) {
    .brightness => const RemixCssColorFilterOperation.brightness(1),
    .contrast => const RemixCssColorFilterOperation.contrast(1),
    .saturate => const RemixCssColorFilterOperation.saturate(1),
  };

  bool get isIdentity => amount == 1;

  List<double> get matrix => switch (function) {
    .brightness => <double>[
      amount,
      0,
      0,
      0,
      0,
      0,
      amount,
      0,
      0,
      0,
      0,
      0,
      amount,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ],
    .contrast => <double>[
      amount,
      0,
      0,
      0,
      127.5 * (1 - amount),
      0,
      amount,
      0,
      0,
      127.5 * (1 - amount),
      0,
      0,
      amount,
      0,
      127.5 * (1 - amount),
      0,
      0,
      0,
      1,
      0,
    ],
    .saturate => <double>[
      0.213 + 0.787 * amount,
      0.715 - 0.715 * amount,
      0.072 - 0.072 * amount,
      0,
      0,
      0.213 - 0.213 * amount,
      0.715 + 0.285 * amount,
      0.072 - 0.072 * amount,
      0,
      0,
      0.213 - 0.213 * amount,
      0.715 - 0.715 * amount,
      0.072 + 0.928 * amount,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ],
  };

  RemixCssColorFilterOperation lerp(
    RemixCssColorFilterOperation other,
    double t,
  ) {
    assert(function == other.function);
    final value = ui.lerpDouble(amount, other.amount, t)!;
    return switch (function) {
      .brightness => RemixCssColorFilterOperation.brightness(value),
      .contrast => RemixCssColorFilterOperation.contrast(value),
      .saturate => RemixCssColorFilterOperation.saturate(value),
    };
  }

  @override
  List<Object?> get props => [function, amount];
}

/// Applies a CSS-compatible sequence to the complete painted child subtree.
///
/// Each function gets its own [ColorFiltered] boundary. This preserves CSS
/// function ordering and intermediate clamping instead of collapsing the
/// sequence into one matrix.
final class RemixOrderedColorFilterModifier
    extends WidgetModifier<RemixOrderedColorFilterModifier> {
  const RemixOrderedColorFilterModifier(this.operations);

  final List<RemixCssColorFilterOperation> operations;

  @override
  RemixOrderedColorFilterModifier copyWith({
    List<RemixCssColorFilterOperation>? operations,
  }) => RemixOrderedColorFilterModifier(operations ?? this.operations);

  @override
  RemixOrderedColorFilterModifier lerp(
    RemixOrderedColorFilterModifier? other,
    double t,
  ) {
    final target = other ?? const RemixOrderedColorFilterModifier([]);
    if (!_areCompatible(operations, target.operations)) {
      return t < 0.5 ? this : target;
    }

    final length = operations.length > target.operations.length
        ? operations.length
        : target.operations.length;
    final result = <RemixCssColorFilterOperation>[];
    for (var index = 0; index < length; index++) {
      final start = index < operations.length ? operations[index] : null;
      final end = index < target.operations.length
          ? target.operations[index]
          : null;
      final function = start ?? end!;
      result.add(
        (start ?? function.identity).lerp(end ?? function.identity, t),
      );
    }
    return RemixOrderedColorFilterModifier(result);
  }

  @override
  Widget build(Widget child) {
    var current = child;
    for (final operation in operations) {
      if (operation.isIdentity) continue;
      current = ColorFiltered(
        colorFilter: ColorFilter.matrix(operation.matrix),
        child: current,
      );
    }
    return current;
  }

  @override
  List<Object?> get props => [operations];
}

/// Mix representation for [RemixOrderedColorFilterModifier].
final class RemixOrderedColorFilterModifierMix
    extends ModifierMix<RemixOrderedColorFilterModifier> {
  const RemixOrderedColorFilterModifierMix(this.operations);

  final List<RemixCssColorFilterOperation> operations;

  @override
  RemixOrderedColorFilterModifier resolve(BuildContext context) =>
      RemixOrderedColorFilterModifier(operations);

  @override
  RemixOrderedColorFilterModifierMix merge(
    RemixOrderedColorFilterModifierMix? other,
  ) => other ?? this;

  @override
  List<Object?> get props => [operations];
}

bool _areCompatible(
  List<RemixCssColorFilterOperation> first,
  List<RemixCssColorFilterOperation> second,
) {
  if (first.isEmpty || second.isEmpty) return true;
  final commonLength = first.length < second.length
      ? first.length
      : second.length;
  for (var index = 0; index < commonLength; index++) {
    if (first[index].function != second[index].function) return false;
  }
  return true;
}
