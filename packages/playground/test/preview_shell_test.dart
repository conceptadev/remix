import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playground/preview_shell/preview_shell.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets(
    'preview brightness controls synchronize MediaQuery Material and Fortal',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(1400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      Brightness? mediaBrightness;
      Brightness? materialBrightness;
      FortalAppearance? fortalAppearance;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PreviewShell(
              initialSize: const Size(375, 700),
              child: Builder(
                builder: (context) {
                  mediaBrightness = MediaQuery.platformBrightnessOf(context);
                  materialBrightness = Theme.of(context).brightness;
                  fortalAppearance = FortalTheme.of(context).appearance;
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      );

      expect(mediaBrightness, Brightness.light);
      expect(materialBrightness, Brightness.light);
      expect(fortalAppearance, FortalAppearance.light);
      final scope = find.byType(FortalScope);
      expect(scope, findsOneWidget);
      expect(
        find.descendant(of: scope, matching: find.byType(MaterialApp)),
        findsOneWidget,
      );

      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      expect(mediaBrightness, Brightness.dark);
      expect(materialBrightness, Brightness.dark);
      expect(fortalAppearance, FortalAppearance.dark);
    },
  );
}
