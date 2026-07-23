import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

@immutable
class ThemeSettings {
  const ThemeSettings({
    this.appearance = .inherit,
    this.accentColor = .indigo,
    this.grayColor = .auto,
    this.radius = .medium,
    this.scaling = .percent100,
  });

  final FortalAppearance appearance;
  final FortalAccentColor accentColor;
  final FortalGrayColor grayColor;
  final FortalRadius radius;
  final FortalScaling scaling;

  ThemeMode get themeMode => switch (appearance) {
    .inherit => .system,
    .light => .light,
    .dark => .dark,
  };

  // FortalThemeConfig is intentionally nullable and has no copyWith. Keeping
  // app-owned, concrete settings prevents theme changes from losing values.
  ThemeSettings copyWith({
    FortalAppearance? appearance,
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
