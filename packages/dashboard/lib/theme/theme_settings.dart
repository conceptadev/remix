import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

@immutable
class ThemeSettings {
  const ThemeSettings({
    this.appearance = .system,
    this.accentColor = .indigo,
    this.grayColor = .slate,
    this.radius = .medium,
    this.scaling = .percent100,
  });

  final ThemeMode appearance;
  final FortalAccentColor accentColor;
  final FortalGrayColor grayColor;
  final FortalRadius radius;
  final FortalScaling scaling;

  ThemeMode get themeMode => appearance;

  // ThemeMode.system is app state rather than a FortalThemeConfig value, so the
  // dashboard keeps a concrete settings object that can be copied atomically.
  ThemeSettings copyWith({
    ThemeMode? appearance,
    FortalAccentColor? accentColor,
    FortalGrayColor? grayColor,
    FortalRadius? radius,
    FortalScaling? scaling,
  }) {
    return ThemeSettings(
      appearance: appearance ?? this.appearance,
      accentColor: accentColor ?? this.accentColor,
      grayColor: grayColor ?? this.grayColor,
      radius: radius ?? this.radius,
      scaling: scaling ?? this.scaling,
    );
  }
}
