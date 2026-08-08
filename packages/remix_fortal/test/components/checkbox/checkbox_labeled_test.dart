import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// `RemixBoxWithEffects` is `@internal` to `remix`, but this sibling package's
// tests need it to measure how a Remix component renders a Fortal recipe.
// Suppressed per-use below, so a future accidental internal-member use still
// gets flagged.
import 'package:remix/src/rendering/remix_box_effects.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('Fortal labeled checkbox', () {
    testWidgets('preserves each visual square inside a 48 target', (
      tester,
    ) async {
      const expectedVisualSizes = <FortalCheckboxSize, double>{
        FortalCheckboxSize.size1: 14,
        FortalCheckboxSize.size2: 16,
        FortalCheckboxSize.size3: 20,
      };

      for (final entry in expectedVisualSizes.entries) {
        await tester.pumpRemixApp(
          FortalCheckbox(
            size: entry.key,
            selected: false,
            label: 'Receive updates',
            onChanged: (_) {},
          ),
        );

        expect(
          tester.getSize(find.byType(FortalCheckbox)).height,
          greaterThanOrEqualTo(48),
          reason: entry.key.name,
        );
        expect(
          // ignore: invalid_use_of_internal_member
          tester.getSize(find.byType(RemixBoxWithEffects)),
          Size.square(entry.value),
          reason: entry.key.name,
        );
      }
    });

    test('generated wrapper forwards label and minimum target size', () {
      const checkbox = FortalCheckbox.surface(
        selected: false,
        label: 'Receive updates',
        minimumTapTargetSize: Size.zero,
      );

      expect(checkbox.label, 'Receive updates');
      expect(checkbox.minimumTapTargetSize, Size.zero);
    });
  });
}
