import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// `RemixBoxAdapter` is `@internal` to `remix`, but this sibling package's
// tests need it to measure how a Remix component renders a Fortal recipe.
// Suppressed per-use below, so a future accidental internal-member use still
// gets flagged.
import 'package:remix/src/rendering/remix_box_effects.dart';
// Deliberate: RemixPathIcon/RemixPathGlyph stay unexported, but this sibling
// package verifies Fortal's pinned Radix checkbox defaults at the widget edge.
import 'package:remix/src/utilities/remix_path_icon.dart';
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
          tester.getSize(find.byType(RemixBoxAdapter)),
          Size.square(entry.value),
          reason: entry.key.name,
        );
      }
    });

    testWidgets('uses thick Radix indicators at every checkbox size', (
      tester,
    ) async {
      const expectedIndicatorSizes = <FortalCheckboxSize, double>{
        FortalCheckboxSize.size1: 9,
        FortalCheckboxSize.size2: 10,
        FortalCheckboxSize.size3: 12,
      };

      for (final entry in expectedIndicatorSizes.entries) {
        await tester.pumpRemixApp(
          FortalCheckbox(size: entry.key, selected: true, onChanged: (_) {}),
        );

        expect(
          _pathGlyph(RemixPathGlyph.thickCheck),
          findsOneWidget,
          reason: '${entry.key.name}/checked',
        );
        expect(
          tester.getSize(find.byType(RemixPathIcon)),
          Size.square(entry.value),
          reason: '${entry.key.name}/checked',
        );

        await tester.pumpRemixApp(
          FortalCheckbox(
            size: entry.key,
            selected: null,
            tristate: true,
            onChanged: (_) {},
          ),
        );

        expect(
          _pathGlyph(RemixPathGlyph.thickDividerHorizontal),
          findsOneWidget,
          reason: '${entry.key.name}/indeterminate',
        );
        expect(
          tester.getSize(find.byType(RemixPathIcon)),
          Size.square(entry.value),
          reason: '${entry.key.name}/indeterminate',
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

Finder _pathGlyph(RemixPathGlyph glyph) => find.byWidgetPredicate(
  (widget) => widget is RemixPathIcon && widget.glyph == glyph,
);
