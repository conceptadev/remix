import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'theme_data.dart';

/// Installs a [PlaygroundThemeData] for a subtree.
///
/// Two things are installed together on purpose:
///
/// * [PlaygroundTheme], so application code can read the raw values through
///   [PlaygroundTheme.of];
/// * a `MixScope` carrying the same values keyed by `PlaygroundTokens`, so every Mix
///   styler resolved below this point sees them.
///
/// Nesting a scope replaces the values for its subtree; nothing merges with
/// the ancestor, which keeps "what does this token resolve to here?" a
/// single-lookup question.
class PlaygroundThemeScope extends StatelessWidget {
  /// Creates a scope that provides [data] to [child].
  const PlaygroundThemeScope({
    super.key,
    required this.data,
    required this.child,
  });

  /// The theme installed for [child].
  final PlaygroundThemeData data;

  /// The subtree that resolves against [data].
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PlaygroundTheme(
      data: data,
      child: MixScope(tokens: data.tokens, child: child),
    );
  }
}

/// The inherited half of [PlaygroundThemeScope].
///
/// Prefer [PlaygroundThemeScope]; this is public because `PlaygroundTheme.of` is how widgets
/// read theme values that are not expressed as Mix styles, and because
/// `InheritedTheme.wrap` has to be able to rebuild it across a route
/// boundary.
class PlaygroundTheme extends InheritedTheme {
  /// Creates the inherited theme holding [data].
  const PlaygroundTheme({super.key, required this.data, required super.child});

  /// The theme values available to [child].
  final PlaygroundThemeData data;

  /// The closest [PlaygroundThemeData], or `null` when no scope is installed.
  static PlaygroundThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PlaygroundTheme>()?.data;

  /// The closest [PlaygroundThemeData].
  ///
  /// Throws when no [PlaygroundThemeScope] is installed above [context]; use
  /// [maybeOf] when absence is a valid state.
  static PlaygroundThemeData of(BuildContext context) {
    final data = maybeOf(context);
    if (data != null) return data;

    throw FlutterError.fromParts([
      ErrorSummary('No PlaygroundTheme found.'),
      ErrorDescription(
        '${context.widget.runtimeType} tried to read the UI theme, but no '
        'PlaygroundThemeScope was found above it.',
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
    return PlaygroundTheme(
      data: data,
      child: MixScope(tokens: data.tokens, child: child),
    );
  }

  @override
  bool updateShouldNotify(PlaygroundTheme oldWidget) => data != oldWidget.data;
}
