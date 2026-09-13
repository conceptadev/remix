import 'package:flutter/widgets.dart';
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

  final FortalThemeMode appearance;
  final FortalAccentColor accentColor;
  final FortalGrayColor grayColor;
  final FortalPanelBackground panelBackground;
  final FortalRadius radius;
  final FortalScaling scaling;

  // The scope resolves system appearance; the dashboard owns the preference.
  ThemeSettings copyWith({
    FortalThemeMode? appearance,
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
