import 'package:flutter/material.dart';
import '../ui/ui.dart';

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
  final UiAccentColor accentColor;
  final UiGrayColor grayColor;
  final UiPanelBackground panelBackground;
  final UiRadius radius;
  final UiScaling scaling;

  ThemeMode get themeMode => appearance;

  // ThemeMode.system is app state rather than a UiThemeConfig value, so the
  // dashboard keeps a concrete settings object that can be copied atomically.
  ThemeSettings copyWith({
    ThemeMode? appearance,
    UiAccentColor? accentColor,
    UiGrayColor? grayColor,
    UiPanelBackground? panelBackground,
    UiRadius? radius,
    UiScaling? scaling,
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
