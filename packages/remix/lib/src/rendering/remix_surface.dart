import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mix/mix.dart';

import 'remix_blend_mode.dart';

/// Whether a painted shadow falls outside a surface or into its interior.
enum RemixPaintShadowKind { outer, inset }

/// A CSS-shaped box-shadow layer that can represent real inset shadows.
@immutable
class RemixPaintShadow {
  const RemixPaintShadow({
    this.kind = RemixPaintShadowKind.outer,
    this.color = const Color(0xFF000000),
    this.offset = Offset.zero,
    this.blurRadius = 0,
    this.spreadRadius = 0,
    this.shapeInset = 0,
  }) : assert(blurRadius >= 0),
       assert(shapeInset >= 0);

  final RemixPaintShadowKind kind;
  final Color color;
  final Offset offset;
  final double blurRadius;
  final double spreadRadius;
  final double shapeInset;

  RemixPaintShadow scale(double factor) => RemixPaintShadow(
    kind: kind,
    color: color.withValues(alpha: color.a * factor),
    offset: offset * factor,
    blurRadius: math.max(0, blurRadius * factor),
    spreadRadius: spreadRadius * factor,
    shapeInset: math.max(0, shapeInset * factor),
  );

  static RemixPaintShadow? lerp(
    RemixPaintShadow? a,
    RemixPaintShadow? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    if (a == null) return b!.scale(t);
    if (b == null) return a.scale(1 - t);

    return RemixPaintShadow(
      kind: t < 0.5 ? a.kind : b.kind,
      color: Color.lerp(a.color, b.color, t)!,
      offset: Offset.lerp(a.offset, b.offset, t)!,
      blurRadius: math.max(0, ui.lerpDouble(a.blurRadius, b.blurRadius, t)!),
      spreadRadius: ui.lerpDouble(a.spreadRadius, b.spreadRadius, t)!,
      shapeInset: math.max(0, ui.lerpDouble(a.shapeInset, b.shapeInset, t)!),
    );
  }

  static List<RemixPaintShadow> lerpList(
    List<RemixPaintShadow> a,
    List<RemixPaintShadow> b,
    double t,
  ) {
    final commonLength = math.min(a.length, b.length);
    return [
      for (var index = 0; index < commonLength; index++)
        lerp(a[index], b[index], t)!,
      for (var index = commonLength; index < a.length; index++)
        lerp(a[index], null, t)!,
      for (var index = commonLength; index < b.length; index++)
        lerp(null, b[index], t)!,
    ];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemixPaintShadow &&
          kind == other.kind &&
          color == other.color &&
          offset == other.offset &&
          blurRadius == other.blurRadius &&
          spreadRadius == other.spreadRadius &&
          shapeInset == other.shapeInset;

  @override
  int get hashCode =>
      Object.hash(kind, color, offset, blurRadius, spreadRadius, shapeInset);

  @override
  String toString() =>
      'RemixPaintShadow($kind, $color, $offset, $blurRadius, $spreadRadius, '
      '$shapeInset)';
}

/// Mix representation of [RemixPaintShadow] with token-aware fields.
@immutable
class RemixPaintShadowMix extends Mix<RemixPaintShadow> {
  RemixPaintShadowMix({
    RemixPaintShadowKind? kind,
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
    double? shapeInset,
  }) : this.create(
         kind: Prop.maybe(kind),
         color: Prop.maybe(color),
         offset: Prop.maybe(offset),
         blurRadius: Prop.maybe(blurRadius),
         spreadRadius: Prop.maybe(spreadRadius),
         shapeInset: Prop.maybe(shapeInset),
       );

  const RemixPaintShadowMix.create({
    Prop<RemixPaintShadowKind>? kind,
    Prop<Color>? color,
    Prop<Offset>? offset,
    Prop<double>? blurRadius,
    Prop<double>? spreadRadius,
    Prop<double>? shapeInset,
  }) : $kind = kind,
       $color = color,
       $offset = offset,
       $blurRadius = blurRadius,
       $spreadRadius = spreadRadius,
       $shapeInset = shapeInset;

  RemixPaintShadowMix.value(RemixPaintShadow value)
    : this(
        kind: value.kind,
        color: value.color,
        offset: value.offset,
        blurRadius: value.blurRadius,
        spreadRadius: value.spreadRadius,
        shapeInset: value.shapeInset,
      );

  final Prop<RemixPaintShadowKind>? $kind;
  final Prop<Color>? $color;
  final Prop<Offset>? $offset;
  final Prop<double>? $blurRadius;
  final Prop<double>? $spreadRadius;
  final Prop<double>? $shapeInset;

  @override
  RemixPaintShadowMix merge(RemixPaintShadowMix? other) {
    if (other == null) return this;
    return RemixPaintShadowMix.create(
      kind: MixOps.merge($kind, other.$kind),
      color: MixOps.merge($color, other.$color),
      offset: MixOps.merge($offset, other.$offset),
      blurRadius: MixOps.merge($blurRadius, other.$blurRadius),
      spreadRadius: MixOps.merge($spreadRadius, other.$spreadRadius),
      shapeInset: MixOps.merge($shapeInset, other.$shapeInset),
    );
  }

  @override
  RemixPaintShadow resolve(BuildContext context) => RemixPaintShadow(
    kind: MixOps.resolve(context, $kind) ?? RemixPaintShadowKind.outer,
    color: MixOps.resolve(context, $color) ?? const Color(0xFF000000),
    offset: MixOps.resolve(context, $offset) ?? Offset.zero,
    blurRadius: MixOps.resolve(context, $blurRadius) ?? 0,
    spreadRadius: MixOps.resolve(context, $spreadRadius) ?? 0,
    shapeInset: MixOps.resolve(context, $shapeInset) ?? 0,
  );

  @override
  List<Object?> get props => [
    $kind,
    $color,
    $offset,
    $blurRadius,
    $spreadRadius,
    $shapeInset,
  ];
}

/// A theme token containing an ordered list of inset-capable shadows.
class RemixPaintShadowListToken extends MixToken<List<RemixPaintShadow>> {
  const RemixPaintShadowListToken(super.name);
}

/// Token-aware Mix representation of a CSS linear gradient.
///
/// Unlike Flutter's `LinearGradientMix`, each color and stop is resolved as an
/// individual Mix property. This allows multiple design-token references in a
/// single gradient.
@immutable
class RemixLinearGradientMix extends Mix<LinearGradient> {
  RemixLinearGradientMix({
    List<Color>? colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
    GradientTransform? transform,
  }) : this.create(
         colors: colors
             ?.map((value) => Prop.value<Color>(value))
             .toList(growable: false),
         stops: stops
             ?.map((value) => Prop.value<double>(value))
             .toList(growable: false),
         begin: Prop.maybe(begin),
         end: Prop.maybe(end),
         tileMode: Prop.maybe(tileMode),
         transform: Prop.maybe(transform),
       );

  const RemixLinearGradientMix.create({
    List<Prop<Color>>? colors,
    List<Prop<double>>? stops,
    Prop<AlignmentGeometry>? begin,
    Prop<AlignmentGeometry>? end,
    Prop<TileMode>? tileMode,
    Prop<GradientTransform>? transform,
  }) : $colors = colors,
       $stops = stops,
       $begin = begin,
       $end = end,
       $tileMode = tileMode,
       $transform = transform;

  RemixLinearGradientMix.value(LinearGradient value)
    : this(
        colors: value.colors,
        stops: value.stops,
        begin: value.begin,
        end: value.end,
        tileMode: value.tileMode,
        transform: value.transform,
      );

  final List<Prop<Color>>? $colors;
  final List<Prop<double>>? $stops;
  final Prop<AlignmentGeometry>? $begin;
  final Prop<AlignmentGeometry>? $end;
  final Prop<TileMode>? $tileMode;
  final Prop<GradientTransform>? $transform;

  @override
  RemixLinearGradientMix merge(RemixLinearGradientMix? other) {
    if (other == null) return this;
    return RemixLinearGradientMix.create(
      colors: other.$colors ?? $colors,
      stops: other.$stops ?? $stops,
      begin: MixOps.merge($begin, other.$begin),
      end: MixOps.merge($end, other.$end),
      tileMode: MixOps.merge($tileMode, other.$tileMode),
      transform: MixOps.merge($transform, other.$transform),
    );
  }

  @override
  LinearGradient resolve(BuildContext context) {
    final colors = $colors
        ?.map((color) => MixOps.resolve(context, color)!)
        .toList(growable: false);
    if (colors == null || colors.length < 2) {
      throw FlutterError(
        'RemixLinearGradientMix requires at least two resolved colors.',
      );
    }
    final stops = $stops
        ?.map((stop) => MixOps.resolve(context, stop)!)
        .toList(growable: false);
    final normalized = _normalizeGradient(colors, stops);

    return LinearGradient(
      colors: normalized.colors,
      stops: normalized.stops,
      begin: MixOps.resolve(context, $begin) ?? Alignment.topCenter,
      end: MixOps.resolve(context, $end) ?? Alignment.bottomCenter,
      tileMode: MixOps.resolve(context, $tileMode) ?? TileMode.clamp,
      transform: MixOps.resolve(context, $transform),
    );
  }

  @override
  List<Object?> get props => [
    $colors,
    $stops,
    $begin,
    $end,
    $tileMode,
    $transform,
  ];
}

typedef _NormalizedGradient = ({List<Color> colors, List<double> stops});

_NormalizedGradient _normalizeGradient(
  List<Color> colors,
  List<double>? suppliedStops,
) {
  if (suppliedStops != null && suppliedStops.length != colors.length) {
    throw FlutterError(
      'Gradient stops (${suppliedStops.length}) must match colors '
      '(${colors.length}).',
    );
  }

  final stops = suppliedStops == null
      ? List<double>.generate(
          colors.length,
          (index) => index / (colors.length - 1),
          growable: false,
        )
      : List<double>.of(suppliedStops);
  if (stops.any((stop) => !stop.isFinite)) {
    throw FlutterError('Gradient stops must be finite numbers.');
  }
  for (var index = 1; index < stops.length; index++) {
    stops[index] = math.max(stops[index - 1], stops[index]);
  }

  Color sample(double position) {
    if (position <= stops.first) return colors.first;
    if (position >= stops.last) return colors.last;
    for (var index = 1; index < stops.length; index++) {
      if (position <= stops[index]) {
        final start = stops[index - 1];
        final end = stops[index];
        if (end == start) return colors[index];
        return Color.lerp(
          colors[index - 1],
          colors[index],
          (position - start) / (end - start),
        )!;
      }
    }
    return colors.last;
  }

  final normalizedColors = <Color>[sample(0)];
  final normalizedStops = <double>[0];
  for (var index = 0; index < stops.length; index++) {
    final stop = stops[index];
    if (stop > 0 && stop < 1) {
      normalizedStops.add(stop);
      normalizedColors.add(colors[index]);
    } else if (stop == 0 && index > 0) {
      normalizedStops.add(0);
      normalizedColors.add(colors[index]);
    } else if (stop == 1 && index < stops.length - 1) {
      normalizedStops.add(1);
      normalizedColors.add(colors[index]);
    }
  }
  normalizedStops.add(1);
  normalizedColors.add(sample(1));

  return (colors: normalizedColors, stops: normalizedStops);
}

/// Resolved ordered surface layers painted behind component content.
@immutable
class RemixSurfaceLayerSpec extends Spec<RemixSurfaceLayerSpec> {
  const RemixSurfaceLayerSpec({
    this.gradients = const [],
    this.gradientInsets = const [],
    this.shadows = const [],
  });

  /// CSS order: the first gradient is painted closest to the content.
  final List<Gradient> gradients;

  /// Optional clip inset for each corresponding [gradients] layer.
  ///
  /// This models CSS backgrounds clipped to a transparent inner border, such
  /// as Radix classic-button pseudo-elements. An empty list means no insets.
  final List<double> gradientInsets;

  /// CSS order: the first shadow is painted closest to the content.
  final List<RemixPaintShadow> shadows;

  /// Whether this layer contributes no paint.
  bool get isEmpty => gradients.isEmpty && shadows.isEmpty;

  /// Interpolates nullable surface slots through an empty visual layer.
  ///
  /// Component specs use nullable layers so variants can add or remove a
  /// surface. Treating absence as an empty layer lets those transitions fade
  /// instead of snapping while preserving `null` at the exact absent endpoint.
  static RemixSurfaceLayerSpec? lerpNullable(
    RemixSurfaceLayerSpec? begin,
    RemixSurfaceLayerSpec? end,
    double t,
  ) {
    if (begin == null && end == null) return null;
    if (begin == null) {
      if (t <= 0) return null;
      if (t >= 1) return end;
      return const RemixSurfaceLayerSpec().lerp(end, t);
    }
    if (end == null) {
      if (t <= 0) return begin;
      if (t >= 1) return null;
      return begin.lerp(const RemixSurfaceLayerSpec(), t);
    }
    return begin.lerp(end, t);
  }

  @override
  RemixSurfaceLayerSpec copyWith({
    List<Gradient>? gradients,
    List<double>? gradientInsets,
    List<RemixPaintShadow>? shadows,
  }) => RemixSurfaceLayerSpec(
    gradients: gradients ?? this.gradients,
    gradientInsets: gradientInsets ?? this.gradientInsets,
    shadows: shadows ?? this.shadows,
  );

  @override
  RemixSurfaceLayerSpec lerp(RemixSurfaceLayerSpec? other, double t) {
    if (other == null) return this;
    final interpolatedGradients = _lerpGradientList(
      gradients,
      other.gradients,
      t,
    );
    final currentInsets = gradientInsets.isEmpty
        ? List<double>.filled(gradients.length, 0)
        : gradientInsets;
    final otherInsets = other.gradientInsets.isEmpty
        ? List<double>.filled(other.gradients.length, 0)
        : other.gradientInsets;
    return RemixSurfaceLayerSpec(
      gradients: interpolatedGradients,
      gradientInsets: _lerpDoubleList(currentInsets, otherInsets, t),
      shadows: RemixPaintShadow.lerpList(shadows, other.shadows, t),
    );
  }

  @override
  List<Object?> get props => [gradients, gradientInsets, shadows];
}

List<double> _lerpDoubleList(List<double> a, List<double> b, double t) {
  final length = math.max(a.length, b.length);
  return [
    for (var index = 0; index < length; index++)
      math.max(
        0,
        ui.lerpDouble(
          index < a.length ? a[index] : 0,
          index < b.length ? b[index] : 0,
          t,
        )!,
      ),
  ];
}

List<Gradient> _lerpGradientList(List<Gradient> a, List<Gradient> b, double t) {
  final commonLength = math.min(a.length, b.length);
  return [
    for (var index = 0; index < commonLength; index++)
      Gradient.lerp(a[index], b[index], t)!,
    for (var index = commonLength; index < a.length; index++)
      Gradient.lerp(a[index], null, t)!,
    for (var index = commonLength; index < b.length; index++)
      Gradient.lerp(null, b[index], t)!,
  ];
}

@immutable
class _RemixGradientListMix extends Mix<List<Gradient>> {
  const _RemixGradientListMix(this.values);

  final List<RemixLinearGradientMix> values;

  @override
  _RemixGradientListMix merge(_RemixGradientListMix? other) => other ?? this;

  @override
  List<Gradient> resolve(BuildContext context) =>
      values.map((value) => value.resolve(context)).toList(growable: false);

  @override
  List<Object?> get props => [values];
}

@immutable
class _RemixDoubleListMix extends Mix<List<double>> {
  const _RemixDoubleListMix(this.values);

  final List<double> values;

  @override
  _RemixDoubleListMix merge(_RemixDoubleListMix? other) => other ?? this;

  @override
  List<double> resolve(BuildContext context) => values
      .map((value) => MixOps.resolve(context, Prop.value(value))!)
      .toList(growable: false);

  @override
  List<Object?> get props => [values];
}

@immutable
class _RemixShadowListMix extends Mix<List<RemixPaintShadow>> {
  const _RemixShadowListMix.values(this.values) : token = null;

  const _RemixShadowListMix.token(this.token) : values = null;

  final List<RemixPaintShadowMix>? values;
  final RemixPaintShadowListToken? token;

  @override
  _RemixShadowListMix merge(_RemixShadowListMix? other) => other ?? this;

  @override
  List<RemixPaintShadow> resolve(BuildContext context) {
    final token = this.token;
    if (token != null) return token.resolve(context);

    return values!
        .map((value) => value.resolve(context))
        .toList(growable: false);
  }

  @override
  List<Object?> get props => [values, token];
}

Prop<List<RemixPaintShadow>>? _shadowProp(
  List<RemixPaintShadowMix>? shadows,
  RemixPaintShadowListToken? token,
) {
  assert(
    shadows == null || token == null,
    'Provide either shadows or shadowToken, not both.',
  );
  if (token != null) return Prop.mix(_RemixShadowListMix.token(token));
  if (shadows != null) {
    return Prop.mix(_RemixShadowListMix.values(shadows));
  }
  return null;
}

/// Mix representation of [RemixSurfaceLayerSpec].
@immutable
class RemixSurfaceLayerMix extends Mix<RemixSurfaceLayerSpec> {
  RemixSurfaceLayerMix({
    List<RemixLinearGradientMix>? gradients,
    List<double>? gradientInsets,
    List<RemixPaintShadowMix>? shadows,
    RemixPaintShadowListToken? shadowToken,
  }) : this.create(
         gradients: gradients == null
             ? null
             : Prop.mix(_RemixGradientListMix(gradients)),
         gradientInsets: gradientInsets == null
             ? null
             : Prop.mix(_RemixDoubleListMix(gradientInsets)),
         shadows: _shadowProp(shadows, shadowToken),
       );

  const RemixSurfaceLayerMix.create({
    Prop<List<Gradient>>? gradients,
    Prop<List<double>>? gradientInsets,
    Prop<List<RemixPaintShadow>>? shadows,
  }) : $gradients = gradients,
       $gradientInsets = gradientInsets,
       $shadows = shadows;

  final Prop<List<Gradient>>? $gradients;
  final Prop<List<double>>? $gradientInsets;
  final Prop<List<RemixPaintShadow>>? $shadows;

  @override
  RemixSurfaceLayerMix merge(RemixSurfaceLayerMix? other) {
    if (other == null) return this;
    return RemixSurfaceLayerMix.create(
      gradients: MixOps.merge($gradients, other.$gradients),
      gradientInsets: MixOps.merge($gradientInsets, other.$gradientInsets),
      shadows: MixOps.merge($shadows, other.$shadows),
    );
  }

  @override
  RemixSurfaceLayerSpec resolve(BuildContext context) => RemixSurfaceLayerSpec(
    gradients: MixOps.resolve(context, $gradients) ?? const [],
    gradientInsets: MixOps.resolve(context, $gradientInsets) ?? const [],
    shadows: MixOps.resolve(context, $shadows) ?? const [],
  );

  @override
  List<Object?> get props => [$gradients, $gradientInsets, $shadows];
}

/// Advanced paint that augments, but does not replace, a Mix Box decoration.
@immutable
class RemixSurfaceEffectsSpec extends Spec<RemixSurfaceEffectsSpec> {
  const RemixSurfaceEffectsSpec({
    this.background,
    this.foreground,
    this.backdropBlur = 0,
    this.outline = BorderSide.none,
    this.outlineOffset = 0,
  }) : assert(backdropBlur >= 0),
       assert(
         outlineOffset >= -double.maxFinite &&
             outlineOffset <= double.maxFinite,
       );

  final RemixSurfaceLayerSpec? background;
  final RemixSurfaceLayerSpec? foreground;
  final double backdropBlur;
  final BorderSide outline;
  final double outlineOffset;

  /// Whether this aggregate contributes no advanced paint.
  bool get isEmpty =>
      (background == null || background!.isEmpty) &&
      (foreground == null || foreground!.isEmpty) &&
      backdropBlur == 0 &&
      (outline.style == BorderStyle.none || outline.width == 0);

  RemixSurfaceEffectsSpec merge(RemixSurfaceEffectsSpec? other) {
    if (other == null) return this;
    final hasOutline = other.outline.style != BorderStyle.none;
    return RemixSurfaceEffectsSpec(
      background: other.background ?? background,
      foreground: other.foreground ?? foreground,
      backdropBlur: other.backdropBlur == 0 ? backdropBlur : other.backdropBlur,
      outline: hasOutline ? other.outline : outline,
      outlineOffset: hasOutline ? other.outlineOffset : outlineOffset,
    );
  }

  static RemixSurfaceEffectsSpec? lerpNullable(
    RemixSurfaceEffectsSpec? begin,
    RemixSurfaceEffectsSpec? end,
    double t,
  ) {
    if (begin == null && end == null) return null;
    if (begin == null) {
      if (t <= 0) return null;
      if (t >= 1) return end;
      return RemixSurfaceEffectsSpec().lerp(end, t);
    }
    if (end == null) {
      if (t <= 0) return begin;
      if (t >= 1) return null;
      return begin.lerp(RemixSurfaceEffectsSpec(), t);
    }
    return begin.lerp(end, t);
  }

  @override
  RemixSurfaceEffectsSpec copyWith({
    RemixSurfaceLayerSpec? background,
    RemixSurfaceLayerSpec? foreground,
    double? backdropBlur,
    BorderSide? outline,
    double? outlineOffset,
  }) => RemixSurfaceEffectsSpec(
    background: background ?? this.background,
    foreground: foreground ?? this.foreground,
    backdropBlur: backdropBlur ?? this.backdropBlur,
    outline: outline ?? this.outline,
    outlineOffset: outlineOffset ?? this.outlineOffset,
  );

  @override
  RemixSurfaceEffectsSpec lerp(RemixSurfaceEffectsSpec? other, double t) {
    if (other == null) return this;
    return RemixSurfaceEffectsSpec(
      background: RemixSurfaceLayerSpec.lerpNullable(
        background,
        other.background,
        t,
      ),
      foreground: RemixSurfaceLayerSpec.lerpNullable(
        foreground,
        other.foreground,
        t,
      ),
      backdropBlur: math.max(
        0,
        ui.lerpDouble(backdropBlur, other.backdropBlur, t)!,
      ),
      outline: _lerpOutline(outline, other.outline, t),
      outlineOffset: ui.lerpDouble(outlineOffset, other.outlineOffset, t)!,
    );
  }

  @override
  List<Object?> get props => [
    background,
    foreground,
    backdropBlur,
    outline,
    outlineOffset,
  ];
}

BorderSide _lerpOutline(BorderSide begin, BorderSide end, double t) {
  final beginVisible = begin.style != BorderStyle.none && begin.width > 0;
  final endVisible = end.style != BorderStyle.none && end.width > 0;
  final beginColor = beginVisible
      ? begin.color
      : end.color.withValues(alpha: 0);
  final endColor = endVisible ? end.color : begin.color.withValues(alpha: 0);
  return BorderSide(
    color: Color.lerp(beginColor, endColor, t)!,
    width: math.max(
      0,
      ui.lerpDouble(
        beginVisible ? begin.width : 0,
        endVisible ? end.width : 0,
        t,
      )!,
    ),
    style: beginVisible || endVisible ? BorderStyle.solid : BorderStyle.none,
    strokeAlign: BorderSide.strokeAlignInside,
  );
}

/// Mix representation of [RemixSurfaceEffectsSpec].
@immutable
class RemixSurfaceEffectsMix extends Mix<RemixSurfaceEffectsSpec> {
  RemixSurfaceEffectsMix({
    RemixSurfaceLayerMix? background,
    RemixSurfaceLayerMix? foreground,
    double? backdropBlur,
    BorderSideMix? outline,
    double? outlineOffset,
  }) : this.create(
         background: Prop.maybeMix(background),
         foreground: Prop.maybeMix(foreground),
         backdropBlur: Prop.maybe(backdropBlur),
         outline: Prop.maybeMix(outline),
         outlineOffset: Prop.maybe(outlineOffset),
       );

  const RemixSurfaceEffectsMix.create({
    Prop<RemixSurfaceLayerSpec>? background,
    Prop<RemixSurfaceLayerSpec>? foreground,
    Prop<double>? backdropBlur,
    Prop<BorderSide>? outline,
    Prop<double>? outlineOffset,
  }) : $background = background,
       $foreground = foreground,
       $backdropBlur = backdropBlur,
       $outline = outline,
       $outlineOffset = outlineOffset;

  final Prop<RemixSurfaceLayerSpec>? $background;
  final Prop<RemixSurfaceLayerSpec>? $foreground;
  final Prop<double>? $backdropBlur;
  final Prop<BorderSide>? $outline;
  final Prop<double>? $outlineOffset;

  @override
  RemixSurfaceEffectsMix merge(RemixSurfaceEffectsMix? other) {
    if (other == null) return this;
    return RemixSurfaceEffectsMix.create(
      background: MixOps.merge($background, other.$background),
      foreground: MixOps.merge($foreground, other.$foreground),
      backdropBlur: MixOps.merge($backdropBlur, other.$backdropBlur),
      outline: MixOps.merge($outline, other.$outline),
      outlineOffset: MixOps.merge($outlineOffset, other.$outlineOffset),
    );
  }

  @override
  RemixSurfaceEffectsSpec resolve(BuildContext context) =>
      RemixSurfaceEffectsSpec(
        background: MixOps.resolve(context, $background),
        foreground: MixOps.resolve(context, $foreground),
        backdropBlur: MixOps.resolve(context, $backdropBlur) ?? 0,
        outline: MixOps.resolve(context, $outline) ?? BorderSide.none,
        outlineOffset: MixOps.resolve(context, $outlineOffset) ?? 0,
      );

  @override
  List<Object?> get props => [
    $background,
    $foreground,
    $backdropBlur,
    $outline,
    $outlineOffset,
  ];
}

/// Builds a Mix [Box], inserting the private effects adapter only when needed.
Widget remixSurfaceBox({
  Key? key,
  required StyleSpec<BoxSpec> styleSpec,
  RemixSurfaceEffectsSpec? effects,
  Widget? child,
}) {
  final resolvedEffects = effects ?? const RemixSurfaceEffectsSpec();
  if (!resolvedEffects.isEmpty) _validateEffects(resolvedEffects);
  return _RemixEffectsBox(
    key: key,
    styleSpec: styleSpec,
    effects: resolvedEffects,
    child: child,
  );
}

/// Builds a Mix [FlexBox], inserting the private effects adapter only when needed.
Widget remixSurfaceFlexBox({
  Key? key,
  required StyleSpec<FlexBoxSpec> styleSpec,
  Axis? direction,
  RemixSurfaceEffectsSpec? effects,
  List<Widget> children = const [],
}) {
  final resolvedEffects = effects ?? const RemixSurfaceEffectsSpec();
  if (!resolvedEffects.isEmpty) _validateEffects(resolvedEffects);
  return _RemixEffectsFlexBox(
    key: key,
    styleSpec: styleSpec,
    direction: direction,
    effects: resolvedEffects,
    children: children,
  );
}

void _validateEffects(RemixSurfaceEffectsSpec effects) {
  if (effects.outline.style != BorderStyle.none &&
      effects.outline.strokeAlign != BorderSide.strokeAlignInside) {
    throw FlutterError(
      'Remix Surface outlines must use BorderSide.strokeAlignInside.',
    );
  }
}

class _RemixEffectsFlexBox extends StatelessWidget {
  const _RemixEffectsFlexBox({
    super.key,
    required this.styleSpec,
    required this.effects,
    this.direction,
    this.children = const [],
  });

  final StyleSpec<FlexBoxSpec> styleSpec;
  final Axis? direction;
  final RemixSurfaceEffectsSpec effects;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => StyleSpecBuilder<FlexBoxSpec>(
    styleSpec: styleSpec,
    builder: (context, spec) {
      final box = spec.box?.spec;
      final margin = box?.margin;
      if (effects.isEmpty && (margin == null || margin.isNonNegative)) {
        final resolved = StyleSpec(spec: spec);
        return switch (direction) {
          Axis.horizontal => RowBox(styleSpec: resolved, children: children),
          Axis.vertical => ColumnBox(styleSpec: resolved, children: children),
          null => FlexBox(styleSpec: resolved, children: children),
        };
      }
      final decoration = box?.decoration;
      if (decoration is! BoxDecoration || decoration.shape == BoxShape.circle) {
        if (effects.isEmpty) {
          throw FlutterError(
            'Negative Remix FlexBox margins require a rectangular '
            'BoxDecoration.',
          );
        }
        throw FlutterError(
          'Remix Surface effects require a rectangular BoxDecoration. '
          'Add a radius-only BoxDecoration for otherwise undecorated content; '
          'ShapeDecoration and BoxShape.circle are not supported.',
        );
      }
      return _RemixDecoratedFlexBox(
        styleSpec: StyleSpec(spec: spec),
        direction: direction,
        effects: effects,
        children: children,
      );
    },
  );
}

class _RemixEffectsBox extends StatelessWidget {
  const _RemixEffectsBox({
    super.key,
    required this.styleSpec,
    required this.effects,
    this.child,
  });

  final StyleSpec<BoxSpec> styleSpec;
  final RemixSurfaceEffectsSpec effects;
  final Widget? child;

  @override
  Widget build(BuildContext context) => StyleSpecBuilder<BoxSpec>(
    styleSpec: styleSpec,
    builder: (context, spec) {
      if (effects.isEmpty &&
          (spec.margin == null || spec.margin!.isNonNegative)) {
        return Box(
          styleSpec: StyleSpec(spec: spec),
          child: child,
        );
      }
      final decoration = spec.decoration;
      if (decoration is! BoxDecoration || decoration.shape == BoxShape.circle) {
        if (effects.isEmpty) {
          throw FlutterError(
            'Negative Remix Box margins require a rectangular BoxDecoration.',
          );
        }
        throw FlutterError(
          'Remix Surface effects require a rectangular BoxDecoration. '
          'Add a radius-only BoxDecoration for otherwise undecorated content; '
          'ShapeDecoration and BoxShape.circle are not supported.',
        );
      }
      return _RemixDecoratedBox(
        styleSpec: StyleSpec(spec: spec),
        effects: effects,
        child: child,
      );
    },
  );
}

/// Internal Box equivalent that inserts surface layers at the decoration
/// boundary, inside constraints and margin.
class _RemixDecoratedBox extends StatelessWidget {
  const _RemixDecoratedBox({
    required this.styleSpec,
    required this.effects,
    this.child,
  });

  final StyleSpec<BoxSpec> styleSpec;
  final RemixSurfaceEffectsSpec effects;
  final Widget? child;

  @override
  Widget build(BuildContext context) => StyleSpecBuilder<BoxSpec>(
    styleSpec: styleSpec,
    builder: (context, spec) {
      Widget? current = child;
      if (child == null) {
        current = spec.constraints == null || !spec.constraints!.isTight
            ? LimitedBox(
                maxWidth: 0,
                maxHeight: 0,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                ),
              )
            : const SizedBox.shrink();
      } else if (spec.alignment != null) {
        current = Align(alignment: spec.alignment!, child: current);
      }

      final decorationPadding = spec.decoration?.padding;
      final padding = switch ((spec.padding, decorationPadding)) {
        (null, final value) => value,
        (final value, null) => value,
        (final value?, final decoration?) => value.add(decoration),
      };
      if (padding != null) current = Padding(padding: padding, child: current);

      final decoration = spec.decoration! as BoxDecoration;
      final textDirection = Directionality.maybeOf(context);
      final borderRadius = (decoration.borderRadius ?? BorderRadius.zero)
          .resolve(textDirection);
      final background = effects.background ?? const RemixSurfaceLayerSpec();

      // Box fill -> advanced background -> border -> child.
      if (decoration.border case final border?) {
        current = CustomPaint(
          painter: _RemixBoxBorderPainter(
            border: border,
            borderRadius: borderRadius,
            textDirection: textDirection,
          ),
          child: current,
        );
      }
      if (!background.isEmpty) {
        current = CustomPaint(
          painter: _RemixSurfacePainter(
            spec: background,
            borderRadius: borderRadius,
            textDirection: textDirection,
            phase: _SurfacePaintPhase.inner,
          ),
          child: current,
        );
      }
      current = DecoratedBox(
        decoration: _backgroundDecoration(decoration),
        child: current,
      );

      if (effects.backdropBlur > 0) {
        current = ClipRRect(
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: effects.backdropBlur,
              sigmaY: effects.backdropBlur,
            ),
            child: current,
          ),
        );
      }

      // Clip decorated content without clipping surface shadows or outlines.
      if (spec.clipBehavior case final clip? when clip != Clip.none) {
        current = ClipPath(
          clipper: _RemixDecorationClipper(
            textDirection: textDirection,
            decoration: decoration,
          ),
          clipBehavior: clip,
          child: current,
        );
      }

      if (_decorationShadow(decoration) case final shadow?) {
        current = DecoratedBox(decoration: shadow, child: current);
      }
      if (!background.isEmpty) {
        current = CustomPaint(
          painter: _RemixSurfacePainter(
            spec: background,
            borderRadius: borderRadius,
            textDirection: textDirection,
            phase: _SurfacePaintPhase.outer,
          ),
          child: current,
        );
      }
      if (spec.foregroundDecoration case final foreground?) {
        current = DecoratedBox(
          decoration: foreground,
          position: DecorationPosition.foreground,
          child: current,
        );
      }
      final hasForeground =
          effects.foreground != null && !effects.foreground!.isEmpty;
      final hasOutline =
          effects.outline.style != BorderStyle.none &&
          effects.outline.width > 0;
      if (hasForeground || hasOutline) {
        current = CustomPaint(
          foregroundPainter: _RemixSurfaceForegroundPainter(
            effects: effects,
            borderRadius: borderRadius,
            textDirection: textDirection,
          ),
          child: current,
        );
      }
      if (spec.constraints case final constraints?) {
        current = ConstrainedBox(constraints: constraints, child: current);
      }
      if (spec.margin case final margin?) {
        current = margin.isNonNegative
            ? Padding(padding: margin, child: current)
            : _RemixNegativeMargin(margin: margin, child: current);
      }
      if (spec.transform case final transform?) {
        current = Transform(
          transform: transform,
          alignment: spec.transformAlignment,
          child: current,
        );
      }
      return current;
    },
  );
}

/// Internal FlexBox equivalent backed by [_RemixDecoratedBox].
class _RemixDecoratedFlexBox extends StatelessWidget {
  const _RemixDecoratedFlexBox({
    required this.styleSpec,
    this.direction,
    required this.effects,
    this.children = const [],
  });

  final StyleSpec<FlexBoxSpec> styleSpec;
  final Axis? direction;
  final RemixSurfaceEffectsSpec effects;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => StyleSpecBuilder<FlexBoxSpec>(
    styleSpec: styleSpec,
    builder: (context, spec) {
      final flex = spec.flex?.spec;
      assert(
        direction == null ||
            flex?.direction == null ||
            direction == flex!.direction,
        'The forced and styled flex directions must agree.',
      );
      final content = Flex(
        direction: flex?.direction ?? direction ?? Axis.horizontal,
        mainAxisAlignment: flex?.mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize: flex?.mainAxisSize ?? MainAxisSize.max,
        crossAxisAlignment:
            flex?.crossAxisAlignment ?? CrossAxisAlignment.center,
        textDirection: flex?.textDirection,
        verticalDirection: flex?.verticalDirection ?? VerticalDirection.down,
        textBaseline: flex?.textBaseline,
        clipBehavior: flex?.clipBehavior ?? Clip.none,
        spacing: flex?.spacing ?? 0,
        children: children,
      );
      final box = spec.box;
      if (box == null) {
        throw FlutterError(
          'Remix Surface effects require a rectangular BoxDecoration. '
          'Add a radius-only BoxDecoration for otherwise undecorated content.',
        );
      }
      return _RemixDecoratedBox(
        styleSpec: box,
        effects: effects,
        child: content,
      );
    },
  );
}

/// Lays out a child using CSS margin arithmetic when one or more insets are
/// negative.
///
/// Flutter's [Padding] intentionally rejects negative values, while Radix's
/// ghost controls use a negative margin to cancel their visual padding in
/// surrounding layout. This render object keeps the padded child paintable at
/// its full size while reporting the margin-adjusted footprint to its parent.
class _RemixNegativeMargin extends SingleChildRenderObjectWidget {
  const _RemixNegativeMargin({required this.margin, required super.child});

  final EdgeInsetsGeometry margin;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderRemixNegativeMargin(
        margin: margin,
        textDirection: Directionality.maybeOf(context),
      );

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderRemixNegativeMargin renderObject,
  ) {
    renderObject
      ..margin = margin
      ..textDirection = Directionality.maybeOf(context);
  }
}

class _RenderRemixNegativeMargin extends RenderShiftedBox {
  _RenderRemixNegativeMargin({
    required EdgeInsetsGeometry margin,
    required TextDirection? textDirection,
    RenderBox? child,
  }) : _margin = margin,
       _textDirection = textDirection,
       super(child);

  EdgeInsets? _resolvedMarginCache;

  EdgeInsets get _resolvedMargin =>
      _resolvedMarginCache ??= margin.resolve(textDirection);

  EdgeInsetsGeometry get margin => _margin;
  EdgeInsetsGeometry _margin;

  set margin(EdgeInsetsGeometry value) {
    if (_margin == value) return;
    _margin = value;
    _markNeedsResolution();
  }

  TextDirection? get textDirection => _textDirection;
  TextDirection? _textDirection;

  set textDirection(TextDirection? value) {
    if (_textDirection == value) return;
    _textDirection = value;
    _markNeedsResolution();
  }

  void _markNeedsResolution() {
    _resolvedMarginCache = null;
    markNeedsLayout();
  }

  double _intrinsicExtent(double childExtent, double marginExtent) =>
      math.max(0, childExtent + marginExtent);

  @override
  double computeMinIntrinsicWidth(double height) {
    final resolved = _resolvedMargin;
    return _intrinsicExtent(
      child?.getMinIntrinsicWidth(math.max(0, height - resolved.vertical)) ?? 0,
      resolved.horizontal,
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final resolved = _resolvedMargin;
    return _intrinsicExtent(
      child?.getMaxIntrinsicWidth(math.max(0, height - resolved.vertical)) ?? 0,
      resolved.horizontal,
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final resolved = _resolvedMargin;
    return _intrinsicExtent(
      child?.getMinIntrinsicHeight(math.max(0, width - resolved.horizontal)) ??
          0,
      resolved.vertical,
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final resolved = _resolvedMargin;
    return _intrinsicExtent(
      child?.getMaxIntrinsicHeight(math.max(0, width - resolved.horizontal)) ??
          0,
      resolved.vertical,
    );
  }

  Size _constrainOuterSize(BoxConstraints constraints, Size childSize) {
    final resolved = _resolvedMargin;
    return constraints.constrain(
      Size(
        math.max(0, childSize.width + resolved.horizontal),
        math.max(0, childSize.height + resolved.vertical),
      ),
    );
  }

  @override
  @protected
  Size computeDryLayout(covariant BoxConstraints constraints) {
    final resolved = _resolvedMargin;
    final currentChild = child;
    if (currentChild == null) {
      return constraints.constrain(
        Size(math.max(0, resolved.horizontal), math.max(0, resolved.vertical)),
      );
    }
    return _constrainOuterSize(
      constraints,
      currentChild.getDryLayout(constraints.deflate(resolved)),
    );
  }

  @override
  double? computeDryBaseline(
    covariant BoxConstraints constraints,
    TextBaseline baseline,
  ) {
    final currentChild = child;
    if (currentChild == null) return null;
    final resolved = _resolvedMargin;
    final childBaseline = currentChild.getDryBaseline(
      constraints.deflate(resolved),
      baseline,
    );
    return childBaseline == null ? null : childBaseline + resolved.top;
  }

  @override
  void performLayout() {
    final resolved = _resolvedMargin;
    final currentChild = child;
    if (currentChild == null) {
      size = constraints.constrain(
        Size(math.max(0, resolved.horizontal), math.max(0, resolved.vertical)),
      );
      return;
    }

    currentChild.layout(constraints.deflate(resolved), parentUsesSize: true);
    (currentChild.parentData! as BoxParentData).offset = Offset(
      resolved.left,
      resolved.top,
    );
    size = _constrainOuterSize(constraints, currentChild.size);
  }

  @override
  Rect get paintBounds {
    final currentChild = child;
    if (currentChild == null) return Offset.zero & size;
    final offset = (currentChild.parentData! as BoxParentData).offset;
    return (Offset.zero & size).expandToInclude(
      currentChild.paintBounds.shift(offset),
    );
  }

  @override
  Rect get semanticBounds => paintBounds;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (child == null || !hasSize) return false;
    if (!hitTestChildren(result, position: position)) return false;
    result.add(BoxHitTestEntry(this, position));
    return true;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin))
      ..add(
        EnumProperty<TextDirection>(
          'textDirection',
          textDirection,
          defaultValue: null,
        ),
      );
  }
}

Decoration _backgroundDecoration(Decoration decoration) {
  if (decoration is BoxDecoration) {
    return BoxDecoration(
      color: decoration.color,
      image: decoration.image,
      borderRadius: decoration.borderRadius,
      gradient: decoration.gradient,
      backgroundBlendMode: decoration.backgroundBlendMode,
      shape: decoration.shape,
    );
  }
  return decoration;
}

Decoration? _decorationShadow(Decoration decoration) {
  if (decoration case BoxDecoration(
    :final boxShadow?,
  ) when boxShadow.isNotEmpty) {
    return BoxDecoration(
      borderRadius: decoration.borderRadius,
      boxShadow: boxShadow,
      shape: decoration.shape,
    );
  }
  return null;
}

class _RemixDecorationClipper extends CustomClipper<Path> {
  const _RemixDecorationClipper({
    required this.textDirection,
    required this.decoration,
  });

  final TextDirection? textDirection;
  final Decoration decoration;

  @override
  Path getClip(Size size) => decoration.getClipPath(
    Offset.zero & size,
    textDirection ?? TextDirection.ltr,
  );

  @override
  bool shouldReclip(_RemixDecorationClipper oldClipper) =>
      decoration != oldClipper.decoration ||
      textDirection != oldClipper.textDirection;
}

enum _SurfacePaintPhase { all, outer, inner, outline }

class _RemixBoxBorderPainter extends CustomPainter {
  const _RemixBoxBorderPainter({
    required this.border,
    required this.borderRadius,
    required this.textDirection,
  });

  final BoxBorder border;
  final BorderRadius borderRadius;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    border.paint(
      canvas,
      Offset.zero & size,
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
      textDirection: textDirection,
    );
  }

  @override
  bool shouldRepaint(_RemixBoxBorderPainter oldDelegate) =>
      border != oldDelegate.border ||
      borderRadius != oldDelegate.borderRadius ||
      textDirection != oldDelegate.textDirection;
}

class _RemixSurfaceForegroundPainter extends CustomPainter
    implements RemixCustomPainterPaintBounds {
  const _RemixSurfaceForegroundPainter({
    required this.effects,
    required this.borderRadius,
    required this.textDirection,
  });

  final RemixSurfaceEffectsSpec effects;
  final BorderRadius borderRadius;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    if (effects.foreground case final foreground?) {
      _RemixSurfacePainter(
        spec: foreground,
        borderRadius: borderRadius,
        textDirection: textDirection,
        phase: _SurfacePaintPhase.all,
      ).paint(canvas, size);
    }

    _RemixSurfacePainter(
      spec: const RemixSurfaceLayerSpec(),
      borderRadius: borderRadius,
      textDirection: textDirection,
      phase: _SurfacePaintPhase.outline,
      outline: effects.outline,
      outlineOffset: effects.outlineOffset,
    ).paint(canvas, size);
  }

  @override
  bool hitTest(Offset position) => false;

  @override
  Rect paintBoundsForSize(Size size) {
    var bounds = _surfacePaintBounds(
      const RemixSurfaceLayerSpec(),
      size,
      borderRadius: borderRadius,
      includeOuterShadows: false,
      includeOutline: true,
      outline: effects.outline,
      outlineOffset: effects.outlineOffset,
    );
    if (effects.foreground case final foreground?) {
      bounds = bounds.expandToInclude(
        _surfacePaintBounds(
          foreground,
          size,
          borderRadius: borderRadius,
          includeOuterShadows: true,
          includeOutline: false,
        ),
      );
    }
    return bounds;
  }

  @override
  bool shouldRepaint(_RemixSurfaceForegroundPainter oldDelegate) =>
      effects != oldDelegate.effects ||
      borderRadius != oldDelegate.borderRadius ||
      textDirection != oldDelegate.textDirection;
}

class _RemixSurfacePainter extends CustomPainter
    implements RemixCustomPainterPaintBounds {
  const _RemixSurfacePainter({
    required this.spec,
    required this.borderRadius,
    required this.textDirection,
    required this.phase,
    this.outline = BorderSide.none,
    this.outlineOffset = 0,
  });

  final RemixSurfaceLayerSpec spec;
  final BorderRadius borderRadius;
  final TextDirection? textDirection;
  final _SurfacePaintPhase phase;
  final BorderSide outline;
  final double outlineOffset;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final rect = Offset.zero & size;
    final shape = borderRadius.toRRect(rect);

    if (phase == _SurfacePaintPhase.outline) {
      _paintOutline(canvas, shape);
      return;
    }
    if (phase != _SurfacePaintPhase.inner) {
      _paintOuterShadows(canvas, shape);
    }
    if (phase != _SurfacePaintPhase.outer) {
      _paintInnerLayers(canvas, rect, shape);
    }
    if (phase == _SurfacePaintPhase.all) {
      _paintOutline(canvas, shape);
    }
  }

  void _paintOuterShadows(Canvas canvas, RRect shape) {
    for (final shadow in spec.shadows.reversed) {
      if (shadow.kind != RemixPaintShadowKind.outer || shadow.color.a == 0) {
        continue;
      }
      final targetShape = shape.deflate(shadow.shapeInset);
      final shadowShape = targetShape
          .inflate(shadow.spreadRadius)
          .shift(shadow.offset);
      if (shadowShape.outerRect.isEmpty) continue;
      final paint = BoxShadow(
        color: shadow.color,
        blurRadius: shadow.blurRadius,
      ).toPaint();

      final blurExtent = ui.Shadow.convertRadiusToSigma(shadow.blurRadius) * 3;
      final shadowBounds = shadowShape.outerRect
          .inflate(blurExtent)
          .expandToInclude(targetShape.outerRect);
      // Isolate the knockout so it cannot erase the filtered backdrop.
      canvas.saveLayer(shadowBounds, Paint());
      canvas.drawRRect(shadowShape, paint);
      canvas.drawRRect(targetShape, Paint()..blendMode = BlendMode.dstOut);
      canvas.restore();
    }
  }

  void _paintOutline(Canvas canvas, RRect shape) {
    if (outline.style == BorderStyle.none || outline.width <= 0) return;
    final inner = shape.inflate(outlineOffset);
    final outer = shape.inflate(outlineOffset + outline.width);
    if (outer.outerRect.isEmpty) return;

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRRect(outer);
    if (!inner.outerRect.isEmpty) path.addRRect(inner);
    canvas.drawPath(path, Paint()..color = outline.color);
  }

  void _paintInnerLayers(Canvas canvas, Rect rect, RRect shape) {
    if (spec.gradientInsets.isNotEmpty &&
        spec.gradientInsets.length != spec.gradients.length) {
      throw FlutterError(
        'RemixSurfaceLayerSpec.gradientInsets must be empty or match the '
        'gradients length.',
      );
    }
    if (spec.gradientInsets.any((inset) => !inset.isFinite || inset < 0)) {
      throw FlutterError(
        'RemixSurfaceLayerSpec.gradientInsets must contain finite '
        'non-negative values. Received ${spec.gradientInsets}.',
      );
    }
    canvas.save();
    canvas.clipRRect(shape, doAntiAlias: true);

    for (var index = spec.gradients.length - 1; index >= 0; index--) {
      final gradient = spec.gradients[index];
      final inset = spec.gradientInsets.isEmpty
          ? 0.0
          : spec.gradientInsets[index];
      final gradientShape = inset == 0 ? shape : shape.deflate(inset);
      if (gradientShape.outerRect.isEmpty) continue;
      final gradientRect = gradientShape.outerRect;
      canvas.save();
      canvas.clipRRect(gradientShape, doAntiAlias: true);
      canvas.drawRect(
        gradientRect,
        Paint()
          ..shader = gradient.createShader(
            gradientRect,
            textDirection: textDirection,
          ),
      );
      canvas.restore();
    }
    canvas.restore();

    for (final shadow in spec.shadows.reversed) {
      if (shadow.kind == RemixPaintShadowKind.inset) {
        _paintInsetShadow(canvas, shape, shadow);
      }
    }
  }

  void _paintInsetShadow(Canvas canvas, RRect shape, RemixPaintShadow shadow) {
    final targetShape = shape.deflate(shadow.shapeInset);
    if (targetShape.outerRect.isEmpty) return;
    final hole = targetShape.deflate(shadow.spreadRadius).shift(shadow.offset);
    if (hole.outerRect.isEmpty) {
      canvas.drawRRect(targetShape, Paint()..color = shadow.color);
      return;
    }

    final blurExtent = shadow.blurRadius * 2 + 1;
    final layerBounds = targetShape.outerRect
        .expandToInclude(hole.outerRect)
        .inflate(blurExtent);
    canvas.saveLayer(layerBounds, Paint());
    if (shadow.blurRadius > 0) {
      final sigma = ui.Shadow.convertRadiusToSigma(shadow.blurRadius);
      canvas.saveLayer(
        layerBounds,
        Paint()
          ..imageFilter = ui.ImageFilter.blur(
            sigmaX: sigma,
            sigmaY: sigma,
            tileMode: TileMode.decal,
          ),
      );
    }
    final shadowPath = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(layerBounds)
      ..addRRect(hole);
    canvas.drawPath(shadowPath, Paint()..color = shadow.color);
    if (shadow.blurRadius > 0) canvas.restore();
    final outsideShape = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(layerBounds)
      ..addRRect(targetShape);
    canvas.drawPath(
      outsideShape,
      Paint()
        ..color = const Color(0xFFFFFFFF)
        ..blendMode = BlendMode.dstOut,
    );
    canvas.restore();
  }

  @override
  bool hitTest(Offset position) => false;

  @override
  Rect paintBoundsForSize(Size size) => _surfacePaintBounds(
    spec,
    size,
    borderRadius: borderRadius,
    includeOuterShadows:
        phase != _SurfacePaintPhase.inner &&
        phase != _SurfacePaintPhase.outline,
    includeOutline:
        phase == _SurfacePaintPhase.all || phase == _SurfacePaintPhase.outline,
    outline: outline,
    outlineOffset: outlineOffset,
  );

  @override
  bool shouldRepaint(_RemixSurfacePainter oldDelegate) =>
      spec != oldDelegate.spec ||
      borderRadius != oldDelegate.borderRadius ||
      textDirection != oldDelegate.textDirection ||
      phase != oldDelegate.phase ||
      outline != oldDelegate.outline ||
      outlineOffset != oldDelegate.outlineOffset;
}

Rect _surfacePaintBounds(
  RemixSurfaceLayerSpec spec,
  Size size, {
  required BorderRadius borderRadius,
  required bool includeOuterShadows,
  required bool includeOutline,
  BorderSide outline = BorderSide.none,
  double outlineOffset = 0,
}) {
  var bounds = Offset.zero & size;
  final shape = borderRadius.toRRect(bounds);

  if (includeOuterShadows) {
    for (final shadow in spec.shadows) {
      if (shadow.kind != RemixPaintShadowKind.outer || shadow.color.a == 0) {
        continue;
      }
      final shadowShape = shape
          .deflate(shadow.shapeInset)
          .inflate(shadow.spreadRadius)
          .shift(shadow.offset);
      if (shadowShape.outerRect.isEmpty) continue;
      final blurExtent = ui.Shadow.convertRadiusToSigma(shadow.blurRadius) * 3;
      bounds = bounds.expandToInclude(
        shadowShape.outerRect.inflate(blurExtent),
      );
    }
  }

  if (includeOutline &&
      outline.style != BorderStyle.none &&
      outline.color.a > 0 &&
      outline.width > 0) {
    final outlineShape = shape.inflate(outlineOffset + outline.width);
    if (!outlineShape.outerRect.isEmpty) {
      bounds = bounds.expandToInclude(outlineShape.outerRect);
    }
  }

  return bounds;
}
