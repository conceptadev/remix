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
      background = AcmeTokens.colorBackground.resolve(context);
      accent = AcmeTokens.accent9.resolve(context);
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
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.light()).colorBackground,
    );
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    await tester.pump();
    expect(active.brightness, Brightness.dark);
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.dark()).colorBackground,
    );
  });

  testWidgets('explicit mode overrides system and survives changes', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await tester.pumpWidget(host(AcmeScope(mode: .light, child: probe())));
    expect(active.brightness, Brightness.light);
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.light()).colorBackground,
    );
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await tester.pump();
    expect(active.brightness, Brightness.light);
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.light()).colorBackground,
    );
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
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.light()).colorBackground,
    );
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
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.light()).colorBackground,
    );
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
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.dark()).colorBackground,
    );
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
      expect(
        background,
        resolveAcmeTokens(const AcmeThemeData.dark()).colorBackground,
      );
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
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.light()).colorBackground,
    );
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
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.light()).colorBackground,
    );
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
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.light()).colorBackground,
    );
    update(() => mode = AcmeThemeMode.dark);
    await tester.pumpAndSettle();
    expect(active.brightness, Brightness.dark);
    expect(
      background,
      resolveAcmeTokens(const AcmeThemeData.dark()).colorBackground,
    );
    Navigator.of(pageContext).pop();
    await tester.pumpAndSettle();
  });

  testWidgets('custom colors survive copyWith and repeated mode switching', (
    tester,
  ) async {
    final light = const AcmeThemeData.light(
      accent: AcmeAccentColor.red,
    ).copyWith(radius: AcmeRadius.large);
    final dark = const AcmeThemeData.dark(
      accent: AcmeAccentColor.blue,
    ).copyWith(radius: AcmeRadius.large);
    for (final mode in [
      AcmeThemeMode.light,
      AcmeThemeMode.dark,
      AcmeThemeMode.light,
    ]) {
      await tester.pumpWidget(
        host(
          AcmeScope(theme: light, darkTheme: dark, mode: mode, child: probe()),
        ),
      );
      expect(
        accent,
        mode == AcmeThemeMode.light
            ? resolveAcmeTokens(light).accent.scale.step(9)
            : resolveAcmeTokens(dark).accent.scale.step(9),
      );
      expect(active.radius, light.radius);
    }
    expect(
      resolveAcmeTokens(light).accent.scale.step(9),
      isNot(resolveAcmeTokens(dark).accent.scale.step(9)),
    );
  });

  testWidgets('text defaults respect host placement and explicit overrides', (
    tester,
  ) async {
    const override = TextStyle(color: Color(0xFFFF00FF), fontSize: 31);
    Widget app({TextStyle? textStyle, bool scopeInBuilder = false}) =>
        WidgetsApp(
          color: const Color(0xFFFFFFFF),
          textStyle: textStyle,
          builder: (context, _) => scopeInBuilder
              ? const AcmeScope(mode: .light, child: Text('sample'))
              : const Text('sample'),
        );
    TextStyle rendered() =>
        tester.widget<RichText>(find.byType(RichText).first).text.style!;
    final foreground = resolveAcmeTokens(
      const AcmeThemeData.light(),
    ).gray.scale.step(12);
    await tester.pumpWidget(AcmeScope(mode: .light, child: app()));
    expect(rendered().color, foreground);
    expect(rendered().fontSize, 16);
    await tester.pumpWidget(
      AcmeScope(
        mode: .light,
        child: app(textStyle: override),
      ),
    );
    expect(rendered().color, override.color);
    expect(rendered().fontSize, 31);
    await tester.pumpWidget(app(textStyle: override, scopeInBuilder: true));
    expect(rendered().color, foreground);
    expect(rendered().fontSize, 16);
  });
}
