import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/ui/ui.dart';

void main() {
  Widget host(Widget child) => WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (context, _) => child,
  );
  late AcmeThemeData active;
  late Color background;
  late Color accent;
  Widget probe() => Builder(
    builder: (context) {
      active = AcmeTheme.of(context);
      background = AcmeTokens.background.resolve(context);
      accent = AcmeTokens.primary.resolve(context);
      return const SizedBox.shrink();
    },
  );

  testWidgets('root defaults follow live system changes above the app', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await tester.pumpWidget(AcmeThemeScope(child: host(probe())));
    expect(active.brightness, Brightness.light);
    expect(background, const Color(0xFFFFFFFF));
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    await tester.pump();
    expect(active.brightness, Brightness.dark);
    expect(background, const Color(0xFF0A0A0A));
  });

  testWidgets('explicit mode overrides system and survives changes', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await tester.pumpWidget(host(AcmeThemeScope(mode: .light, child: probe())));
    expect(active.brightness, Brightness.light);
    expect(background, const Color(0xFFFFFFFF));
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await tester.pump();
    expect(active.brightness, Brightness.light);
    expect(background, const Color(0xFFFFFFFF));
  });

  testWidgets('theme is the fallback when a custom dark theme is omitted', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        AcmeThemeScope(
          theme: const AcmeThemeData.light(),
          mode: .dark,
          child: probe(),
        ),
      ),
    );
    expect(active.brightness, Brightness.light);
    expect(background, const Color(0xFFFFFFFF));
  });

  testWidgets('darkTheme alone leaves the generated light default available', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        AcmeThemeScope(
          darkTheme: const AcmeThemeData.dark(),
          mode: .light,
          child: probe(),
        ),
      ),
    );
    expect(active.brightness, Brightness.light);
    expect(background, const Color(0xFFFFFFFF));
    await tester.pumpWidget(
      host(
        AcmeThemeScope(
          darkTheme: const AcmeThemeData.dark(),
          mode: .dark,
          child: probe(),
        ),
      ),
    );
    expect(active.brightness, Brightness.dark);
    expect(background, const Color(0xFF0A0A0A));
  });

  testWidgets(
    'nested scopes inherit selection rather than local system brightness',
    (tester) async {
      await tester.pumpWidget(
        host(
          AcmeThemeScope(
            mode: .dark,
            child: MediaQuery(
              data: const MediaQueryData(platformBrightness: Brightness.light),
              child: AcmeThemeScope(child: probe()),
            ),
          ),
        ),
      );
      expect(active.brightness, Brightness.dark);
      expect(background, const Color(0xFF0A0A0A));
    },
  );

  testWidgets('nested mode overrides retain the configured theme pair', (
    tester,
  ) async {
    // Deliberately reversed brightness values identify the supplied pair.
    await tester.pumpWidget(
      host(
        AcmeThemeScope(
          theme: const AcmeThemeData.dark(),
          darkTheme: const AcmeThemeData.light(),
          mode: .light,
          child: AcmeThemeScope(mode: .dark, child: probe()),
        ),
      ),
    );
    expect(active.brightness, Brightness.light);
    expect(background, const Color(0xFFFFFFFF));
  });

  testWidgets('capturing a theme preserves alternatives for a new subtree', (
    tester,
  ) async {
    late Widget captured;
    await tester.pumpWidget(
      host(
        AcmeThemeScope(
          theme: const AcmeThemeData.dark(),
          darkTheme: const AcmeThemeData.light(),
          mode: .light,
          child: Builder(
            builder: (context) {
              captured = InheritedTheme.captureAll(
                context,
                AcmeThemeScope(mode: .dark, child: probe()),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpWidget(host(captured));
    expect(active.brightness, Brightness.light);
    expect(background, const Color(0xFFFFFFFF));
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
            builder: (context, child) =>
                AcmeThemeScope(mode: mode, child: child!),
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
    expect(background, const Color(0xFFFFFFFF));
    update(() => mode = AcmeThemeMode.dark);
    await tester.pumpAndSettle();
    expect(active.brightness, Brightness.dark);
    expect(background, const Color(0xFF0A0A0A));
    Navigator.of(pageContext).pop();
    await tester.pumpAndSettle();
  });

  testWidgets('custom colors survive copyWith and repeated mode switching', (
    tester,
  ) async {
    final light = const AcmeThemeData.light()
        .copyWith(primary: const Color(0xFF123456))
        .copyWith(radius: const Radius.circular(12));
    final dark = const AcmeThemeData.dark()
        .copyWith(primary: const Color(0xFFABCDEF))
        .copyWith(radius: const Radius.circular(12));
    for (final mode in [
      AcmeThemeMode.light,
      AcmeThemeMode.dark,
      AcmeThemeMode.light,
    ]) {
      await tester.pumpWidget(
        host(
          AcmeThemeScope(
            theme: light,
            darkTheme: dark,
            mode: mode,
            child: probe(),
          ),
        ),
      );
      expect(
        accent,
        mode == AcmeThemeMode.light
            ? const Color(0xFF123456)
            : const Color(0xFFABCDEF),
      );
      expect(active.radius, light.radius);
    }
    expect(const Color(0xFF123456), isNot(const Color(0xFFABCDEF)));
  });
}
