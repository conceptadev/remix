import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('FortalButton wrapper widget', () {
    testWidgets('renders generated button and forwards core params', (
      tester,
    ) async {
      var pressCount = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpRemixApp(
        FortalButton.soft(
          size: .size3,
          highContrast: true,
          label: 'Save',
          leadingIcon: Icons.save,
          trailingIcon: Icons.check,
          loading: false,
          enabled: true,
          enableFeedback: false,
          onPressed: () => pressCount++,
          focusNode: focusNode,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(FortalButton), findsOneWidget);
      expect(find.byType(RemixButton), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      final generated = tester.widget<FortalButton>(find.byType(FortalButton));
      expect(generated.variant, equals(FortalButtonVariant.soft));
      expect(generated.size, equals(FortalButtonSize.size3));
      expect(generated.highContrast, isTrue);

      final remixButton = tester.widget<RemixButton>(find.byType(RemixButton));
      expect(
        remixButton.style,
        equals(
          fortalButtonStyle(variant: .soft, size: .size3, highContrast: true),
        ),
      );
      expect(remixButton.label, equals('Save'));
      expect(remixButton.leadingIcon, equals(Icons.save));
      expect(remixButton.trailingIcon, equals(Icons.check));
      expect(remixButton.loading, isFalse);
      expect(remixButton.enabled, isTrue);
      expect(remixButton.enableFeedback, isFalse);
      expect(remixButton.onPressed, isNotNull);
      expect(remixButton.focusNode, same(focusNode));

      final nakedButton = tester.widget<NakedButton>(find.byType(NakedButton));
      expect(nakedButton.enableFeedback, isFalse);

      await tester.tap(find.byType(FortalButton));
      await tester.pumpAndSettle();

      expect(pressCount, equals(1));
    });

    testWidgets('keeps scaled labels unclipped across sizes and variants', (
      tester,
    ) async {
      for (final variant in const [
        FortalButtonVariant.solid,
        FortalButtonVariant.outline,
      ]) {
        for (final size in FortalButtonSize.values) {
          await tester.pumpRemixApp(
            MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(2)),
              child: FortalButton(
                variant: variant,
                size: size,
                label: 'Continue',
                onPressed: () {},
              ),
            ),
          );
          await tester.pumpAndSettle();

          final label = tester.renderObject<RenderBox>(find.text('Continue'));
          final intrinsicHeight = label.getMaxIntrinsicHeight(label.size.width);

          expect(tester.takeException(), isNull);
          expect(
            label.size.height,
            greaterThanOrEqualTo(intrinsicHeight - 0.01),
            reason: '${variant.name}/${size.name} clipped its label',
          );
        }
      }
    });

    testWidgets('preserves normal-scale Fortal heights', (tester) async {
      const expectedHeights = {
        FortalButtonSize.size1: 24.0,
        FortalButtonSize.size2: 32.0,
        FortalButtonSize.size3: 40.0,
        FortalButtonSize.size4: 48.0,
      };

      for (final entry in expectedHeights.entries) {
        await tester.pumpRemixApp(
          FortalButton.solid(
            size: entry.key,
            label: 'Continue',
            onPressed: () {},
          ),
        );
        await tester.pumpAndSettle();

        expect(
          tester.getSize(find.byType(RowBox)).height,
          entry.value,
          reason: entry.key.name,
        );
      }
    });
  });
}
