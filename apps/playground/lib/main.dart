import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart' show SemanticsBinding;

import 'registry/component_registry.dart';
import 'routes/playground_home.dart';

void main() {
  // Ensure bindings are initialized before enabling semantics
  WidgetsFlutterBinding.ensureInitialized();
  // Enable accessible semantics for automation tools (e.g., Playwright)
  SemanticsBinding.instance.ensureSemantics();
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

    return MaterialApp(
      home: builder != null
          ? Scaffold(body: Builder(builder: builder))
          : const PlaygroundHome(),
      title: 'Remix Playground',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
    );
  }
}
