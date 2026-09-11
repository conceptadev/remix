import 'package:flutter/material.dart';

import 'ui/ui.dart';

/// Runs a small application composed entirely from installed Fortal source.
void main() => runApp(const AcmeApp());

/// Minimal consumer shell for the Fortal preset.
class AcmeApp extends StatelessWidget {
  /// Creates the example application.
  const AcmeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AcmeScope(
        child: Scaffold(
          body: Center(
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
      ),
    );
  }
}
