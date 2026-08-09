import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

@immutable
class ThemeSettings {
  const ThemeSettings({
    this.appearance = .system,
    this.accentColor = .indigo,
    this.grayColor = .slate,
    this.panelBackground = .solid,
    this.radius = .medium,
    this.scaling = .percent100,
  });

  final ThemeMode appearance;
  final FortalAccentColor accentColor;
  final FortalGrayColor grayColor;
  final FortalPanelBackground panelBackground;
  final FortalRadius radius;
  final FortalScaling scaling;

  ThemeMode get themeMode => appearance;

  // ThemeMode.system is app state rather than a FortalThemeConfig value, so the
  // dashboard keeps a concrete settings object that can be copied atomically.
  ThemeSettings copyWith({
    ThemeMode? appearance,
    FortalAccentColor? accentColor,
    FortalGrayColor? grayColor,
    FortalPanelBackground? panelBackground,
    FortalRadius? radius,
    FortalScaling? scaling,
  }) {
    return ThemeSettings(
      appearance: appearance ?? this.appearance,
      accentColor: accentColor ?? this.accentColor,
      grayColor: grayColor ?? this.grayColor,
      panelBackground: panelBackground ?? this.panelBackground,
      radius: radius ?? this.radius,
      scaling: scaling ?? this.scaling,
    );
  }
}
