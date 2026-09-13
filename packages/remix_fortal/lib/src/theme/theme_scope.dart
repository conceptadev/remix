import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'theme_data.dart';
import 'tokens.dart';

/// Establishes a courtesy default text run for bare [Text] descendants.
///
/// `.radix-themes` is not only a token carrier upstream: `color.css` sets
/// `color: var(--gray-12)` in the same rule as the `data-has-background` fill,
/// and `typography.css` pins the root to `--default-font-size`
/// (`--font-size-3`), `--default-line-height`, `--default-letter-spacing`, and
/// `--default-font-weight`. Those resolve to exactly [FortalTokens.text3] plus
/// [FortalTokens.gray12] at regular weight.
///
/// Fortal text recipes resolve and pin their own runs. This fallback keeps
/// deliberately bare [Text] descendants aligned with Radix's root typography
/// and neutral foreground. A nearer descendant `DefaultTextStyle` still wins
/// through Flutter's normal inheritance.
///
/// Only the outermost [FortalScope] installs this. A nested scope re-scopes
/// tokens for its subtree and nothing more: upstream, `.radix-themes` inside
/// another `.radix-themes` still inherits `color` and the font properties from
/// its parent chain, and a nested scope that reinstalled the root run here
/// would silently replace whatever `DefaultTextStyle` the subtree sits in.
///
/// The font family is deliberately left unset. Radix's `--default-font-family`
/// is the platform system stack, and a null family is Flutter's equivalent;
/// naming a concrete family here would pin every consumer to one typeface.
Widget _fortalRootTextStyle({
  required Map<MixToken<Object?>, Object> tokens,
  required Widget child,
}) {
  final root = tokens[FortalTokens.text3]! as TextStyle;

  return DefaultTextStyle(
    style: root.copyWith(
      color: tokens[FortalTokens.gray12]! as Color,
      fontWeight: tokens[FortalTokens.fontWeightRegular]! as FontWeight,
    ),
    child: child,
  );
}

/// Widget that provides Fortal design tokens to its subtree via [MixScope].
///
/// Place [FortalScope] below the application host so its text defaults apply.
/// For a routed app, wrap the navigator in the host's builder. This also keeps
/// [FortalTokens] available to routes and dialogs.
///
/// ```dart
/// WidgetsApp(
///   color: const Color(0xFFF8FAFC),
///   pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
///     settings: settings,
///     pageBuilder: (context, animation, secondaryAnimation) => builder(context),
///   ),
///   builder: (_, child) => FortalScope(child: child!),
///   home: const HomePage(),
/// )
/// ```
class FortalScope extends StatelessWidget {
  const FortalScope({
    super.key,
    this.theme,
    this.darkTheme,
    this.mode,
    this.accent,
    this.gray,
    this.panelBackground,
    this.radius,
    this.scaling,
    this.hasBackground,
    this.orderOfModifiers,
    required this.child,
  });

  /// Base appearance. Without either theme, the preset provides both defaults.
  /// If only [theme] is supplied, it is also the dark-mode fallback.
  final FortalThemeConfig? theme;
  final FortalThemeConfig? darkTheme;

  /// Omitted at a root follows the system; omitted below a scope inherits it.
  final FortalThemeMode? mode;

  final FortalAccentColor? accent;
  final FortalGrayColor? gray;
  final FortalPanelBackground? panelBackground;
  final FortalRadius? radius;
  final FortalScaling? scaling;
  final bool? hasBackground;
  final List<Type>? orderOfModifiers;
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
    final inherited = context.dependOnInheritedWidgetOfExactType<FortalTheme>();
    final parent = inherited?.data;
    final baseParent = inherited?.baseTheme ?? parent;
    final darkParent = inherited?.darkTheme ?? parent;
    FortalThemeData resolve(
      FortalThemeConfig? supplied,
      FortalThemeData? ancestor,
      Brightness fallback,
    ) {
      final config = supplied ?? const FortalThemeConfig();
      return _resolveFortalTheme(
        FortalThemeConfig(
          accent: accent ?? config.accent,
          gray: gray ?? config.gray,
          brightness: config.brightness ?? ancestor?.brightness ?? fallback,
          panelBackground: panelBackground ?? config.panelBackground,
          radius: radius ?? config.radius,
          scaling: scaling ?? config.scaling,
          hasBackground: hasBackground ?? config.hasBackground,
        ),
        parent: ancestor,
      );
    }

    final base = resolve(theme, baseParent, Brightness.light);
    final dark = darkTheme == null && theme != null
        ? base
        : resolve(darkTheme, darkParent, Brightness.dark);
    final useDark = mode == null && inherited != null
        ? inherited.usesDarkTheme
        : switch (mode ?? FortalThemeMode.system) {
            FortalThemeMode.light => false,
            FortalThemeMode.dark => true,
            FortalThemeMode.system =>
              (MediaQuery.maybePlatformBrightnessOf(context) ??
                      Brightness.light) ==
                  Brightness.dark,
          };
    final data = useDark ? dark : base;
    final tokens = buildFortalScopeTokens(data);
    Widget result = MixScope(
      tokens: tokens,
      orderOfModifiers: orderOfModifiers,
      // Theme-root identity, not `hasBackground`, decides who owns the text
      // run: a scope nested for its accent or scaling must leave the current
      // run alone, while a root scope with `hasBackground: false` still
      // establishes it.
      child: parent == null
          ? _fortalRootTextStyle(tokens: tokens, child: child)
          : child,
    );
    if (data.hasBackground) {
      result = ColoredBox(
        color: tokens[FortalTokens.colorBackground]! as Color,
        child: result,
      );
    }

    return FortalTheme(
      data: data,
      baseTheme: base,
      darkTheme: dark,
      useDarkTheme: useDark,
      orderOfModifiers: orderOfModifiers,
      child: result,
    );
  }
}

FortalThemeData _resolveFortalTheme(
  FortalThemeConfig config, {
  FortalThemeData? parent,
}) {
  final accent = config.accent ?? parent?.accent ?? FortalAccentColor.indigo;

  return FortalThemeData(
    accent: accent,
    gray: config.gray ?? parent?.gray ?? FortalGrayColor.slate,
    brightness: config.brightness ?? parent?.brightness ?? Brightness.light,
    panelBackground:
        config.panelBackground ??
        parent?.panelBackground ??
        FortalPanelBackground.translucent,
    radius: config.radius ?? parent?.radius ?? FortalRadius.medium,
    scaling: config.scaling ?? parent?.scaling ?? FortalScaling.percent100,
    hasBackground: config.hasBackground ?? parent == null,
  );
}

/// Makes the active [FortalThemeData] available to descendants.
class FortalTheme extends InheritedTheme {
  const FortalTheme({
    super.key,
    required this.data,
    this.baseTheme,
    this.darkTheme,
    this.useDarkTheme,
    this.orderOfModifiers,
    required super.child,
  });

  final FortalThemeData data;
  final FortalThemeData? baseTheme;
  final FortalThemeData? darkTheme;
  final bool? useDarkTheme;
  bool get usesDarkTheme => useDarkTheme ?? data.isDark;
  final List<Type>? orderOfModifiers;

  /// Returns the closest resolved Fortal theme.
  static FortalThemeData of(BuildContext context) {
    final data = maybeOf(context);
    if (data != null) return data;
    throw FlutterError.fromParts([
      ErrorSummary('No FortalTheme found.'),
      ErrorDescription(
        '${context.widget.runtimeType} tried to read the Fortal theme, but no FortalScope was found above it.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  /// Returns the closest resolved Fortal theme, if one is available.
  static FortalThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FortalTheme>()?.data;

  /// Rebuilds only the theme and its Mix tokens.
  ///
  /// The captured subtree's text run is *not* synthesized here.
  /// `DefaultTextStyle` is itself an [InheritedTheme], so
  /// `InheritedTheme.capture` already carries the actual nearest ambient run
  /// across to the new route; installing the Radix root run alongside it would
  /// overwrite that capture with a value the source context never had.
  @override
  Widget wrap(BuildContext context, Widget child) => FortalTheme(
    data: data,
    baseTheme: baseTheme,
    darkTheme: darkTheme,
    useDarkTheme: useDarkTheme,
    orderOfModifiers: orderOfModifiers,
    child: MixScope(
      tokens: buildFortalScopeTokens(data),
      orderOfModifiers: orderOfModifiers,
      child: child,
    ),
  );

  @override
  bool updateShouldNotify(FortalTheme oldWidget) =>
      data != oldWidget.data ||
      baseTheme != oldWidget.baseTheme ||
      darkTheme != oldWidget.darkTheme ||
      useDarkTheme != oldWidget.useDarkTheme;
}
