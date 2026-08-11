import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart' show SemanticsAction;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_box_effects.dart'
    show RemixBoxWithEffects;
import 'package:remix/src/utilities/remix_path_icon.dart';

import '../../helpers/test_helpers.dart';

enum _Topic { design, code }

/// The visual square is 24px; the composed checkbox keeps it inside the
/// default 48px interaction target.
final _itemStyle = CheckboxStyler().size(24, 24);

Finder _itemAt(int index) =>
    find.byType(RemixCheckboxGroupItem<String>).at(index);

Finder _pathGlyph(RemixPathGlyph glyph) => find.byWidgetPredicate(
  (widget) => widget is RemixPathIcon && widget.glyph == glyph,
);

/// Wraps [group] between two ordinary focus stops so the group's Tab
/// boundaries are observable from both sides.
Widget _traversalHarness({
  required FocusNode before,
  required FocusNode after,
  required Widget group,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Focus(focusNode: before, child: const SizedBox(width: 20, height: 20)),
      group,
      Focus(focusNode: after, child: const SizedBox(width: 20, height: 20)),
    ],
  );
}

Future<void> _pressTab(WidgetTester tester, {bool shift = false}) async {
  if (shift) {
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
  }
  await tester.sendKeyEvent(LogicalKeyboardKey.tab);
  if (shift) {
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
  }
  await tester.pump();
}

void main() {
  group('RemixCheckboxGroup', () {
    group('Controlled values', () {
      testWidgets('checking emits the current values plus the item value', (
        tester,
      ) async {
        Set<String>? emitted;

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {'design'},
            onChanged: (values) => emitted = values,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        await tester.tap(_itemAt(1));
        await tester.pump();

        expect(emitted, equals({'design', 'code'}));
      });

      testWidgets('unchecking emits the current values minus the item value', (
        tester,
      ) async {
        Set<String>? emitted;

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {'design', 'code'},
            onChanged: (values) => emitted = values,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        await tester.tap(_itemAt(0));
        await tester.pump();

        expect(emitted, equals({'code'}));
      });

      testWidgets('emits a new unmodifiable set that preserves T', (
        tester,
      ) async {
        final source = <String>{'design'};
        Set<String>? emitted;

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: source,
            onChanged: (values) => emitted = values,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        await tester.tap(_itemAt(1));
        await tester.pump();

        expect(emitted, isA<Set<String>>());
        expect(identical(emitted, source), isFalse);
        expect(() => emitted!.add('research'), throwsUnsupportedError);
        expect(
          source,
          equals({'design'}),
          reason: 'input set is never mutated',
        );
      });

      testWidgets('carries enum values without erasing the type argument', (
        tester,
      ) async {
        Set<_Topic>? emitted;

        await tester.pumpRemixApp(
          RemixCheckboxGroup<_Topic>(
            values: const {_Topic.design},
            onChanged: (values) => emitted = values,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<_Topic>(
                  value: _Topic.design,
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<_Topic>(
                  value: _Topic.code,
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        await tester.tap(find.byType(RemixCheckboxGroupItem<_Topic>).at(1));
        await tester.pump();

        expect(emitted, isA<Set<_Topic>>());
        expect(emitted, equals({_Topic.design, _Topic.code}));
      });

      testWidgets('preserves values that have no mounted item', (tester) async {
        // The group coordinates the caller's set; it must not quietly drop
        // values whose options are filtered out or not yet rendered.
        Set<String>? emitted;

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {'archived'},
            onChanged: (values) => emitted = values,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        await tester.tap(_itemAt(0));
        await tester.pump();

        expect(emitted, equals({'archived', 'design'}));
      });

      testWidgets('stays controlled when the callback rejects the change', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {'design'},
            onChanged: (_) {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        expect(_pathGlyph(RemixPathGlyph.check), findsOneWidget);

        await tester.tap(_itemAt(1));
        await tester.pumpAndSettle();

        expect(
          _pathGlyph(RemixPathGlyph.check),
          findsOneWidget,
          reason: 'selection is owned by the caller, not the group',
        );
      });

      testWidgets('a null callback suppresses every option', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {'design'},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        await tester.tap(_itemAt(1), warnIfMissed: false);
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(_pathGlyph(RemixPathGlyph.check), findsOneWidget);
      });

      testWidgets('a disabled group suppresses every option', (tester) async {
        var emitted = 0;

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {'design'},
            enabled: false,
            onChanged: (_) => emitted += 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        await tester.tap(_itemAt(0), warnIfMissed: false);
        await tester.tap(_itemAt(1), warnIfMissed: false);
        await tester.pump();

        expect(emitted, isZero);
      });

      testWidgets('group and item disabled states combine', (tester) async {
        final emitted = <Set<String>>[];

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: emitted.add,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  enabled: false,
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        await tester.tap(_itemAt(0), warnIfMissed: false);
        await tester.pump();
        expect(emitted, isEmpty);

        await tester.tap(_itemAt(1));
        await tester.pump();
        expect(
          emitted,
          equals([
            <String>{'code'},
          ]),
        );
      });
    });

    group('Composed visuals', () {
      testWidgets('an item renders the same visuals as a standalone checkbox', (
        tester,
      ) async {
        // The group owns no visuals; a disabled option must resolve exactly the
        // style's own treatment, not a group-invented one.
        final style = CheckboxStyler().size(24, 24).fillColor(Colors.blue);

        await tester.pumpRemixApp(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RemixCheckbox(
                selected: true,
                enabled: false,
                onChanged: (_) {},
                style: style,
              ),
              RemixCheckboxGroup<String>(
                values: const {'design'},
                enabled: false,
                onChanged: (_) {},
                child: RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: style,
                ),
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsNWidgets(2));

        // One container Box per checkbox, in tree order: standalone, then item.
        final boxes = tester.widgetList<Box>(find.byType(Box)).toList();
        expect(boxes, hasLength(2));
        expect(
          boxes[1].styleSpec?.spec.decoration,
          equals(boxes[0].styleSpec?.spec.decoration),
        );
        expect(_pathGlyph(RemixPathGlyph.check), findsNWidgets(2));
      });
    });

    group('Labeled interaction target', () {
      testWidgets('defaults to 48 square and forwards Size.zero opt-out', (
        tester,
      ) async {
        const defaultKey = ValueKey('default-target');
        const compactKey = ValueKey('compact-target');
        final style = CheckboxStyler().size(16, 16);

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  key: defaultKey,
                  value: 'a',
                  label: 'A',
                  style: style,
                ),
                RemixCheckboxGroupItem<String>(
                  key: compactKey,
                  value: 'b',
                  label: 'B',
                  minimumTapTargetSize: Size.zero,
                  style: style,
                ),
              ],
            ),
          ),
        );

        expect(tester.getSize(find.byKey(defaultKey)), const Size.square(48));
        final compactSize = tester.getSize(find.byKey(compactKey));
        expect(compactSize.height, lessThan(48));
        expect(compactSize.width, lessThan(48));
        expect(
          tester.getSize(
            find.descendant(
              of: find.byKey(compactKey),
              matching: find.byType(RemixBoxWithEffects),
            ),
          ),
          const Size.square(16),
        );
      });

      testWidgets('indicator, label, gap, and padded edge toggle one control', (
        tester,
      ) async {
        const itemKey = ValueKey('whole-target');
        const label = 'Receive updates';
        var changes = 0;

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) => changes += 1,
            child: RemixCheckboxGroupItem<String>(
              key: itemKey,
              value: 'updates',
              label: label,
              style: CheckboxStyler().size(16, 16).labelSpacing(12),
            ),
          ),
        );

        final item = find.byKey(itemKey);
        final targetRect = tester.getRect(item);
        final boxRect = tester.getRect(find.byType(RemixBoxWithEffects));
        final labelRect = tester.getRect(find.text(label));
        final locations = <Offset>[
          boxRect.center,
          labelRect.center,
          Offset((boxRect.right + labelRect.left) / 2, targetRect.center.dy),
          targetRect.bottomLeft + const Offset(1, -1),
        ];

        for (var index = 0; index < locations.length; index++) {
          await tester.tapAt(locations[index]);
          await tester.pump();
          expect(changes, index + 1, reason: 'tap at ${locations[index]}');
        }
      });

      testWidgets('uses ambient RTL order and preserves styled label spacing', (
        tester,
      ) async {
        const label = 'Design';

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: RemixCheckboxGroupItem<String>(
              value: 'design',
              label: label,
              style: CheckboxStyler().size(16, 16).labelSpacing(12),
            ),
          ),
          textDirection: TextDirection.rtl,
        );

        final boxRect = tester.getRect(find.byType(RemixBoxWithEffects));
        final labelRect = tester.getRect(find.text(label));
        expect(boxRect.left, greaterThan(labelRect.left));
        expect(boxRect.left - labelRect.right, 12);
      });

      testWidgets('wraps the label at 3x text scale within bounded width', (
        tester,
      ) async {
        const label =
            'Receive detailed release notes and important API migration updates';

        await tester.pumpRemixApp(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(3)),
            child: SizedBox(
              width: 220,
              child: RemixCheckboxGroup<String>(
                values: const {},
                onChanged: (_) {},
                child: RemixCheckboxGroupItem<String>(
                  value: 'updates',
                  label: label,
                  style: CheckboxStyler().size(16, 16),
                ),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
        expect(tester.getSize(_itemAt(0)).width, 220);
        expect(tester.getSize(find.text(label)).height, greaterThan(48));
      });
    });

    group('Focus and keyboard', () {
      testWidgets('every enabled option is a tab stop in widget order', (
        tester,
      ) async {
        final before = FocusNode(debugLabel: 'before');
        final after = FocusNode(debugLabel: 'after');
        final design = FocusNode(debugLabel: 'design');
        final code = FocusNode(debugLabel: 'code');
        addTearDown(() {
          for (final node in [before, after, design, code]) {
            node.dispose();
          }
        });

        await tester.pumpRemixApp(
          _traversalHarness(
            before: before,
            after: after,
            group: RemixCheckboxGroup<String>(
              values: const {},
              onChanged: (_) {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RemixCheckboxGroupItem<String>(
                    value: 'design',
                    label: 'Design',
                    focusNode: design,
                    style: _itemStyle,
                  ),
                  RemixCheckboxGroupItem<String>(
                    value: 'code',
                    label: 'Code',
                    focusNode: code,
                    style: _itemStyle,
                  ),
                ],
              ),
            ),
          ),
        );

        await _pressTab(tester);
        expect(before.hasPrimaryFocus, isTrue);

        await _pressTab(tester);
        expect(design.hasPrimaryFocus, isTrue);

        await _pressTab(tester);
        expect(code.hasPrimaryFocus, isTrue);

        await _pressTab(tester);
        expect(after.hasPrimaryFocus, isTrue);
      });

      testWidgets('shift-tab walks back out of the group', (tester) async {
        final before = FocusNode(debugLabel: 'before');
        final after = FocusNode(debugLabel: 'after');
        final design = FocusNode(debugLabel: 'design');
        final code = FocusNode(debugLabel: 'code');
        addTearDown(() {
          for (final node in [before, after, design, code]) {
            node.dispose();
          }
        });

        await tester.pumpRemixApp(
          _traversalHarness(
            before: before,
            after: after,
            group: RemixCheckboxGroup<String>(
              values: const {},
              onChanged: (_) {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RemixCheckboxGroupItem<String>(
                    value: 'design',
                    label: 'Design',
                    focusNode: design,
                    style: _itemStyle,
                  ),
                  RemixCheckboxGroupItem<String>(
                    value: 'code',
                    label: 'Code',
                    focusNode: code,
                    style: _itemStyle,
                  ),
                ],
              ),
            ),
          ),
        );

        after.requestFocus();
        await tester.pump();

        await _pressTab(tester, shift: true);
        expect(code.hasPrimaryFocus, isTrue);

        await _pressTab(tester, shift: true);
        expect(design.hasPrimaryFocus, isTrue);

        await _pressTab(tester, shift: true);
        expect(before.hasPrimaryFocus, isTrue);
      });

      testWidgets('a disabled option is skipped by traversal', (tester) async {
        final before = FocusNode(debugLabel: 'before');
        final after = FocusNode(debugLabel: 'after');
        final design = FocusNode(debugLabel: 'design');
        final code = FocusNode(debugLabel: 'code');
        addTearDown(() {
          for (final node in [before, after, design, code]) {
            node.dispose();
          }
        });

        await tester.pumpRemixApp(
          _traversalHarness(
            before: before,
            after: after,
            group: RemixCheckboxGroup<String>(
              values: const {},
              onChanged: (_) {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RemixCheckboxGroupItem<String>(
                    value: 'design',
                    label: 'Design',
                    enabled: false,
                    focusNode: design,
                    style: _itemStyle,
                  ),
                  RemixCheckboxGroupItem<String>(
                    value: 'code',
                    label: 'Code',
                    focusNode: code,
                    style: _itemStyle,
                  ),
                ],
              ),
            ),
          ),
        );

        before.requestFocus();
        await tester.pump();

        await _pressTab(tester);
        expect(design.hasPrimaryFocus, isFalse);
        expect(code.hasPrimaryFocus, isTrue);
      });

      testWidgets('a disabled group is skipped entirely', (tester) async {
        final before = FocusNode(debugLabel: 'before');
        final after = FocusNode(debugLabel: 'after');
        final design = FocusNode(debugLabel: 'design');
        final code = FocusNode(debugLabel: 'code');
        addTearDown(() {
          for (final node in [before, after, design, code]) {
            node.dispose();
          }
        });

        await tester.pumpRemixApp(
          _traversalHarness(
            before: before,
            after: after,
            group: RemixCheckboxGroup<String>(
              values: const {},
              enabled: false,
              onChanged: (_) {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RemixCheckboxGroupItem<String>(
                    value: 'design',
                    label: 'Design',
                    focusNode: design,
                    style: _itemStyle,
                  ),
                  RemixCheckboxGroupItem<String>(
                    value: 'code',
                    label: 'Code',
                    focusNode: code,
                    style: _itemStyle,
                  ),
                ],
              ),
            ),
          ),
        );

        before.requestFocus();
        await tester.pump();

        await _pressTab(tester);
        expect(after.hasPrimaryFocus, isTrue);
        expect(design.hasFocus, isFalse);
        expect(code.hasFocus, isFalse);
      });

      testWidgets('space toggles only the focused option', (tester) async {
        final emitted = <Set<String>>[];
        final design = FocusNode(debugLabel: 'design');
        final code = FocusNode(debugLabel: 'code');
        addTearDown(() {
          design.dispose();
          code.dispose();
        });

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: emitted.add,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  focusNode: design,
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  focusNode: code,
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        code.requestFocus();
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pump();

        expect(
          emitted,
          equals([
            <String>{'code'},
          ]),
        );
      });

      testWidgets('enter toggles only the focused option', (tester) async {
        final emitted = <Set<String>>[];
        final design = FocusNode(debugLabel: 'design');
        final code = FocusNode(debugLabel: 'code');
        addTearDown(() {
          design.dispose();
          code.dispose();
        });

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: emitted.add,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  focusNode: design,
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  focusNode: code,
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        design.requestFocus();
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pump();

        expect(
          emitted,
          equals([
            <String>{'design'},
          ]),
        );
      });

      testWidgets('a single enabled autofocus item takes focus on mount', (
        tester,
      ) async {
        final code = FocusNode(debugLabel: 'code');
        addTearDown(code.dispose);

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  autofocus: true,
                  focusNode: code,
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );
        await tester.pump();

        expect(code.hasPrimaryFocus, isTrue);
        expect(tester.takeException(), isNull);
      });

      testWidgets('duplicate autofocus reports a descriptive error', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  autofocus: true,
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  autofocus: true,
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        final error = tester.takeException();
        expect(error, isFlutterError);
        expect('$error', contains('autofocus'));
      });

      testWidgets('duplicate values report a descriptive error', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design (again)',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        final error = tester.takeException();
        expect(error, isFlutterError);
        expect('$error', contains('Duplicate'));
        expect('$error', contains('design'));
      });

      testWidgets(
        'caller focus nodes survive item unmount and are not disposed',
        (tester) async {
          final code = FocusNode(debugLabel: 'code');
          addTearDown(code.dispose);

          Widget build({required bool showCode}) {
            return RemixCheckboxGroup<String>(
              values: const {},
              onChanged: (_) {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RemixCheckboxGroupItem<String>(
                    value: 'design',
                    label: 'Design',
                    style: _itemStyle,
                  ),
                  if (showCode)
                    RemixCheckboxGroupItem<String>(
                      value: 'code',
                      label: 'Code',
                      focusNode: code,
                      style: _itemStyle,
                    ),
                ],
              ),
            );
          }

          await tester.pumpRemixApp(build(showCode: true));

          code.requestFocus();
          await tester.pump();
          expect(code.hasPrimaryFocus, isTrue);

          await tester.pumpRemixApp(build(showCode: false));
          await tester.pump();

          expect(tester.takeException(), isNull);
          expect(
            () => code.addListener(() {}),
            returnsNormally,
            reason: 'the group never disposes caller-owned nodes',
          );
        },
      );

      testWidgets('removing the focused option does not throw', (tester) async {
        final code = FocusNode(debugLabel: 'code');
        addTearDown(code.dispose);

        Widget build({required List<String> options}) {
          return RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final option in options)
                  RemixCheckboxGroupItem<String>(
                    key: ValueKey(option),
                    value: option,
                    label: option,
                    focusNode: option == 'code' ? code : null,
                    style: _itemStyle,
                  ),
              ],
            ),
          );
        }

        await tester.pumpRemixApp(
          build(options: ['design', 'code', 'research']),
        );

        code.requestFocus();
        await tester.pump();
        expect(code.hasPrimaryFocus, isTrue);

        await tester.pumpRemixApp(build(options: ['design', 'research']));
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(find.byType(RemixCheckboxGroupItem<String>), findsNWidgets(2));
      });

      testWidgets(
        'shrinking an unkeyed option list reports no false duplicate',
        (tester) async {
          // Without keys, Flutter updates the surviving elements to the shifted
          // values before unmounting the last one, so every value is transiently
          // registered twice mid-build.
          Widget build({required List<String> options}) {
            return RemixCheckboxGroup<String>(
              values: const {},
              onChanged: (_) {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final option in options)
                    RemixCheckboxGroupItem<String>(
                      value: option,
                      label: option,
                      style: _itemStyle,
                    ),
                ],
              ),
            );
          }

          await tester.pumpRemixApp(
            build(options: ['design', 'code', 'research']),
          );
          await tester.pumpRemixApp(build(options: ['code', 'research']));
          await tester.pump();

          expect(tester.takeException(), isNull);
        },
      );

      testWidgets('adding options while mounted does not throw', (
        tester,
      ) async {
        Widget build({required List<String> options}) {
          return RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final option in options)
                  RemixCheckboxGroupItem<String>(
                    key: ValueKey(option),
                    value: option,
                    label: option,
                    style: _itemStyle,
                  ),
              ],
            ),
          );
        }

        await tester.pumpRemixApp(build(options: ['design']));
        await tester.pumpRemixApp(build(options: ['design', 'code']));
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(find.byType(RemixCheckboxGroupItem<String>), findsNWidgets(2));
      });

      testWidgets('disabling the focused option does not throw', (
        tester,
      ) async {
        final code = FocusNode(debugLabel: 'code');
        addTearDown(code.dispose);

        Widget build({required bool codeEnabled}) {
          return RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  enabled: codeEnabled,
                  focusNode: code,
                  style: _itemStyle,
                ),
              ],
            ),
          );
        }

        await tester.pumpRemixApp(build(codeEnabled: true));

        code.requestFocus();
        await tester.pump();
        expect(code.hasPrimaryFocus, isTrue);

        await tester.pumpRemixApp(build(codeEnabled: false));
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(code.hasPrimaryFocus, isFalse);
      });

      testWidgets('directional navigation keeps a disabled option focusable', (
        tester,
      ) async {
        // NavigationMode.directional (d-pad/TV) deliberately keeps disabled
        // widgets focusable so users can discover them; only activation is
        // suppressed. See NakedFocusableDetector.
        final node = FocusNode(debugLabel: 'disabled');
        addTearDown(node.dispose);
        var emitted = 0;

        await tester.pumpRemixApp(
          Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(navigationMode: NavigationMode.directional),
                child: RemixCheckboxGroup<String>(
                  values: const {},
                  onChanged: (_) => emitted += 1,
                  child: RemixCheckboxGroupItem<String>(
                    value: 'design',
                    label: 'Design',
                    enabled: false,
                    focusNode: node,
                    style: _itemStyle,
                  ),
                ),
              );
            },
          ),
        );

        node.requestFocus();
        await tester.pump();
        expect(node.hasPrimaryFocus, isTrue);

        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pump();
        expect(emitted, isZero);
      });
    });

    group('Controlled rebuilds', () {
      testWidgets(
        'accepting changes re-renders checked visuals and exact semantics',
        (tester) async {
          final handle = tester.ensureSemantics();
          final emitted = <Set<String>>[];
          var interests = <String>{};

          await tester.pumpRemixApp(
            StatefulBuilder(
              builder: (context, setState) {
                return RemixCheckboxGroup<String>(
                  values: interests,
                  onChanged: (values) => setState(() {
                    emitted.add(values);
                    interests = values;
                  }),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RemixCheckboxGroupItem<String>(
                        value: 'design',
                        label: 'Design',
                        style: _itemStyle,
                      ),
                      RemixCheckboxGroupItem<String>(
                        value: 'code',
                        label: 'Code',
                        style: _itemStyle,
                      ),
                    ],
                  ),
                );
              },
            ),
          );

          Matcher checkbox({required String label, required bool checked}) {
            return matchesSemantics(
              label: label,
              hasCheckedState: true,
              isChecked: checked,
              hasEnabledState: true,
              isEnabled: true,
              isFocusable: true,
              hasTapAction: true,
              hasFocusAction: true,
            );
          }

          expect(_pathGlyph(RemixPathGlyph.check), findsNothing);
          expect(
            tester.getSemantics(_itemAt(0)),
            checkbox(label: 'Design', checked: false),
          );

          await tester.tap(_itemAt(0));
          await tester.pumpAndSettle();

          expect(
            emitted,
            equals([
              <String>{'design'},
            ]),
          );
          expect(_pathGlyph(RemixPathGlyph.check), findsOneWidget);
          expect(
            tester.getSemantics(_itemAt(0)),
            checkbox(label: 'Design', checked: true),
          );
          expect(
            tester.getSemantics(_itemAt(1)),
            checkbox(label: 'Code', checked: false),
          );

          await tester.tap(_itemAt(1));
          await tester.pumpAndSettle();

          expect(emitted.last, equals({'design', 'code'}));
          expect(_pathGlyph(RemixPathGlyph.check), findsNWidgets(2));

          await tester.tap(_itemAt(0));
          await tester.pumpAndSettle();

          expect(emitted.last, equals({'code'}));
          expect(_pathGlyph(RemixPathGlyph.check), findsOneWidget);
          expect(
            tester.getSemantics(_itemAt(0)),
            checkbox(label: 'Design', checked: false),
          );

          handle.dispose();
        },
      );

      testWidgets(
        'toggling group enabled at runtime updates interactivity and semantics',
        (tester) async {
          final handle = tester.ensureSemantics();
          final emitted = <Set<String>>[];
          var enabled = false;
          late StateSetter setOuterState;

          await tester.pumpRemixApp(
            StatefulBuilder(
              builder: (context, setState) {
                setOuterState = setState;

                return RemixCheckboxGroup<String>(
                  values: const {},
                  enabled: enabled,
                  onChanged: emitted.add,
                  child: RemixCheckboxGroupItem<String>(
                    value: 'design',
                    label: 'Design',
                    style: _itemStyle,
                  ),
                );
              },
            ),
          );

          await tester.tap(_itemAt(0), warnIfMissed: false);
          await tester.pump();
          expect(emitted, isEmpty);
          expect(
            tester.getSemantics(_itemAt(0)),
            matchesSemantics(
              label: 'Design',
              hasCheckedState: true,
              hasEnabledState: true,
            ),
          );

          setOuterState(() => enabled = true);
          await tester.pumpAndSettle();

          expect(
            tester.getSemantics(_itemAt(0)),
            matchesSemantics(
              label: 'Design',
              hasCheckedState: true,
              hasEnabledState: true,
              isEnabled: true,
              isFocusable: true,
              hasTapAction: true,
              hasFocusAction: true,
            ),
          );

          await tester.tap(_itemAt(0));
          await tester.pump();
          expect(
            emitted,
            equals([
              <String>{'design'},
            ]),
          );

          handle.dispose();
        },
      );
    });

    group('Construction errors', () {
      test('an empty visible label fails at construction', () {
        expect(
          () => RemixCheckboxGroupItem<String>(value: 'design', label: ''),
          throwsAssertionError,
        );
      });

      testWidgets('a whitespace-only visible label fails at build', (
        tester,
      ) async {
        // trim() cannot run in a const initializer, so the whitespace-only
        // case is rejected by the first build instead of the constructor.
        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: RemixCheckboxGroupItem<String>(
              value: 'design',
              label: '   ',
              style: _itemStyle,
            ),
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });

      test('an empty semantic label override fails at construction', () {
        expect(
          () => RemixCheckboxGroupItem<String>(
            value: 'design',
            label: 'Design',
            semanticLabel: '',
          ),
          throwsAssertionError,
        );
      });

      testWidgets('a whitespace-only semantic override fails at build', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: RemixCheckboxGroupItem<String>(
              value: 'design',
              label: 'Design',
              semanticLabel: '   ',
              style: _itemStyle,
            ),
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });

      test('an empty group semantic label fails at construction', () {
        expect(
          () => RemixCheckboxGroup<String>(
            values: const {},
            semanticLabel: '',
            child: const SizedBox(),
          ),
          throwsAssertionError,
        );
      });

      test(
        'a required group without a semantic label fails at construction',
        () {
          expect(
            () => RemixCheckboxGroup<String>(
              values: const {},
              isRequired: true,
              child: const SizedBox(),
            ),
            throwsAssertionError,
          );
        },
      );

      testWidgets('a whitespace-only group semantic label fails at build', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            semanticLabel: '   ',
            child: const SizedBox(),
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });

      testWidgets(
        'a required group with a whitespace-only label fails at build',
        (tester) async {
          await tester.pumpRemixApp(
            RemixCheckboxGroup<String>(
              values: const {},
              onChanged: (_) {},
              isRequired: true,
              semanticLabel: '   ',
              child: const SizedBox(),
            ),
          );

          expect(tester.takeException(), isAssertionError);
        },
      );

      testWidgets('an unnamed group that is not required is allowed', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            child: RemixCheckboxGroupItem<String>(
              value: 'design',
              label: 'Design',
              style: _itemStyle,
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });

      testWidgets('a required excluded group without a label is allowed', (
        tester,
      ) async {
        // With excludeSemantics nothing is announced, so there is no unnamed
        // "required" container to forbid.
        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            isRequired: true,
            excludeSemantics: true,
            child: RemixCheckboxGroupItem<String>(
              value: 'design',
              label: 'Design',
              style: _itemStyle,
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });
    });

    group('Scope errors', () {
      testWidgets('an item without a group throws a descriptive error', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixCheckboxGroupItem<String>(
            value: 'design',
            label: 'Design',
          ),
        );

        final error = tester.takeException();
        expect(error, isFlutterError);
        expect('$error', contains('RemixCheckboxGroup<String>'));
      });

      testWidgets('an item whose type argument does not match throws', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixCheckboxGroup<int>(
            values: {1},
            child: RemixCheckboxGroupItem<String>(
              value: 'design',
              label: 'Design',
            ),
          ),
        );

        final error = tester.takeException();
        expect(error, isFlutterError);
        expect('$error', contains('RemixCheckboxGroup<String>'));
      });
    });

    group('Semantics', () {
      testWidgets('the group is one labeled container with explicit children', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {'design'},
            onChanged: (_) {},
            semanticLabel: 'Interests',
            isRequired: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        final groupNode = tester.getSemantics(
          find.byType(RemixCheckboxGroup<String>),
        );

        // matchesSemantics is exact: every flag or action not listed here
        // (isButton, hasToggledState, isSelected, ...) must be absent.
        expect(
          groupNode,
          matchesSemantics(
            label: 'Interests',
            hasRequiredState: true,
            isRequired: true,
            children: [
              matchesSemantics(
                label: 'Design',
                hasCheckedState: true,
                isChecked: true,
                hasEnabledState: true,
                isEnabled: true,
                isFocusable: true,
                hasTapAction: true,
                hasFocusAction: true,
              ),
              matchesSemantics(
                label: 'Code',
                hasCheckedState: true,
                isChecked: false,
                hasEnabledState: true,
                isEnabled: true,
                isFocusable: true,
                hasTapAction: true,
                hasFocusAction: true,
              ),
            ],
          ),
        );

        handle.dispose();
      });

      testWidgets('a group that is not required carries no required state', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            semanticLabel: 'Filters',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'open',
                  label: 'Open',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        expect(
          tester.getSemantics(find.byType(RemixCheckboxGroup<String>)),
          isSemantics(label: 'Filters', hasRequiredState: false),
        );

        handle.dispose();
      });

      testWidgets('a disabled group leaves no tap actions or focusable nodes', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {'design'},
            enabled: false,
            onChanged: (_) {},
            semanticLabel: 'Interests',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        final groupNode = tester.getSemantics(
          find.byType(RemixCheckboxGroup<String>),
        );

        // Exact match: a disabled option keeps its checkbox identity and
        // checked state but must expose no tap/focus action, no focusability,
        // and no stray flags.
        expect(
          groupNode,
          matchesSemantics(
            label: 'Interests',
            children: [
              matchesSemantics(
                label: 'Design',
                hasCheckedState: true,
                isChecked: true,
                hasEnabledState: true,
              ),
            ],
          ),
        );

        handle.dispose();
      });

      testWidgets('excludeSemantics removes the container and all options', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {'design'},
            onChanged: (_) {},
            semanticLabel: 'Interests',
            excludeSemantics: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixCheckboxGroupItem<String>(
                  value: 'design',
                  label: 'Design',
                  style: _itemStyle,
                ),
                RemixCheckboxGroupItem<String>(
                  value: 'code',
                  label: 'Code',
                  style: _itemStyle,
                ),
              ],
            ),
          ),
        );

        expect(find.bySemanticsLabel('Interests'), findsNothing);
        expect(find.bySemanticsLabel('Design'), findsNothing);
        expect(find.bySemanticsLabel('Code'), findsNothing);

        handle.dispose();
      });

      testWidgets('visible label fallback creates one exact checkbox node', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: (_) {},
            semanticLabel: 'Interests',
            child: RemixCheckboxGroupItem<String>(
              value: 'design',
              label: 'Design',
              style: _itemStyle,
            ),
          ),
        );

        expect(find.text('Design'), findsOneWidget);
        expect(find.bySemanticsLabel('Design'), findsOneWidget);
        expect(
          tester.getSemantics(_itemAt(0)),
          matchesSemantics(
            label: 'Design',
            textDirection: TextDirection.ltr,
            hasCheckedState: true,
            hasEnabledState: true,
            isEnabled: true,
            isFocusable: true,
            hasTapAction: true,
            hasFocusAction: true,
            children: const <Matcher>[],
          ),
        );

        handle.dispose();
      });

      testWidgets(
        'semanticLabel overrides label without duplicate text nodes',
        (tester) async {
          final handle = tester.ensureSemantics();

          await tester.pumpRemixApp(
            RemixCheckboxGroup<String>(
              values: const {},
              onChanged: (_) {},
              semanticLabel: 'Interests',
              child: RemixCheckboxGroupItem<String>(
                value: 'design',
                label: 'Design',
                semanticLabel: 'Design interest',
                style: _itemStyle,
              ),
            ),
          );

          expect(find.text('Design'), findsOneWidget);
          expect(find.bySemanticsLabel('Design'), findsNothing);
          expect(find.bySemanticsLabel('Design interest'), findsOneWidget);
          expect(
            tester.getSemantics(_itemAt(0)),
            matchesSemantics(
              label: 'Design interest',
              textDirection: TextDirection.ltr,
              hasCheckedState: true,
              hasEnabledState: true,
              isEnabled: true,
              isFocusable: true,
              hasTapAction: true,
              hasFocusAction: true,
              children: const <Matcher>[],
            ),
          );

          handle.dispose();
        },
      );

      testWidgets('performing SemanticsAction.tap toggles the option', (
        tester,
      ) async {
        // Screen readers activate controls through semantics actions, not
        // pointer events; the action must reach the same toggle path.
        final handle = tester.ensureSemantics();
        final emitted = <Set<String>>[];

        await tester.pumpRemixApp(
          RemixCheckboxGroup<String>(
            values: const {},
            onChanged: emitted.add,
            child: RemixCheckboxGroupItem<String>(
              value: 'design',
              label: 'Design',
              style: _itemStyle,
            ),
          ),
        );

        tester.semantics.performAction(
          find.semantics.byLabel('Design'),
          SemanticsAction.tap,
        );
        await tester.pump();

        expect(
          emitted,
          equals([
            <String>{'design'},
          ]),
        );

        handle.dispose();
      });
    });
  });
}
