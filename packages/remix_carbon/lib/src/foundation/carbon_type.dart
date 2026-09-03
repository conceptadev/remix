import 'package:flutter/widgets.dart';

import '../tokens/carbon_token_types.dart';
import '../tokens/generated/carbon_layout.g.dart';
import '../tokens/generated/carbon_type.g.dart';
import 'carbon_scope.dart';

/// Access to Carbon typography.
///
/// Fixed styles are exposed as ordinary Mix text-style tokens (`CarbonTokens.body01`
/// etc.) and resolve inside a `CarbonScope`. Fluid styles change across Carbon's
/// five breakpoints and need a viewport, so they are resolved here.
class CarbonType {
  const CarbonType._();

  /// All responsive (fluid) styles, keyed by Carbon name (e.g. `fluidHeading05`).
  static const Map<String, CarbonFluidTypeStyle> fluidStyles =
      carbonFluidTypeStyles;

  /// Whether [name] is a known fluid style.
  static bool isFluid(String name) => carbonFluidTypeStyles.containsKey(name);

  /// Resolves the effective measurements of fluid style [name] at [width].
  ///
  /// Throws [ArgumentError] for an unknown [name] in every build mode, so a
  /// typo cannot silently ship as fallback body text.
  static CarbonTextStyleData resolveFluid(String name, double width) {
    final style = carbonFluidTypeStyles[name];
    if (style == null) {
      throw ArgumentError.value(name, 'name', 'Unknown fluid type style');
    }

    return style.resolveAt(width, carbonBreakpoints);
  }

  /// Builds a Flutter [TextStyle] for fluid style [name] using the viewport
  /// width from [context]. Rebuilds responsively via `MediaQuery`.
  ///
  /// When [fontFamily] is null, the enclosing `CarbonScope`'s configured
  /// font family (via `CarbonThemeOverrides.fontFamily`) is used, keeping
  /// fluid and fixed typography on the same font without re-passing it at
  /// every call site.
  static TextStyle fluidTextStyle(
    BuildContext context,
    String name, {
    String? fontFamily,
  }) {
    final width = MediaQuery.widthOf(context);
    final family = fontFamily ?? CarbonScope.overridesOf(context).fontFamily;

    return resolveFluid(name, width).toTextStyle(fontFamily: family);
  }
}
