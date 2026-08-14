import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CarbonScope', () {
    testWidgets('exposes the active theme to descendants', (tester) async {
      late CarbonTheme resolved;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: CarbonScope(
            theme: CarbonTheme.g100,
            child: Builder(
              builder: (context) {
                resolved = CarbonScope.themeOf(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
      expect(resolved, CarbonTheme.g100);
    });

    test('theme brightness mapping', () {
      expect(CarbonTheme.white.brightness, Brightness.light);
      expect(CarbonTheme.g10.brightness, Brightness.light);
      expect(CarbonTheme.g90.brightness, Brightness.dark);
      expect(CarbonTheme.g100.brightness, Brightness.dark);
      expect(CarbonTheme.g100.isDark, isTrue);
    });

    testWidgets('maybeThemeOf returns null with no scope', (tester) async {
      late CarbonTheme? resolved;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              resolved = CarbonScope.maybeThemeOf(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(resolved, isNull);
    });
  });
}
