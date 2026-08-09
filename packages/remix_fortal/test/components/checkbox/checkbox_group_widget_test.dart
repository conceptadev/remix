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

  testWidgets('fortalCheckboxGroupItemStyle delegates across the whole matrix', (
    tester,
  ) async {
    // The wrapper's only job is to forward variant/size/highContrast into the
    // checkbox recipe, so every combination must resolve identically — not
    // just the default one. `CheckboxStyler` has no value equality (unlike
    // `ToggleGroupStyler`), so this compares the resolved specs instead.
    for (final variant in FortalCheckboxVariant.values) {
      for (final size in FortalCheckboxSize.values) {
        for (final highContrast in const [false, true]) {
          final reason = '$variant/$size/highContrast=$highContrast';
          final wrapped = await _resolveCheckboxStyle(
            tester,
            fortalCheckboxGroupItemStyle(
              variant: variant,
              size: size,
              highContrast: highContrast,
            ),
          );
          final direct = await _resolveCheckboxStyle(
            tester,
            fortalCheckboxStyle(
              variant: variant,
              size: size,
              highContrast: highContrast,
            ),
          );

          expect(wrapped, equals(direct), reason: reason);
        }
      }
    }
  });

  testWidgets('FortalCheckboxGroupItem participates in group selection', (
    tester,
  ) async {
    var values = const <String>{};
    await tester.pumpRemixApp(
      StatefulBuilder(
        builder: (context, setState) => RemixCheckboxGroup<String>(
          values: values,
          onChanged: (next) => setState(() => values = next),
          child: const FortalCheckboxGroupItem<String>(
            value: 'a',
            label: 'A',
          ),
        ),
      ),
    );

    await tester.tap(find.text('A'));
    await tester.pump();

    expect(values, {'a'});
    expect(tester.takeException(), isNull);
  });
}

Finder _itemAt(int index) =>
    find.byType(RemixCheckboxGroupItem<String>).at(index);

Future<StyleSpec<CheckboxSpec>> _resolveCheckboxStyle(
  WidgetTester tester,
  CheckboxStyler style,
) async {
  late StyleSpec<CheckboxSpec> resolved;

  await tester.pumpWidget(
    FortalScope(
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            resolved = style.build(context);

            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );

  return resolved;
}
