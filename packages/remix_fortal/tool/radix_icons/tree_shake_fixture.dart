import 'package:flutter/widgets.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// Release-build fixture used to verify Flutter subsets the Fortal icon font.
///
/// Keep this entrypoint limited to one static icon reference. A dynamic icon
/// catalog here would intentionally make Flutter retain the complete font.
void main() {
  runApp(
    WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (context, child) => const Center(child: Icon(FortalIcons.check)),
    ),
  );
}
