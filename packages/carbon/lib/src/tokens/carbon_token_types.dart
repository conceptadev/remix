import 'package:flutter/widgets.dart';

/// Plain, dependency-light data holders shared by the generated token files and
/// the runtime foundation. Kept in a leaf module (no imports beyond Flutter) so
/// both `generated/*.g.dart` and `foundation/*` can depend on it without cycles.

/// A responsive breakpoint from `@carbon/layout`.
@immutable
class CarbonBreakpointData {
  const CarbonBreakpointData({
    required this.name,
    required this.width,
    required this.columns,
    required this.margin,
  });

  /// Carbon breakpoint key (`sm`, `md`, `lg`, `xlg`, `max`).
  final String name;

  /// Minimum viewport width, in logical pixels, at which the breakpoint applies.
  final double width;

  /// Number of grid columns at this breakpoint.
  final int columns;

  /// Grid margin, in logical pixels, at this breakpoint.
  final double margin;
}

/// The unit a fluid spacing step is expressed in.
enum CarbonSpaceUnit { px, vw }

/// A fluid spacing step: either a fixed pixel value or a viewport-relative one.
@immutable
class CarbonFluidSpaceData {
  const CarbonFluidSpaceData(this.value, this.unit);

  final double value;
  final CarbonSpaceUnit unit;

  /// Resolves against a viewport [width] (logical pixels).
  double resolve(double width) => unit == .vw ? width * value / 100.0 : value;
}

/// One (possibly partial) set of text-style measurements. Fields are nullable so
/// fluid breakpoint overrides can carry only the properties Carbon changes.
@immutable
class CarbonTextStyleData {
  const CarbonTextStyleData({
    this.fontSize,
    this.fontWeight,
    this.lineHeight,
    this.letterSpacing,
  });

  /// Font size in logical pixels.
  final double? fontSize;

  /// CSS numeric font weight (300/400/600).
  final int? fontWeight;

  /// Line height as a ratio (Flutter `TextStyle.height`).
  final double? lineHeight;

  /// Letter spacing in logical pixels.
  final double? letterSpacing;

  /// The CSS numeric weight as a Flutter [FontWeight] (100–900 supported).
  FontWeight? get flutterFontWeight {
    final weight = fontWeight;
    if (weight == null) return null;

    return switch ((weight ~/ 100).clamp(1, 9)) {
      1 => FontWeight.w100,
      2 => FontWeight.w200,
      3 => FontWeight.w300,
      4 => FontWeight.w400,
      5 => FontWeight.w500,
      6 => FontWeight.w600,
      7 => FontWeight.w700,
      8 => FontWeight.w800,
      _ => FontWeight.w900,
    };
  }

  /// Returns a copy where [other]'s non-null fields replace this style's.
  ///
  /// The single merge rule used by the fluid breakpoint resolver.
  CarbonTextStyleData merge(CarbonTextStyleData other) => .new(
    fontSize: other.fontSize ?? fontSize,
    fontWeight: other.fontWeight ?? fontWeight,
    lineHeight: other.lineHeight ?? lineHeight,
    letterSpacing: other.letterSpacing ?? letterSpacing,
  );

  /// Builds a Flutter [TextStyle] from these measurements.
  TextStyle toTextStyle({String? fontFamily}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: flutterFontWeight,
      height: lineHeight,
      letterSpacing: letterSpacing,
    );
  }
}

/// A responsive Carbon type style with a base and per-breakpoint overrides.
@immutable
class CarbonFluidTypeStyle {
  const CarbonFluidTypeStyle({required this.base, required this.breakpoints});

  final CarbonTextStyleData base;

  /// Overrides keyed by Carbon breakpoint (`md`, `lg`, `xlg`, `max`).
  final Map<String, CarbonTextStyleData> breakpoints;

  /// Resolves the effective style at a viewport [width], applying every override
  /// whose breakpoint has been reached (breakpoints are cumulative in Carbon).
  CarbonTextStyleData resolveAt(double width, List<CarbonBreakpointData> bps) {
    var effective = base;
    for (final bp in bps) {
      final override = width >= bp.width ? breakpoints[bp.name] : null;
      if (override != null) effective = effective.merge(override);
    }

    return effective;
  }
}
