import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/ui/ui.dart';

void main() {
  Widget host(Widget child) => WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (context, _) => child,
  );
  late AcmeThemeData active;
  Widget probe() => Builder(
    builder: (context) {
      active = AcmeTheme.of(context);
      return const SizedBox.shrink();
    },
  );

  testWidgets('root defaults follow live system changes above the app', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await tester.pumpWidget(AcmeScope(child: host(probe())));
    expect(active.brightness, Brightness.light);
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    await tester.pump();
    expect(active.brightness, Brightness.dark);
  });

  testWidgets('explicit mode overrides system and survives changes', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await tester.pumpWidget(host(AcmeScope(mode: .light, child: probe())));
    expect(active.brightness, Brightness.light);
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await tester.pump();
    expect(active.brightness, Brightness.light);
  });

  testWidgets('theme is the fallback when a custom dark theme is omitted', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        AcmeScope(
          theme: const AcmeThemeData.light(),
          mode: .dark,
          child: probe(),
        ),
      ),
    );
    expect(active.brightness, Brightness.light);
  });

  testWidgets('darkTheme alone leaves the generated light default available', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        AcmeScope(
          darkTheme: const AcmeThemeData.dark(),
          mode: .light,
          child: probe(),
        ),
      ),
    );
    expect(active.brightness, Brightness.light);
    await tester.pumpWidget(
      host(
        AcmeScope(
          darkTheme: const AcmeThemeData.dark(),
          mode: .dark,
          child: probe(),
        ),
      ),
    );
    expect(active.brightness, Brightness.dark);
  });

  testWidgets(
    'nested scopes inherit selection rather than local system brightness',
    (tester) async {
      await tester.pumpWidget(
        host(
          AcmeScope(
            mode: .dark,
            child: MediaQuery(
              data: const MediaQueryData(platformBrightness: Brightness.light),
              child: AcmeScope(child: probe()),
            ),
          ),
        ),
      );
      expect(active.brightness, Brightness.dark);
    },
  );

  testWidgets('nested mode overrides retain the configured theme pair', (
    tester,
  ) async {
    // Deliberately reversed brightness values identify the supplied pair.
    await tester.pumpWidget(
      host(
        AcmeScope(
          theme: const AcmeThemeData.dark(),
          darkTheme: const AcmeThemeData.light(),
          mode: .light,
          child: AcmeScope(mode: .dark, child: probe()),
        ),
      ),
    );
    expect(active.brightness, Brightness.light);
  });

  testWidgets('capturing a theme preserves alternatives for a new subtree', (
    tester,
  ) async {
    late Widget captured;
    await tester.pumpWidget(
      host(
        AcmeScope(
          theme: const AcmeThemeData.dark(),
          darkTheme: const AcmeThemeData.light(),
          mode: .light,
          child: Builder(
            builder: (context) {
              captured = InheritedTheme.captureAll(
                context,
                AcmeScope(mode: .dark, child: probe()),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpWidget(host(captured));
    expect(active.brightness, Brightness.light);
  });

  testWidgets('changing mode updates an already-open dialog', (tester) async {
    var mode = AcmeThemeMode.light;
    late StateSetter update;
    late BuildContext pageContext;
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) {
          update = setState;
          return WidgetsApp(
            color: const Color(0xFFFFFFFF),
            pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
              settings: settings,
              pageBuilder: (context, _, _) => builder(context),
            ),
            builder: (context, child) => AcmeScope(mode: mode, child: child!),
            home: Builder(
              builder: (context) {
                pageContext = context;
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
    showGeneralDialog<void>(
      context: pageContext,
      pageBuilder: (context, _, _) => probe(),
    );
    await tester.pumpAndSettle();
    expect(active.brightness, Brightness.light);
    update(() => mode = AcmeThemeMode.dark);
    await tester.pumpAndSettle();
    expect(active.brightness, Brightness.dark);
    Navigator.of(pageContext).pop();
    await tester.pumpAndSettle();
  });
}
