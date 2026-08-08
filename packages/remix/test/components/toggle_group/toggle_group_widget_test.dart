import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

List<RemixToggleGroupItem<String>> _items(
  List<FocusNode> nodes, {
  bool disableMiddle = false,
}) {
  return [
    RemixToggleGroupItem(
      value: 'list',
      label: 'List',
      icon: Icons.view_list,
      focusNode: nodes[0],
    ),
    RemixToggleGroupItem(
      value: 'grid',
      label: 'Grid',
      icon: Icons.grid_view,
      enabled: !disableMiddle,
      focusNode: nodes[1],
    ),
    RemixToggleGroupItem(
      value: 'board',
      label: 'Board',
      icon: Icons.view_kanban,
      focusNode: nodes[2],
    ),
  ];
}

List<FocusNode> _focusNodes() => List.generate(3, (index) => FocusNode());

void _disposeNodes(List<FocusNode> nodes) {
  for (final node in nodes) {
    node.dispose();
  }
}

void main() {
  group('RemixToggleGroupItem contract', () {
    test('requires a non-null value', () {
      String? value;

      expect(
        () => RemixToggleGroupItem<String?>(value: value, label: 'List'),
        throwsAssertionError,
      );
    });

    test('requires an accessible name for icon-only items', () {
      expect(
        () =>
            RemixToggleGroupItem<String>(value: 'grid', icon: Icons.grid_view),
        throwsAssertionError,
      );
    });

    test('rejects empty labels and semantic labels', () {
      expect(
        () => RemixToggleGroupItem(value: 'grid', label: ''),
        throwsAssertionError,
      );
      expect(
        () => RemixToggleGroupItem(
          value: 'grid',
          icon: Icons.grid_view,
          semanticLabel: '',
        ),
        throwsAssertionError,
      );
    });
  });

  group('RemixToggleGroup', () {
    testWidgets('renders all items', (tester) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: _items(nodes),
          selectedValue: 'list',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NakedToggleGroup<String>), findsOneWidget);
      expect(find.byType(NakedToggleOption<String>), findsNWidgets(3));
      expect(find.text('List'), findsOneWidget);
      expect(find.text('Grid'), findsOneWidget);
      expect(find.text('Board'), findsOneWidget);
      expect(find.byIcon(Icons.grid_view), findsOneWidget);
    });

    testWidgets('styleSpec preserves vertical layout orientation', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [
            RemixToggleGroupItem(value: 'list', label: 'List'),
            RemixToggleGroupItem(value: 'grid', label: 'Grid'),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          orientation: Axis.vertical,
          styleSpec: const ToggleGroupSpec(),
        ),
      );
      await tester.pumpAndSettle();

      final listPosition = tester.getTopLeft(find.text('List'));
      final gridPosition = tester.getTopLeft(find.text('Grid'));
      expect(listPosition.dx, gridPosition.dx);
      expect(listPosition.dy, lessThan(gridPosition.dy));
    });

    testWidgets('styleSpec bypasses fluent style resolution', (tester) async {
      var fluentBuilds = 0;
      final fluentStyle = ToggleGroupStyler().onBuilder((context) {
        fluentBuilds += 1;

        return ToggleGroupStyler(
          item: ToggleGroupItemStyler().foregroundColor(Colors.blue),
        );
      });
      const rawSpec = ToggleGroupSpec(
        item: StyleSpec(
          spec: ToggleGroupItemSpec(
            label: StyleSpec(
              spec: TextSpec(style: TextStyle(color: Colors.red)),
            ),
          ),
        ),
      );

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [RemixToggleGroupItem(value: 'list', label: 'List')],
          selectedValue: 'list',
          onChanged: (_) {},
          style: fluentStyle,
          styleSpec: rawSpec,
        ),
      );
      await tester.pumpAndSettle();

      expect(fluentBuilds, 0);
      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.red);
    });

    testWidgets('raw item defaults bypass per-item fluent styles', (
      tester,
    ) async {
      const rawSpec = ToggleGroupSpec(
        item: StyleSpec(
          spec: ToggleGroupItemSpec(
            label: StyleSpec(
              spec: TextSpec(style: TextStyle(color: Colors.red)),
            ),
          ),
        ),
      );

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: [
            RemixToggleGroupItem(
              value: 'list',
              label: 'List',
              style: ToggleGroupItemStyler().foregroundColor(Colors.green),
            ),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          styleSpec: rawSpec,
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.red);
    });

    testWidgets('group context variants compose with item state variants', (
      tester,
    ) async {
      final style =
          ToggleGroupStyler(
            item: ToggleGroupItemStyler()
                .foregroundColor(Colors.red)
                .onSelected(
                  ToggleGroupItemStyler().foregroundColor(Colors.blue),
                ),
          ).onRtl(
            ToggleGroupStyler(
              item: ToggleGroupItemStyler().foregroundColor(Colors.green),
            ),
          );

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [
            RemixToggleGroupItem(value: 'selected', label: 'Selected'),
            RemixToggleGroupItem(value: 'other', label: 'Other'),
          ],
          selectedValue: 'selected',
          onChanged: (_) {},
          style: style,
        ),
        textDirection: TextDirection.rtl,
      );
      await tester.pumpAndSettle();

      expect(
        tester.widget<Text>(find.text('Selected')).style?.color,
        Colors.blue,
      );
      expect(
        tester.widget<Text>(find.text('Other')).style?.color,
        Colors.green,
      );
    });

    testWidgets('item context variants compose with item state variants', (
      tester,
    ) async {
      final style = ToggleGroupStyler(
        item: ToggleGroupItemStyler()
            .foregroundColor(Colors.red)
            .onSelected(ToggleGroupItemStyler().foregroundColor(Colors.blue))
            .onRtl(ToggleGroupItemStyler().foregroundColor(Colors.green)),
      );

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [
            RemixToggleGroupItem(value: 'selected', label: 'Selected'),
            RemixToggleGroupItem(value: 'other', label: 'Other'),
          ],
          selectedValue: 'selected',
          onChanged: (_) {},
          style: style,
        ),
        textDirection: TextDirection.rtl,
      );
      await tester.pumpAndSettle();

      expect(
        tester.widget<Text>(find.text('Selected')).style?.color,
        Colors.blue,
      );
      expect(
        tester.widget<Text>(find.text('Other')).style?.color,
        Colors.green,
      );
    });

    testWidgets('tapping an item selects its value', (tester) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));
      String? selected;

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: _items(nodes),
          selectedValue: 'list',
          onChanged: (value) => selected = value,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Grid'));
      await tester.pumpAndSettle();

      expect(selected, 'grid');
    });

    testWidgets('tapping the selected item does not emit a change', (
      tester,
    ) async {
      var changes = 0;

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [RemixToggleGroupItem(value: 'list', label: 'List')],
          selectedValue: 'list',
          onChanged: (_) => changes += 1,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('List'));
      await tester.pumpAndSettle();

      expect(changes, 0);
    });

    testWidgets('a disabled item ignores taps', (tester) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));
      var changes = 0;

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: _items(nodes, disableMiddle: true),
          selectedValue: 'list',
          onChanged: (_) => changes += 1,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Grid'));
      await tester.pumpAndSettle();

      expect(changes, 0);
    });

    testWidgets('a null callback disables interaction and item styling', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [RemixToggleGroupItem(value: 'list', label: 'List')],
          selectedValue: 'list',
          style: ToggleGroupStyler(
            item: ToggleGroupItemStyler()
                .foregroundColor(Colors.red)
                .onDisabled(
                  ToggleGroupItemStyler().foregroundColor(Colors.grey),
                ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.grey);
      final option = find.bySemanticsLabel('List');
      final optionCount = option.evaluate().length;
      final optionSemantics = optionCount == 1
          ? tester.getSemantics(option)
          : null;
      semantics.dispose();
      expect(optionCount, 1);
      expect(
        optionSemantics,
        isSemantics(
          label: 'List',
          isButton: true,
          hasEnabledState: true,
          isEnabled: false,
          hasTapAction: false,
        ),
      );
    });

    testWidgets('exposes one tab stop and then exits the group', (
      tester,
    ) async {
      final nodes = _focusNodes();
      final before = FocusNode();
      final after = FocusNode();
      addTearDown(() {
        _disposeNodes(nodes);
        before.dispose();
        after.dispose();
      });

      await tester.pumpRemixApp(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              focusNode: before,
              autofocus: true,
              onPressed: () {},
              child: const Text('Before'),
            ),
            RemixToggleGroup<String>(
              items: _items(nodes),
              selectedValue: 'grid',
              onChanged: (_) {},
            ),
            TextButton(
              focusNode: after,
              onPressed: () {},
              child: const Text('After'),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(before.hasFocus, isTrue);

      await sendKeyAndSettle(tester, LogicalKeyboardKey.tab);
      expect(nodes[1].hasFocus, isTrue);

      await sendKeyAndSettle(tester, LogicalKeyboardKey.tab);
      expect(after.hasFocus, isTrue);
    });

    for (final (orientation, key) in [
      (Axis.horizontal, LogicalKeyboardKey.arrowRight),
      (Axis.vertical, LogicalKeyboardKey.arrowDown),
    ]) {
      testWidgets('$key moves focus forward without selecting', (tester) async {
        final nodes = _focusNodes();
        addTearDown(() => _disposeNodes(nodes));
        var changes = 0;

        await tester.pumpRemixApp(
          RemixToggleGroup<String>(
            items: _items(nodes),
            selectedValue: 'list',
            onChanged: (_) => changes += 1,
            orientation: orientation,
          ),
        );
        await tester.pumpAndSettle();
        nodes[0].requestFocus();
        await tester.pumpAndSettle();

        await sendKeyAndSettle(tester, key);

        expect(nodes[1].hasFocus, isTrue);
        expect(changes, 0);
      });
    }

    for (final (orientation, key) in [
      (Axis.horizontal, LogicalKeyboardKey.arrowLeft),
      (Axis.vertical, LogicalKeyboardKey.arrowUp),
    ]) {
      testWidgets('$key moves focus backward', (tester) async {
        final nodes = _focusNodes();
        addTearDown(() => _disposeNodes(nodes));

        await tester.pumpRemixApp(
          RemixToggleGroup<String>(
            items: _items(nodes),
            selectedValue: 'grid',
            onChanged: (_) {},
            orientation: orientation,
          ),
        );
        await tester.pumpAndSettle();
        nodes[1].requestFocus();
        await tester.pumpAndSettle();

        await sendKeyAndSettle(tester, key);

        expect(nodes[0].hasFocus, isTrue);
      });
    }

    testWidgets('Home and End move to the first and last item', (tester) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: _items(nodes),
          selectedValue: 'grid',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();
      nodes[1].requestFocus();
      await tester.pumpAndSettle();

      await sendKeyAndSettle(tester, LogicalKeyboardKey.home);
      expect(nodes[0].hasFocus, isTrue);

      await sendKeyAndSettle(tester, LogicalKeyboardKey.end);
      expect(nodes[2].hasFocus, isTrue);
    });

    testWidgets('arrow traversal skips disabled items', (tester) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: _items(nodes, disableMiddle: true),
          selectedValue: 'list',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();
      nodes[0].requestFocus();
      await tester.pumpAndSettle();

      await sendKeyAndSettle(tester, LogicalKeyboardKey.arrowRight);

      expect(nodes[2].hasFocus, isTrue);
      expect(nodes[1].hasFocus, isFalse);
    });

    testWidgets('loop wraps while non-looping navigation clamps', (
      tester,
    ) async {
      final loopingNodes = _focusNodes();
      final clampedNodes = _focusNodes();
      addTearDown(() {
        _disposeNodes(loopingNodes);
        _disposeNodes(clampedNodes);
      });

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: _items(loopingNodes),
          selectedValue: 'board',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();
      loopingNodes[2].requestFocus();
      await tester.pumpAndSettle();
      await sendKeyAndSettle(tester, LogicalKeyboardKey.arrowRight);
      expect(loopingNodes[0].hasFocus, isTrue);

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: _items(clampedNodes),
          selectedValue: 'board',
          onChanged: (_) {},
          loop: false,
        ),
      );
      await tester.pumpAndSettle();
      clampedNodes[2].requestFocus();
      await tester.pumpAndSettle();
      await sendKeyAndSettle(tester, LogicalKeyboardKey.arrowRight);
      expect(clampedNodes[2].hasFocus, isTrue);
    });

    testWidgets('RTL inverts horizontal arrow direction', (tester) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: _items(nodes),
          selectedValue: 'grid',
          onChanged: (_) {},
        ),
        textDirection: TextDirection.rtl,
      );
      await tester.pumpAndSettle();
      nodes[1].requestFocus();
      await tester.pumpAndSettle();

      await sendKeyAndSettle(tester, LogicalKeyboardKey.arrowRight);

      expect(nodes[0].hasFocus, isTrue);
    });

    testWidgets('item identity follows values when items reorder', (
      tester,
    ) async {
      final before = FocusNode();
      addTearDown(before.dispose);
      late StateSetter update;
      var values = ['a', 'b', 'c'];

      await tester.pumpRemixApp(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              focusNode: before,
              autofocus: true,
              onPressed: () {},
              child: const Text('Before'),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                update = setState;

                return RemixToggleGroup<String>(
                  items: [
                    for (final value in values)
                      RemixToggleGroupItem(
                        value: value,
                        label: value.toUpperCase(),
                      ),
                  ],
                  selectedValue: 'b',
                  onChanged: (_) {},
                );
              },
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      await sendKeyAndSettle(tester, LogicalKeyboardKey.tab);
      expect(Focus.of(tester.element(find.text('B'))).hasFocus, isTrue);

      update(() => values = ['c', 'a', 'b']);
      await tester.pumpAndSettle();

      expect(Focus.of(tester.element(find.text('B'))).hasFocus, isTrue);
    });

    for (final key in [LogicalKeyboardKey.space, LogicalKeyboardKey.enter]) {
      testWidgets('$key activates the focused item', (tester) async {
        final nodes = _focusNodes();
        addTearDown(() => _disposeNodes(nodes));
        String? selected;

        await tester.pumpRemixApp(
          RemixToggleGroup<String>(
            items: _items(nodes),
            selectedValue: 'list',
            onChanged: (value) => selected = value,
          ),
        );
        await tester.pumpAndSettle();
        nodes[1].requestFocus();
        await tester.pumpAndSettle();

        await sendKeyAndSettle(tester, key);

        expect(selected, 'grid');
      });
    }

    testWidgets('a disabled group has no tab stop', (tester) async {
      final nodes = _focusNodes();
      final before = FocusNode();
      final after = FocusNode();
      addTearDown(() {
        _disposeNodes(nodes);
        before.dispose();
        after.dispose();
      });

      await tester.pumpRemixApp(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              focusNode: before,
              autofocus: true,
              onPressed: () {},
              child: const Text('Before'),
            ),
            RemixToggleGroup<String>(
              items: _items(nodes),
              selectedValue: 'list',
              onChanged: (_) {},
              enabled: false,
            ),
            TextButton(
              focusNode: after,
              onPressed: () {},
              child: const Text('After'),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await sendKeyAndSettle(tester, LogicalKeyboardKey.tab);

      expect(after.hasFocus, isTrue);
      expect(nodes.every((node) => !node.hasFocus), isTrue);
    });

    testWidgets('icon-only items use their semantic label', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [
            RemixToggleGroupItem(
              value: 'grid',
              icon: Icons.grid_view,
              semanticLabel: 'Grid view',
            ),
          ],
          selectedValue: 'grid',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();

      final option = find.bySemanticsLabel('Grid view');
      final optionCount = option.evaluate().length;
      final optionSemantics = optionCount == 1
          ? tester.getSemantics(option)
          : null;
      semantics.dispose();
      expect(optionCount, 1);
      expect(
        optionSemantics,
        isSemantics(
          label: 'Grid view',
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
        ),
      );
    });

    testWidgets('visible labels produce one accessible name', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [RemixToggleGroupItem(value: 'list', label: 'List')],
          selectedValue: 'list',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();

      final option = find.bySemanticsLabel('List');
      final optionCount = option.evaluate().length;
      final optionSemantics = optionCount == 1
          ? tester.getSemantics(option)
          : null;
      semantics.dispose();
      expect(optionCount, 1);
      expect(
        optionSemantics,
        isSemantics(
          label: 'List',
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
        ),
      );
    });

    testWidgets('semanticLabel replaces visible label semantics', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [
            RemixToggleGroupItem(
              value: 'list',
              label: 'List',
              semanticLabel: 'List view',
            ),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();

      final option = find.bySemanticsLabel('List view');
      final optionCount = option.evaluate().length;
      final optionSemantics = optionCount == 1
          ? tester.getSemantics(option)
          : null;
      semantics.dispose();
      expect(optionCount, 1);
      expect(
        optionSemantics,
        isSemantics(
          label: 'List view',
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
        ),
      );
    });

    testWidgets('excludeSemantics hides the group and its items', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [RemixToggleGroupItem(value: 'list', label: 'List')],
          selectedValue: 'list',
          onChanged: (_) {},
          semanticLabel: 'View style',
          excludeSemantics: true,
        ),
      );
      await tester.pumpAndSettle();

      final groupCount = find.bySemanticsLabel('View style').evaluate().length;
      final itemCount = find.bySemanticsLabel('List').evaluate().length;
      semantics.dispose();
      expect(groupCount, 0);
      expect(itemCount, 0);
    });

    testWidgets('an empty group is valid when nothing is selected', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [],
          selectedValue: null,
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NakedToggleGroup<String>), findsOneWidget);
      expect(find.byType(NakedToggleOption<String>), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('rejects duplicate item values', (tester) async {
      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [
            RemixToggleGroupItem(value: 'list', label: 'List'),
            RemixToggleGroupItem(value: 'list', label: 'List again'),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
        ),
      );

      expect(
        tester.takeException().toString(),
        contains('item values must be unique'),
      );
    });

    testWidgets('rejects a selected value that is not an item', (tester) async {
      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [RemixToggleGroupItem(value: 'list', label: 'List')],
          selectedValue: 'grid',
          onChanged: (_) {},
        ),
      );

      expect(
        tester.takeException().toString(),
        contains('selectedValue must match one item'),
      );
    });

    testWidgets('rejects more than one autofocus item', (tester) async {
      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [
            RemixToggleGroupItem(value: 'list', label: 'List', autofocus: true),
            RemixToggleGroupItem(value: 'grid', label: 'Grid', autofocus: true),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
        ),
      );

      expect(
        tester.takeException().toString(),
        contains('Only one item may autofocus'),
      );
    });

    testWidgets('vertical orientation ignores horizontal arrows', (
      tester,
    ) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));

      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: _items(nodes),
          selectedValue: 'list',
          onChanged: (_) {},
          orientation: Axis.vertical,
        ),
      );
      await tester.pumpAndSettle();
      nodes[0].requestFocus();
      await tester.pumpAndSettle();

      await sendKeyAndSettle(tester, LogicalKeyboardKey.arrowRight);
      expect(nodes[0].hasFocus, isTrue);

      await sendKeyAndSettle(tester, LogicalKeyboardKey.arrowDown);
      expect(nodes[1].hasFocus, isTrue);
    });
  });

  group('item visual states', () {
    testWidgets('selected style is removed when selection changes', (
      tester,
    ) async {
      late StateSetter update;
      var selectedValue = 'list';
      final style = ToggleGroupStyler(
        item: ToggleGroupItemStyler()
            .foregroundColor(Colors.red)
            .onSelected(ToggleGroupItemStyler().foregroundColor(Colors.blue)),
      );

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) {
            update = setState;

            return RemixToggleGroup<String>(
              items: const [
                RemixToggleGroupItem(value: 'list', label: 'List'),
                RemixToggleGroupItem(value: 'grid', label: 'Grid'),
              ],
              selectedValue: selectedValue,
              onChanged: (_) {},
              style: style,
            );
          },
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.blue);
      expect(tester.widget<Text>(find.text('Grid')).style?.color, Colors.red);

      update(() => selectedValue = 'grid');
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.red);
      expect(tester.widget<Text>(find.text('Grid')).style?.color, Colors.blue);
    });

    testWidgets('disabled style wins when an item is also selected', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: const [
            RemixToggleGroupItem(value: 'list', label: 'List', enabled: false),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          style: ToggleGroupStyler(
            item: ToggleGroupItemStyler()
                .foregroundColor(Colors.red)
                .onSelected(
                  ToggleGroupItemStyler().foregroundColor(Colors.blue),
                )
                .onDisabled(
                  ToggleGroupItemStyler().foregroundColor(Colors.grey),
                ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.grey);
    });

    testWidgets('focus style is removed when the focused item is disabled', (
      tester,
    ) async {
      final node = FocusNode();
      addTearDown(node.dispose);
      late StateSetter update;
      var itemEnabled = true;

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) {
            update = setState;

            return RemixToggleGroup<String>(
              items: [
                RemixToggleGroupItem(
                  value: 'list',
                  label: 'List',
                  enabled: itemEnabled,
                  focusNode: node,
                ),
              ],
              selectedValue: 'list',
              onChanged: (_) {},
              style: ToggleGroupStyler(
                item: ToggleGroupItemStyler()
                    .foregroundColor(Colors.red)
                    .onFocused(
                      ToggleGroupItemStyler().foregroundColor(Colors.green),
                    )
                    .onDisabled(
                      ToggleGroupItemStyler().foregroundColor(Colors.grey),
                    ),
              ),
            );
          },
        ),
      );
      node.requestFocus();
      await tester.pumpAndSettle();
      expect(node.hasFocus, isTrue);
      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.green);

      update(() => itemEnabled = false);
      await tester.pumpAndSettle();

      expect(node.hasFocus, isFalse);
      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.grey);
    });

    testWidgets('per-item state variants override group item variants', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixToggleGroup<String>(
          items: [
            RemixToggleGroupItem(
              value: 'list',
              label: 'List',
              style: ToggleGroupItemStyler().onSelected(
                ToggleGroupItemStyler().foregroundColor(Colors.purple),
              ),
            ),
            RemixToggleGroupItem(
              value: 'grid',
              label: 'Grid',
              style: ToggleGroupItemStyler().foregroundColor(Colors.green),
            ),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          style: ToggleGroupStyler(
            item: ToggleGroupItemStyler()
                .foregroundColor(Colors.red)
                .onSelected(
                  ToggleGroupItemStyler().foregroundColor(Colors.blue),
                ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.widget<Text>(find.text('List')).style?.color,
        Colors.purple,
      );
      expect(tester.widget<Text>(find.text('Grid')).style?.color, Colors.green);
    });
  });
}
