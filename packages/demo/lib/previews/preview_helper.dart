import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

/// Helper function for creating consistent widget previews.
///
/// Wraps the widget with proper Remix theming and Material app context.
/// This ensures all previews have:
/// - Remix tokens and theming
/// - Material design context
/// - Consistent background and centering
/// - Debug banner disabled for clean previews
Widget createRemixPreview(Widget child) {
  return FortalScope(
    appearance: .light,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: MixColors.grey[50],
        body: Center(child: child),
      ),
    ),
  );
}

/// Dark mode variant of the preview wrapper.
Widget createRemixPreviewDark(Widget child) {
  return FortalScope(
    appearance: .dark,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: MixColors.blueGrey,
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        backgroundColor: MixColors.black,
        body: Center(child: child),
      ),
    ),
  );
}
