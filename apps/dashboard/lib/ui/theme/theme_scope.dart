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
/// `--default-font-weight`. Those resolve to exactly [UiTokens.text3] plus
/// [UiTokens.gray12] at regular weight.
///
/// Ui text recipes resolve and pin their own runs. This fallback keeps
/// deliberately bare [Text] descendants aligned with Radix's root typography
/// and neutral foreground. A nearer descendant `DefaultTextStyle` still wins
/// through Flutter's normal inheritance.
///
/// Only the outermost [UiScope] installs this. A nested scope re-scopes
/// tokens for its subtree and nothing more: upstream, `.radix-themes` inside
/// another `.radix-themes` still inherits `color` and the font properties from
/// its parent chain, and a nested scope that reinstalled the root run here
/// would silently replace whatever `DefaultTextStyle` the subtree sits in.
///
/// The font family is deliberately left unset. Radix's `--default-font-family`
/// is the platform system stack, and a null family is Flutter's equivalent;
/// naming a concrete family here would pin every consumer to one typeface.
Widget _uiRootTextStyle({
  required Map<MixToken<Object?>, Object> tokens,
  required Widget child,
}) {
  final root = tokens[UiTokens.text3]! as TextStyle;

  return DefaultTextStyle(
    style: root.copyWith(
      color: tokens[UiTokens.gray12]! as Color,
      fontWeight: tokens[UiTokens.fontWeightRegular]! as FontWeight,
    ),
    child: child,
  );
}

/// Widget that provides Ui design tokens to its subtree via [MixScope].
///
/// Place [UiScope] below the application host so its text defaults apply.
/// For a routed app, wrap the navigator in the host's builder. This also keeps
/// [UiTokens] available to routes and dialogs.
///
/// ```dart
/// MaterialApp(
///   builder: (_, child) => UiScope(child: child!),
///   home: const HomePage(),
/// )
/// ```
class UiScope extends StatelessWidget {
  const UiScope({
    super.key,
    this.accent,
    this.gray,
    this.brightness,
    this.panelBackground,
    this.radius,
    this.scaling,
    this.hasBackground,
    this.orderOfModifiers,
    required this.child,
  });

  final UiAccentColor? accent;
  final UiGrayColor? gray;
  final Brightness? brightness;
  final UiPanelBackground? panelBackground;
  final UiRadius? radius;
  final UiScaling? scaling;
  final bool? hasBackground;
  final List<Type>? orderOfModifiers;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final config = UiThemeConfig(
      accent: accent,
      gray: gray,
      brightness: brightness,
      panelBackground: panelBackground,
      radius: radius,
      scaling: scaling,
      hasBackground: hasBackground,
    );
    final parent = UiTheme.maybeOf(context);
    final data = _resolveUiTheme(config, parent: parent);
    final tokens = buildUiScopeTokens(data);
    Widget result = MixScope(
      tokens: tokens,
      orderOfModifiers: orderOfModifiers,
      // Theme-root identity, not `hasBackground`, decides who owns the text
      // run: a scope nested for its accent or scaling must leave the current
      // run alone, while a root scope with `hasBackground: false` still
      // establishes it.
      child: parent == null
          ? _uiRootTextStyle(tokens: tokens, child: child)
          : child,
    );
    if (data.hasBackground) {
      result = ColoredBox(
        color: tokens[UiTokens.colorBackground]! as Color,
        child: result,
      );
    }

    return UiTheme(
      data: data,
      orderOfModifiers: orderOfModifiers,
      child: result,
    );
  }
}

UiThemeData _resolveUiTheme(UiThemeConfig config, {UiThemeData? parent}) {
  final accent = config.accent ?? parent?.accent ?? UiAccentColor.indigo;

  return UiThemeData(
    accent: accent,
    gray: config.gray ?? parent?.gray ?? UiGrayColor.slate,
    brightness: config.brightness ?? parent?.brightness ?? Brightness.light,
    panelBackground:
        config.panelBackground ??
        parent?.panelBackground ??
        UiPanelBackground.translucent,
    radius: config.radius ?? parent?.radius ?? UiRadius.medium,
    scaling: config.scaling ?? parent?.scaling ?? UiScaling.percent100,
    hasBackground: config.hasBackground ?? parent == null,
  );
}

/// Makes the active [UiThemeData] available to descendants.
class UiTheme extends InheritedTheme {
  const UiTheme({
    super.key,
    required this.data,
    this.orderOfModifiers,
    required super.child,
  });

  final UiThemeData data;
  final List<Type>? orderOfModifiers;

  /// Returns the closest resolved Ui theme.
  static UiThemeData of(BuildContext context) {
    final data = maybeOf(context);
    if (data != null) return data;
    throw FlutterError.fromParts([
      ErrorSummary('No UiTheme found.'),
      ErrorDescription(
        '${context.widget.runtimeType} tried to read the Ui theme, but no UiScope was found above it.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  /// Returns the closest resolved Ui theme, if one is available.
  static UiThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UiTheme>()?.data;

  /// Rebuilds only the theme and its Mix tokens.
  ///
  /// The captured subtree's text run is *not* synthesized here.
  /// `DefaultTextStyle` is itself an [InheritedTheme], so
  /// `InheritedTheme.capture` already carries the actual nearest ambient run
  /// across to the new route; installing the Radix root run alongside it would
  /// overwrite that capture with a value the source context never had.
  @override
  Widget wrap(BuildContext context, Widget child) => UiTheme(
    data: data,
    orderOfModifiers: orderOfModifiers,
    child: MixScope(
      tokens: buildUiScopeTokens(data),
      orderOfModifiers: orderOfModifiers,
      child: child,
    ),
  );

  @override
  bool updateShouldNotify(UiTheme oldWidget) => data != oldWidget.data;
}
