import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

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
  required Map<MixToken, Object> tokens,
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
/// Use [FortalScope] at the root of your app (or around any subtree that uses
/// Fortal styles) so that [FortalTokens] resolve to actual values.
///
/// ```dart
/// FortalScope(
///   child: WidgetsApp(...),
/// )
/// ```
class FortalScope extends StatelessWidget {
  const FortalScope({
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

  final FortalAccentColor? accent;
  final FortalGrayColor? gray;
  final Brightness? brightness;
  final FortalPanelBackground? panelBackground;
  final FortalRadius? radius;
  final FortalScaling? scaling;
  final bool? hasBackground;
  final List<Type>? orderOfModifiers;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final config = FortalThemeConfig(
      accent: accent,
      gray: gray,
      brightness: brightness,
      panelBackground: panelBackground,
      radius: radius,
      scaling: scaling,
      hasBackground: hasBackground,
    );
    final parent = FortalTheme.maybeOf(context);
    final data = _resolveFortalTheme(config, parent: parent);
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
    this.orderOfModifiers,
    required super.child,
  });

  final FortalThemeData data;
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
    orderOfModifiers: orderOfModifiers,
    child: MixScope(
      tokens: buildFortalScopeTokens(data),
      orderOfModifiers: orderOfModifiers,
      child: child,
    ),
  );

  @override
  bool updateShouldNotify(FortalTheme oldWidget) => data != oldWidget.data;
}
