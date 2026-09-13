import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'theme_data.dart';

/// Installs a [UiThemeData] for a subtree.
///
/// Two things are installed together on purpose:
///
/// * [UiTheme], so application code can read the raw values through
///   [UiTheme.of];
/// * a `MixScope` carrying the same values keyed by `UiTokens`, so every Mix
///   styler resolved below this point sees them.
///
/// Each supplied theme replaces the values for its appearance. An empty nested
/// scope inherits the parent pair and selection; individual tokens do not merge.
class UiThemeScope extends StatelessWidget {
  /// A root follows the system and supplies both preset defaults.
  /// A custom theme without darkTheme is used in both modes.
  /// Nested scopes inherit the configured pair and active selection.
  const UiThemeScope({
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

  final UiThemeData? theme;
  final UiThemeData? darkTheme;
  final UiThemeMode? mode;

  /// Compatibility shorthand for installing one fixed, resolved theme.
  final UiThemeData? data;
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
    final inherited = context.dependOnInheritedWidgetOfExactType<UiTheme>();
    final base =
        data ??
        theme ??
        inherited?.baseTheme ??
        inherited?.data ??
        const UiThemeData.light();
    final dark =
        data ??
        darkTheme ??
        (theme != null
            ? theme!
            : inherited?.darkTheme ??
                  inherited?.data ??
                  const UiThemeData.dark());
    final useDark = data != null
        ? data!.brightness == Brightness.dark
        : mode == null && inherited != null
        ? inherited.usesDarkTheme
        : switch (mode ?? UiThemeMode.system) {
            UiThemeMode.light => false,
            UiThemeMode.dark => true,
            UiThemeMode.system =>
              (MediaQuery.maybePlatformBrightnessOf(context) ??
                      Brightness.light) ==
                  Brightness.dark,
          };
    final selected = useDark ? dark : base;
    return UiTheme(
      data: selected,
      baseTheme: base,
      darkTheme: dark,
      useDarkTheme: useDark,
      child: MixScope(tokens: selected.tokens, child: child),
    );
  }
}

/// The inherited half of [UiThemeScope].
///
/// Prefer [UiThemeScope]; this is public because `UiTheme.of` is how widgets
/// read theme values that are not expressed as Mix styles, and because
/// `InheritedTheme.wrap` has to be able to rebuild it across a route
/// boundary.
class UiTheme extends InheritedTheme {
  /// Creates the inherited theme holding [data].
  const UiTheme({
    super.key,
    required this.data,
    this.baseTheme,
    this.darkTheme,
    this.useDarkTheme,
    required super.child,
  });

  /// The theme values available to [child].
  final UiThemeData data;
  final UiThemeData? baseTheme;
  final UiThemeData? darkTheme;
  final bool? useDarkTheme;
  bool get usesDarkTheme => useDarkTheme ?? data.brightness == Brightness.dark;

  /// The closest [UiThemeData], or `null` when no scope is installed.
  static UiThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UiTheme>()?.data;

  /// The closest [UiThemeData].
  ///
  /// Throws when no [UiThemeScope] is installed above [context]; use
  /// [maybeOf] when absence is a valid state.
  static UiThemeData of(BuildContext context) {
    final data = maybeOf(context);
    if (data != null) return data;

    throw FlutterError.fromParts([
      ErrorSummary('No UiTheme found.'),
      ErrorDescription(
        '${context.widget.runtimeType} tried to read the UI theme, but no '
        'UiThemeScope was found above it.',
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
    return UiTheme(
      data: data,
      baseTheme: baseTheme,
      darkTheme: darkTheme,
      useDarkTheme: useDarkTheme,
      child: MixScope(tokens: data.tokens, child: child),
    );
  }

  @override
  bool updateShouldNotify(UiTheme oldWidget) =>
      data != oldWidget.data ||
      baseTheme != oldWidget.baseTheme ||
      darkTheme != oldWidget.darkTheme ||
      useDarkTheme != oldWidget.useDarkTheme;
}
