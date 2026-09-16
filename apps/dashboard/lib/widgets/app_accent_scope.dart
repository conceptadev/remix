import 'package:flutter/widgets.dart';
import '../ui/ui.dart';

/// Applies an app-owned local Fortal accent without owning the surface.
///
/// Every other theme setting continues to come from the nearest parent scope,
/// and the surrounding page or component remains responsible for painting its
/// background.
class AppAccentScope extends StatelessWidget {
  const AppAccentScope({super.key, required this.accent, required this.child});

  final UiAccentColor accent;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      UiScope(accent: accent, hasBackground: false, child: child);
}
