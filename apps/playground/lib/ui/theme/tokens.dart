import 'package:remix/remix.dart';

/// Semantic design tokens owned by the application.
///
/// Remix ships no theme, so the names below are the application's vocabulary,
/// not a Remix contract. A [MixToken] is only an identity: the concrete value
/// comes from whichever `MixScope` is active, which `PlaygroundThemeScope` installs
/// from a `PlaygroundThemeData`. Editing, renaming, or adding a token here is a
/// local change — nothing in Remix reads these names.
///
/// ```dart
/// ButtonStyler().color(PlaygroundTokens.primary());
/// ```
abstract final class PlaygroundTokens {
  /// Page background the application paints behind its content.
  static const background = ColorToken('ui.color.background');

  /// Default content color used on top of [background].
  static const foreground = ColorToken('ui.color.foreground');

  /// Highest-emphasis fill.
  static const primary = ColorToken('ui.color.primary');

  /// Content color used on top of [primary].
  static const primaryForeground = ColorToken('ui.color.primary-foreground');

  /// Medium-emphasis fill.
  static const secondary = ColorToken('ui.color.secondary');

  /// Content color used on top of [secondary].
  static const secondaryForeground = ColorToken(
    'ui.color.secondary-foreground',
  );

  /// De-emphasized surface.
  static const muted = ColorToken('ui.color.muted');

  /// Content color used on top of [muted].
  static const mutedForeground = ColorToken('ui.color.muted-foreground');

  /// Interaction surface for otherwise transparent controls.
  static const accent = ColorToken('ui.color.accent');

  /// Content color used on top of [accent].
  static const accentForeground = ColorToken('ui.color.accent-foreground');

  /// Destructive fill for irreversible actions.
  static const destructive = ColorToken('ui.color.destructive');

  /// Content color used on top of [destructive].
  static const destructiveForeground = ColorToken(
    'ui.color.destructive-foreground',
  );

  /// Hairline separator and control outline color.
  static const border = ColorToken('ui.color.border');

  /// Focus ring color drawn for keyboard focus.
  static const focusRing = ColorToken('ui.color.focus-ring');

  /// Corner radius shared by the application's controls.
  static const radius = RadiusToken('ui.radius');

  /// Every color token this layer defines, in declaration order.
  ///
  /// `PlaygroundThemeData` builds its scope map from this list, so a token added here
  /// and to `PlaygroundThemeData` cannot be forgotten in the scope.
  static const colors = <ColorToken>[
    background,
    foreground,
    primary,
    primaryForeground,
    secondary,
    secondaryForeground,
    muted,
    mutedForeground,
    accent,
    accentForeground,
    destructive,
    destructiveForeground,
    border,
    focusRing,
  ];
}
