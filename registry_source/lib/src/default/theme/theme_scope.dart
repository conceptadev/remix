import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'theme_data.dart';

/// Installs a [VanillaThemeData] for a subtree.
///
/// Two things are installed together on purpose:
///
/// * [VanillaTheme], so application code can read the raw values through
///   [VanillaTheme.of];
/// * a `MixScope` carrying the same values keyed by `VanillaTokens`, so every Mix
///   styler resolved below this point sees them.
///
/// Nesting a scope replaces the values for its subtree; nothing merges with
/// the ancestor, which keeps "what does this token resolve to here?" a
/// single-lookup question.
class VanillaThemeScope extends StatelessWidget {
  /// Creates a scope that provides [data] to [child].
  const VanillaThemeScope({super.key, required this.data, required this.child});

  /// The theme installed for [child].
  final VanillaThemeData data;

  /// The subtree that resolves against [data].
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return VanillaTheme(
      data: data,
      child: MixScope(tokens: data.tokens, child: child),
    );
  }
}

/// The inherited half of [VanillaThemeScope].
///
/// Prefer [VanillaThemeScope]; this is public because `VanillaTheme.of` is how widgets
/// read theme values that are not expressed as Mix styles, and because
/// `InheritedTheme.wrap` has to be able to rebuild it across a route
/// boundary.
class VanillaTheme extends InheritedTheme {
  /// Creates the inherited theme holding [data].
  const VanillaTheme({super.key, required this.data, required super.child});

  /// The theme values available to [child].
  final VanillaThemeData data;

  /// The closest [VanillaThemeData], or `null` when no scope is installed.
  static VanillaThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<VanillaTheme>()?.data;

  /// The closest [VanillaThemeData].
  ///
  /// Throws when no [VanillaThemeScope] is installed above [context]; use
  /// [maybeOf] when absence is a valid state.
  static VanillaThemeData of(BuildContext context) {
    final data = maybeOf(context);
    if (data != null) return data;

    throw FlutterError.fromParts([
      ErrorSummary('No VanillaTheme found.'),
      ErrorDescription(
        '${context.widget.runtimeType} tried to read the UI theme, but no '
        'VanillaThemeScope was found above it.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  /// Rebuilds the theme *and* its Mix scope for a captured subtree.
  ///
  /// `InheritedTheme.capture` only carries `InheritedTheme`s across a route
  /// boundary. `MixScope` is a plain `InheritedModel`, so without rebuilding
  /// it here a captured subtree would keep the theme values and lose the
  /// token values that recipes actually resolve.
  @override
  Widget wrap(BuildContext context, Widget child) {
    return VanillaTheme(
      data: data,
      child: MixScope(tokens: data.tokens, child: child),
    );
  }

  @override
  bool updateShouldNotify(VanillaTheme oldWidget) => data != oldWidget.data;
}
