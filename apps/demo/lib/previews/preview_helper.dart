import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// Helper function for creating consistent widget previews.
///
/// Wraps the widget with proper Remix theming and Material app context.
/// This ensures all previews have:
/// - Remix tokens and theming
/// - Material design context
/// - Consistent background and centering
/// - Debug banner disabled for clean previews
Widget createRemixPreview(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Builder(
      builder: (context) => FortalScope(
        brightness: Theme.of(context).brightness,
        child: Scaffold(
          backgroundColor: MixColors.grey[50],
          body: Center(child: child),
        ),
      ),
    ),
  );
}
