import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

const _destinations = <RemixNavigationDestination<String>>[
  RemixNavigationDestination(value: 'overview', label: 'Overview'),
  RemixNavigationDestination(value: 'customers', label: 'Customers'),
];

const _sections = <RemixNavigationSection<String>>[
  RemixNavigationSection(destinations: _destinations),
];

void main() {
  group('NavigationListStyler', () {
    test('constructor retains every anatomy style', () {
      final container = FlexBoxStyler();
      final section = FlexBoxStyler();
      final sectionLabel = TextStyler();
      final destinations = FlexBoxStyler();
      final destination = ToggleStyler();
      final style = NavigationListStyler(
        container: container,
        section: section,
        sectionLabel: sectionLabel,
        destinations: destinations,
        destination: destination,
      );

      expect(style.$container, Prop.maybeMix(container));
      expect(style.$section, Prop.maybeMix(section));
      expect(style.$sectionLabel, Prop.maybeMix(sectionLabel));
      expect(style.$destinations, Prop.maybeMix(destinations));
      expect(style.$destination, Prop.maybeMix(destination));
    });

    styleMethodTest(
      'forwards the root FlexBox surface',
      initial: NavigationListStyler(),
      modify: (style) => style.padding(.all(12)).spacing(8),
      expect: (style) {
        expect(style.$container, isNotNull);
      },
    );

    test('styleFrom and generic call preserve the public type', () {
      expect(RemixNavigationList.styleFrom(), isA<NavigationListStyler>());

      final widget = NavigationListStyler().call<String>(
        sections: _sections,
        selectedValue: 'overview',
        onSelected: (_) {},
      );

      expect(widget, isA<RemixNavigationList<String>>());
      expect(widget.style, isA<NavigationListStyler>());
    });
  });

  group('RemixNavigationList styling', () {
    testWidgets('default selected variants resolve in each toggle state', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: _sections,
          selectedValue: 'overview',
          onSelected: (_) {},
          style: NavigationListStyler(
            destination: ToggleStyler()
                .labelColor(Colors.red)
                .onSelected(ToggleStyler().labelColor(Colors.blue)),
          ),
        ),
      );

      expect(
        tester.widget<Text>(find.text('Overview')).style?.color,
        Colors.blue,
      );
      expect(
        tester.widget<Text>(find.text('Customers')).style?.color,
        Colors.red,
      );
    });

    testWidgets('per-destination style merges after the list default', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: [
            RemixNavigationSection(
              destinations: [
                RemixNavigationDestination(
                  value: 'overview',
                  label: 'Overview',
                  style: ToggleStyler().labelColor(Colors.green),
                ),
              ],
            ),
          ],
          selectedValue: 'overview',
          onSelected: (_) {},
          style: NavigationListStyler(
            destination: ToggleStyler().labelColor(Colors.red),
          ),
        ),
      );

      expect(
        tester.widget<Text>(find.text('Overview')).style?.color,
        Colors.green,
      );
    });

    testWidgets('raw spec bypasses fluent and per-destination styles', (
      tester,
    ) async {
      var fluentBuilds = 0;
      final fluentStyle = NavigationListStyler().onBuilder((context) {
        fluentBuilds += 1;
        return NavigationListStyler(
          destination: ToggleStyler().labelColor(Colors.blue),
        );
      });
      const rawSpec = NavigationListSpec(
        destination: StyleSpec(
          spec: ToggleSpec(
            label: StyleSpec(
              spec: TextSpec(style: TextStyle(color: Colors.red)),
            ),
          ),
        ),
      );

      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: [
            RemixNavigationSection(
              destinations: [
                RemixNavigationDestination(
                  value: 'overview',
                  label: 'Overview',
                  style: ToggleStyler().labelColor(Colors.green),
                ),
              ],
            ),
          ],
          selectedValue: 'overview',
          onSelected: (_) {},
          style: fluentStyle,
          styleSpec: rawSpec,
        ),
      );

      expect(fluentBuilds, 0);
      expect(
        tester.widget<Text>(find.text('Overview')).style?.color,
        Colors.red,
      );
    });

    for (final useRawSpec in [false, true]) {
      testWidgets(
        '${useRawSpec ? 'raw' : 'fluent'} directions cannot reorder destinations',
        (tester) async {
          const reversedHorizontal = StyleSpec(
            spec: FlexBoxSpec(
              flex: StyleSpec(
                spec: FlexSpec(
                  direction: Axis.horizontal,
                  verticalDirection: VerticalDirection.up,
                ),
              ),
            ),
          );

          await tester.pumpRemixApp(
            RemixNavigationList<String>(
              sections: _sections,
              selectedValue: 'overview',
              onSelected: (_) {},
              style: useRawSpec
                  ? NavigationListStyler()
                  : NavigationListStyler(
                      container: FlexBoxStyler()
                          .direction(Axis.horizontal)
                          .verticalDirection(VerticalDirection.up),
                      section: FlexBoxStyler()
                          .direction(Axis.horizontal)
                          .verticalDirection(VerticalDirection.up),
                      destinations: FlexBoxStyler()
                          .direction(Axis.horizontal)
                          .verticalDirection(VerticalDirection.up),
                    ),
              styleSpec: useRawSpec
                  ? const NavigationListSpec(
                      container: reversedHorizontal,
                      section: reversedHorizontal,
                      destinations: reversedHorizontal,
                    )
                  : null,
            ),
          );

          final overview = tester.getTopLeft(find.text('Overview'));
          final customers = tester.getTopLeft(find.text('Customers'));
          expect(overview.dx, customers.dx);
          expect(overview.dy, lessThan(customers.dy));
        },
      );
    }

    for (final enabled in [true, false]) {
      testWidgets(
        '${enabled ? 'null callback' : 'enabled false'} resolves the root disabled variant',
        (tester) async {
          await tester.pumpRemixApp(
            RemixNavigationList<String>(
              sections: _sections,
              selectedValue: 'overview',
              onSelected: enabled ? null : (_) {},
              enabled: enabled,
              style: NavigationListStyler()
                  .color(Colors.red)
                  .onDisabled(NavigationListStyler().color(Colors.grey)),
            ),
          );

          final container = tester.widget<FlexBox>(
            find.byKey(const ValueKey('RemixNavigationList.container')),
          );
          final decoration =
              container.styleSpec!.spec.box?.spec.decoration as BoxDecoration?;
          expect(decoration?.color, Colors.grey);
        },
      );
    }
  });
}
