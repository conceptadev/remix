import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import 'shell/dashboard_shell.dart';
import 'theme/scroll_behavior.dart';
import 'theme/theme_scope.dart';
import 'theme/theme_settings.dart';

void main() => runApp(const DashboardApp());

class DashboardApp extends StatefulWidget {
  const DashboardApp({super.key, this.initialSettings = const ThemeSettings()});

  final ThemeSettings initialSettings;

  @override
  State<DashboardApp> createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  late ThemeSettings _settings = widget.initialSettings;

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      settings: _settings,
      onChanged: (settings) => setState(() => _settings = settings),
      child: FortalScope(
        appearance: _settings.appearance,
        accentColor: _settings.accentColor,
        grayColor: _settings.grayColor,
        radius: _settings.radius,
        scaling: _settings.scaling,
        child: MaterialApp(
          title: 'Remix Dashboard',
          debugShowCheckedModeBanner: false,
          scrollBehavior: const AppScrollBehavior(),
          themeMode: _settings.themeMode,
          theme: ThemeData(brightness: .light, useMaterial3: true),
          darkTheme: ThemeData(brightness: .dark, useMaterial3: true),
          themeAnimationDuration: Duration.zero,
          home: const DashboardShell(),
        ),
      ),
    );
  }
}
