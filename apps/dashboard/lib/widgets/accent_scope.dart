import 'package:flutter/widgets.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// Applies a local Fortal accent without owning the surrounding surface.
///
/// Local dashboard accents are Fortal token overrides. Every other theme
/// setting continues to come from the nearest parent scope, and the existing
/// page or component remains responsible for painting its background.
class DashboardAccentScope extends StatelessWidget {
  const DashboardAccentScope({
    super.key,
    required this.accent,
    required this.child,
  });

  final FortalAccentColor accent;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      FortalScope(accent: accent, hasBackground: false, child: child);
}
