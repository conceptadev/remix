import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

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

class _DashboardAppState extends State<DashboardApp>
    with WidgetsBindingObserver {
  late ThemeSettings _settings = widget.initialSettings;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    if (_settings.appearance == .system) setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = switch (_settings.appearance) {
      .light => Brightness.light,
      .dark => Brightness.dark,
      .system => WidgetsBinding.instance.platformDispatcher.platformBrightness,
    };
    return ThemeScope(
      settings: _settings,
      onChanged: (settings) => setState(() => _settings = settings),
      child: MaterialApp(
        title: 'Remix Dashboard',
        debugShowCheckedModeBanner: false,
        scrollBehavior: const AppScrollBehavior(),
        themeMode: _settings.themeMode,
        theme: ThemeData(brightness: .light, useMaterial3: true),
        darkTheme: ThemeData(brightness: .dark, useMaterial3: true),
        themeAnimationDuration: Duration.zero,
        // FortalScope goes *below* MaterialApp and *above* the Navigator.
        //
        // MaterialApp always hands WidgetsApp its "put your text in a Material"
        // fallback style, which WidgetsApp installs as a DefaultTextStyle
        // around everything beneath it — so a scope placed above MaterialApp
        // would have its root text run overridden. `builder` wraps the whole
        // Navigator, so this placement still reaches pushed routes and raw
        // Overlay entries such as the toast with Fortal's root fallback.
        // A nearer DefaultTextStyle (for example from a Material surface) can
        // still override it through Flutter's normal inheritance.
        builder: (context, child) => FortalScope(
          key: const ValueKey('dashboard-fortal-scope'),
          accent: _settings.accentColor,
          gray: _settings.grayColor,
          brightness: brightness,
          panelBackground: _settings.panelBackground,
          radius: _settings.radius,
          scaling: _settings.scaling,
          child: child!,
        ),
        home: const DashboardShell(),
      ),
    );
  }
}
