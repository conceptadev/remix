import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'tokens.dart';

/// The concrete values behind [UiTokens] for one brightness.
///
/// This is application-owned data: change a hex value, add a field, or drop
/// one, and only this layer moves. `UiThemeScope` turns an instance into the
/// `MixScope` token map that every recipe resolves against.
@immutable
class UiThemeData {
  /// Creates a theme with an explicit value for every token.
  const UiThemeData({
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
  const UiThemeData.light()
    : background = const Color(0xFFFFFFFF),
      foreground = const Color(0xFF171717),
      primary = const Color(0xFF171717),
      primaryForeground = const Color(0xFFFAFAFA),
      secondary = const Color(0xFFF5F5F5),
      secondaryForeground = const Color(0xFF171717),
      muted = const Color(0xFFF5F5F5),
      mutedForeground = const Color(0xFF737373),
      accent = const Color(0xFFE5E5E5),
      accentForeground = const Color(0xFF171717),
      destructive = const Color(0xFFB91C1C),
      destructiveForeground = const Color(0xFFFFFFFF),
      border = const Color(0xFFE5E5E5),
      focusRing = const Color(0xFF737373),
      radius = const Radius.circular(8);

  /// The neutral dark theme.
  const UiThemeData.dark()
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

  /// Value for [UiTokens.background].
  final Color background;

  /// Value for [UiTokens.foreground].
  final Color foreground;

  /// Value for [UiTokens.primary].
  final Color primary;

  /// Value for [UiTokens.primaryForeground].
  final Color primaryForeground;

  /// Value for [UiTokens.secondary].
  final Color secondary;

  /// Value for [UiTokens.secondaryForeground].
  final Color secondaryForeground;

  /// Value for [UiTokens.muted].
  final Color muted;

  /// Value for [UiTokens.mutedForeground].
  final Color mutedForeground;

  /// Value for [UiTokens.accent].
  final Color accent;

  /// Value for [UiTokens.accentForeground].
  final Color accentForeground;

  /// Value for [UiTokens.destructive].
  final Color destructive;

  /// Value for [UiTokens.destructiveForeground].
  final Color destructiveForeground;

  /// Value for [UiTokens.border].
  final Color border;

  /// Value for [UiTokens.focusRing].
  final Color focusRing;

  /// Value for [UiTokens.radius].
  final Radius radius;

  /// This theme's values keyed by the token that resolves them.
  ///
  /// Returned unmodifiable so a caller cannot mutate a theme that widgets
  /// already read from; use [copyWith] to derive a changed theme instead.
  Map<MixToken<Object?>, Object> get tokens =>
      Map<MixToken<Object?>, Object>.unmodifiable(<MixToken<Object?>, Object>{
        UiTokens.background: background,
        UiTokens.foreground: foreground,
        UiTokens.primary: primary,
        UiTokens.primaryForeground: primaryForeground,
        UiTokens.secondary: secondary,
        UiTokens.secondaryForeground: secondaryForeground,
        UiTokens.muted: muted,
        UiTokens.mutedForeground: mutedForeground,
        UiTokens.accent: accent,
        UiTokens.accentForeground: accentForeground,
        UiTokens.destructive: destructive,
        UiTokens.destructiveForeground: destructiveForeground,
        UiTokens.border: border,
        UiTokens.focusRing: focusRing,
        UiTokens.radius: radius,
      });

  /// Returns a copy of this theme with the given values replaced.
  UiThemeData copyWith({
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
  }) => UiThemeData(
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
      other is UiThemeData && listEquals(other._fields, _fields);

  @override
  int get hashCode => Object.hashAll(_fields);

  @override
  String toString() => 'UiThemeData(background: $background, radius: $radius)';
}
