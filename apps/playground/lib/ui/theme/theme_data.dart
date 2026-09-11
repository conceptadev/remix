import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'tokens.dart';

/// The concrete values behind [PlaygroundTokens] for one brightness.
///
/// This is application-owned data: change a hex value, add a field, or drop
/// one, and only this layer moves. `PlaygroundThemeScope` turns an instance into the
/// `MixScope` token map that every recipe resolves against.
@immutable
class PlaygroundThemeData {
  /// Creates a theme with an explicit value for every token.
  const PlaygroundThemeData({
    required this.background,
    required this.foreground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.muted,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.border,
    required this.focusRing,
    required this.radius,
  });

  /// The neutral light theme.
  const PlaygroundThemeData.light()
    : background = const Color(0xFFFFFFFF),
      foreground = const Color(0xFF171717),
      primary = const Color(0xFF4F46E5),
      primaryForeground = const Color(0xFFFFFFFF),
      secondary = const Color(0xFFF5F5F5),
      secondaryForeground = const Color(0xFF171717),
      muted = const Color(0xFFF5F5F5),
      mutedForeground = const Color(0xFF737373),
      accent = const Color(0xFFE5E5E5),
      accentForeground = const Color(0xFF171717),
      destructive = const Color(0xFFB91C1C),
      destructiveForeground = const Color(0xFFFFFFFF),
      border = const Color(0xFFE5E5E5),
      focusRing = const Color(0xFF4F46E5),
      radius = const Radius.circular(8);

  /// The neutral dark theme.
  const PlaygroundThemeData.dark()
    : background = const Color(0xFF0A0A0A),
      foreground = const Color(0xFFFAFAFA),
      primary = const Color(0xFFFAFAFA),
      primaryForeground = const Color(0xFF171717),
      secondary = const Color(0xFF262626),
      secondaryForeground = const Color(0xFFFAFAFA),
      muted = const Color(0xFF262626),
      mutedForeground = const Color(0xFFA3A3A3),
      accent = const Color(0xFF404040),
      accentForeground = const Color(0xFFFAFAFA),
      destructive = const Color(0xFFDC2626),
      destructiveForeground = const Color(0xFFFFFFFF),
      border = const Color(0xFF404040),
      focusRing = const Color(0xFFA3A3A3),
      radius = const Radius.circular(8);

  /// Value for [PlaygroundTokens.background].
  final Color background;

  /// Value for [PlaygroundTokens.foreground].
  final Color foreground;

  /// Value for [PlaygroundTokens.primary].
  final Color primary;

  /// Value for [PlaygroundTokens.primaryForeground].
  final Color primaryForeground;

  /// Value for [PlaygroundTokens.secondary].
  final Color secondary;

  /// Value for [PlaygroundTokens.secondaryForeground].
  final Color secondaryForeground;

  /// Value for [PlaygroundTokens.muted].
  final Color muted;

  /// Value for [PlaygroundTokens.mutedForeground].
  final Color mutedForeground;

  /// Value for [PlaygroundTokens.accent].
  final Color accent;

  /// Value for [PlaygroundTokens.accentForeground].
  final Color accentForeground;

  /// Value for [PlaygroundTokens.destructive].
  final Color destructive;

  /// Value for [PlaygroundTokens.destructiveForeground].
  final Color destructiveForeground;

  /// Value for [PlaygroundTokens.border].
  final Color border;

  /// Value for [PlaygroundTokens.focusRing].
  final Color focusRing;

  /// Value for [PlaygroundTokens.radius].
  final Radius radius;

  /// This theme's values keyed by the token that resolves them.
  ///
  /// Returned unmodifiable so a caller cannot mutate a theme that widgets
  /// already read from; use [copyWith] to derive a changed theme instead.
  Map<MixToken<Object?>, Object> get tokens =>
      Map<MixToken<Object?>, Object>.unmodifiable(<MixToken<Object?>, Object>{
        PlaygroundTokens.background: background,
        PlaygroundTokens.foreground: foreground,
        PlaygroundTokens.primary: primary,
        PlaygroundTokens.primaryForeground: primaryForeground,
        PlaygroundTokens.secondary: secondary,
        PlaygroundTokens.secondaryForeground: secondaryForeground,
        PlaygroundTokens.muted: muted,
        PlaygroundTokens.mutedForeground: mutedForeground,
        PlaygroundTokens.accent: accent,
        PlaygroundTokens.accentForeground: accentForeground,
        PlaygroundTokens.destructive: destructive,
        PlaygroundTokens.destructiveForeground: destructiveForeground,
        PlaygroundTokens.border: border,
        PlaygroundTokens.focusRing: focusRing,
        PlaygroundTokens.radius: radius,
      });

  /// Returns a copy of this theme with the given values replaced.
  PlaygroundThemeData copyWith({
    Color? background,
    Color? foreground,
    Color? primary,
    Color? primaryForeground,
    Color? secondary,
    Color? secondaryForeground,
    Color? muted,
    Color? mutedForeground,
    Color? accent,
    Color? accentForeground,
    Color? destructive,
    Color? destructiveForeground,
    Color? border,
    Color? focusRing,
    Radius? radius,
  }) => PlaygroundThemeData(
    background: background ?? this.background,
    foreground: foreground ?? this.foreground,
    primary: primary ?? this.primary,
    primaryForeground: primaryForeground ?? this.primaryForeground,
    secondary: secondary ?? this.secondary,
    secondaryForeground: secondaryForeground ?? this.secondaryForeground,
    muted: muted ?? this.muted,
    mutedForeground: mutedForeground ?? this.mutedForeground,
    accent: accent ?? this.accent,
    accentForeground: accentForeground ?? this.accentForeground,
    destructive: destructive ?? this.destructive,
    destructiveForeground: destructiveForeground ?? this.destructiveForeground,
    border: border ?? this.border,
    focusRing: focusRing ?? this.focusRing,
    radius: radius ?? this.radius,
  );

  List<Object?> get _fields => [
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
    radius,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaygroundThemeData && listEquals(other._fields, _fields);

  @override
  int get hashCode => Object.hashAll(_fields);

  @override
  String toString() =>
      'PlaygroundThemeData(background: $background, radius: $radius)';
}
