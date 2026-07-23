part of 'remix_box_effects.dart';

/// Whether a painted shadow falls outside a box or into its interior.
enum RemixBoxShadowKind { outer, inset }

/// A CSS-shaped box-shadow layer that can represent real inset shadows.
@immutable
class RemixBoxShadow {
  const RemixBoxShadow({
    this.kind = RemixBoxShadowKind.outer,
    this.color = const Color(0xFF000000),
    this.offset = Offset.zero,
    this.blurRadius = 0,
    this.spreadRadius = 0,
    this.shapeInset = 0,
  }) : assert(blurRadius >= 0),
       assert(shapeInset >= 0);

  final RemixBoxShadowKind kind;
  final Color color;
  final Offset offset;
  final double blurRadius;
  final double spreadRadius;
  final double shapeInset;

  RemixBoxShadow scale(double factor) => RemixBoxShadow(
    kind: kind,
    color: color.withValues(alpha: color.a * factor),
    offset: offset * factor,
    blurRadius: math.max(0, blurRadius * factor),
    spreadRadius: spreadRadius * factor,
    shapeInset: math.max(0, shapeInset * factor),
  );

  static RemixBoxShadow? lerp(RemixBoxShadow? a, RemixBoxShadow? b, double t) {
    if (identical(a, b)) return a;
    if (a == null) return b!.scale(t);
    if (b == null) return a.scale(1 - t);

    return RemixBoxShadow(
      kind: t < 0.5 ? a.kind : b.kind,
      color: Color.lerp(a.color, b.color, t)!,
      offset: Offset.lerp(a.offset, b.offset, t)!,
      blurRadius: math.max(0, ui.lerpDouble(a.blurRadius, b.blurRadius, t)!),
      spreadRadius: ui.lerpDouble(a.spreadRadius, b.spreadRadius, t)!,
      shapeInset: math.max(0, ui.lerpDouble(a.shapeInset, b.shapeInset, t)!),
    );
  }

  static List<RemixBoxShadow> lerpList(
    List<RemixBoxShadow> a,
    List<RemixBoxShadow> b,
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
      other is RemixBoxShadow &&
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
      'RemixBoxShadow($kind, $color, $offset, $blurRadius, $spreadRadius, '
      '$shapeInset)';
}

/// Mix representation of [RemixBoxShadow] with token-aware fields.
@immutable
class RemixBoxShadowMix extends Mix<RemixBoxShadow> {
  RemixBoxShadowMix({
    RemixBoxShadowKind? kind,
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

  const RemixBoxShadowMix.create({
    Prop<RemixBoxShadowKind>? kind,
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

  RemixBoxShadowMix.value(RemixBoxShadow value)
    : this(
        kind: value.kind,
        color: value.color,
        offset: value.offset,
        blurRadius: value.blurRadius,
        spreadRadius: value.spreadRadius,
        shapeInset: value.shapeInset,
      );

  final Prop<RemixBoxShadowKind>? $kind;
  final Prop<Color>? $color;
  final Prop<Offset>? $offset;
  final Prop<double>? $blurRadius;
  final Prop<double>? $spreadRadius;
  final Prop<double>? $shapeInset;

  @override
  RemixBoxShadowMix merge(RemixBoxShadowMix? other) {
    if (other == null) return this;
    return RemixBoxShadowMix.create(
      kind: MixOps.merge($kind, other.$kind),
      color: MixOps.merge($color, other.$color),
      offset: MixOps.merge($offset, other.$offset),
      blurRadius: MixOps.merge($blurRadius, other.$blurRadius),
      spreadRadius: MixOps.merge($spreadRadius, other.$spreadRadius),
      shapeInset: MixOps.merge($shapeInset, other.$shapeInset),
    );
  }

  @override
  RemixBoxShadow resolve(BuildContext context) => RemixBoxShadow(
    kind: MixOps.resolve(context, $kind) ?? RemixBoxShadowKind.outer,
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
class RemixBoxShadowListToken extends MixToken<List<RemixBoxShadow>> {
  const RemixBoxShadowListToken(super.name);
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

/// Resolved ordered box effect layers painted behind component content.
@immutable
class RemixBoxEffectLayerSpec extends Spec<RemixBoxEffectLayerSpec> {
  const RemixBoxEffectLayerSpec({
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
  final List<RemixBoxShadow> shadows;

  /// Whether this layer contributes no paint.
  bool get isEmpty => gradients.isEmpty && shadows.isEmpty;

  /// Interpolates nullable surface slots through an empty visual layer.
  ///
  /// Component specs use nullable layers so variants can add or remove a
  /// surface. Treating absence as an empty layer lets those transitions fade
  /// instead of snapping while preserving `null` at the exact absent endpoint.
  static RemixBoxEffectLayerSpec? lerpNullable(
    RemixBoxEffectLayerSpec? begin,
    RemixBoxEffectLayerSpec? end,
    double t,
  ) {
    if (begin == null && end == null) return null;
    if (begin == null) {
      if (t <= 0) return null;
      if (t >= 1) return end;
      return const RemixBoxEffectLayerSpec().lerp(end, t);
    }
    if (end == null) {
      if (t <= 0) return begin;
      if (t >= 1) return null;
      return begin.lerp(const RemixBoxEffectLayerSpec(), t);
    }
    return begin.lerp(end, t);
  }

  @override
  RemixBoxEffectLayerSpec copyWith({
    List<Gradient>? gradients,
    List<double>? gradientInsets,
    List<RemixBoxShadow>? shadows,
  }) => RemixBoxEffectLayerSpec(
    gradients: gradients ?? this.gradients,
    gradientInsets: gradientInsets ?? this.gradientInsets,
    shadows: shadows ?? this.shadows,
  );

  @override
  RemixBoxEffectLayerSpec lerp(RemixBoxEffectLayerSpec? other, double t) {
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
    return RemixBoxEffectLayerSpec(
      gradients: interpolatedGradients,
      gradientInsets: _lerpDoubleList(currentInsets, otherInsets, t),
      shadows: RemixBoxShadow.lerpList(shadows, other.shadows, t),
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
class _RemixShadowListMix extends Mix<List<RemixBoxShadow>> {
  const _RemixShadowListMix.values(this.values) : token = null;

  const _RemixShadowListMix.token(this.token) : values = null;

  final List<RemixBoxShadowMix>? values;
  final RemixBoxShadowListToken? token;

  @override
  _RemixShadowListMix merge(_RemixShadowListMix? other) => other ?? this;

  @override
  List<RemixBoxShadow> resolve(BuildContext context) {
    final token = this.token;
    if (token != null) return token.resolve(context);

    return values!
        .map((value) => value.resolve(context))
        .toList(growable: false);
  }

  @override
  List<Object?> get props => [values, token];
}

Prop<List<RemixBoxShadow>>? _shadowProp(
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? token,
) {
  if (shadows != null && token != null) {
    throw ArgumentError('Provide either shadows or shadowToken, not both.');
  }
  if (token != null) return Prop.mix(_RemixShadowListMix.token(token));
  if (shadows != null) {
    return Prop.mix(_RemixShadowListMix.values(shadows));
  }
  return null;
}

/// Mix representation of [RemixBoxEffectLayerSpec].
@immutable
class RemixBoxEffectLayerMix extends Mix<RemixBoxEffectLayerSpec> {
  RemixBoxEffectLayerMix({
    List<RemixLinearGradientMix>? gradients,
    List<double>? gradientInsets,
    List<RemixBoxShadowMix>? shadows,
    RemixBoxShadowListToken? shadowToken,
  }) : this.create(
         gradients: gradients == null
             ? null
             : Prop.mix(_RemixGradientListMix(gradients)),
         gradientInsets: gradientInsets == null
             ? null
             : Prop.mix(_RemixDoubleListMix(gradientInsets)),
         shadows: _shadowProp(shadows, shadowToken),
       );

  const RemixBoxEffectLayerMix.create({
    Prop<List<Gradient>>? gradients,
    Prop<List<double>>? gradientInsets,
    Prop<List<RemixBoxShadow>>? shadows,
  }) : $gradients = gradients,
       $gradientInsets = gradientInsets,
       $shadows = shadows;

  final Prop<List<Gradient>>? $gradients;
  final Prop<List<double>>? $gradientInsets;
  final Prop<List<RemixBoxShadow>>? $shadows;

  @override
  RemixBoxEffectLayerMix merge(RemixBoxEffectLayerMix? other) {
    if (other == null) return this;
    return RemixBoxEffectLayerMix.create(
      gradients: MixOps.merge($gradients, other.$gradients),
      gradientInsets: MixOps.merge($gradientInsets, other.$gradientInsets),
      shadows: MixOps.merge($shadows, other.$shadows),
    );
  }

  @override
  RemixBoxEffectLayerSpec resolve(BuildContext context) =>
      RemixBoxEffectLayerSpec(
        gradients: MixOps.resolve(context, $gradients) ?? const [],
        gradientInsets: MixOps.resolve(context, $gradientInsets) ?? const [],
        shadows: MixOps.resolve(context, $shadows) ?? const [],
      );

  @override
  List<Object?> get props => [$gradients, $gradientInsets, $shadows];
}

/// Advanced paint that augments, but does not replace, a Mix Box decoration.
@immutable
class RemixBoxEffectsSpec extends Spec<RemixBoxEffectsSpec> {
  const RemixBoxEffectsSpec({
    this.behindContent,
    this.overContent,
    this.backdropBlur = 0,
    this.outline = BorderSide.none,
    this.outlineOffset = 0,
  }) : assert(backdropBlur >= 0),
       assert(
         outlineOffset >= -double.maxFinite &&
             outlineOffset <= double.maxFinite,
       );

  final RemixBoxEffectLayerSpec? behindContent;
  final RemixBoxEffectLayerSpec? overContent;
  final double backdropBlur;
  final BorderSide outline;
  final double outlineOffset;

  /// Whether this aggregate contributes no advanced paint.
  bool get isEmpty =>
      (behindContent == null || behindContent!.isEmpty) &&
      (overContent == null || overContent!.isEmpty) &&
      backdropBlur == 0 &&
      (outline.style == BorderStyle.none || outline.width == 0);

  RemixBoxEffectsSpec merge(RemixBoxEffectsSpec? other) {
    if (other == null) return this;
    final hasOutline = other.outline.style != BorderStyle.none;
    return RemixBoxEffectsSpec(
      behindContent: other.behindContent ?? behindContent,
      overContent: other.overContent ?? overContent,
      backdropBlur: other.backdropBlur == 0 ? backdropBlur : other.backdropBlur,
      outline: hasOutline ? other.outline : outline,
      outlineOffset: hasOutline ? other.outlineOffset : outlineOffset,
    );
  }

  static RemixBoxEffectsSpec? lerpNullable(
    RemixBoxEffectsSpec? begin,
    RemixBoxEffectsSpec? end,
    double t,
  ) {
    if (begin == null && end == null) return null;
    if (begin == null) {
      if (t <= 0) return null;
      if (t >= 1) return end;
      return RemixBoxEffectsSpec().lerp(end, t);
    }
    if (end == null) {
      if (t <= 0) return begin;
      if (t >= 1) return null;
      return begin.lerp(RemixBoxEffectsSpec(), t);
    }
    return begin.lerp(end, t);
  }

  @override
  RemixBoxEffectsSpec copyWith({
    RemixBoxEffectLayerSpec? behindContent,
    RemixBoxEffectLayerSpec? overContent,
    double? backdropBlur,
    BorderSide? outline,
    double? outlineOffset,
  }) => RemixBoxEffectsSpec(
    behindContent: behindContent ?? this.behindContent,
    overContent: overContent ?? this.overContent,
    backdropBlur: backdropBlur ?? this.backdropBlur,
    outline: outline ?? this.outline,
    outlineOffset: outlineOffset ?? this.outlineOffset,
  );

  @override
  RemixBoxEffectsSpec lerp(RemixBoxEffectsSpec? other, double t) {
    if (other == null) return this;
    return RemixBoxEffectsSpec(
      behindContent: RemixBoxEffectLayerSpec.lerpNullable(
        behindContent,
        other.behindContent,
        t,
      ),
      overContent: RemixBoxEffectLayerSpec.lerpNullable(
        overContent,
        other.overContent,
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
    behindContent,
    overContent,
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

/// Mix representation of [RemixBoxEffectsSpec].
@immutable
class RemixBoxEffectsMix extends Mix<RemixBoxEffectsSpec> {
  RemixBoxEffectsMix({
    RemixBoxEffectLayerMix? behindContent,
    RemixBoxEffectLayerMix? overContent,
    double? backdropBlur,
    BorderSideMix? outline,
    double? outlineOffset,
  }) : this.create(
         behindContent: Prop.maybeMix(behindContent),
         overContent: Prop.maybeMix(overContent),
         backdropBlur: Prop.maybe(backdropBlur),
         outline: Prop.maybeMix(outline),
         outlineOffset: Prop.maybe(outlineOffset),
       );

  const RemixBoxEffectsMix.create({
    Prop<RemixBoxEffectLayerSpec>? behindContent,
    Prop<RemixBoxEffectLayerSpec>? overContent,
    Prop<double>? backdropBlur,
    Prop<BorderSide>? outline,
    Prop<double>? outlineOffset,
  }) : $behindContent = behindContent,
       $overContent = overContent,
       $backdropBlur = backdropBlur,
       $outline = outline,
       $outlineOffset = outlineOffset;

  final Prop<RemixBoxEffectLayerSpec>? $behindContent;
  final Prop<RemixBoxEffectLayerSpec>? $overContent;
  final Prop<double>? $backdropBlur;
  final Prop<BorderSide>? $outline;
  final Prop<double>? $outlineOffset;

  @override
  RemixBoxEffectsMix merge(RemixBoxEffectsMix? other) {
    if (other == null) return this;
    return RemixBoxEffectsMix.create(
      behindContent: MixOps.merge($behindContent, other.$behindContent),
      overContent: MixOps.merge($overContent, other.$overContent),
      backdropBlur: MixOps.merge($backdropBlur, other.$backdropBlur),
      outline: MixOps.merge($outline, other.$outline),
      outlineOffset: MixOps.merge($outlineOffset, other.$outlineOffset),
    );
  }

  @override
  RemixBoxEffectsSpec resolve(BuildContext context) => RemixBoxEffectsSpec(
    behindContent: MixOps.resolve(context, $behindContent),
    overContent: MixOps.resolve(context, $overContent),
    backdropBlur: MixOps.resolve(context, $backdropBlur) ?? 0,
    outline: MixOps.resolve(context, $outline) ?? BorderSide.none,
    outlineOffset: MixOps.resolve(context, $outlineOffset) ?? 0,
  );

  @override
  List<Object?> get props => [
    $behindContent,
    $overContent,
    $backdropBlur,
    $outline,
    $outlineOffset,
  ];
}
