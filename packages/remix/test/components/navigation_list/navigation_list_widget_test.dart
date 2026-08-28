import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

const _sections = <RemixNavigationSection<String>>[
  RemixNavigationSection(
    label: 'Workspace',
    destinations: [
      RemixNavigationDestination(
        value: 'overview',
        label: 'Overview',
        icon: Icons.space_dashboard_outlined,
      ),
    ],
  ),
  RemixNavigationSection(
    label: 'Data',
    destinations: [
      RemixNavigationDestination(
        value: 'customers',
        label: 'Customers',
        icon: Icons.people_outline,
      ),
      RemixNavigationDestination(
        value: 'orders',
        label: 'Orders',
        icon: Icons.receipt_long_outlined,
      ),
    ],
  ),
];

void main() {
  group('RemixNavigationList', () {
    testWidgets('renders labeled sections and destinations in source order', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: _sections,
          selectedValue: 'overview',
          onSelected: (_) {},
        ),
      );

      expect(find.text('Workspace'), findsOneWidget);
      expect(find.text('Data'), findsOneWidget);
      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Customers'), findsOneWidget);
      expect(find.text('Orders'), findsOneWidget);
      expect(find.byType(RemixToggle), findsNWidgets(3));
    });

    testWidgets('skips empty sections together with their headings', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: const [
            ..._sections,
            RemixNavigationSection(label: 'Empty', destinations: []),
          ],
          selectedValue: 'overview',
          onSelected: (_) {},
        ),
      );

      expect(find.text('Empty'), findsNothing);
    });

    testWidgets('pointer activation emits inactive and selected values once', (
      tester,
    ) async {
      final emitted = <String>[];
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: _sections,
          selectedValue: 'overview',
          onSelected: emitted.add,
        ),
      );

      await tester.tap(find.byKey(const ValueKey<String>('customers')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey<String>('overview')));
      await tester.pump();

      expect(emitted, ['customers', 'overview']);
    });

    testWidgets('semantics activation emits exactly once', (tester) async {
      final semantics = tester.ensureSemantics();
      final emitted = <String>[];
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: _sections,
          selectedValue: 'overview',
          onSelected: emitted.add,
        ),
      );

      tester.semantics.tap(find.semantics.byLabel('Customers'));
      await tester.pump();

      expect(emitted, ['customers']);
      semantics.dispose();
    });

    testWidgets(
      'publishes navigation, heading, and selected-button semantics',
      (tester) async {
        final semantics = tester.ensureSemantics();
        await tester.pumpRemixApp(
          RemixNavigationList<String>(
            sections: _sections,
            selectedValue: 'overview',
            onSelected: (_) {},
            semanticLabel: 'Primary navigation',
          ),
        );

        final root = tester.getSemantics(
          find.bySemanticsLabel('Primary navigation'),
        );
        expect(root.getSemanticsData().role, ui.SemanticsRole.navigation);
        expect(root.childrenCount, 5);

        expect(
          tester.getSemantics(find.bySemanticsLabel('Workspace')),
          isSemantics(label: 'Workspace', isHeader: true),
        );
        expect(
          tester.getSemantics(find.bySemanticsLabel('Overview')),
          isSemantics(
            label: 'Overview',
            isButton: true,
            isSelected: true,
            hasSelectedState: true,
            hasEnabledState: true,
            isEnabled: true,
            isFocusable: true,
            hasTapAction: true,
            hasFocusAction: true,
            hasToggledState: false,
          ),
        );
        expect(
          tester.getSemantics(find.bySemanticsLabel('Customers')),
          isSemantics(
            label: 'Customers',
            isButton: true,
            isSelected: false,
            hasSelectedState: true,
            hasToggledState: false,
          ),
        );
        semantics.dispose();
      },
    );

    testWidgets('semanticLabel replaces destination visible-text semantics', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: const [
            RemixNavigationSection(
              destinations: [
                RemixNavigationDestination(
                  value: 'overview',
                  label: 'Overview',
                  semanticLabel: 'Workspace overview',
                ),
              ],
            ),
          ],
          selectedValue: 'overview',
          onSelected: (_) {},
        ),
      );

      expect(find.bySemanticsLabel('Workspace overview'), findsOneWidget);
      expect(find.bySemanticsLabel('Overview'), findsNothing);
      expect(find.text('Overview'), findsOneWidget);
      semantics.dispose();
    });

    testWidgets('excludeSemantics hides the landmark and destinations', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: _sections,
          selectedValue: 'overview',
          onSelected: (_) {},
          semanticLabel: 'Primary navigation',
          excludeSemantics: true,
        ),
      );

      expect(find.bySemanticsLabel('Primary navigation'), findsNothing);
      expect(find.bySemanticsLabel('Overview'), findsNothing);
      semantics.dispose();
    });

    testWidgets('root and item disabled states remove activation', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      final emitted = <String>[];
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: const [
            RemixNavigationSection(
              destinations: [
                RemixNavigationDestination(
                  value: 'overview',
                  label: 'Overview',
                ),
                RemixNavigationDestination(
                  value: 'disabled',
                  label: 'Disabled',
                  enabled: false,
                ),
              ],
            ),
          ],
          selectedValue: 'overview',
          onSelected: emitted.add,
          enabled: false,
        ),
      );

      await tester.tap(find.text('Overview'));
      await tester.tap(find.text('Disabled'));
      await tester.pump();
      expect(emitted, isEmpty);

      for (final label in ['Overview', 'Disabled']) {
        expect(
          tester.getSemantics(find.bySemanticsLabel(label)),
          isSemantics(
            label: label,
            isButton: true,
            hasEnabledState: true,
            isEnabled: false,
            hasTapAction: false,
          ),
        );
      }
      semantics.dispose();
    });

    testWidgets('a null callback disables every destination', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        const RemixNavigationList<String>(
          sections: _sections,
          selectedValue: 'overview',
        ),
      );
      semantics.dispose();

      expect(
        tester.getSemantics(find.bySemanticsLabel('Overview')),
        isSemantics(
          label: 'Overview',
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
          hasEnabledState: true,
          isEnabled: false,
          hasTapAction: false,
        ),
      );
    });

    testWidgets('Tab order is visual order and Enter and Space activate', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      final emitted = <String>[];
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: _sections,
          selectedValue: 'overview',
          onSelected: emitted.add,
        ),
      );

      for (final label in ['Overview', 'Customers', 'Orders']) {
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();
        expect(
          find.semantics
              .byLabel(label)
              .evaluate()
              .single
              .getSemanticsData()
              .flagsCollection
              .isFocused,
          ui.Tristate.isTrue,
        );
      }

      await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
      await tester.pump();
      expect(
        find.semantics
            .byLabel('Customers')
            .evaluate()
            .single
            .getSemanticsData()
            .flagsCollection
            .isFocused,
        ui.Tristate.isTrue,
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();

      expect(emitted, ['orders', 'orders']);
      semantics.dispose();
    });

    testWidgets('null selectedValue leaves every destination unselected', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixNavigationList<String>(
          sections: _sections,
          selectedValue: null,
          onSelected: (_) {},
        ),
      );

      for (final label in ['Overview', 'Customers', 'Orders']) {
        expect(
          find.semantics
              .byLabel(label)
              .evaluate()
              .single
              .getSemanticsData()
              .flagsCollection
              .isSelected,
          ui.Tristate.isFalse,
        );
      }
      semantics.dispose();
    });

    testWidgets('builds in scrolling and fixed-height non-scrolling hosts', (
      tester,
    ) async {
      RemixNavigationList<String> buildList() => RemixNavigationList<String>(
        sections: _sections,
        selectedValue: 'overview',
        onSelected: (_) {},
      );

      await tester.pumpRemixApp(SingleChildScrollView(child: buildList()));
      expect(tester.takeException(), isNull);
      expect(
        find.descendant(
          of: find.byType(RemixNavigationList<String>),
          matching: find.byType(Scrollable),
        ),
        findsNothing,
      );

      await tester.pumpRemixApp(
        SizedBox(height: 320, child: Column(children: [buildList()])),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('supports 200 percent text and RTL without overflow', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(2)),
            child: SizedBox(
              width: 256,
              child: RemixNavigationList<String>(
                sections: const [
                  RemixNavigationSection(
                    label: 'Workspace',
                    destinations: [
                      RemixNavigationDestination(
                        value: 'overview',
                        label:
                            'Overview of every active workspace and its status',
                        icon: Icons.space_dashboard_outlined,
                      ),
                    ],
                  ),
                ],
                selectedValue: 'overview',
                onSelected: (_) {},
              ),
            ),
          ),
        ),
        textDirection: TextDirection.rtl,
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('rejects blank public labels', (tester) async {
      for (final blank in ['', ' ', '\t\n']) {
        await tester.pumpRemixApp(
          RemixNavigationList<String>(
            sections: [
              RemixNavigationSection(
                destinations: [
                  RemixNavigationDestination(value: 'value', label: blank),
                ],
              ),
            ],
            selectedValue: 'value',
          ),
        );
        expect(tester.takeException(), isA<AssertionError>());

        await tester.pumpRemixApp(
          RemixNavigationList<String>(
            sections: [
              RemixNavigationSection(
                label: blank,
                destinations: const [
                  RemixNavigationDestination(value: 'value', label: 'Value'),
                ],
              ),
            ],
            selectedValue: 'value',
          ),
        );
        expect(tester.takeException(), isA<AssertionError>());

        await tester.pumpRemixApp(
          RemixNavigationList<String>(
            sections: [
              RemixNavigationSection(
                destinations: [
                  RemixNavigationDestination(
                    value: 'value',
                    label: 'Value',
                    semanticLabel: blank,
                  ),
                ],
              ),
            ],
            selectedValue: 'value',
          ),
        );
        expect(tester.takeException(), isA<AssertionError>());

        await tester.pumpRemixApp(
          RemixNavigationList<String>(
            sections: const [],
            selectedValue: null,
            semanticLabel: blank,
          ),
        );
        expect(tester.takeException(), isA<AssertionError>());
      }
    });

    testWidgets('rejects duplicate, unmatched, and multiple-autofocus data', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixNavigationList<String>(
          sections: [
            RemixNavigationSection(
              destinations: [
                RemixNavigationDestination(value: 'same', label: 'First'),
                RemixNavigationDestination(value: 'same', label: 'Second'),
              ],
            ),
          ],
          selectedValue: 'same',
        ),
      );
      expect(
        tester.takeException().toString(),
        contains('destination values must be unique'),
      );

      await tester.pumpRemixApp(
        const RemixNavigationList<String>(
          sections: [
            RemixNavigationSection(
              destinations: [
                RemixNavigationDestination(value: 'first', label: 'First'),
              ],
            ),
          ],
          selectedValue: 'missing',
        ),
      );
      expect(
        tester.takeException().toString(),
        contains('selectedValue must match one destination'),
      );

      await tester.pumpRemixApp(
        const RemixNavigationList<String>(
          sections: [
            RemixNavigationSection(
              destinations: [
                RemixNavigationDestination(
                  value: 'first',
                  label: 'First',
                  autofocus: true,
                ),
                RemixNavigationDestination(
                  value: 'second',
                  label: 'Second',
                  autofocus: true,
                ),
              ],
            ),
          ],
          selectedValue: 'first',
        ),
      );
      expect(
        tester.takeException().toString(),
        contains('Only one destination may autofocus'),
      );
    });

    testWidgets('an empty list is valid when nothing is selected', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixNavigationList<String>(sections: [], selectedValue: null),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(RemixToggle), findsNothing);
    });
  });
}
