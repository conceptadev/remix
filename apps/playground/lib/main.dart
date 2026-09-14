import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/semantics.dart' show SemanticsBinding;

import 'package:remix_fortal/remix_fortal.dart';

import 'registry/component_registry.dart';
import 'routes/playground_home.dart';

void main() {
  // Ensure bindings are initialized before enabling semantics
  WidgetsFlutterBinding.ensureInitialized();
  // Enable accessible semantics for automation tools (e.g., Playwright)
  if (kIsWeb) SemanticsBinding.instance.ensureSemantics();
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    const defineKey = String.fromEnvironment('COMPONENT', defaultValue: '');
    final queryKey = kIsWeb ? Uri.base.queryParameters['component'] ?? '' : '';
    final key = (defineKey.isNotEmpty ? defineKey : queryKey).toLowerCase();

    final builder = components[key];

    return WidgetsApp(
      color: const Color(0xFFFAFAFA),
      pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
      ),
      builder: (context, child) => FortalScope(child: child!),
      home: builder != null
          ? Builder(builder: builder)
          : const PlaygroundHome(),
      title: 'Remix Playground',
      debugShowCheckedModeBanner: false,
    );
  }
}
