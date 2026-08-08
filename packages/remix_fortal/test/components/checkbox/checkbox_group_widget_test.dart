import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
// `RemixBoxWithEffects` is `@internal` to `remix`, but this sibling package's
// tests need it to measure how a Remix component renders a Fortal recipe.
// Suppressed per-use below, so a future accidental internal-member use still
// gets flagged.
import 'package:remix/src/rendering/remix_box_effects.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('keeps Fortal 14, 16, and 20 visuals inside 48 targets', (
    tester,
  ) async {
    const expectedVisualSizes = <FortalCheckboxSize, double>{
      FortalCheckboxSize.size1: 14,
      FortalCheckboxSize.size2: 16,
      FortalCheckboxSize.size3: 20,
    };

    for (final entry in expectedVisualSizes.entries) {
      await tester.pumpRemixApp(
        RemixCheckboxGroup<String>(
          values: const {},
          onChanged: (_) {},
          child: RemixCheckboxGroupItem<String>(
            value: 'a',
            label: 'A',
            style: fortalCheckboxStyle(size: entry.key),
          ),
        ),
      );

      expect(
        tester.getSize(_itemAt(0)),
        const Size.square(48),
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
}

Finder _itemAt(int index) =>
    find.byType(RemixCheckboxGroupItem<String>).at(index);
