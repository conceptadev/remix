import 'dart:math' as math;
import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

List<RemixSegmentedControlItem<String>> _items(
  List<FocusNode> nodes, {
  bool disableMiddle = false,
}) {
  return [
    RemixSegmentedControlItem(
      value: 'list',
      label: 'List',
      icon: Icons.view_list,
      focusNode: nodes[0],
    ),
    RemixSegmentedControlItem(
      value: 'grid',
      label: 'Grid',
      icon: Icons.grid_view,
      enabled: !disableMiddle,
      focusNode: nodes[1],
    ),
    RemixSegmentedControlItem(
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

Finder _trackBox() => find
    .descendant(
      of: find.byKey(const ValueKey('RemixSegmentedControl.track')),
      matching: find.byType(Box),
    )
    .first;

/// Labels long enough to wrap, so each segment's minimum intrinsic width
/// (its longest word) is strictly smaller than its maximum (a single line).
const _wrappableItems = <RemixSegmentedControlItem<String>>[
  RemixSegmentedControlItem(value: 'a', label: 'Wrappable long label'),
  RemixSegmentedControlItem(value: 'b', label: 'Another long one'),
];

double _largestSegmentExtent(
  WidgetTester tester,
  double Function(RenderBox segment) measure,
) {
  final options = find.byType(NakedToggleOption<String>);
  var largest = 0.0;
  for (var index = 0; index < options.evaluate().length; index++) {
    largest = math.max(
      largest,
      measure(tester.renderObject<RenderBox>(options.at(index))),
    );
  }

  return largest;
}

void _expectContained(Rect inner, Rect outer) {
  expect(inner.left, greaterThanOrEqualTo(outer.left));
  expect(inner.top, greaterThanOrEqualTo(outer.top));
  expect(inner.right, lessThanOrEqualTo(outer.right));
  expect(inner.bottom, lessThanOrEqualTo(outer.bottom));
}

void main() {
  group('RemixSegmentedControlItem contract', () {
    test('requires an accessible name for icon-only items', () {
      expect(
        () => RemixSegmentedControlItem<String>(
          value: 'grid',
          icon: Icons.grid_view,
        ),
        throwsAssertionError,
      );
    });

    testWidgets('rejects blank labels and semantic labels', (tester) async {
      for (final blank in ['', ' ', '\t\n']) {
        await tester.pumpRemixApp(
          RemixSegmentedControl<String>(
            items: [RemixSegmentedControlItem(value: 'grid', label: blank)],
            selectedValue: 'grid',
          ),
        );
        expect(tester.takeException(), isA<AssertionError>());

        await tester.pumpRemixApp(
          RemixSegmentedControl<String>(
            items: [
              RemixSegmentedControlItem(
                value: 'grid',
                icon: Icons.grid_view,
                semanticLabel: blank,
              ),
            ],
            selectedValue: 'grid',
          ),
        );
        expect(tester.takeException(), isA<AssertionError>());
      }
    });
  });

  group('RemixSegmentedControl', () {
    testWidgets('rejects a blank control semantic label', (tester) async {
      for (final blank in ['', ' ', '\t\n']) {
        await tester.pumpRemixApp(
          RemixSegmentedControl<String>(
            items: const [
              RemixSegmentedControlItem(value: 'list', label: 'List'),
            ],
            selectedValue: null,
            semanticLabel: blank,
          ),
        );

        expect(tester.takeException(), isA<AssertionError>());
      }
    });

    testWidgets('renders all items', (tester) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
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

    testWidgets('shrink-wraps the segmented-control container', (tester) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: _items(nodes),
          selectedValue: 'list',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();

      final size = tester.getSize(_trackBox());
      expect(size.width, lessThan(400));
      expect(size.height, lessThan(100));
    });

    testWidgets(
      'horizontal root and semantics shrink vertically and only fill width',
      (tester) async {
        final semantics = tester.ensureSemantics();
        const parentKey = ValueKey('horizontal-bounds');

        Widget build({required bool fillMainAxis}) {
          return SizedBox(
            key: parentKey,
            width: 320,
            height: 120,
            child: Center(
              child: RemixSegmentedControl<String>(
                items: const [
                  RemixSegmentedControlItem(value: 'day', label: 'Day'),
                  RemixSegmentedControlItem(value: 'week', label: 'Week'),
                ],
                selectedValue: 'day',
                onChanged: (_) {},
                semanticLabel: 'Horizontal periods',
                style: fillMainAxis
                    ? SegmentedControlStyler().mainAxisSize(.max)
                    : SegmentedControlStyler(),
              ),
            ),
          );
        }

        for (final fillMainAxis in [false, true]) {
          await tester.pumpRemixApp(build(fillMainAxis: fillMainAxis));
          await tester.pumpAndSettle();

          final parentRect = tester.getRect(find.byKey(parentKey));
          final rootRect = tester.getRect(
            find.byType(RemixSegmentedControl<String>),
          );
          final trackRect = tester.getRect(_trackBox());
          final semanticsRect = tester.getRect(
            find.bySemanticsLabel('Horizontal periods'),
          );

          expect(rootRect, trackRect);
          expect(semanticsRect, trackRect);
          expect(trackRect.center, parentRect.center);
          expect(trackRect.height, lessThan(parentRect.height));
          if (fillMainAxis) {
            expect(trackRect.width, parentRect.width);
          } else {
            expect(trackRect.width, lessThan(parentRect.width));
          }
        }
        semantics.dispose();
      },
    );

    testWidgets(
      'vertical root and semantics shrink horizontally and only fill height',
      (tester) async {
        final semantics = tester.ensureSemantics();
        const parentKey = ValueKey('vertical-bounds');

        Widget build({required bool fillMainAxis}) {
          return SizedBox(
            key: parentKey,
            width: 220,
            height: 300,
            child: Center(
              child: RemixSegmentedControl<String>(
                items: const [
                  RemixSegmentedControlItem(value: 'day', label: 'Day'),
                  RemixSegmentedControlItem(value: 'week', label: 'Week'),
                ],
                selectedValue: 'day',
                onChanged: (_) {},
                orientation: Axis.vertical,
                semanticLabel: 'Vertical periods',
                style: fillMainAxis
                    ? SegmentedControlStyler().mainAxisSize(.max)
                    : SegmentedControlStyler(),
              ),
            ),
          );
        }

        for (final fillMainAxis in [false, true]) {
          await tester.pumpRemixApp(build(fillMainAxis: fillMainAxis));
          await tester.pumpAndSettle();

          final parentRect = tester.getRect(find.byKey(parentKey));
          final rootRect = tester.getRect(
            find.byType(RemixSegmentedControl<String>),
          );
          final trackRect = tester.getRect(_trackBox());
          final semanticsRect = tester.getRect(
            find.bySemanticsLabel('Vertical periods'),
          );

          expect(rootRect, trackRect);
          expect(semanticsRect, trackRect);
          expect(trackRect.center, parentRect.center);
          expect(trackRect.width, lessThan(parentRect.width));
          if (fillMainAxis) {
            expect(trackRect.height, parentRect.height);
          } else {
            expect(trackRect.height, lessThan(parentRect.height));
          }
        }
        semantics.dispose();
      },
    );

    testWidgets('styleSpec preserves vertical layout orientation', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
            RemixSegmentedControlItem(value: 'grid', label: 'Grid'),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          orientation: Axis.vertical,
          styleSpec: const SegmentedControlSpec(),
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
      final fluentStyle = SegmentedControlStyler().onBuilder((context) {
        fluentBuilds += 1;

        return SegmentedControlStyler(
          item: SegmentedControlItemStyler()
              .labelColor(Colors.blue)
              .iconColor(Colors.blue),
        );
      });
      const rawSpec = SegmentedControlSpec(
        container: StyleSpec(
          spec: BoxSpec(decoration: BoxDecoration(color: Colors.green)),
        ),
        item: StyleSpec(
          spec: SegmentedControlItemSpec(
            label: StyleSpec(
              spec: TextSpec(style: TextStyle(color: Colors.red)),
            ),
          ),
        ),
      );

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          style: fluentStyle,
          styleSpec: rawSpec,
        ),
      );
      await tester.pumpAndSettle();

      expect(fluentBuilds, 0);
      final track = tester.widget<Box>(_trackBox());
      final decoration = track.styleSpec!.spec.decoration as BoxDecoration;
      expect(decoration.color, Colors.green);
      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.red);
    });

    testWidgets('raw item defaults bypass per-item fluent styles', (
      tester,
    ) async {
      const rawSpec = SegmentedControlSpec(
        item: StyleSpec(
          spec: SegmentedControlItemSpec(
            label: StyleSpec(
              spec: TextSpec(style: TextStyle(color: Colors.red)),
            ),
          ),
        ),
      );

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: [
            RemixSegmentedControlItem(
              value: 'list',
              label: 'List',
              style: SegmentedControlItemStyler()
                  .labelColor(Colors.green)
                  .iconColor(Colors.green),
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
          SegmentedControlStyler(
            item: SegmentedControlItemStyler()
                .labelColor(Colors.red)
                .iconColor(Colors.red)
                .onSelected(
                  SegmentedControlItemStyler()
                      .labelColor(Colors.blue)
                      .iconColor(Colors.blue),
                ),
          ).onRtl(
            SegmentedControlStyler(
              item: SegmentedControlItemStyler()
                  .labelColor(Colors.green)
                  .iconColor(Colors.green),
            ),
          );

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'selected', label: 'Selected'),
            RemixSegmentedControlItem(value: 'other', label: 'Other'),
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
      final style = SegmentedControlStyler(
        item: SegmentedControlItemStyler()
            .labelColor(Colors.red)
            .iconColor(Colors.red)
            .onSelected(
              SegmentedControlItemStyler()
                  .labelColor(Colors.blue)
                  .iconColor(Colors.blue),
            )
            .onRtl(
              SegmentedControlItemStyler()
                  .labelColor(Colors.green)
                  .iconColor(Colors.green),
            ),
      );

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'selected', label: 'Selected'),
            RemixSegmentedControlItem(value: 'other', label: 'Other'),
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

    testWidgets('tapping emits a non-null value when selection starts null', (
      tester,
    ) async {
      final nodes = _focusNodes();
      addTearDown(() => _disposeNodes(nodes));
      final changes = <String>[];

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: _items(nodes),
          selectedValue: null,
          onChanged: changes.add,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Grid'));
      await tester.pumpAndSettle();

      expect(changes, ['grid']);
    });

    testWidgets('tapping the selected item does not emit a change', (
      tester,
    ) async {
      var changes = 0;

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
          ],
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
        RemixSegmentedControl<String>(
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
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
          ],
          selectedValue: 'list',
          style: SegmentedControlStyler(
            item: SegmentedControlItemStyler()
                .labelColor(Colors.red)
                .iconColor(Colors.red)
                .onDisabled(
                  SegmentedControlItemStyler()
                      .labelColor(Colors.grey)
                      .iconColor(Colors.grey),
                ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.grey);
      final option = find.bySemanticsLabel('List');
      expect(option, findsOneWidget);
      expect(
        tester.getSemantics(option),
        isSemantics(
          label: 'List',
          isButton: true,
          hasSelectedState: true,
          isSelected: true,
          hasEnabledState: true,
          isEnabled: false,
          isFocusable: false,
          hasTapAction: false,
          hasFocusAction: false,
          hasCheckedState: false,
          hasToggledState: false,
        ),
      );
      semantics.dispose();
    });

    testWidgets('exposes one tab stop and then exits the group', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
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
            RemixSegmentedControl<String>(
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
      expect(
        tester.getSemantics(find.bySemanticsLabel('Grid')),
        isSemantics(isFocused: true, isFocusable: true, hasFocusAction: true),
      );

      await sendKeyAndSettle(tester, LogicalKeyboardKey.tab);
      expect(after.hasFocus, isTrue);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Grid')),
        isSemantics(isFocused: false),
      );
      semantics.dispose();
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
          RemixSegmentedControl<String>(
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
          RemixSegmentedControl<String>(
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
        RemixSegmentedControl<String>(
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
        RemixSegmentedControl<String>(
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
        RemixSegmentedControl<String>(
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
        RemixSegmentedControl<String>(
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
        RemixSegmentedControl<String>(
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

    testWidgets(
      'ambient direction controls visual, keyboard, and semantics order',
      (tester) async {
        final semantics = tester.ensureSemantics();
        final nodes = _focusNodes();
        addTearDown(() => _disposeNodes(nodes));

        await tester.pumpRemixApp(
          RemixSegmentedControl<String>(
            items: _items(nodes),
            selectedValue: 'list',
            onChanged: (_) {},
          ),
          textDirection: TextDirection.ltr,
        );
        await tester.pumpAndSettle();

        final options = find.byType(NakedToggleOption<String>);
        final firstRect = tester.getRect(options.at(0));
        final secondRect = tester.getRect(options.at(1));
        final thirdRect = tester.getRect(options.at(2));

        expect(firstRect.left, lessThan(secondRect.left));
        expect(secondRect.left, lessThan(thirdRect.left));
        expect(tester.getRect(find.bySemanticsLabel('List')), firstRect);
        expect(tester.getRect(find.bySemanticsLabel('Grid')), secondRect);
        expect(tester.getRect(find.bySemanticsLabel('Board')), thirdRect);

        nodes[0].requestFocus();
        await tester.pumpAndSettle();
        await sendKeyAndSettle(tester, LogicalKeyboardKey.arrowRight);

        expect(nodes[1].hasFocus, isTrue);
        semantics.dispose();
      },
    );

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

                return RemixSegmentedControl<String>(
                  items: [
                    for (final value in values)
                      RemixSegmentedControlItem(
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

    testWidgets('restores caller-owned focus node properties', (tester) async {
      final node = FocusNode(canRequestFocus: false, skipTraversal: true);
      addTearDown(node.dispose);
      late StateSetter update;
      var showControl = true;

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return showControl
                ? RemixSegmentedControl<String>(
                    items: [
                      RemixSegmentedControlItem(
                        value: 'list',
                        label: 'List',
                        focusNode: node,
                      ),
                    ],
                    selectedValue: 'list',
                    onChanged: (_) {},
                  )
                : const SizedBox();
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(node.canRequestFocus, isTrue);
      expect(node.skipTraversal, isFalse);

      update(() => showControl = false);
      await tester.pumpAndSettle();

      expect(node.canRequestFocus, isFalse);
      expect(node.skipTraversal, isTrue);
    });

    for (final key in [LogicalKeyboardKey.space, LogicalKeyboardKey.enter]) {
      testWidgets('$key activates the focused item', (tester) async {
        final nodes = _focusNodes();
        addTearDown(() => _disposeNodes(nodes));
        String? selected;

        await tester.pumpRemixApp(
          RemixSegmentedControl<String>(
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
            RemixSegmentedControl<String>(
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
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(
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
      expect(option, findsOneWidget);
      expect(
        tester.getSemantics(option),
        isSemantics(
          label: 'Grid view',
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
        ),
      );
      semantics.dispose();
    });

    testWidgets('group label contains explicit option nodes', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
            RemixSegmentedControlItem(value: 'grid', label: 'Grid'),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          semanticLabel: 'View style',
        ),
      );
      await tester.pumpAndSettle();

      final group = tester.getSemantics(find.bySemanticsLabel('View style'));

      expect(group.childrenCount, 2);
      expect(find.bySemanticsLabel('List'), findsOneWidget);
      expect(find.bySemanticsLabel('Grid'), findsOneWidget);
      semantics.dispose();
    });

    testWidgets('options expose selected-button mutually exclusive semantics', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
            RemixSegmentedControlItem(value: 'grid', label: 'Grid'),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();

      final selected = find.bySemanticsLabel('List');
      final unselected = find.bySemanticsLabel('Grid');
      expect(selected, findsOneWidget);
      expect(unselected, findsOneWidget);
      expect(
        tester.getSemantics(selected),
        isSemantics(
          label: 'List',
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
          hasEnabledState: true,
          isEnabled: true,
          isFocusable: true,
          isInMutuallyExclusiveGroup: true,
          hasTapAction: true,
          hasFocusAction: true,
          hasCheckedState: false,
          hasToggledState: false,
        ),
      );
      expect(
        tester.getSemantics(unselected),
        isSemantics(
          label: 'Grid',
          isButton: true,
          isSelected: false,
          hasSelectedState: true,
          hasEnabledState: true,
          isEnabled: true,
          isFocusable: true,
          isInMutuallyExclusiveGroup: true,
          hasTapAction: true,
          hasFocusAction: true,
          hasCheckedState: false,
          hasToggledState: false,
        ),
      );
      semantics.dispose();
    });

    testWidgets('semantics activation selects an inactive option', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      String? selected;

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
            RemixSegmentedControlItem(value: 'grid', label: 'Grid'),
          ],
          selectedValue: 'list',
          onChanged: (value) => selected = value,
        ),
      );
      await tester.pumpAndSettle();

      final grid = find.semantics.byLabel('Grid');
      expect(grid, findsOne);
      tester.semantics.tap(grid);
      await tester.pumpAndSettle();

      expect(selected, 'grid');
      semantics.dispose();
    });

    testWidgets('semanticLabel replaces visible label semantics', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(
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
      expect(option, findsOneWidget);
      expect(
        tester.getSemantics(option),
        isSemantics(
          label: 'List view',
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
        ),
      );
      semantics.dispose();
    });

    testWidgets('excludeSemantics hides the group and its items', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          semanticLabel: 'View style',
          excludeSemantics: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('View style'), findsNothing);
      expect(find.bySemanticsLabel('List'), findsNothing);
      semantics.dispose();
    });

    testWidgets('an empty group is valid when nothing is selected', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
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
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
            RemixSegmentedControlItem(value: 'list', label: 'List again'),
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
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
          ],
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
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(
              value: 'list',
              label: 'List',
              autofocus: true,
            ),
            RemixSegmentedControlItem(
              value: 'grid',
              label: 'Grid',
              autofocus: true,
            ),
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
        RemixSegmentedControl<String>(
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
    testWidgets('hovered and pressed styles resolve at runtime', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          style: SegmentedControlStyler(
            item: SegmentedControlItemStyler()
                .labelColor(Colors.red)
                .iconColor(Colors.red)
                .onHovered(
                  SegmentedControlItemStyler()
                      .labelColor(Colors.green)
                      .iconColor(Colors.green),
                )
                .onPressed(
                  SegmentedControlItemStyler()
                      .labelColor(Colors.purple)
                      .iconColor(Colors.purple),
                ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer(location: Offset.zero);
      await mouse.moveTo(tester.getCenter(find.text('List')));
      await tester.pump();
      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.green);

      await mouse.down(tester.getCenter(find.text('List')));
      await tester.pump();
      expect(
        tester.widget<Text>(find.text('List')).style?.color,
        Colors.purple,
      );

      await mouse.up();
      await mouse.moveTo(Offset.zero);
      await tester.pump();
      expect(tester.widget<Text>(find.text('List')).style?.color, Colors.red);
    });

    testWidgets('selected style is removed when selection changes', (
      tester,
    ) async {
      late StateSetter update;
      var selectedValue = 'list';
      final style = SegmentedControlStyler(
        item: SegmentedControlItemStyler()
            .labelColor(Colors.red)
            .iconColor(Colors.red)
            .onSelected(
              SegmentedControlItemStyler()
                  .labelColor(Colors.blue)
                  .iconColor(Colors.blue),
            ),
      );

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) {
            update = setState;

            return RemixSegmentedControl<String>(
              items: const [
                RemixSegmentedControlItem(value: 'list', label: 'List'),
                RemixSegmentedControlItem(value: 'grid', label: 'Grid'),
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
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(
              value: 'list',
              label: 'List',
              enabled: false,
            ),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          style: SegmentedControlStyler(
            item: SegmentedControlItemStyler()
                .labelColor(Colors.red)
                .iconColor(Colors.red)
                .onSelected(
                  SegmentedControlItemStyler()
                      .labelColor(Colors.blue)
                      .iconColor(Colors.blue),
                )
                .onDisabled(
                  SegmentedControlItemStyler()
                      .labelColor(Colors.grey)
                      .iconColor(Colors.grey),
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

            return RemixSegmentedControl<String>(
              items: [
                RemixSegmentedControlItem(
                  value: 'list',
                  label: 'List',
                  enabled: itemEnabled,
                  focusNode: node,
                ),
              ],
              selectedValue: 'list',
              onChanged: (_) {},
              style: SegmentedControlStyler(
                item: SegmentedControlItemStyler()
                    .labelColor(Colors.red)
                    .iconColor(Colors.red)
                    .onFocused(
                      SegmentedControlItemStyler()
                          .labelColor(Colors.green)
                          .iconColor(Colors.green),
                    )
                    .onDisabled(
                      SegmentedControlItemStyler()
                          .labelColor(Colors.grey)
                          .iconColor(Colors.grey),
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
        RemixSegmentedControl<String>(
          items: [
            RemixSegmentedControlItem(
              value: 'list',
              label: 'List',
              style: SegmentedControlItemStyler().onSelected(
                SegmentedControlItemStyler()
                    .labelColor(Colors.purple)
                    .iconColor(Colors.purple),
              ),
            ),
            RemixSegmentedControlItem(
              value: 'grid',
              label: 'Grid',
              style: SegmentedControlItemStyler()
                  .labelColor(Colors.green)
                  .iconColor(Colors.green),
            ),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          style: SegmentedControlStyler(
            item: SegmentedControlItemStyler()
                .labelColor(Colors.red)
                .iconColor(Colors.red)
                .onSelected(
                  SegmentedControlItemStyler()
                      .labelColor(Colors.blue)
                      .iconColor(Colors.blue),
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

  group('segmented layout and track anatomy', () {
    testWidgets(
      'bounded horizontal spacing contains options and semantics and activates',
      (tester) async {
        final semantics = tester.ensureSemantics();
        const labels = ['A', 'B', 'C'];
        String? changedValue;

        await tester.pumpRemixApp(
          SizedBox(
            width: 50,
            child: RemixSegmentedControl<String>(
              items: const [
                RemixSegmentedControlItem(value: 'a', label: 'A'),
                RemixSegmentedControlItem(value: 'b', label: 'B'),
                RemixSegmentedControlItem(value: 'c', label: 'C'),
              ],
              selectedValue: 'a',
              onChanged: (value) => changedValue = value,
              style: SegmentedControlStyler().mainAxisSize(.max).spacing(30),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final trackRect = tester.getRect(_trackBox());
        final options = find.byType(NakedToggleOption<String>);
        for (var index = 0; index < 3; index++) {
          final optionRect = tester.getRect(options.at(index));
          expect(optionRect.width, greaterThan(0));
          _expectContained(optionRect, trackRect);
          _expectContained(
            tester.getRect(find.bySemanticsLabel(labels[index])),
            trackRect,
          );
        }

        await tester.tap(options.at(2));
        await tester.pumpAndSettle();

        expect(changedValue, 'c');
        semantics.dispose();
      },
    );

    testWidgets(
      'bounded vertical spacing contains options and semantics and activates',
      (tester) async {
        final semantics = tester.ensureSemantics();
        const labels = ['A', 'B', 'C'];
        String? changedValue;

        await tester.pumpRemixApp(
          SizedBox(
            height: 50,
            child: RemixSegmentedControl<String>(
              items: const [
                RemixSegmentedControlItem(value: 'a', label: 'A'),
                RemixSegmentedControlItem(value: 'b', label: 'B'),
                RemixSegmentedControlItem(value: 'c', label: 'C'),
              ],
              selectedValue: 'a',
              onChanged: (value) => changedValue = value,
              orientation: Axis.vertical,
              style: SegmentedControlStyler().mainAxisSize(.max).spacing(30),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final trackRect = tester.getRect(_trackBox());
        final options = find.byType(NakedToggleOption<String>);
        for (var index = 0; index < 3; index++) {
          final optionRect = tester.getRect(options.at(index));
          expect(optionRect.height, greaterThan(0));
          _expectContained(optionRect, trackRect);
          _expectContained(
            tester.getRect(find.bySemanticsLabel(labels[index])),
            trackRect,
          );
        }

        await tester.tap(options.at(2));
        await tester.pumpAndSettle();

        expect(changedValue, 'c');
        semantics.dispose();
      },
    );

    testWidgets(
      'maximum finite spacing preserves two nonzero options and semantics',
      (tester) async {
        final semantics = tester.ensureSemantics();
        String? changedValue;

        await tester.pumpRemixApp(
          SizedBox(
            width: 50,
            child: RemixSegmentedControl<String>(
              items: const [
                RemixSegmentedControlItem(value: 'a', label: 'A'),
                RemixSegmentedControlItem(value: 'b', label: 'B'),
              ],
              selectedValue: 'a',
              onChanged: (value) => changedValue = value,
              style: SegmentedControlStyler()
                  .mainAxisSize(.max)
                  .spacing(double.maxFinite),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final trackRect = tester.getRect(_trackBox());
        final options = find.byType(NakedToggleOption<String>);
        for (var index = 0; index < 2; index++) {
          final optionRect = tester.getRect(options.at(index));
          final semanticsRect = tester.getRect(
            find.bySemanticsLabel(index == 0 ? 'A' : 'B'),
          );
          expect(optionRect.width, greaterThan(0));
          expect(semanticsRect.width, greaterThan(0));
          _expectContained(optionRect, trackRect);
          _expectContained(semanticsRect, trackRect);
        }

        await tester.tap(options.at(1));
        await tester.pumpAndSettle();

        expect(changedValue, 'b');
        semantics.dispose();
      },
    );

    testWidgets(
      'maximum finite spacing stays finite on an unbounded main axis',
      (tester) async {
        await tester.pumpRemixApp(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: RemixSegmentedControl<String>(
              items: const [
                RemixSegmentedControlItem(value: 'a', label: 'A'),
                RemixSegmentedControlItem(value: 'b', label: 'B'),
                RemixSegmentedControlItem(value: 'c', label: 'C'),
              ],
              selectedValue: 'a',
              onChanged: (_) {},
              style: SegmentedControlStyler().spacing(double.maxFinite),
            ),
          ),
        );
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(tester.getSize(_trackBox()).width.isFinite, isTrue);
        final options = find.byType(NakedToggleOption<String>);
        for (var index = 0; index < 3; index++) {
          final optionWidth = tester.getSize(options.at(index)).width;
          expect(optionWidth.isFinite, isTrue);
          expect(optionWidth, greaterThan(0));
        }
      },
    );

    testWidgets(
      'compressed RTL spacing contains options and semantics and activates',
      (tester) async {
        final semantics = tester.ensureSemantics();
        const labels = ['A', 'B', 'C'];
        String? changedValue;

        await tester.pumpRemixApp(
          SizedBox(
            width: 50,
            child: RemixSegmentedControl<String>(
              items: const [
                RemixSegmentedControlItem(value: 'a', label: 'A'),
                RemixSegmentedControlItem(value: 'b', label: 'B'),
                RemixSegmentedControlItem(value: 'c', label: 'C'),
              ],
              selectedValue: 'a',
              onChanged: (value) => changedValue = value,
              style: SegmentedControlStyler().mainAxisSize(.max).spacing(30),
            ),
          ),
          textDirection: TextDirection.rtl,
        );
        await tester.pumpAndSettle();

        final trackRect = tester.getRect(_trackBox());
        final options = find.byType(NakedToggleOption<String>);
        final optionRects = [
          for (var index = 0; index < 3; index++)
            tester.getRect(options.at(index)),
        ];
        expect(optionRects[0].left, greaterThan(optionRects[1].left));
        expect(optionRects[1].left, greaterThan(optionRects[2].left));
        for (var index = 0; index < 3; index++) {
          _expectContained(optionRects[index], trackRect);
          _expectContained(
            tester.getRect(find.bySemanticsLabel(labels[index])),
            trackRect,
          );
        }

        await tester.tap(options.at(2));
        await tester.pumpAndSettle();

        expect(changedValue, 'c');
        semantics.dispose();
      },
    );

    testWidgets('item spacing controls the horizontal icon-label gap', (
      tester,
    ) async {
      const spacing = 11.0;

      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(
              value: 'list',
              label: 'List',
              icon: Icons.view_list,
            ),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          style: SegmentedControlStyler(
            item: SegmentedControlItemStyler().spacing(spacing),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final iconRect = tester.getRect(find.byIcon(Icons.view_list));
      final labelRect = tester.getRect(find.text('List'));
      expect(labelRect.left - iconRect.right, closeTo(spacing, 0.01));
    });

    testWidgets('horizontal segments use the largest intrinsic width', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'a', label: 'A'),
            RemixSegmentedControlItem(value: 'long', label: 'Longer label'),
            RemixSegmentedControlItem(
              value: 'icon',
              icon: Icons.grid_view,
              semanticLabel: 'Grid',
            ),
          ],
          selectedValue: 'a',
          onChanged: (_) {},
          style: SegmentedControlStyler(
            item: SegmentedControlItemStyler().paddingAll(8),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final options = find.byType(NakedToggleOption<String>);
      final widths = [
        for (var index = 0; index < 3; index++)
          tester.getSize(options.at(index)).width,
      ];
      final trackWidth = tester.getSize(_trackBox()).width;

      expect(widths[0], closeTo(widths[1], 0.01));
      expect(widths[1], closeTo(widths[2], 0.01));
      expect(trackWidth, closeTo(widths.first * 3, 0.01));
      expect(trackWidth, lessThan(800));
    });

    testWidgets('an explicit track width is divided equally', (tester) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'day', label: 'Day'),
            RemixSegmentedControlItem(value: 'week', label: 'Week'),
            RemixSegmentedControlItem(value: 'month', label: 'Month'),
          ],
          selectedValue: 'day',
          onChanged: (_) {},
          style: SegmentedControlStyler().constraintsOnly(width: 300),
        ),
      );
      await tester.pumpAndSettle();

      final options = find.byType(NakedToggleOption<String>);

      expect(tester.getSize(_trackBox()).width, 300);
      for (var index = 0; index < 3; index++) {
        expect(tester.getSize(options.at(index)).width, closeTo(100, 0.01));
      }
    });

    testWidgets('horizontal segments fill the shared cross axis', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 180,
          child: RemixSegmentedControl<String>(
            items: const [
              RemixSegmentedControlItem(value: 'day', label: 'Day'),
              RemixSegmentedControlItem(value: 'week', label: 'This week'),
              RemixSegmentedControlItem(value: 'month', label: 'Month'),
            ],
            selectedValue: 'week',
            onChanged: (_) {},
            style: SegmentedControlStyler()
                .mainAxisSize(.max)
                .item(SegmentedControlItemStyler().paddingAll(8)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final options = find.byType(NakedToggleOption<String>);
      final heights = [
        for (var index = 0; index < 3; index++)
          tester.getSize(options.at(index)).height,
      ];

      expect(heights[0], closeTo(heights[1], 0.01));
      expect(heights[1], closeTo(heights[2], 0.01));
    });

    testWidgets('mainAxisSize max opts into the bounded width', (tester) async {
      Widget build(SegmentedControlStyler style) {
        return SizedBox(
          width: 300,
          child: RemixSegmentedControl<String>(
            items: const [
              RemixSegmentedControlItem(value: 'day', label: 'Day'),
              RemixSegmentedControlItem(value: 'week', label: 'Week'),
            ],
            selectedValue: 'day',
            onChanged: (_) {},
            style: style,
          ),
        );
      }

      await tester.pumpRemixApp(build(SegmentedControlStyler()));
      await tester.pumpAndSettle();
      expect(tester.getSize(_trackBox()).width, lessThan(300));

      await tester.pumpRemixApp(
        build(SegmentedControlStyler().mainAxisSize(.max)),
      );
      await tester.pumpAndSettle();
      expect(tester.getSize(_trackBox()).width, 300);
    });

    testWidgets('rejects negative spacing when creating the layout', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'day', label: 'Day'),
            RemixSegmentedControlItem(value: 'week', label: 'Week'),
          ],
          selectedValue: 'day',
          onChanged: (_) {},
          style: SegmentedControlStyler().spacing(-1),
        ),
      );

      expect(tester.takeException(), isA<AssertionError>());
    });

    testWidgets('rejects negative spacing when updating the layout', (
      tester,
    ) async {
      late StateSetter update;
      var spacing = 0.0;

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return RemixSegmentedControl<String>(
              items: const [],
              selectedValue: null,
              onChanged: (_) {},
              style: SegmentedControlStyler().spacing(spacing),
            );
          },
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      update(() => spacing = -1);
      await tester.pump();

      expect(tester.takeException(), isA<AssertionError>());
    });

    for (final invalidSpacing in [
      (name: 'NaN', value: double.nan),
      (name: 'infinite', value: double.infinity),
    ]) {
      testWidgets(
        'rejects ${invalidSpacing.name} spacing when creating the layout',
        (tester) async {
          await tester.pumpRemixApp(
            RemixSegmentedControl<String>(
              items: const [
                RemixSegmentedControlItem(value: 'day', label: 'Day'),
                RemixSegmentedControlItem(value: 'week', label: 'Week'),
              ],
              selectedValue: 'day',
              onChanged: (_) {},
              style: SegmentedControlStyler().spacing(invalidSpacing.value),
            ),
          );

          expect(tester.takeException(), isA<AssertionError>());
        },
      );

      testWidgets(
        'rejects ${invalidSpacing.name} spacing when updating the layout',
        (tester) async {
          late StateSetter update;
          var spacing = 0.0;

          await tester.pumpRemixApp(
            StatefulBuilder(
              builder: (context, setState) {
                update = setState;
                return RemixSegmentedControl<String>(
                  items: const [],
                  selectedValue: null,
                  onChanged: (_) {},
                  style: SegmentedControlStyler().spacing(spacing),
                );
              },
            ),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);

          update(() => spacing = invalidSpacing.value);
          await tester.pump();

          expect(tester.takeException(), isA<AssertionError>());
        },
      );
    }

    testWidgets('vertical intrinsic widths use per-segment height', (
      tester,
    ) async {
      const trackHeight = 100.0;
      const spacing = 10.0;
      const aspectRatio = 2.0;

      await tester.pumpRemixApp(
        SizedBox(
          height: trackHeight,
          child: RemixSegmentedControl<String>(
            items: const [
              RemixSegmentedControlItem(value: 'day', label: 'Day'),
              RemixSegmentedControlItem(value: 'week', label: 'Week'),
            ],
            selectedValue: 'day',
            onChanged: (_) {},
            orientation: Axis.vertical,
            style: SegmentedControlStyler()
                .mainAxisSize(.max)
                .spacing(spacing)
                .item(
                  SegmentedControlItemStyler().wrap(.aspectRatio(aspectRatio)),
                ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final track = tester.renderObject<RenderBox>(_trackBox());
      final segmentHeight = (trackHeight - spacing) / 2;
      final expectedWidth = segmentHeight * aspectRatio;

      expect(track.size, Size(expectedWidth, trackHeight));
      expect(
        track.getMinIntrinsicWidth(trackHeight),
        closeTo(expectedWidth, 0.01),
      );
      expect(
        track.getMaxIntrinsicWidth(trackHeight),
        closeTo(expectedWidth, 0.01),
      );
    });

    testWidgets('oversized spacing clamps intrinsics the way layout does', (
      tester,
    ) async {
      // Spacing wider than the track would starve every segment, so layout
      // clamps it. The intrinsic queries must apply the same clamp or an
      // intrinsic-sizing parent collapses the track to zero.
      const trackHeight = 100.0;
      const spacing = 150.0;
      const aspectRatio = 2.0;

      Widget buildControl() => RemixSegmentedControl<String>(
        items: const [
          RemixSegmentedControlItem(value: 'day', label: 'Day'),
          RemixSegmentedControlItem(value: 'week', label: 'Week'),
        ],
        selectedValue: 'day',
        onChanged: (_) {},
        orientation: Axis.vertical,
        style: SegmentedControlStyler()
            .mainAxisSize(.max)
            .spacing(spacing)
            .item(SegmentedControlItemStyler().wrap(.aspectRatio(aspectRatio))),
      );

      await tester.pumpRemixApp(
        SizedBox(height: trackHeight, child: buildControl()),
      );
      await tester.pumpAndSettle();

      // effectiveSpacing clamps to trackHeight / childCount == 50.
      const segmentHeight = (trackHeight - 50.0) / 2;
      const expectedWidth = segmentHeight * aspectRatio;

      final track = tester.renderObject<RenderBox>(_trackBox());
      expect(track.size, const Size(expectedWidth, trackHeight));
      expect(
        track.getMinIntrinsicWidth(trackHeight),
        closeTo(expectedWidth, 0.01),
      );
      expect(
        track.getMaxIntrinsicWidth(trackHeight),
        closeTo(expectedWidth, 0.01),
      );

      await tester.pumpRemixApp(
        SizedBox(
          height: trackHeight,
          child: IntrinsicWidth(child: buildControl()),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.renderObject<RenderBox>(_trackBox()).size,
        const Size(expectedWidth, trackHeight),
      );
    });

    testWidgets(
      'horizontal main-axis intrinsics separate segment minimums from maximums',
      (tester) async {
        const spacing = 6.0;

        await tester.pumpRemixApp(
          RemixSegmentedControl<String>(
            items: _wrappableItems,
            selectedValue: 'a',
            onChanged: (_) {},
            style: SegmentedControlStyler().spacing(spacing),
          ),
        );
        await tester.pumpAndSettle();

        final track = tester.renderObject<RenderBox>(_trackBox());
        final segmentMin = _largestSegmentExtent(
          tester,
          (segment) => segment.getMinIntrinsicWidth(double.infinity),
        );
        final segmentMax = _largestSegmentExtent(
          tester,
          (segment) => segment.getMaxIntrinsicWidth(double.infinity),
        );

        // Guards the fixture: if the labels did not wrap, both segment getters
        // would agree and the track assertions could not tell them apart.
        expect(segmentMin, lessThan(segmentMax));

        expect(
          track.getMinIntrinsicWidth(double.infinity),
          closeTo(segmentMin * 2 + spacing, 0.01),
        );
        expect(
          track.getMaxIntrinsicWidth(double.infinity),
          closeTo(segmentMax * 2 + spacing, 0.01),
        );
      },
    );

    testWidgets(
      'vertical main-axis intrinsics separate segment minimums from maximums',
      (tester) async {
        const spacing = 8.0;

        await tester.pumpRemixApp(
          RemixSegmentedControl<String>(
            items: _wrappableItems,
            selectedValue: 'a',
            onChanged: (_) {},
            orientation: Axis.vertical,
            // A quarter turn swaps each segment's width and height intrinsics,
            // which is what makes its minimum and maximum heights differ.
            style: SegmentedControlStyler()
                .spacing(spacing)
                .item(SegmentedControlItemStyler().wrap(.rotatedBox(1))),
          ),
        );
        await tester.pumpAndSettle();

        final track = tester.renderObject<RenderBox>(_trackBox());
        final segmentMin = _largestSegmentExtent(
          tester,
          (segment) => segment.getMinIntrinsicHeight(double.infinity),
        );
        final segmentMax = _largestSegmentExtent(
          tester,
          (segment) => segment.getMaxIntrinsicHeight(double.infinity),
        );

        expect(segmentMin, lessThan(segmentMax));

        expect(
          track.getMinIntrinsicHeight(double.infinity),
          closeTo(segmentMin * 2 + spacing, 0.01),
        );
        expect(
          track.getMaxIntrinsicHeight(double.infinity),
          closeTo(segmentMax * 2 + spacing, 0.01),
        );
      },
    );

    testWidgets('an intrinsic-column parent wraps instead of overflowing', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: _wrappableItems,
          selectedValue: 'a',
          onChanged: (_) {},
        ),
      );
      await tester.pumpAndSettle();

      final segmentMin = _largestSegmentExtent(
        tester,
        (segment) => segment.getMinIntrinsicWidth(double.infinity),
      );
      final segmentMax = _largestSegmentExtent(
        tester,
        (segment) => segment.getMaxIntrinsicWidth(double.infinity),
      );
      // Sits between the two segment minimums and the two maximums, so a track
      // that reports maximums from computeMinIntrinsicWidth cannot shrink into
      // it while a correct one can.
      final parentWidth = segmentMin + segmentMax;

      await tester.pumpRemixApp(
        SizedBox(
          width: parentWidth,
          child: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                children: [
                  RemixSegmentedControl<String>(
                    items: _wrappableItems,
                    selectedValue: 'a',
                    onChanged: (_) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.getSize(_trackBox()).width,
        lessThanOrEqualTo(parentWidth + 0.01),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('an IntrinsicWidth parent still sizes to segment maximums', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        IntrinsicWidth(
          child: RemixSegmentedControl<String>(
            items: _wrappableItems,
            selectedValue: 'a',
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final segmentMax = _largestSegmentExtent(
        tester,
        (segment) => segment.getMaxIntrinsicWidth(double.infinity),
      );

      expect(tester.getSize(_trackBox()).width, closeTo(segmentMax * 2, 0.01));
    });

    testWidgets('vertical segments use equal intrinsic heights', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'one', label: 'One'),
            RemixSegmentedControlItem(
              value: 'two',
              label: 'Two',
              icon: Icons.star,
            ),
            RemixSegmentedControlItem(value: 'three', label: 'Three'),
          ],
          selectedValue: 'one',
          onChanged: (_) {},
          orientation: Axis.vertical,
          style: SegmentedControlStyler(
            item: SegmentedControlItemStyler().paddingY(12),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final options = find.byType(NakedToggleOption<String>);
      final heights = [
        for (var index = 0; index < 3; index++)
          tester.getSize(options.at(index)).height,
      ];

      expect(heights[0], closeTo(heights[1], 0.01));
      expect(heights[1], closeTo(heights[2], 0.01));
    });

    testWidgets(
      'narrow vertical segments fit wrapped labels at 200% text scale',
      (tester) async {
        const longLabel = 'Wrapped';

        await tester.pumpRemixApp(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: SizedBox(
              width: 90,
              child: RemixSegmentedControl<String>(
                items: const [
                  RemixSegmentedControlItem(value: 'short', label: 'Short'),
                  RemixSegmentedControlItem(
                    value: 'localized',
                    label: longLabel,
                  ),
                ],
                selectedValue: 'short',
                onChanged: (_) {},
                orientation: Axis.vertical,
                style: SegmentedControlStyler(
                  item: SegmentedControlItemStyler().paddingAll(4),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final options = find.byType(NakedToggleOption<String>);
        final labelBox = tester.renderObject<RenderBox>(find.text(longLabel));
        final wrappedHeight = labelBox.getMaxIntrinsicHeight(
          labelBox.constraints.maxWidth,
        );
        final singleLineHeight = labelBox.getMaxIntrinsicHeight(
          double.infinity,
        );

        expect(wrappedHeight, greaterThan(singleLineHeight));
        expect(labelBox.size.height, closeTo(wrappedHeight, 0.01));
        expect(
          tester.getSize(options.at(0)).height,
          closeTo(tester.getSize(options.at(1)).height, 0.01),
        );
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('vertical segments fill the shared cross axis', (tester) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'a', label: 'A'),
            RemixSegmentedControlItem(
              value: 'comfortable',
              label: 'Comfortable',
            ),
            RemixSegmentedControlItem(value: 'wide', label: 'Wide'),
          ],
          selectedValue: 'comfortable',
          onChanged: (_) {},
          orientation: Axis.vertical,
          style: SegmentedControlStyler(
            item: SegmentedControlItemStyler().paddingAll(8),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final options = find.byType(NakedToggleOption<String>);
      final widths = [
        for (var index = 0; index < 3; index++)
          tester.getSize(options.at(index)).width,
      ];

      expect(widths[0], closeTo(widths[1], 0.01));
      expect(widths[1], closeTo(widths[2], 0.01));
    });

    testWidgets('an explicit vertical track height is divided equally', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'one', label: 'One'),
            RemixSegmentedControlItem(value: 'two', label: 'Two'),
            RemixSegmentedControlItem(value: 'three', label: 'Three'),
          ],
          selectedValue: 'one',
          onChanged: (_) {},
          orientation: Axis.vertical,
          style: SegmentedControlStyler().constraintsOnly(height: 240),
        ),
      );
      await tester.pumpAndSettle();

      final options = find.byType(NakedToggleOption<String>);
      expect(tester.getSize(_trackBox()).height, 240);
      for (var index = 0; index < 3; index++) {
        expect(tester.getSize(options.at(index)).height, closeTo(80, 0.01));
      }
    });

    testWidgets('RTL visual order follows widget and semantics order', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'first', label: 'First'),
            RemixSegmentedControlItem(value: 'second', label: 'Second'),
            RemixSegmentedControlItem(value: 'third', label: 'Third'),
          ],
          selectedValue: 'first',
          onChanged: (_) {},
        ),
        textDirection: TextDirection.rtl,
      );
      await tester.pumpAndSettle();

      final options = find.byType(NakedToggleOption<String>);
      final firstRect = tester.getRect(options.at(0));
      final secondRect = tester.getRect(options.at(1));
      final thirdRect = tester.getRect(options.at(2));

      expect(firstRect.left, greaterThan(secondRect.left));
      expect(secondRect.left, greaterThan(thirdRect.left));
      expect(firstRect.width, closeTo(secondRect.width, 0.01));
      expect(secondRect.width, closeTo(thirdRect.width, 0.01));
      expect(tester.getRect(find.bySemanticsLabel('First')), firstRect);
      expect(tester.getRect(find.bySemanticsLabel('Second')), secondRect);
      expect(tester.getRect(find.bySemanticsLabel('Third')), thirdRect);
      semantics.dispose();
    });

    testWidgets('200% text scale fits a narrow bounded parent', (tester) async {
      await tester.pumpRemixApp(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: SizedBox(
            width: 180,
            child: RemixSegmentedControl<String>(
              items: const [
                RemixSegmentedControlItem(value: 'short', label: 'Short'),
                RemixSegmentedControlItem(
                  value: 'localized',
                  label: 'Long localized label',
                ),
              ],
              selectedValue: 'short',
              onChanged: (_) {},
              style: SegmentedControlStyler(
                item: SegmentedControlItemStyler().paddingAll(4),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final options = find.byType(NakedToggleOption<String>);
      expect(tester.getSize(_trackBox()).width, lessThanOrEqualTo(180));
      expect(
        tester.getSize(options.at(0)).width,
        closeTo(tester.getSize(options.at(1)).width, 0.01),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('dry track layout matches wet layout', (tester) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 240,
          child: RemixSegmentedControl<String>(
            items: const [
              RemixSegmentedControlItem(value: 'day', label: 'Day'),
              RemixSegmentedControlItem(value: 'week', label: 'This week'),
              RemixSegmentedControlItem(value: 'month', label: 'Month'),
            ],
            selectedValue: 'week',
            onChanged: (_) {},
            style: SegmentedControlStyler()
                .mainAxisSize(.max)
                .spacing(6)
                .paddingAll(4),
          ),
        ),
        textDirection: TextDirection.rtl,
      );
      await tester.pumpAndSettle();

      final track = tester.renderObject<RenderBox>(_trackBox());
      final drySize = track.getDryLayout(track.constraints);
      final options = find.byType(NakedToggleOption<String>);
      final firstRect = tester.getRect(options.at(0));
      final secondRect = tester.getRect(options.at(1));
      final thirdRect = tester.getRect(options.at(2));

      expect(drySize, track.size);
      expect(track.size.width, 240);
      expect(firstRect.width, closeTo(secondRect.width, 0.01));
      expect(secondRect.width, closeTo(thirdRect.width, 0.01));
      expect(firstRect.left, greaterThan(secondRect.left));
      expect(secondRect.left, greaterThan(thirdRect.left));
      expect(firstRect.left - secondRect.right, closeTo(6, 0.01));
      expect(secondRect.left - thirdRect.right, closeTo(6, 0.01));
    });

    testWidgets('null callback resolves the disabled track variant', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
          ],
          selectedValue: 'list',
          style: SegmentedControlStyler()
              .color(Colors.red)
              .onDisabled(SegmentedControlStyler().color(Colors.grey)),
        ),
      );
      await tester.pumpAndSettle();

      final track = tester.widget<Box>(_trackBox());
      final decoration = track.styleSpec!.spec.decoration as BoxDecoration?;

      expect(decoration?.color, Colors.grey);
    });

    testWidgets('enabled false resolves the disabled track variant', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSegmentedControl<String>(
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
          ],
          selectedValue: 'list',
          onChanged: (_) {},
          enabled: false,
          style: SegmentedControlStyler()
              .color(Colors.red)
              .onDisabled(SegmentedControlStyler().color(Colors.grey)),
        ),
      );
      await tester.pumpAndSettle();

      final track = tester.widget<Box>(_trackBox());
      final decoration = track.styleSpec!.spec.decoration as BoxDecoration?;

      expect(decoration?.color, Colors.grey);
    });

    testWidgets('selected item effects do not change segment geometry', (
      tester,
    ) async {
      late StateSetter update;
      var selectedValue = 'list';
      final style = SegmentedControlStyler(
        item: SegmentedControlItemStyler().onSelected(
          SegmentedControlItemStyler().containerEffects(
            RemixBoxEffectsMix(
              outline: BorderSideMix(
                color: Colors.blue,
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              outlineOffset: 3,
            ),
          ),
        ),
      );

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return RemixSegmentedControl<String>(
              items: const [
                RemixSegmentedControlItem(value: 'list', label: 'List'),
                RemixSegmentedControlItem(value: 'grid', label: 'Grid'),
              ],
              selectedValue: selectedValue,
              onChanged: (_) {},
              style: style,
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      final options = find.byType(NakedToggleOption<String>);
      final before = [
        tester.getSize(options.at(0)),
        tester.getSize(options.at(1)),
      ];

      update(() => selectedValue = 'grid');
      await tester.pumpAndSettle();

      expect(tester.getSize(options.at(0)), before[0]);
      expect(tester.getSize(options.at(1)), before[1]);
      expect(tester.takeException(), isNull);
    });
  });
}
