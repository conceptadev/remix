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
/// Each supplied theme replaces the values for its appearance. An empty nested
/// scope inherits the parent pair and selection; individual tokens do not merge.
class PlaygroundThemeScope extends StatelessWidget {
  /// A root follows the system and supplies both preset defaults.
  /// A custom theme without darkTheme is used in both modes.
  /// Nested scopes inherit the configured pair and active selection.
  const PlaygroundThemeScope({
    super.key,
    this.theme,
    this.darkTheme,
    this.mode,
    this.data,
    required this.child,
  }) : assert(
         data == null || (theme == null && darkTheme == null && mode == null),
         'Use data for a fixed theme, or theme/darkTheme/mode for appearance selection.',
       );

  final PlaygroundThemeData? theme;
  final PlaygroundThemeData? darkTheme;
  final PlaygroundThemeMode? mode;

  /// Compatibility shorthand for installing one fixed, resolved theme.
  final PlaygroundThemeData? data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final view = View.maybeOf(context);
    if (MediaQuery.maybeOf(context) == null && view != null) {
      return MediaQuery.fromView(
        view: view,
        child: Builder(builder: _build),
      );
    }
    return _build(context);
  }

  Widget _build(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<PlaygroundTheme>();
    final base =
        data ??
        theme ??
        inherited?.baseTheme ??
        inherited?.data ??
        const PlaygroundThemeData.light();
    final dark =
        data ??
        darkTheme ??
        (theme != null
            ? theme!
            : inherited?.darkTheme ??
                  inherited?.data ??
                  const PlaygroundThemeData.dark());
    final useDark = data != null
        ? data!.brightness == Brightness.dark
        : mode == null && inherited != null
        ? inherited.usesDarkTheme
        : switch (mode ?? PlaygroundThemeMode.system) {
            PlaygroundThemeMode.light => false,
            PlaygroundThemeMode.dark => true,
            PlaygroundThemeMode.system =>
              (MediaQuery.maybePlatformBrightnessOf(context) ??
                      Brightness.light) ==
                  Brightness.dark,
          };
    final selected = useDark ? dark : base;
    return PlaygroundTheme(
      data: selected,
      baseTheme: base,
      darkTheme: dark,
      useDarkTheme: useDark,
      child: MixScope(tokens: selected.tokens, child: child),
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
  const PlaygroundTheme({
    super.key,
    required this.data,
    this.baseTheme,
    this.darkTheme,
    this.useDarkTheme,
    required super.child,
  });

  /// The theme values available to [child].
  final PlaygroundThemeData data;
  final PlaygroundThemeData? baseTheme;
  final PlaygroundThemeData? darkTheme;
  final bool? useDarkTheme;
  bool get usesDarkTheme => useDarkTheme ?? data.brightness == Brightness.dark;

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
      baseTheme: baseTheme,
      darkTheme: darkTheme,
      useDarkTheme: useDarkTheme,
      child: MixScope(tokens: data.tokens, child: child),
    );
  }

  @override
  bool updateShouldNotify(PlaygroundTheme oldWidget) =>
      data != oldWidget.data ||
      baseTheme != oldWidget.baseTheme ||
      darkTheme != oldWidget.darkTheme ||
      useDarkTheme != oldWidget.useDarkTheme;
}
