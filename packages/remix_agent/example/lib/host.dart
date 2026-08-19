import 'package:flutter/widgets.dart';

/// Example-only host palette. Not part of remix_agent.
///
/// Cool paper and indigo ink — a workshop ledger, not a product theme.
/// Copper marks the live run. Widgets still read ink from [DefaultTextStyle].
class HostTheme extends InheritedWidget {
  const HostTheme({super.key, required this.dark, required super.child});

  final bool dark;

  static HostTheme of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<HostTheme>();
    assert(theme != null, 'HostTheme missing.');
    return theme!;
  }

  Color get paper => dark ? const Color(0xFF12151C) : const Color(0xFFE8EDF2);

  Color get ink => dark ? const Color(0xFFE8EDF2) : const Color(0xFF12151C);

  Color get live => const Color(0xFFC45C26);

  Color get rail => dark ? const Color(0xFF1A1E28) : const Color(0xFFDDE3EA);

  Color get hairline => ink.withValues(alpha: 0.14);

  TextStyle get body => TextStyle(
    color: ink,
    fontSize: 15,
    height: 1.45,
    fontFamily: 'Source Sans 3',
    fontFamilyFallback: const ['Segoe UI', 'Helvetica Neue', 'sans-serif'],
  );

  TextStyle get display => body.copyWith(
    fontSize: 28,
    height: 1.15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  TextStyle get meta => body.copyWith(
    fontSize: 12,
    height: 1.35,
    color: ink.withValues(alpha: 0.62),
    fontFamily: 'ui-monospace',
    fontFamilyFallback: const ['SF Mono', 'Menlo', 'Consolas', 'monospace'],
  );

  @override
  bool updateShouldNotify(HostTheme oldWidget) => dark != oldWidget.dark;
}
