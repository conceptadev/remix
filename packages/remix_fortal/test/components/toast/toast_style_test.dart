import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('FortalToast', () {
    test('named constructors pin variants', () {
      const surface = FortalToast.surface(title: 'Saved');
      const classic = FortalToast.classic(title: 'Saved');

      expect(surface.variant, FortalToastVariant.surface);
      expect(classic.variant, FortalToastVariant.classic);
      expect(const FortalToast(title: 'Saved').size, FortalToastSize.size2);
      expect(
        const FortalToast(title: 'Saved').intent,
        FortalToastIntent.accent,
      );
    });

    for (final brightness in Brightness.values) {
      for (final variant in FortalToastVariant.values) {
        for (final size in FortalToastSize.values) {
          for (final intent in FortalToastIntent.values) {
            testWidgets(
              'resolves $variant $size $intent in ${brightness.name}',
              (tester) async {
                await tester.pumpRemixApp(
                  FortalScope(
                    brightness: brightness,
                    child: FortalToast(
                      variant: variant,
                      size: size,
                      intent: intent,
                      title: 'Draft saved',
                      description: 'Stored on this device.',
                      icon: Icons.check,
                      action: RemixToastAction(label: 'Undo', onPressed: () {}),
                      onDismiss: () {},
                      dismissLabel: 'Dismiss notification',
                    ),
                  ),
                );

                expect(tester.takeException(), isNull);
                expect(find.text('Draft saved'), findsOneWidget);
                expect(
                  tester.getSize(find.byType(RemixToast)).width,
                  lessThanOrEqualTo(360),
                );
              },
            );
          }
        }
      }
    }

    testWidgets('shrinks below its cap on narrow screens', (tester) async {
      await tester.pumpRemixApp(
        const SizedBox(
          width: 240,
          child: FortalToast(
            title: 'A long message that has to wrap on a narrow screen.',
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.byType(RemixToast)).width, 240);
    });

    testWidgets('stays within its cap at a large text scale', (tester) async {
      await tester.pumpRemixApp(
        const MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(2)),
          child: FortalToast(
            title: 'A long message that has to wrap at a large text scale.',
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byType(RemixToast)).width,
        lessThanOrEqualTo(360),
      );
    });

    test('the intent never changes semantics priority', () {
      const toast = RemixToastData(title: 'Failed');

      expect(toast.priority, RemixToastPriority.polite);
      expect(fortalToastStyle(intent: .error), isA<ToastStyler>());
    });
  });
}
