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

  testWidgets(
    'fortalCheckboxGroupItemStyle preserves checkbox anatomy across the matrix',
    (tester) async {
      // Item-only label metrics layer on top of the checkbox recipe. The
      // checkbox square, indicator bounds, and effects must still resolve
      // identically for every variant/size/high-contrast combination.
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

            expect(
              wrapped.spec.container,
              equals(direct.spec.container),
              reason: '$reason/container',
            );
            expect(
              wrapped.spec.indicator,
              equals(direct.spec.indicator),
              reason: '$reason/indicator',
            );
            expect(
              wrapped.spec.containerEffects,
              equals(direct.spec.containerEffects),
              reason: '$reason/effects',
            );
          }
        }
      }
    },
  );

  testWidgets('links item typography and gaps to size and theme scaling', (
    tester,
  ) async {
    const metrics =
        <
          FortalCheckboxSize,
          ({
            double fontSize,
            double lineHeight,
            double letterSpacing,
            double gap,
          })
        >{
          FortalCheckboxSize.size1: (
            fontSize: 12,
            lineHeight: 16 / 12,
            letterSpacing: 0.0025 * 12,
            gap: 6,
          ),
          FortalCheckboxSize.size2: (
            fontSize: 14,
            lineHeight: 20 / 14,
            letterSpacing: 0,
            gap: 7,
          ),
          FortalCheckboxSize.size3: (
            fontSize: 16,
            lineHeight: 24 / 16,
            letterSpacing: 0,
            gap: 8,
          ),
        };

    for (final scaling in FortalScaling.values) {
      for (final entry in metrics.entries) {
        final resolved = await _resolveCheckboxStyle(
          tester,
          fortalCheckboxGroupItemStyle(size: entry.key),
          scaling: scaling,
        );
        final label = resolved.spec.label.spec.style!;
        final reason = '${scaling.name}/${entry.key.name}';

        expect(
          label.fontSize,
          closeTo(entry.value.fontSize * scaling.factor, 1e-9),
          reason: '$reason/fontSize',
        );
        expect(
          label.height,
          closeTo(entry.value.lineHeight, 1e-9),
          reason: '$reason/height',
        );
        expect(
          label.letterSpacing,
          closeTo(entry.value.letterSpacing * scaling.factor, 1e-9),
          reason: '$reason/letterSpacing',
        );
        expect(
          resolved.spec.labelSpacing,
          closeTo(entry.value.gap * scaling.factor, 1e-9),
          reason: '$reason/gap',
        );
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
          child: const FortalCheckboxGroupItem<String>(value: 'a', label: 'A'),
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
  CheckboxStyler style, {
  FortalScaling scaling = .percent100,
}) async {
  late StyleSpec<CheckboxSpec> resolved;

  await tester.pumpWidget(
    FortalScope(
      scaling: scaling,
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
