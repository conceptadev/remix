import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../helpers/test_helpers.dart';

void main() {
  testWidgets('Select icon remains sized when opened and selection works', (
    tester,
  ) async {
    String? selected;
    await tester.pumpRemixApp(
      FortalSelect<String>(
        trigger: const RemixSelectTrigger(
          placeholder: 'Choose',
          icon: Icons.star,
        ),
        items: const [RemixSelectItem(value: 'a', label: 'Apple')],
        onChanged: (value) => selected = value,
      ),
    );
    await tester.tap(find.text('Choose'));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byIcon(Icons.star)), const Size.square(16));
    await tester.tap(find.text('Apple'));
    await tester.pumpAndSettle();
    expect(selected, 'a');
    expect(tester.takeException(), isNull);
  });

  testWidgets('Segmented item override wins and selection works', (
    tester,
  ) async {
    String? selected;
    await tester.pumpRemixApp(
      FortalSegmentedControl<String>(
        style: SegmentedControlStyler().item(
          SegmentedControlItemStyler().icon(.size(14)),
        ),
        items: [
          RemixSegmentedControlItem(
            value: 'a',
            label: 'Alpha',
            icon: Icons.star,
            style: SegmentedControlItemStyler().icon(.size(18)),
          ),
        ],
        selectedValue: null,
        onChanged: (value) => selected = value,
      ),
    );
    expect(tester.getSize(find.byIcon(Icons.star)), const Size.square(18));
    await tester.tap(find.text('Alpha'));
    await tester.pumpAndSettle();
    expect(selected, 'a');
    expect(tester.takeException(), isNull);
  });

  testWidgets('Base Remix retains ambient icon sizing', (tester) async {
    for (final widget in <Widget>[
      RemixSelect<String>(
        trigger: const RemixSelectTrigger(
          placeholder: 'Choose',
          icon: Icons.star,
        ),
        items: const [RemixSelectItem(value: 'a', label: 'Apple')],
      ),
      RemixSegmentedControl<String>(
        items: const [
          RemixSegmentedControlItem(
            value: 'a',
            label: 'Alpha',
            icon: Icons.star,
          ),
        ],
        selectedValue: null,
        onChanged: (_) {},
      ),
    ]) {
      await tester.pumpRemixApp(
        IconTheme(data: const IconThemeData(size: 19), child: widget),
      );
      expect(tester.getSize(find.byIcon(Icons.star)), const Size.square(19));
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('Content icon tokens follow Fortal scaling', (tester) async {
    for (final widget in <Widget>[
      FortalSelect<String>(
        trigger: const RemixSelectTrigger(
          placeholder: 'Choose',
          icon: Icons.star,
        ),
        items: const [RemixSelectItem(value: 'a', label: 'Apple')],
      ),
      FortalSegmentedControl<String>(
        items: const [
          RemixSegmentedControlItem(
            value: 'a',
            label: 'Alpha',
            icon: Icons.star,
          ),
        ],
        selectedValue: null,
        onChanged: (_) {},
      ),
    ]) {
      await tester.pumpRemixApp(
        FortalScope(scaling: .percent110, child: widget),
      );
      expect(
        tester.getSize(find.byIcon(Icons.star)).width,
        closeTo(17.6, 1e-9),
      );
      expect(
        tester.getSize(find.byIcon(Icons.star)).height,
        closeTo(17.6, 1e-9),
      );
      expect(tester.takeException(), isNull);
    }
  });

  for (final size in FortalSelectSize.values) {
    for (final variant in FortalSelectVariant.values) {
      for (final enabled in [true, false]) {
        for (final direction in TextDirection.values) {
          for (final override in [false, true]) {
            testWidgets(
              'Select ${size.name} $variant enabled=$enabled $direction override=$override',
              (tester) async {
                await tester.pumpRemixApp(
                  IconTheme(
                    data: const IconThemeData(size: 48),
                    child: FortalSelect<String>(
                      size: size,
                      variant: variant,
                      enabled: enabled,
                      style: override
                          ? SelectStyler().trigger(
                              SelectTriggerStyler().icon(.size(14)),
                            )
                          : const SelectStyler.create(),
                      trigger: const RemixSelectTrigger(
                        placeholder: 'Choose',
                        icon: Icons.star,
                      ),
                      items: const [
                        RemixSelectItem(value: 'a', label: 'Apple'),
                      ],
                      onChanged: (_) {},
                    ),
                  ),
                  textDirection: direction,
                );
                final icon = find.byIcon(Icons.star);
                expect(icon, findsOneWidget);
                final spec = tester.resolvedSpecOf<SelectTriggerSpec>(icon);
                final expected = override
                    ? 14.0
                    : [12.0, 16.0, 20.0][size.index];
                expect(spec.icon.spec.size, expected);
                expect(tester.getSize(icon), Size.square(expected));
                expect(tester.takeException(), isNull);
              },
            );
          }
        }
      }
    }
  }
  for (final size in FortalSegmentedControlSize.values) {
    for (final variant in FortalSegmentedControlVariant.values) {
      for (final enabled in [true, false]) {
        for (final direction in TextDirection.values) {
          for (final override in [false, true]) {
            testWidgets(
              'Segmented ${size.name} $variant enabled=$enabled $direction override=$override',
              (tester) async {
                await tester.pumpRemixApp(
                  IconTheme(
                    data: const IconThemeData(size: 48),
                    child: FortalSegmentedControl<String>(
                      size: size,
                      variant: variant,
                      enabled: enabled,
                      style: override
                          ? SegmentedControlStyler().item(
                              SegmentedControlItemStyler().icon(.size(14)),
                            )
                          : const SegmentedControlStyler.create(),
                      items: const [
                        RemixSegmentedControlItem(
                          value: 'a',
                          label: 'Alpha',
                          icon: Icons.star,
                        ),
                      ],
                      selectedValue: 'a',
                      onChanged: (_) {},
                    ),
                  ),
                  textDirection: direction,
                );
                final icon = find.byIcon(Icons.star);
                expect(icon, findsOneWidget);
                final spec = tester.resolvedSpecOf<SegmentedControlItemSpec>(
                  icon,
                );
                final expected = override
                    ? 14.0
                    : [12.0, 16.0, 20.0][size.index];
                expect(spec.icon.spec.size, expected);
                expect(tester.getSize(icon), Size.square(expected));
                expect(tester.takeException(), isNull);
              },
            );
          }
        }
      }
    }
  }
}
