import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

const _sections = <RemixSidebarSection<String>>[
  RemixSidebarSection(
    label: 'Workspace',
    destinations: [
      RemixSidebarDestination(
        value: 'overview',
        label: 'Overview',
        icon: Icons.space_dashboard_outlined,
      ),
    ],
  ),
  RemixSidebarSection(
    label: 'Data',
    destinations: [
      RemixSidebarDestination(
        value: 'customers',
        label: 'Customers',
        icon: Icons.people_outline,
      ),
      RemixSidebarDestination(
        value: 'orders',
        label: 'Orders',
        icon: Icons.receipt_long_outlined,
      ),
    ],
  ),
];

void main() {
  group('RemixSidebar', () {
    testWidgets('renders labeled sections and destinations in source order', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSidebar<String>(
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
        RemixSidebar<String>(
          sections: const [
            ..._sections,
            RemixSidebarSection(label: 'Empty', destinations: []),
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
        RemixSidebar<String>(
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
        RemixSidebar<String>(
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
          RemixSidebar<String>(
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

    testWidgets('visual text transforms preserve authored heading semantics', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixSidebar<String>(
          sections: _sections,
          selectedValue: 'overview',
          onSelected: (_) {},
          style: SidebarStyler().sectionLabel(TextStyler().uppercase()),
        ),
      );

      expect(find.text('WORKSPACE'), findsOneWidget);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Workspace')),
        isSemantics(label: 'Workspace', isHeader: true),
      );
      expect(find.bySemanticsLabel('WORKSPACE'), findsNothing);
      semantics.dispose();
    });

    testWidgets('semanticLabel replaces destination visible-text semantics', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixSidebar<String>(
          sections: const [
            RemixSidebarSection(
              destinations: [
                RemixSidebarDestination(
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
        RemixSidebar<String>(
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

    testWidgets('excludeSemantics keeps header and footer semantics', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        SizedBox(
          height: 400,
          child: RemixSidebar<String>(
            header: const Text('Acme'),
            sections: _sections,
            selectedValue: 'overview',
            onSelected: (_) {},
            footer: const Text('Account'),
            semanticLabel: 'Primary navigation',
            excludeSemantics: true,
          ),
        ),
      );

      expect(find.bySemanticsLabel('Primary navigation'), findsNothing);
      expect(find.bySemanticsLabel('Overview'), findsNothing);
      expect(find.bySemanticsLabel('Acme'), findsOneWidget);
      expect(find.bySemanticsLabel('Account'), findsOneWidget);
      semantics.dispose();
    });

    testWidgets('header and footer stay outside the navigation landmark', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        SizedBox(
          height: 400,
          child: RemixSidebar<String>(
            header: const Text('Acme'),
            sections: _sections,
            selectedValue: 'overview',
            onSelected: (_) {},
            footer: const Text('Account'),
            semanticLabel: 'Primary navigation',
          ),
        ),
      );

      final landmark = tester.getSemantics(
        find.bySemanticsLabel('Primary navigation'),
      );
      expect(landmark.getSemanticsData().role, ui.SemanticsRole.navigation);

      final names = <String>[];
      void collect(SemanticsNode node) {
        names.add(node.label);
        node.visitChildren((child) {
          collect(child);
          return true;
        });
      }

      landmark.visitChildren((child) {
        collect(child);
        return true;
      });
      expect(names, contains('Overview'));
      expect(names, isNot(contains('Acme')));
      expect(names, isNot(contains('Account')));
      semantics.dispose();
    });

    testWidgets('root and item disabled states remove activation', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      final emitted = <String>[];
      await tester.pumpRemixApp(
        RemixSidebar<String>(
          sections: const [
            RemixSidebarSection(
              destinations: [
                RemixSidebarDestination(value: 'overview', label: 'Overview'),
                RemixSidebarDestination(
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
        const RemixSidebar<String>(
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
        RemixSidebar<String>(
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
        RemixSidebar<String>(
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

    testWidgets('an unbounded host keeps the panel unscrolled', (tester) async {
      RemixSidebar<String> buildPanel() => RemixSidebar<String>(
        sections: _sections,
        selectedValue: 'overview',
        onSelected: (_) {},
      );

      await tester.pumpRemixApp(SingleChildScrollView(child: buildPanel()));
      expect(tester.takeException(), isNull);
      expect(
        find.descendant(
          of: find.byType(RemixSidebar<String>),
          matching: find.byType(Scrollable),
        ),
        findsNothing,
      );

      // A Column hands its children unbounded height, so the panel must not
      // try to scroll or expand inside one either.
      await tester.pumpRemixApp(
        SizedBox(height: 320, child: Column(children: [buildPanel()])),
      );
      expect(tester.takeException(), isNull);
      expect(
        find.descendant(
          of: find.byType(RemixSidebar<String>),
          matching: find.byType(Scrollable),
        ),
        findsNothing,
      );
    });

    testWidgets('a bounded host scrolls destinations and pins the footer', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          height: 200,
          width: 240,
          child: RemixSidebar<String>(
            header: const Text('Acme'),
            sections: _sections,
            selectedValue: 'overview',
            onSelected: (_) {},
            footer: const Text('Account'),
            style: SidebarStyler().destination(ToggleStyler().height(80)),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      final scrollable = find.descendant(
        of: find.byType(RemixSidebar<String>),
        matching: find.byType(Scrollable),
      );
      expect(scrollable, findsOneWidget);

      // The header and footer stay outside the scroll region.
      expect(
        find.descendant(of: scrollable, matching: find.text('Acme')),
        findsNothing,
      );
      expect(
        find.descendant(of: scrollable, matching: find.text('Account')),
        findsNothing,
      );

      final panel = tester.getRect(find.byType(RemixSidebar<String>));
      final header = tester.getRect(find.text('Acme'));
      final footer = tester.getRect(find.text('Account'));
      expect(header.top, closeTo(panel.top, 0.5));
      expect(footer.bottom, closeTo(panel.bottom, 0.5));

      // Taller-than-viewport destinations scroll rather than overflow.
      await tester.drag(scrollable, const Offset(0, -60));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('omits header and footer regions when they are absent', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          height: 300,
          child: RemixSidebar<String>(
            sections: _sections,
            selectedValue: 'overview',
            onSelected: (_) {},
            style: SidebarStyler()
                .header(BoxStyler().height(40))
                .footer(BoxStyler().height(40)),
          ),
        ),
      );

      // Both region styles resolve, but neither renders without content.
      final panel = tester.getRect(find.byType(RemixSidebar<String>));
      final firstHeading = tester.getRect(find.text('Workspace'));
      expect(firstHeading.top, lessThan(panel.top + 40));
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
              child: RemixSidebar<String>(
                sections: const [
                  RemixSidebarSection(
                    label: 'Workspace',
                    destinations: [
                      RemixSidebarDestination(
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
          RemixSidebar<String>(
            sections: [
              RemixSidebarSection(
                destinations: [
                  RemixSidebarDestination(value: 'value', label: blank),
                ],
              ),
            ],
            selectedValue: 'value',
          ),
        );
        expect(tester.takeException(), isA<AssertionError>());

        await tester.pumpRemixApp(
          RemixSidebar<String>(
            sections: [
              RemixSidebarSection(
                label: blank,
                destinations: const [
                  RemixSidebarDestination(value: 'value', label: 'Value'),
                ],
              ),
            ],
            selectedValue: 'value',
          ),
        );
        expect(tester.takeException(), isA<AssertionError>());

        await tester.pumpRemixApp(
          RemixSidebar<String>(
            sections: [
              RemixSidebarSection(
                destinations: [
                  RemixSidebarDestination(
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
          RemixSidebar<String>(
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
        const RemixSidebar<String>(
          sections: [
            RemixSidebarSection(
              destinations: [
                RemixSidebarDestination(value: 'same', label: 'First'),
                RemixSidebarDestination(value: 'same', label: 'Second'),
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
        const RemixSidebar<String>(
          sections: [
            RemixSidebarSection(
              destinations: [
                RemixSidebarDestination(value: 'first', label: 'First'),
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
        const RemixSidebar<String>(
          sections: [
            RemixSidebarSection(
              destinations: [
                RemixSidebarDestination(
                  value: 'first',
                  label: 'First',
                  autofocus: true,
                ),
                RemixSidebarDestination(
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
        const RemixSidebar<String>(sections: [], selectedValue: null),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(RemixToggle), findsNothing);
    });
  });
}
