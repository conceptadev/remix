import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mix/mix.dart';

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
    color: color,
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
    this.color,
    this.gradients = const [],
    this.gradientInsets = const [],
    this.shadows = const [],
    this.borderRadius = BorderRadius.zero,
    this.backdropBlur = 0,
    this.outlineColor,
    this.outlineWidth = 0,
    this.outlineOffset = 0,
  }) : assert(backdropBlur >= 0),
       assert(outlineWidth >= 0),
       assert(
         outlineOffset >= -double.maxFinite &&
             outlineOffset <= double.maxFinite,
       );

  final Color? color;

  /// CSS order: the first gradient is painted closest to the content.
  final List<Gradient> gradients;

  /// Optional clip inset for each corresponding [gradients] layer.
  ///
  /// This models CSS backgrounds clipped to a transparent inner border, such
  /// as Radix classic-button pseudo-elements. An empty list means no insets.
  final List<double> gradientInsets;

  /// CSS order: the first shadow is painted closest to the content.
  final List<RemixPaintShadow> shadows;
  final BorderRadiusGeometry borderRadius;

  /// Backdrop-filter blur sigma, clipped to [borderRadius].
  final double backdropBlur;

  /// CSS-style outline painted without affecting layout.
  final Color? outlineColor;
  final double outlineWidth;
  final double outlineOffset;

  @override
  RemixSurfaceLayerSpec copyWith({
    Color? color,
    List<Gradient>? gradients,
    List<double>? gradientInsets,
    List<RemixPaintShadow>? shadows,
    BorderRadiusGeometry? borderRadius,
    double? backdropBlur,
    Color? outlineColor,
    double? outlineWidth,
    double? outlineOffset,
  }) => RemixSurfaceLayerSpec(
    color: color ?? this.color,
    gradients: gradients ?? this.gradients,
    gradientInsets: gradientInsets ?? this.gradientInsets,
    shadows: shadows ?? this.shadows,
    borderRadius: borderRadius ?? this.borderRadius,
    backdropBlur: backdropBlur ?? this.backdropBlur,
    outlineColor: outlineColor ?? this.outlineColor,
    outlineWidth: outlineWidth ?? this.outlineWidth,
    outlineOffset: outlineOffset ?? this.outlineOffset,
  );

  @override
  RemixSurfaceLayerSpec lerp(RemixSurfaceLayerSpec? other, double t) {
    if (other == null) return this;
    return RemixSurfaceLayerSpec(
      color: Color.lerp(color, other.color, t),
      gradients: _lerpGradientList(gradients, other.gradients, t),
      gradientInsets: _lerpDoubleList(gradientInsets, other.gradientInsets, t),
      shadows: RemixPaintShadow.lerpList(shadows, other.shadows, t),
      borderRadius: BorderRadiusGeometry.lerp(
        borderRadius,
        other.borderRadius,
        t,
      )!,
      backdropBlur: math.max(
        0,
        ui.lerpDouble(backdropBlur, other.backdropBlur, t)!,
      ),
      outlineColor: Color.lerp(outlineColor, other.outlineColor, t),
      outlineWidth: math.max(
        0,
        ui.lerpDouble(outlineWidth, other.outlineWidth, t)!,
      ),
      outlineOffset: ui.lerpDouble(outlineOffset, other.outlineOffset, t)!,
    );
  }

  @override
  List<Object?> get props => [
    color,
    gradients,
    gradientInsets,
    shadows,
    borderRadius,
    backdropBlur,
    outlineColor,
    outlineWidth,
    outlineOffset,
  ];
}

List<double> _lerpDoubleList(List<double> a, List<double> b, double t) {
  final length = math.max(a.length, b.length);
  return [
    for (var index = 0; index < length; index++)
      ui.lerpDouble(
        index < a.length ? a[index] : 0,
        index < b.length ? b[index] : 0,
        t,
      )!,
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
    Color? color,
    List<RemixLinearGradientMix>? gradients,
    List<double>? gradientInsets,
    List<RemixPaintShadowMix>? shadows,
    RemixPaintShadowListToken? shadowToken,
    BorderRadiusGeometryMix? borderRadius,
    double? backdropBlur,
    Color? outlineColor,
    double? outlineWidth,
    double? outlineOffset,
  }) : this.create(
         color: Prop.maybe(color),
         gradients: gradients == null
             ? null
             : Prop.mix(_RemixGradientListMix(gradients)),
         gradientInsets: gradientInsets == null
             ? null
             : Prop.mix(_RemixDoubleListMix(gradientInsets)),
         shadows: _shadowProp(shadows, shadowToken),
         borderRadius: Prop.maybeMix(borderRadius),
         backdropBlur: Prop.maybe(backdropBlur),
         outlineColor: Prop.maybe(outlineColor),
         outlineWidth: Prop.maybe(outlineWidth),
         outlineOffset: Prop.maybe(outlineOffset),
       );

  const RemixSurfaceLayerMix.create({
    Prop<Color>? color,
    Prop<List<Gradient>>? gradients,
    Prop<List<double>>? gradientInsets,
    Prop<List<RemixPaintShadow>>? shadows,
    Prop<BorderRadiusGeometry>? borderRadius,
    Prop<double>? backdropBlur,
    Prop<Color>? outlineColor,
    Prop<double>? outlineWidth,
    Prop<double>? outlineOffset,
  }) : $color = color,
       $gradients = gradients,
       $gradientInsets = gradientInsets,
       $shadows = shadows,
       $borderRadius = borderRadius,
       $backdropBlur = backdropBlur,
       $outlineColor = outlineColor,
       $outlineWidth = outlineWidth,
       $outlineOffset = outlineOffset;

  final Prop<Color>? $color;
  final Prop<List<Gradient>>? $gradients;
  final Prop<List<double>>? $gradientInsets;
  final Prop<List<RemixPaintShadow>>? $shadows;
  final Prop<BorderRadiusGeometry>? $borderRadius;
  final Prop<double>? $backdropBlur;
  final Prop<Color>? $outlineColor;
  final Prop<double>? $outlineWidth;
  final Prop<double>? $outlineOffset;

  @override
  RemixSurfaceLayerMix merge(RemixSurfaceLayerMix? other) {
    if (other == null) return this;
    return RemixSurfaceLayerMix.create(
      color: MixOps.merge($color, other.$color),
      gradients: MixOps.merge($gradients, other.$gradients),
      gradientInsets: MixOps.merge($gradientInsets, other.$gradientInsets),
      shadows: MixOps.merge($shadows, other.$shadows),
      borderRadius: MixOps.merge($borderRadius, other.$borderRadius),
      backdropBlur: MixOps.merge($backdropBlur, other.$backdropBlur),
      outlineColor: MixOps.merge($outlineColor, other.$outlineColor),
      outlineWidth: MixOps.merge($outlineWidth, other.$outlineWidth),
      outlineOffset: MixOps.merge($outlineOffset, other.$outlineOffset),
    );
  }

  @override
  RemixSurfaceLayerSpec resolve(BuildContext context) => RemixSurfaceLayerSpec(
    color: MixOps.resolve(context, $color),
    gradients: MixOps.resolve(context, $gradients) ?? const [],
    gradientInsets: MixOps.resolve(context, $gradientInsets) ?? const [],
    shadows: MixOps.resolve(context, $shadows) ?? const [],
    borderRadius: MixOps.resolve(context, $borderRadius) ?? BorderRadius.zero,
    backdropBlur: MixOps.resolve(context, $backdropBlur) ?? 0,
    outlineColor: MixOps.resolve(context, $outlineColor),
    outlineWidth: MixOps.resolve(context, $outlineWidth) ?? 0,
    outlineOffset: MixOps.resolve(context, $outlineOffset) ?? 0,
  );

  @override
  List<Object?> get props => [
    $color,
    $gradients,
    $gradientInsets,
    $shadows,
    $borderRadius,
    $backdropBlur,
    $outlineColor,
    $outlineWidth,
    $outlineOffset,
  ];
}

/// Paints [spec] behind [child] without changing the child's layout,
/// hit-testing, baseline, or semantics.
class RemixSurface extends StatelessWidget {
  const RemixSurface({
    super.key,
    required this.spec,
    this.overlay,
    required this.child,
  });

  /// Returns [child] unchanged when neither paint slot is present.
  static Widget wrap({
    RemixSurfaceLayerSpec? surface,
    RemixSurfaceLayerSpec? overlay,
    required Widget child,
  }) {
    if (surface == null && overlay == null) return child;
    return RemixSurface(
      spec: surface ?? const RemixSurfaceLayerSpec(),
      overlay: overlay,
      child: child,
    );
  }

  final RemixSurfaceLayerSpec spec;

  /// Optional layers painted after the child without participating in hit
  /// testing or semantics.
  final RemixSurfaceLayerSpec? overlay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.maybeOf(context);
    final borderRadius = spec.borderRadius.resolve(textDirection);
    if (spec.backdropBlur <= 0) {
      return CustomPaint(
        painter: _RemixSurfacePainter(
          spec: spec,
          borderRadius: borderRadius,
          textDirection: textDirection,
          phase: _SurfacePaintPhase.all,
        ),
        foregroundPainter: _overlayPainter(overlay, textDirection),
        child: child,
      );
    }

    return CustomPaint(
      painter: _RemixSurfacePainter(
        spec: spec,
        borderRadius: borderRadius,
        textDirection: textDirection,
        phase: _SurfacePaintPhase.outer,
      ),
      foregroundPainter: _overlayPainter(overlay, textDirection),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: borderRadius,
              clipBehavior: Clip.antiAlias,
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: spec.backdropBlur,
                  sigmaY: spec.backdropBlur,
                ),
                child: CustomPaint(
                  painter: _RemixSurfacePainter(
                    spec: spec,
                    borderRadius: borderRadius,
                    textDirection: textDirection,
                    phase: _SurfacePaintPhase.inner,
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }

  _RemixSurfacePainter? _overlayPainter(
    RemixSurfaceLayerSpec? value,
    TextDirection? textDirection,
  ) {
    if (value == null) return null;
    assert(
      value.backdropBlur == 0,
      'Backdrop blur belongs to the background surface slot.',
    );
    return _RemixSurfacePainter(
      spec: value,
      borderRadius: value.borderRadius.resolve(textDirection),
      textDirection: textDirection,
      phase: _SurfacePaintPhase.all,
    );
  }
}

/// Internal Box equivalent that inserts surface layers at the decoration
/// boundary, inside constraints and margin.
class RemixSurfaceBox extends StatelessWidget {
  const RemixSurfaceBox({
    super.key,
    required this.styleSpec,
    this.surface,
    this.overlay,
    this.child,
  });

  final StyleSpec<BoxSpec> styleSpec;
  final RemixSurfaceLayerSpec? surface;
  final RemixSurfaceLayerSpec? overlay;
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

      current = RemixSurface.wrap(
        surface: surface,
        overlay: overlay,
        child: current!,
      );

      if (spec.clipBehavior case final clip? when clip != Clip.none) {
        final decoration = spec.decoration;
        assert(decoration != null);
        current = ClipPath(
          clipper: _RemixDecorationClipper(
            textDirection: Directionality.maybeOf(context),
            decoration: decoration!,
          ),
          clipBehavior: clip,
          child: current,
        );
      }
      if (spec.decoration case final decoration?) {
        current = DecoratedBox(decoration: decoration, child: current);
        if (_foregroundBorder(decoration) case final border?) {
          current = DecoratedBox(
            decoration: border,
            position: DecorationPosition.foreground,
            child: current,
          );
        }
      }
      if (spec.foregroundDecoration case final foreground?) {
        current = DecoratedBox(
          decoration: foreground,
          position: DecorationPosition.foreground,
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

/// Internal FlexBox equivalent backed by [RemixSurfaceBox].
class RemixSurfaceFlexBox extends StatelessWidget {
  const RemixSurfaceFlexBox({
    super.key,
    required this.styleSpec,
    this.direction,
    this.surface,
    this.overlay,
    this.children = const [],
  });

  final StyleSpec<FlexBoxSpec> styleSpec;
  final Axis? direction;
  final RemixSurfaceLayerSpec? surface;
  final RemixSurfaceLayerSpec? overlay;
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
        return RemixSurface.wrap(
          surface: surface,
          overlay: overlay,
          child: content,
        );
      }
      return RemixSurfaceBox(
        styleSpec: box,
        surface: surface,
        overlay: overlay,
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

Decoration? _foregroundBorder(Decoration decoration) {
  if (decoration case BoxDecoration(:final border?) when border != Border()) {
    return BoxDecoration(
      border: border,
      borderRadius: decoration.borderRadius,
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

enum _SurfacePaintPhase { all, outer, inner }

class _RemixSurfacePainter extends CustomPainter {
  const _RemixSurfacePainter({
    required this.spec,
    required this.borderRadius,
    required this.textDirection,
    required this.phase,
  });

  final RemixSurfaceLayerSpec spec;
  final BorderRadius borderRadius;
  final TextDirection? textDirection;
  final _SurfacePaintPhase phase;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final rect = Offset.zero & size;
    final shape = borderRadius.toRRect(rect);

    if (phase != _SurfacePaintPhase.inner) {
      _paintOuterShadows(canvas, shape);
    }
    if (phase != _SurfacePaintPhase.outer) {
      _paintInnerLayers(canvas, rect, shape);
    }
  }

  void _paintOuterShadows(Canvas canvas, RRect shape) {
    for (final shadow in spec.shadows.reversed) {
      if (shadow.kind != RemixPaintShadowKind.outer) continue;
      final shadowShape = shape
          .deflate(shadow.shapeInset)
          .inflate(shadow.spreadRadius)
          .shift(shadow.offset);
      if (shadowShape.outerRect.isEmpty) continue;
      final paint = BoxShadow(
        color: shadow.color,
        blurRadius: shadow.blurRadius,
      ).toPaint();
      canvas.drawRRect(shadowShape, paint);
    }
    _paintOutline(canvas, shape);
  }

  void _paintOutline(Canvas canvas, RRect shape) {
    final color = spec.outlineColor;
    if (color == null || spec.outlineWidth <= 0) return;
    final inner = shape.inflate(spec.outlineOffset);
    final outer = shape.inflate(spec.outlineOffset + spec.outlineWidth);
    if (outer.outerRect.isEmpty) return;

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRRect(outer);
    if (!inner.outerRect.isEmpty) path.addRRect(inner);
    canvas.drawPath(path, Paint()..color = color);
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
        'non-negative values.',
      );
    }
    canvas.save();
    canvas.clipRRect(shape, doAntiAlias: true);

    if (spec.color case final color?) {
      canvas.drawRect(rect, Paint()..color = color);
    }
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
  bool shouldRepaint(_RemixSurfacePainter oldDelegate) =>
      spec != oldDelegate.spec ||
      borderRadius != oldDelegate.borderRadius ||
      textDirection != oldDelegate.textDirection ||
      phase != oldDelegate.phase;
}
