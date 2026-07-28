import 'package:flutter/widgets.dart';

import 'theme_settings.dart';

class ThemeScope extends InheritedWidget {
  const ThemeScope({
    super.key,
    required this.settings,
    required this.onChanged,
    required super.child,
  });

  final ThemeSettings settings;
  final ValueChanged<ThemeSettings> onChanged;

  static ThemeScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'ThemeScope is missing above this context.');
    return scope!;
  }

  @override
  bool updateShouldNotify(ThemeScope oldWidget) =>
      settings != oldWidget.settings || onChanged != oldWidget.onChanged;
}
