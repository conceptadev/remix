import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  Widget host(Widget child) => WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (context, _) => child,
  );
  late FortalThemeData active;
  late Color background;
  late Color accent;
  Widget probe() => Builder(
    builder: (context) {
      active = FortalTheme.of(context);
      background = FortalTokens.colorBackground.resolve(context);
      accent = FortalTokens.accent9.resolve(context);
      return const SizedBox.shrink();
    },
  );

  testWidgets('root defaults follow live system changes above the app', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await tester.pumpWidget(FortalScope(child: host(probe())));
    expect(active.brightness, Brightness.light);
    expect(
      background,
      resolveFortalTokens(const FortalThemeData.light()).colorBackground,
    );
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    await tester.pump();
    expect(active.brightness, Brightness.dark);
    expect(
      background,
      resolveFortalTokens(const FortalThemeData.dark()).colorBackground,
    );
  });

  testWidgets('explicit mode overrides system and survives changes', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await tester.pumpWidget(host(FortalScope(mode: .light, child: probe())));
    expect(active.brightness, Brightness.light);
    expect(
      background,
      resolveFortalTokens(const FortalThemeData.light()).colorBackground,
    );
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await tester.pump();
    expect(active.brightness, Brightness.light);
    expect(
      background,
      resolveFortalTokens(const FortalThemeData.light()).colorBackground,
    );
  });

  testWidgets('theme is the fallback when a custom dark theme is omitted', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        FortalScope(
          theme: const FortalThemeData.light(),
          mode: .dark,
          child: probe(),
        ),
      ),
    );
    expect(active.brightness, Brightness.light);
    expect(
      background,
      resolveFortalTokens(const FortalThemeData.light()).colorBackground,
    );
  });

  testWidgets('darkTheme alone leaves the generated light default available', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        FortalScope(
          darkTheme: const FortalThemeData.dark(),
          mode: .light,
          child: probe(),
        ),
      ),
    );
    expect(active.brightness, Brightness.light);
    expect(
      background,
      resolveFortalTokens(const FortalThemeData.light()).colorBackground,
    );
    await tester.pumpWidget(
      host(
        FortalScope(
          darkTheme: const FortalThemeData.dark(),
          mode: .dark,
          child: probe(),
        ),
      ),
    );
    expect(active.brightness, Brightness.dark);
    expect(
      background,
      resolveFortalTokens(const FortalThemeData.dark()).colorBackground,
    );
  });

  testWidgets(
    'nested scopes inherit selection rather than local system brightness',
    (tester) async {
      await tester.pumpWidget(
        host(
          FortalScope(
            mode: .dark,
            child: MediaQuery(
              data: const MediaQueryData(platformBrightness: Brightness.light),
              child: FortalScope(child: probe()),
            ),
          ),
        ),
      );
      expect(active.brightness, Brightness.dark);
      expect(
        background,
        resolveFortalTokens(const FortalThemeData.dark()).colorBackground,
      );
    },
  );

  testWidgets('nested mode overrides retain the configured theme pair', (
    tester,
  ) async {
    // Deliberately reversed brightness values identify the supplied pair.
    await tester.pumpWidget(
      host(
        FortalScope(
          theme: const FortalThemeData.dark(),
          darkTheme: const FortalThemeData.light(),
          mode: .light,
          child: FortalScope(mode: .dark, child: probe()),
        ),
      ),
    );
    expect(active.brightness, Brightness.light);
    expect(
      background,
      resolveFortalTokens(const FortalThemeData.light()).colorBackground,
    );
  });

  testWidgets('capturing a theme preserves alternatives for a new subtree', (
    tester,
  ) async {
    late Widget captured;
    await tester.pumpWidget(
      host(
        FortalScope(
          theme: const FortalThemeData.dark(),
          darkTheme: const FortalThemeData.light(),
          mode: .light,
          child: Builder(
            builder: (context) {
              captured = InheritedTheme.captureAll(
                context,
                FortalScope(mode: .dark, child: probe()),
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
      resolveFortalTokens(const FortalThemeData.light()).colorBackground,
    );
  });

  testWidgets('changing mode updates an already-open dialog', (tester) async {
    var mode = FortalThemeMode.light;
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
            builder: (context, child) => FortalScope(mode: mode, child: child!),
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
      resolveFortalTokens(const FortalThemeData.light()).colorBackground,
    );
    update(() => mode = FortalThemeMode.dark);
    await tester.pumpAndSettle();
    expect(active.brightness, Brightness.dark);
    expect(
      background,
      resolveFortalTokens(const FortalThemeData.dark()).colorBackground,
    );
    Navigator.of(pageContext).pop();
    await tester.pumpAndSettle();
  });

  testWidgets('custom colors survive copyWith and repeated mode switching', (
    tester,
  ) async {
    final light = const FortalThemeData.light(
      accent: FortalAccentColor.red,
    ).copyWith(radius: FortalRadius.large);
    final dark = const FortalThemeData.dark(
      accent: FortalAccentColor.blue,
    ).copyWith(radius: FortalRadius.large);
    for (final mode in [
      FortalThemeMode.light,
      FortalThemeMode.dark,
      FortalThemeMode.light,
    ]) {
      await tester.pumpWidget(
        host(
          FortalScope(
            theme: light,
            darkTheme: dark,
            mode: mode,
            child: probe(),
          ),
        ),
      );
      expect(
        accent,
        mode == FortalThemeMode.light
            ? resolveFortalTokens(light).accent.scale.step(9)
            : resolveFortalTokens(dark).accent.scale.step(9),
      );
      expect(active.radius, light.radius);
    }
    expect(
      resolveFortalTokens(light).accent.scale.step(9),
      isNot(resolveFortalTokens(dark).accent.scale.step(9)),
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
              ? const FortalScope(mode: .light, child: Text('sample'))
              : const Text('sample'),
        );
    TextStyle rendered() =>
        tester.widget<RichText>(find.byType(RichText).first).text.style!;
    final foreground = resolveFortalTokens(
      const FortalThemeData.light(),
    ).gray.scale.step(12);
    await tester.pumpWidget(FortalScope(mode: .light, child: app()));
    expect(rendered().color, foreground);
    expect(rendered().fontSize, 16);
    await tester.pumpWidget(
      FortalScope(
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
