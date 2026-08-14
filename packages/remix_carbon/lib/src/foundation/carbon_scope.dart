import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

import 'carbon_theme.dart';

/// Provides IBM Carbon design tokens to its subtree via a [MixScope], and
/// exposes the active [CarbonTheme] to descendants.
///
/// Place a [CarbonScope] at the root of the app (or around any subtree that uses
/// Carbon widgets/styles) so that `CarbonTokens.*` resolve to concrete values.
///
/// ```dart
/// CarbonScope(
///   theme: CarbonTheme.g100,
///   child: app,
/// )
/// ```
///
/// Pass [overrides] to substitute specific colors or a bundled font family
/// (for example an `IBM Plex Sans` family the app ships) without mutating the
/// generated theme maps.
class CarbonScope extends StatelessWidget {
  const CarbonScope({
    super.key,
    this.theme = CarbonTheme.white,
    this.overrides = const CarbonThemeOverrides(),
    this.orderOfModifiers,
    required this.child,
  });

  /// The active Carbon theme.
  final CarbonTheme theme;

  /// Optional typed overrides (colors, font family).
  final CarbonThemeOverrides overrides;

  /// Optional Mix modifier ordering, forwarded to [MixScope].
  final List<Type>? orderOfModifiers;

  final Widget child;

  /// The active [CarbonTheme] for [context], or null if there is no scope.
  static CarbonTheme? maybeThemeOf(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<_CarbonInherited>();

    return scope?.theme;
  }

  /// The active [CarbonThemeOverrides] for [context] (empty with no scope).
  ///
  /// Lets font-aware helpers such as `CarbonType.fluidTextStyle` pick up the
  /// scope's configured font family without re-passing it at every call site.
  static CarbonThemeOverrides overridesOf(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<_CarbonInherited>();

    return scope?.overrides ?? const CarbonThemeOverrides();
  }

  /// The active [CarbonTheme] for [context].
  ///
  /// Throws if there is no enclosing [CarbonScope]; use [maybeThemeOf] when the
  /// scope may be absent.
  static CarbonTheme themeOf(BuildContext context) {
    final theme = maybeThemeOf(context);
    assert(theme != null, 'No CarbonScope found in the widget tree.');

    return theme ?? .white;
  }

  @override
  Widget build(BuildContext context) {
    return _CarbonInherited(
      theme: theme,
      overrides: overrides,
      child: MixScope(
        tokens: buildCarbonTokenMap(theme, overrides: overrides),
        orderOfModifiers: orderOfModifiers,
        child: child,
      ),
    );
  }
}

class _CarbonInherited extends InheritedWidget {
  const _CarbonInherited({
    required this.theme,
    required this.overrides,
    required super.child,
  });

  final CarbonTheme theme;
  final CarbonThemeOverrides overrides;

  @override
  bool updateShouldNotify(_CarbonInherited oldWidget) =>
      oldWidget.theme != theme || oldWidget.overrides != overrides;
}
