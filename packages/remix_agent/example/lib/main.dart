import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'showcase.dart';

final _semanticsHandles = <SemanticsHandle>[];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RemixAgentExampleApp());
  if (kIsWeb) {
    _semanticsHandles.add(SemanticsBinding.instance.ensureSemantics());
  }
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
