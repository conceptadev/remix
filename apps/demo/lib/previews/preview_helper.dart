import 'package:flutter/widgets.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// Wraps previews with Fortal tokens, navigation, overlays, and a consistent background.
Widget createRemixPreview(Widget child) {
  return WidgetsApp(
    color: const Color(0xFFFAFAFA),
    debugShowCheckedModeBanner: false,
    pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    ),
    builder: (context, navigator) => FortalScope(child: navigator!),
    home: ColoredBox(
      color: const Color(0xFFFAFAFA),
      child: Center(child: child),
    ),
  );
}
