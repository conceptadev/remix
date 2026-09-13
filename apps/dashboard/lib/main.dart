import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'shell/dashboard_shell.dart';
import 'theme/scroll_behavior.dart';
import 'theme/theme_scope.dart';
import 'theme/theme_settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Web paints to canvas; without a live semantics tree the page has no
  // accessible names for browser review or Playwright clicks.
  if (kIsWeb) SemanticsBinding.instance.ensureSemantics();
  runApp(const DashboardApp());
}

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
      child: WidgetsApp(
        title: 'Dashboard',
        debugShowCheckedModeBanner: false,
        color: const Color(0xFFF8FAFC),
        pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
        ),
        // Keep the theme above the Navigator so routes and overlays inherit it.
        builder: (context, child) => FortalScope(
          key: const ValueKey('dashboard-fortal-scope'),
          accent: _settings.accentColor,
          gray: _settings.grayColor,
          mode: _settings.appearance,
          panelBackground: _settings.panelBackground,
          radius: _settings.radius,
          scaling: _settings.scaling,
          // RemixToastScope sits above the Navigator, in its own Overlay, so
          // showRemixToast() works from every route, including dialogs and
          // the compact navigation sheet. It inherits the live Fortal tokens
          // FortalScope publishes above.
          child: ScrollConfiguration(
            behavior: const AppScrollBehavior(),
            child: Overlay.wrap(
              child: RemixToastScope(style: fortalToastStyle(), child: child!),
            ),
          ),
        ),
        home: const DashboardShell(),
      ),
    );
  }
}
