import 'package:flutter/widgets.dart';

import 'ui/ui.dart';

/// Runs a small application composed entirely from installed Fortal source.
void main() => runApp(const AcmeApp());

/// Minimal consumer shell for the Fortal preset.
class AcmeApp extends StatelessWidget {
  /// Creates the example application.
  const AcmeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFFF8FAFC),
      pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
      ),
      debugShowCheckedModeBanner: false,
      home: const AcmeScope(
        child: Center(
          child: AcmeCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AcmeHeading('Fortal, now yours'),
                AcmeText('Radix Themes 3.3.0 expressed as local Dart.'),
                AcmeButton(label: 'Continue'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
