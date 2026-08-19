import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'showcase.dart';

void main() {
  runApp(const RemixAgentExampleApp());
}

/// Local catalog host. No theme package and no MaterialApp.
class RemixAgentExampleApp extends StatelessWidget {
  const RemixAgentExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MixScope.empty(
      child: WidgetsApp(
        color: const Color(0xFFE8EDF2),
        debugShowCheckedModeBanner: false,
        builder: (_, _) {
          return Overlay.wrap(child: const DarkHost(child: AgentCatalog()));
        },
      ),
    );
  }
}
