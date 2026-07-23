import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('Fortal theme resolution', () {
    test('exposes current theme values and legacy neutral accents', () {
      expect(FortalAppearance.values, [
        FortalAppearance.inherit,
        FortalAppearance.light,
        FortalAppearance.dark,
      ]);
      expect(FortalScaling.values, [
        FortalScaling.percent90,
        FortalScaling.percent95,
        FortalScaling.percent100,
        FortalScaling.percent105,
        FortalScaling.percent110,
      ]);
      expect(FortalScaling.values.map((value) => value.factor), [
        0.9,
        0.95,
        1.0,
        1.05,
        1.1,
      ]);
      expect(FortalGrayColor.values.map((value) => value.name), [
        'auto',
        'gray',
        'mauve',
        'slate',
        'sage',
        'olive',
        'sand',
      ]);
      expect(FortalAccentColor.values.map((value) => value.name), [
        'gray',
        'mauve',
        'slate',
        'sage',
        'olive',
        'sand',
        'gold',
        'bronze',
        'brown',
        'yellow',
        'amber',
        'orange',
        'tomato',
        'red',
        'ruby',
        'crimson',
        'pink',
        'plum',
        'purple',
        'violet',
        'iris',
        'indigo',
        'blue',
        'cyan',
        'teal',
        'jade',
        'green',
        'grass',
        'lime',
        'mint',
        'sky',
      ]);
    });

    test('FortalThemeConfig is a partial theme description', () {
      const config = FortalThemeConfig();

      expect(config.appearance, isNull);
      expect(config.accentColor, isNull);
      expect(config.grayColor, isNull);
      expect(config.panelBackground, isNull);
      expect(config.radius, isNull);
      expect(config.scaling, isNull);
      expect(config.hasBackground, isNull);
    });

    testWidgets('resolves root defaults above a WidgetsApp', (tester) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
      late FortalThemeData data;
      late Color panel;
      late double panelBlur;

      await tester.pumpWidget(
        FortalScope(
          child: WidgetsApp(
            color: const Color(0xFF000000),
            builder: (context, child) {
              data = FortalTheme.of(context);
              panel = MixScope.tokenOf(FortalTokens.colorPanel, context);
              panelBlur = MixScope.tokenOf(FortalTokens.panelBlur, context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(data.appearance, FortalAppearance.light);
      expect(data.brightness, Brightness.light);
      expect(data.accentColor, FortalAccentColor.indigo);
      expect(data.grayColor, FortalGrayColor.slate);
      expect(data.panelBackground, FortalPanelBackground.translucent);
      expect(data.radius, FortalRadius.medium);
      expect(data.scaling, FortalScaling.percent100);
      expect(data.hasBackground, isTrue);
      expect(
        panel,
        MixScope.tokenOf(
          FortalTokens.colorPanelTranslucent,
          tester.element(find.byType(WidgetsApp)),
        ),
      );
      expect(panelBlur, 64);
    });

    testWidgets('observes platform brightness without Material', (
      tester,
    ) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
      late FortalThemeData data;

      await tester.pumpWidget(
        FortalScope(
          child: WidgetsApp(
            color: const Color(0xFF000000),
            builder: (context, child) {
              data = FortalTheme.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(data.brightness, Brightness.light);

      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      await tester.pump();

      expect(data.appearance, FortalAppearance.dark);
      expect(data.brightness, Brightness.dark);
    });

    testWidgets('solid panels resolve without backdrop blur', (tester) async {
      late Color panel;
      late Color panelSolid;
      late double blur;

      await tester.pumpWidget(
        FortalScope(
          appearance: .light,
          panelBackground: .solid,
          child: Builder(
            builder: (context) {
              panel = MixScope.tokenOf(FortalTokens.colorPanel, context);
              panelSolid = MixScope.tokenOf(
                FortalTokens.colorPanelSolid,
                context,
              );
              blur = MixScope.tokenOf(FortalTokens.panelBlur, context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(panel, panelSolid);
      expect(blur, 0);
    });

    testWidgets('auto gray follows the exact accent mapping', (tester) async {
      for (final accent in FortalAccentColor.values) {
        late FortalThemeData data;

        await tester.pumpWidget(
          FortalScope(
            appearance: .light,
            accentColor: accent,
            grayColor: .auto,
            child: WidgetsApp(
              color: const Color(0xFF000000),
              builder: (context, child) {
                data = FortalTheme.of(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        );

        expect(
          data.grayColor,
          _expectedGrayFor(accent),
          reason: 'auto gray for ${accent.name}',
        );
      }
    });

    testWidgets('nested accent changes inherit gray unless auto is explicit', (
      tester,
    ) async {
      late FortalThemeData outer;
      late FortalThemeData inheritedGray;
      late FortalThemeData rematchedGray;

      await tester.pumpWidget(
        FortalScope(
          appearance: .light,
          accentColor: .indigo,
          grayColor: .auto,
          child: WidgetsApp(
            color: const Color(0xFF000000),
            builder: (context, child) {
              outer = FortalTheme.of(context);
              return Column(
                children: [
                  FortalScope(
                    accentColor: .red,
                    child: Builder(
                      builder: (context) {
                        inheritedGray = FortalTheme.of(context);
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  FortalScope(
                    accentColor: .red,
                    grayColor: .auto,
                    child: Builder(
                      builder: (context) {
                        rematchedGray = FortalTheme.of(context);
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );

      expect(outer.grayColor, FortalGrayColor.slate);
      expect(inheritedGray.accentColor, FortalAccentColor.red);
      expect(inheritedGray.grayColor, FortalGrayColor.slate);
      expect(rematchedGray.grayColor, FortalGrayColor.mauve);
    });

    testWidgets(
      'nested appearance and background defaults match scope boundaries',
      (tester) async {
        final resolved = <String, FortalThemeData>{};

        Widget capture(String name) => Builder(
          builder: (context) {
            resolved[name] = FortalTheme.of(context);
            return SizedBox(key: ValueKey(name));
          },
        );

        await tester.pumpWidget(
          FortalScope(
            appearance: .light,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                children: [
                  FortalScope(child: capture('inherited')),
                  FortalScope(
                    appearance: .inherit,
                    child: capture('explicit-inherit'),
                  ),
                  FortalScope(
                    appearance: .dark,
                    child: capture('explicit-dark'),
                  ),
                  FortalScope(
                    appearance: .dark,
                    hasBackground: false,
                    child: capture('dark-without-background'),
                  ),
                  FortalScope(
                    hasBackground: true,
                    child: capture('inherited-with-background'),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(resolved['inherited']!.appearance, FortalAppearance.light);
        expect(resolved['inherited']!.hasBackground, isFalse);
        expect(
          resolved['explicit-inherit']!.appearance,
          FortalAppearance.light,
        );
        expect(resolved['explicit-inherit']!.hasBackground, isFalse);
        expect(resolved['explicit-dark']!.appearance, FortalAppearance.dark);
        expect(resolved['explicit-dark']!.hasBackground, isTrue);
        expect(
          resolved['dark-without-background']!.appearance,
          FortalAppearance.dark,
        );
        expect(resolved['dark-without-background']!.hasBackground, isFalse);
        expect(
          resolved['inherited-with-background']!.appearance,
          FortalAppearance.light,
        );
        expect(resolved['inherited-with-background']!.hasBackground, isTrue);

        expect(find.byType(ColoredBox), findsNWidgets(3));
        expect(
          find.ancestor(
            of: find.byKey(const ValueKey('inherited')),
            matching: find.byType(ColoredBox),
          ),
          findsOneWidget,
        );
        expect(
          find.ancestor(
            of: find.byKey(const ValueKey('explicit-dark')),
            matching: find.byType(ColoredBox),
          ),
          findsNWidgets(2),
        );
        expect(
          find.ancestor(
            of: find.byKey(const ValueKey('dark-without-background')),
            matching: find.byType(ColoredBox),
          ),
          findsOneWidget,
        );
      },
    );
  });
}

FortalGrayColor _expectedGrayFor(FortalAccentColor accent) => switch (accent) {
  .tomato ||
  .red ||
  .ruby ||
  .crimson ||
  .pink ||
  .plum ||
  .purple ||
  .violet => .mauve,
  .iris || .indigo || .blue || .sky || .cyan => .slate,
  .teal || .jade || .mint || .green => .sage,
  .grass || .lime => .olive,
  .yellow || .amber || .orange || .brown || .gold || .bronze => .sand,
  .gray => .gray,
  .mauve => .mauve,
  .slate => .slate,
  .sage => .sage,
  .olive => .olive,
  .sand => .sand,
};
