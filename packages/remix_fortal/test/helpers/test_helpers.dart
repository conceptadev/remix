import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// Fortal's counterpart to `packages/remix/test/helpers/test_helpers.dart`.
///
/// Dart `package:` imports only reach `lib/`, so test helpers cannot be shared
/// across packages. This copy differs in exactly one way that matters: it wraps
/// every pump in [FortalScope], because Fortal recipes resolve Fortal tokens.
extension WidgetTesterHelpers on WidgetTester {
  /// Pumps a Fortal widget in the Material interoperability test harness.
  ///
  /// `MaterialApp` and `Scaffold` are conveniences here, not Remix host
  /// requirements. Host-contract tests should provide only the capability under
  /// test, such as `Overlay.wrap` or a caller-owned `Navigator`.
  Future<void> pumpRemixApp(
    Widget widget, {
    TextDirection textDirection = TextDirection.ltr,
  }) async {
    await pumpWidget(
      FortalScope(
        child: MaterialApp(
          home: Directionality(
            textDirection: textDirection,
            child: Scaffold(body: Center(child: widget)),
          ),
        ),
      ),
    );
  }

  /// Returns the resolved Mix spec for [finder].
  S resolvedSpecOf<S extends Spec<S>>(Finder finder) {
    final context = element(finder);
    final provider = context
        .getInheritedWidgetOfExactType<StyleSpecProvider<S>>();
    expect(provider, isNotNull, reason: 'No StyleSpecProvider<$S> found');
    return provider!.spec.spec;
  }
}

/// Resolves a value against a `BuildContext` inside a default [FortalScope].
///
/// Use this for assertions on token or style resolution that need no scope
/// configuration. Suites that vary the accent, brightness, radius, or widget
/// states keep their own richer local resolver.
Future<T> resolveInFortalScope<T>(
  WidgetTester tester,
  T Function(BuildContext context) resolve,
) async {
  late T result;
  await tester.pumpRemixApp(
    Builder(
      builder: (context) {
        result = resolve(context);

        return const SizedBox.shrink();
      },
    ),
  );

  return result;
}
