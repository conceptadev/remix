import 'dart:ui' show SemanticsRole, Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixSelect behavior', () {
    testWidgets(
      'renders placeholder, leading icon, and a stable down chevron',
      (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(
              placeholder: 'Choose',
              icon: Icons.star,
            ),
            items: const [RemixSelectItem(value: 'a', label: 'A')],
            onChanged: (_) {},
          ),
        );

        expect(find.text('Choose'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
        expect(find.byIcon(Icons.keyboard_arrow_up), findsNothing);
      },
    );

    testWidgets('supports styled trigger and indicator glyph builders', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: const [RemixSelectItem(value: 'a', label: 'Alpha')],
          selectedValue: 'a',
          onChanged: (_) {},
          triggerChevronBuilder: (context, styleSpec) =>
              const SizedBox(key: ValueKey('custom-chevron')),
          itemIndicatorBuilder: (context, styleSpec) =>
              const SizedBox(key: ValueKey('custom-indicator')),
        ),
      );

      expect(find.byKey(const ValueKey('custom-chevron')), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down), findsNothing);

      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('custom-indicator')), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('null onChanged can inspect options without changing value', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixSelect<String>(
          trigger: RemixSelectTrigger(placeholder: 'Choose'),
          items: [RemixSelectItem(value: 'a', label: 'A')],
        ),
      );

      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();

      expect(find.text('A'), findsOneWidget);
      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();
      expect(find.text('Choose'), findsOneWidget);
    });

    testWidgets('selection is controlled and closes content by default', (
      tester,
    ) async {
      String? selected;
      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) => RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Choose'),
            items: const [
              RemixSelectItem(value: 'a', label: 'Alpha'),
              RemixSelectItem(value: 'b', label: 'Beta'),
            ],
            selectedValue: selected,
            onChanged: (value) => setState(() => selected = value),
          ),
        ),
      );

      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Beta'));
      await tester.pumpAndSettle();

      expect(selected, 'b');
      expect(find.text('Beta'), findsOneWidget);
      expect(find.text('Alpha'), findsNothing);
    });

    testWidgets('closeOnSelect false leaves content open', (tester) async {
      String? selected;
      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) => RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Choose'),
            items: const [
              RemixSelectItem(value: 'a', label: 'Alpha'),
              RemixSelectItem(value: 'b', label: 'Beta'),
            ],
            selectedValue: selected,
            onChanged: (value) => setState(() => selected = value),
            closeOnSelect: false,
          ),
        ),
      );

      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Alpha'));
      await tester.pumpAndSettle();

      expect(selected, 'a');
      expect(find.text('Beta'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('disabled root and disabled option do not select', (
      tester,
    ) async {
      var changes = 0;
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: const [
            RemixSelectItem(value: 'a', label: 'Alpha', enabled: false),
          ],
          onChanged: (_) => changes++,
          enabled: false,
        ),
      );
      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();
      expect(find.text('Alpha'), findsNothing);

      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: const [
            RemixSelectItem(value: 'a', label: 'Alpha', enabled: false),
          ],
          onChanged: (_) => changes++,
        ),
      );
      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Alpha'));
      await tester.pumpAndSettle();
      expect(changes, 0);
    });

    testWidgets('reports open and close lifecycle around a selection', (
      tester,
    ) async {
      var opens = 0;
      var closes = 0;
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: const [RemixSelectItem(value: 'a', label: 'Alpha')],
          onChanged: (_) {},
          onOpen: () => opens++,
          onClose: () => closes++,
        ),
      );

      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Alpha'));
      await tester.pumpAndSettle();

      expect(opens, 1);
      expect(closes, 1);
    });

    testWidgets('uses the provided trigger focus node', (tester) async {
      final node = FocusNode();
      addTearDown(node.dispose);
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: const [RemixSelectItem(value: 'a', label: 'A')],
          onChanged: (_) {},
          focusNode: node,
        ),
      );

      node.requestFocus();
      await tester.pump();
      expect(node.hasFocus, isTrue);
    });

    testWidgets('asserts when a controlled value is absent from all items', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: const [RemixSelectItem(value: 'a', label: 'A')],
          selectedValue: 'missing',
          onChanged: (_) {},
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });

    testWidgets('asserts when nested items contain duplicate values', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: const [
            RemixSelectItem(value: 'duplicate', label: 'First'),
            RemixSelectGroup(
              items: [RemixSelectItem(value: 'duplicate', label: 'Second')],
            ),
          ],
          onChanged: (_) {},
        ),
      );

      expect(tester.takeException(), isFlutterError);
    });
  });

  group('RemixSelect styling and composition', () {
    testWidgets('select-level item style is inherited by items', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: const [RemixSelectItem(value: 'a', label: 'Alpha')],
          onChanged: (_) {},
          style: RemixSelectStyler().item(
            RemixSelectMenuItemStyler().text(TextStyler().color(Colors.red)),
          ),
        ),
      );
      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.text('Alpha')).style?.color, Colors.red);
    });

    testWidgets('item style merges after the select default', (tester) async {
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: [
            RemixSelectItem(
              value: 'a',
              label: 'Alpha',
              style: RemixSelectMenuItemStyler().text(
                TextStyler().color(Colors.green),
              ),
            ),
          ],
          onChanged: (_) {},
          style: RemixSelectStyler().item(
            RemixSelectMenuItemStyler().text(TextStyler().color(Colors.red)),
          ),
        ),
      );
      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();

      expect(
        tester.widget<Text>(find.text('Alpha')).style?.color,
        Colors.green,
      );
    });

    testWidgets('raw styleSpec bypasses fluent item styles', (tester) async {
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: [
            RemixSelectItem(
              value: 'a',
              label: 'Alpha',
              style: RemixSelectMenuItemStyler().text(
                TextStyler().color(Colors.green),
              ),
            ),
          ],
          onChanged: (_) {},
          styleSpec: const RemixSelectSpec(
            item: StyleSpec(
              spec: RemixSelectMenuItemSpec(
                text: StyleSpec(
                  spec: TextSpec(style: TextStyle(color: Colors.blue)),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.text('Alpha')).style?.color, Colors.blue);
    });

    testWidgets('part wrappers surround their own resolution boundaries', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: const [RemixSelectItem(value: 'a', label: 'Alpha')],
          onChanged: (_) {},
          triggerWrapper: (context, child) => KeyedSubtree(
            key: const ValueKey('trigger-wrapper'),
            child: child,
          ),
          contentWrapper: (context, child) => KeyedSubtree(
            key: const ValueKey('content-wrapper'),
            child: child,
          ),
        ),
      );

      expect(find.byKey(const ValueKey('trigger-wrapper')), findsOneWidget);
      expect(find.byKey(const ValueKey('content-wrapper')), findsNothing);
      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('content-wrapper')), findsOneWidget);
    });

    testWidgets('long content uses a scroll viewport', (tester) async {
      await tester.pumpRemixApp(
        RemixSelect<int>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          items: [
            for (var index = 0; index < 60; index++)
              RemixSelectItem(value: index, label: 'Option $index'),
          ],
          onChanged: (_) {},
        ),
      );
      await tester.tap(find.byType(RemixSelect<int>));
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('RemixSelect semantics', () {
    testWidgets('trigger exposes name, enabled state, and expanded state', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      try {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            semanticLabel: 'Fruit picker',
            trigger: const RemixSelectTrigger(placeholder: 'Choose'),
            items: const [RemixSelectItem(value: 'a', label: 'Apple')],
            onChanged: (_) {},
          ),
        );

        expect(
          find.descendant(
            of: find.byType(RemixSelect<String>),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Semantics &&
                  widget.properties.label == 'Fruit picker' &&
                  widget.properties.button == true &&
                  widget.properties.enabled == true,
            ),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(RemixSelect<String>),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Semantics && widget.properties.expanded == false,
            ),
          ),
          findsOneWidget,
        );

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();
        expect(
          find.descendant(
            of: find.byType(RemixSelect<String>),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Semantics && widget.properties.expanded == true,
            ),
          ),
          findsOneWidget,
        );
      } finally {
        handle.dispose();
      }
    });

    testWidgets('option owns one menu-item name and selected state', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      try {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Choose'),
            items: const [
              RemixSelectItem(
                value: 'a',
                label: 'Apple',
                semanticLabel: 'Red apple',
              ),
            ],
            selectedValue: 'a',
            onChanged: (_) {},
          ),
        );
        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        final semantics = tester.getSemantics(
          find.bySemanticsLabel('Red apple'),
        );
        expect(semantics.getSemanticsData().role, SemanticsRole.menuItem);
        expect(semantics.flagsCollection.isSelected, Tristate.isTrue);
      } finally {
        handle.dispose();
      }
    });
  });
}
