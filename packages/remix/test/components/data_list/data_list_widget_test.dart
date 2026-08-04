import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart' hide SemanticsRole;
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

/// The horizontal renderer uses a private [Table] subclass, so match by
/// subtype instead of by exact runtime type.
final Finder _table = find.byWidgetPredicate((widget) => widget is Table);

/// Deterministic typography for geometry assertions: the FlutterTest font has
/// a 0.75em ascent and 0.25em descent, and `height: 1.0` pins the line height
/// to the font size.
DataListStyler _metricStyle({double labelSize = 10, double valueSize = 10}) {
  return DataListStyler()
      .labelTextStyle(TextStyleMix(fontSize: labelSize, height: 1.0))
      .valueTextStyle(TextStyleMix(fontSize: valueSize, height: 1.0));
}

SemanticsNode? _findNode(
  SemanticsNode root,
  bool Function(SemanticsData data) predicate,
) {
  if (predicate(root.getSemanticsData())) return root;
  SemanticsNode? found;
  root.visitChildren((child) {
    found ??= _findNode(child, predicate);
    return found == null;
  });
  return found;
}

SemanticsNode? _listNode(WidgetTester tester) {
  final anchor = tester.getSemantics(find.byType(RemixDataList));
  return _findNode(anchor, (data) => data.role == SemanticsRole.list);
}

List<SemanticsNode> _rowNodes(WidgetTester tester) {
  final list = _listNode(tester);
  expect(list, isNotNull, reason: 'Expected a list semantics node.');
  final rows = <SemanticsNode>[];
  list!.visitChildren((node) {
    rows.add(node);
    return true;
  });
  return rows;
}

int _countNodesWithLabel(WidgetTester tester, String label) {
  var count = 0;
  void visit(SemanticsNode node) {
    if (node.getSemanticsData().label == label) count += 1;
    node.visitChildren((child) {
      visit(child);
      return true;
    });
  }

  visit(tester.getSemantics(find.byType(RemixDataList)));
  return count;
}

void main() {
  group('RemixDataListItem', () {
    test('accepts a string value or a custom child', () {
      expect(
        () => const RemixDataListItem(label: 'Name', value: 'Leo'),
        returnsNormally,
      );
      expect(
        () => const RemixDataListItem(label: 'Name', child: SizedBox()),
        returnsNormally,
      );
    });

    test('rejects providing both value and child', () {
      expect(
        () => RemixDataListItem(
          label: 'Name',
          value: 'Leo',
          child: const SizedBox(),
        ),
        throwsAssertionError,
      );
    });

    test('rejects providing neither value nor child', () {
      expect(() => RemixDataListItem(label: 'Name'), throwsAssertionError);
    });

    test('rejects empty label', () {
      expect(
        () => RemixDataListItem(label: '', value: 'Leo'),
        throwsAssertionError,
      );
    });

    test('rejects empty value', () {
      expect(
        () => RemixDataListItem(label: 'Name', value: ''),
        throwsAssertionError,
      );
    });

    test('rejects semanticValue without child', () {
      expect(
        () => RemixDataListItem(
          label: 'Name',
          value: 'Leo',
          semanticValue: 'Leo',
        ),
        throwsAssertionError,
      );
    });

    test('rejects empty semanticValue', () {
      expect(
        () => RemixDataListItem(
          label: 'Name',
          child: const SizedBox(),
          semanticValue: '',
        ),
        throwsAssertionError,
      );
    });
  });

  group('RemixDataList Widget Tests', () {
    group('Basic Rendering', () {
      testWidgets('horizontal orientation renders one shared Table', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixDataList(
            items: [
              RemixDataListItem(label: 'Name', value: 'Leo'),
              RemixDataListItem(label: 'Email', value: 'leo@example.com'),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDataList), findsOneWidget);
        expect(_table, findsOneWidget);
        expect(find.text('Name'), findsOneWidget);
        expect(find.text('leo@example.com'), findsOneWidget);
      });

      testWidgets('vertical orientation stacks items without a Table', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixDataList(
            orientation: Axis.vertical,
            items: [
              RemixDataListItem(label: 'Name', value: 'Leo'),
              RemixDataListItem(label: 'Email', value: 'leo@example.com'),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(_table, findsNothing);
        expect(find.text('Name'), findsOneWidget);
        expect(find.text('leo@example.com'), findsOneWidget);
      });

      testWidgets('renders an empty item list', (tester) async {
        final handle = tester.ensureSemantics();
        await tester.pumpRemixApp(
          const RemixDataList(semanticLabel: 'Account', items: []),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(_rowNodes(tester), isEmpty);
        handle.dispose();
      });

      testWidgets('renders with raw styleSpec parameter', (tester) async {
        await tester.pumpRemixApp(
          const RemixDataList(
            styleSpec: DataListSpec(),
            items: [RemixDataListItem(label: 'Name', value: 'Leo')],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixDataList), findsOneWidget);
        expect(find.text('Leo'), findsOneWidget);
      });

      testWidgets('renders a custom child value', (tester) async {
        await tester.pumpRemixApp(
          const RemixDataList(
            items: [
              RemixDataListItem(
                label: 'Status',
                child: SizedBox(width: 20, height: 20),
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('Status'), findsOneWidget);
      });
    });

    group('Item List Contract', () {
      testWidgets('each build reads a fresh snapshot of the retained list', (
        tester,
      ) async {
        final items = <RemixDataListItem>[
          const RemixDataListItem(label: 'Name', value: 'Leo'),
        ];

        await tester.pumpRemixApp(RemixDataList(items: items));
        await tester.pumpAndSettle();
        expect(find.text('Name'), findsOneWidget);
        expect(find.text('Email'), findsNothing);

        items.add(const RemixDataListItem(label: 'Email', value: 'a@b.co'));
        await tester.pumpRemixApp(RemixDataList(items: items));
        await tester.pumpAndSettle();

        expect(find.text('Name'), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('rejects negative resolved rowSpacing', (tester) async {
        await tester.pumpRemixApp(
          RemixDataList(
            style: DataListStyler().rowSpacing(-4.0),
            items: const [RemixDataListItem(label: 'Name', value: 'Leo')],
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });

      testWidgets('rejects negative resolved minLabelWidth', (tester) async {
        await tester.pumpRemixApp(
          RemixDataList(
            style: DataListStyler().minLabelWidth(-1.0),
            items: const [RemixDataListItem(label: 'Name', value: 'Leo')],
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });
    });

    group('Semantics', () {
      testWidgets('root exposes a list role with an optional label', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();
        await tester.pumpRemixApp(
          const RemixDataList(
            semanticLabel: 'Account details',
            items: [RemixDataListItem(label: 'Name', value: 'Leo')],
          ),
        );
        await tester.pumpAndSettle();

        final list = _listNode(tester);
        expect(list, isNotNull);
        expect(list!.getSemanticsData().label, equals('Account details'));
        handle.dispose();
      });

      testWidgets('string row is one list-item node with label and value', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();
        await tester.pumpRemixApp(
          const RemixDataList(
            items: [
              RemixDataListItem(label: 'Name', value: 'Leo'),
              RemixDataListItem(label: 'Email', value: 'leo@example.com'),
            ],
          ),
        );
        await tester.pumpAndSettle();

        final rows = _rowNodes(tester);
        expect(rows, hasLength(2));

        final first = rows[0].getSemanticsData();
        expect(first.role, equals(SemanticsRole.listItem));
        expect(first.label, equals('Name'));
        expect(first.value, equals('Leo'));

        final second = rows[1].getSemanticsData();
        expect(second.label, equals('Email'));
        expect(second.value, equals('leo@example.com'));

        // Both visible text nodes are excluded beneath the row node.
        expect(_countNodesWithLabel(tester, 'Name'), equals(1));
        expect(_countNodesWithLabel(tester, 'Leo'), isZero);
        handle.dispose();
      });

      testWidgets('vertical orientation exposes the same row semantics', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();
        await tester.pumpRemixApp(
          const RemixDataList(
            orientation: Axis.vertical,
            items: [RemixDataListItem(label: 'Name', value: 'Leo')],
          ),
        );
        await tester.pumpAndSettle();

        final rows = _rowNodes(tester);
        expect(rows, hasLength(1));
        final data = rows.single.getSemanticsData();
        expect(data.role, equals(SemanticsRole.listItem));
        expect(data.label, equals('Name'));
        expect(data.value, equals('Leo'));
        expect(_countNodesWithLabel(tester, 'Name'), equals(1));
        handle.dispose();
      });

      testWidgets(
        'custom interactive child keeps its action and label once',
        (tester) async {
          final handle = tester.ensureSemantics();
          var pressed = 0;
          await tester.pumpRemixApp(
            RemixDataList(
              items: [
                RemixDataListItem(
                  label: 'Status',
                  child: RemixButton(
                    label: 'Copy',
                    onPressed: () => pressed += 1,
                  ),
                ),
              ],
            ),
          );
          await tester.pumpAndSettle();

          final rows = _rowNodes(tester);
          expect(rows, hasLength(1));
          final row = rows.single.getSemanticsData();
          expect(row.role, equals(SemanticsRole.listItem));
          expect(row.label, equals('Status'));

          // The button survives as its own actionable node under the row.
          final button = _findNode(
            rows.single,
            (data) =>
                data.label == 'Copy' && data.hasAction(SemanticsAction.tap),
          );
          expect(button, isNotNull);

          // The visual label is not announced a second time.
          expect(_countNodesWithLabel(tester, 'Status'), equals(1));

          await tester.tap(find.text('Copy'));
          await tester.pumpAndSettle();
          expect(pressed, equals(1));
          handle.dispose();
        },
      );

      testWidgets(
        'semanticValue summarizes a noninteractive child into one node',
        (tester) async {
          final handle = tester.ensureSemantics();
          await tester.pumpRemixApp(
            const RemixDataList(
              items: [
                RemixDataListItem(
                  label: 'Status',
                  semanticValue: 'Authorized',
                  child: Text('Complex Widget'),
                ),
              ],
            ),
          );
          await tester.pumpAndSettle();

          final rows = _rowNodes(tester);
          expect(rows, hasLength(1));
          final row = rows.single.getSemanticsData();
          expect(row.role, equals(SemanticsRole.listItem));
          expect(row.label, equals('Status'));
          expect(row.value, equals('Authorized'));

          // The child's own semantics are excluded by the summary.
          expect(_countNodesWithLabel(tester, 'Complex Widget'), isZero);
          handle.dispose();
        },
      );

      testWidgets('excludeSemantics removes the full list', (tester) async {
        final handle = tester.ensureSemantics();
        await tester.pumpRemixApp(
          const RemixDataList(
            excludeSemantics: true,
            semanticLabel: 'Account',
            items: [RemixDataListItem(label: 'Name', value: 'Leo')],
          ),
        );
        await tester.pumpAndSettle();

        final anchor = tester.getSemantics(find.byType(RemixDataList));
        expect(
          _findNode(anchor, (data) => data.role == SemanticsRole.list),
          isNull,
        );
        expect(find.bySemanticsLabel('Name'), findsNothing);
        handle.dispose();
      });

      testWidgets('RTL keeps the logical row order in semantics', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();
        await tester.pumpRemixApp(
          const RemixDataList(
            items: [
              RemixDataListItem(label: 'Name', value: 'Leo'),
              RemixDataListItem(label: 'Email', value: 'leo@example.com'),
            ],
          ),
          textDirection: TextDirection.rtl,
        );
        await tester.pumpAndSettle();

        final rows = _rowNodes(tester);
        expect(
          rows.map((node) => node.getSemanticsData().label).toList(),
          equals(['Name', 'Email']),
        );
        handle.dispose();
      });
    });

    group('Horizontal Layout', () {
      testWidgets('labels share one column width regardless of length', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 400,
            child: RemixDataList(
              style: _metricStyle().columnSpacing(12.0),
              items: const [
                RemixDataListItem(label: 'A', value: 'first'),
                RemixDataListItem(label: 'BBBB', value: 'second'),
                RemixDataListItem(label: 'CCCCCCCC', value: 'third'),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final labelWidths = ['A', 'BBBB', 'CCCCCCCC']
            .map((label) => tester.getSize(find.text(label)).width)
            .toList();
        expect(labelWidths[0], equals(labelWidths[1]));
        expect(labelWidths[1], equals(labelWidths[2]));

        final valueLefts = ['first', 'second', 'third']
            .map((value) => tester.getTopLeft(find.text(value)).dx)
            .toList();
        expect(valueLefts[0], equals(valueLefts[1]));
        expect(valueLefts[1], equals(valueLefts[2]));

        // The shared boundary sits after the label column plus the gap.
        final tableLeft = tester.getTopLeft(_table).dx;
        expect(valueLefts[0], equals(tableLeft + labelWidths[0] + 12.0));
      });

      testWidgets('label column respects minLabelWidth', (tester) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 400,
            child: RemixDataList(
              style: _metricStyle().minLabelWidth(140.0).columnSpacing(24.0),
              items: const [RemixDataListItem(label: 'A', value: 'v')],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final tableLeft = tester.getTopLeft(_table).dx;
        expect(tester.getSize(find.text('A')).width, equals(140.0));
        expect(
          tester.getTopLeft(find.text('v')).dx,
          equals(tableLeft + 140.0 + 24.0),
        );
      });

      testWidgets('label column grows past minLabelWidth for a wide label', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 400,
            child: RemixDataList(
              style: _metricStyle().minLabelWidth(10.0).columnSpacing(12.0),
              items: const [
                RemixDataListItem(label: 'CCCCCCCC', value: 'v'),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final labelWidth = tester.getSize(find.text('CCCCCCCC')).width;
        expect(labelWidth, greaterThan(10.0));

        final tableLeft = tester.getTopLeft(_table).dx;
        expect(
          tester.getTopLeft(find.text('v')).dx,
          equals(tableLeft + labelWidth + 12.0),
        );
      });

      testWidgets('value column flexes to the bounded width', (tester) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 400,
            child: RemixDataList(
              style: _metricStyle(),
              items: const [RemixDataListItem(label: 'A', value: 'v')],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.getSize(_table).width, equals(400.0));
      });

      testWidgets('value column becomes intrinsic under unbounded width', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: RemixDataList(
              style: _metricStyle().columnSpacing(12.0),
              items: const [RemixDataListItem(label: 'AB', value: 'CDE')],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        final labelWidth = tester.getSize(find.text('AB')).width;
        final valueWidth = tester.getSize(find.text('CDE')).width;
        expect(
          tester.getSize(_table).width,
          equals(labelWidth + 12.0 + valueWidth),
        );
      });

      testWidgets('rowSpacing separates consecutive rows only', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 400,
            child: RemixDataList(
              style: _metricStyle().rowSpacing(12.0),
              items: const [
                RemixDataListItem(label: 'A', value: 'first'),
                RemixDataListItem(label: 'B', value: 'second'),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final firstTop = tester.getTopLeft(find.text('A')).dy;
        final secondTop = tester.getTopLeft(find.text('B')).dy;
        // One 10 px line plus the 12 px gap.
        expect(secondTop - firstTop, equals(22.0));

        final tableHeight = tester.getSize(_table).height;
        // No trailing gap after the last row: two lines plus one gap.
        expect(tableHeight, equals(32.0));
      });

      testWidgets(
        'custom child keeps its natural width at the value column start',
        (tester) async {
          const probeKey = ValueKey('inline');
          await tester.pumpRemixApp(
            SizedBox(
              width: 400,
              child: RemixDataList(
                style: _metricStyle().minLabelWidth(100.0).columnSpacing(24.0),
                items: const [
                  RemixDataListItem(label: 'A', value: 'text value'),
                  RemixDataListItem(
                    label: 'B',
                    alignment: RemixDataListItemAlignment.start,
                    child: SizedBox(key: probeKey, width: 20, height: 10),
                  ),
                ],
              ),
            ),
          );
          await tester.pumpAndSettle();

          final tableLeft = tester.getTopLeft(_table).dx;
          // A string value fills the column so long text can wrap.
          expect(
            tester.getSize(find.text('text value')).width,
            equals(400.0 - 100.0 - 24.0),
          );
          // A custom child sits inline at the column start at natural size.
          expect(tester.getSize(find.byKey(probeKey)).width, equals(20.0));
          expect(
            tester.getTopLeft(find.byKey(probeKey)).dx,
            equals(tableLeft + 100.0 + 24.0),
          );
        },
      );

      testWidgets('RTL reverses column order and directional gap', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 400,
            child: RemixDataList(
              style: _metricStyle().minLabelWidth(140.0).columnSpacing(24.0),
              items: const [RemixDataListItem(label: 'A', value: 'v')],
            ),
          ),
          textDirection: TextDirection.rtl,
        );
        await tester.pumpAndSettle();

        final tableRight = tester.getTopRight(_table).dx;
        final labelCenter = tester.getCenter(find.text('A')).dx;
        final valueCenter = tester.getCenter(find.text('v')).dx;

        // Label column occupies the trailing (right) edge in RTL.
        expect(labelCenter, greaterThan(valueCenter));
        expect(tester.getTopRight(find.text('A')).dx, equals(tableRight));
        // The directional gap moves to the value cell's right side.
        expect(
          tester.getTopRight(find.text('v')).dx,
          equals(tableRight - 140.0 - 24.0),
        );
      });
    });

    group('Item Alignment', () {
      const probeKey = ValueKey('probe');
      const probe = SizedBox(key: probeKey, width: 20, height: 60);

      Future<void> pumpAligned(
        WidgetTester tester,
        RemixDataListItemAlignment alignment,
      ) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 300,
            child: RemixDataList(
              style: _metricStyle(),
              items: [
                RemixDataListItem(
                  label: 'L',
                  alignment: alignment,
                  child: probe,
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();
      }

      testWidgets('start aligns both cells to the row top', (tester) async {
        await pumpAligned(tester, RemixDataListItemAlignment.start);

        expect(
          tester.getTopLeft(find.text('L')).dy,
          equals(tester.getTopLeft(find.byKey(probeKey)).dy),
        );
      });

      testWidgets('center aligns both cell centers', (tester) async {
        await pumpAligned(tester, RemixDataListItemAlignment.center);

        expect(
          tester.getCenter(find.text('L')).dy,
          equals(tester.getCenter(find.byKey(probeKey)).dy),
        );
      });

      testWidgets('end aligns both cell bottoms', (tester) async {
        await pumpAligned(tester, RemixDataListItemAlignment.end);

        expect(
          tester.getBottomLeft(find.text('L')).dy,
          equals(tester.getBottomLeft(find.byKey(probeKey)).dy),
        );
      });

      testWidgets('stretch sizes both cells to the tallest cell', (
        tester,
      ) async {
        await pumpAligned(tester, RemixDataListItemAlignment.stretch);

        expect(tester.getSize(find.text('L')).height, equals(60.0));
        expect(tester.getSize(find.byKey(probeKey)).height, equals(60.0));
      });

      testWidgets('string baseline row aligns text baselines', (tester) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 300,
            child: RemixDataList(
              style: _metricStyle(labelSize: 10, valueSize: 30),
              items: const [
                RemixDataListItem(
                  label: 'L',
                  value: 'V',
                  alignment: RemixDataListItemAlignment.baseline,
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final labelTop = tester.getTopLeft(find.text('L')).dy;
        final valueTop = tester.getTopLeft(find.text('V')).dy;
        // FlutterTest font baselines: 0.75 * 10 = 7.5 and 0.75 * 30 = 22.5.
        expect(labelTop + 7.5, moreOrLessEquals(valueTop + 22.5));
      });

      testWidgets('custom-child baseline row deterministically maps to top', (
        tester,
      ) async {
        await pumpAligned(tester, RemixDataListItemAlignment.baseline);

        expect(
          tester.getTopLeft(find.text('L')).dy,
          equals(tester.getTopLeft(find.byKey(probeKey)).dy),
        );
      });

      testWidgets('vertical baseline maps to start', (tester) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 300,
            child: RemixDataList(
              orientation: Axis.vertical,
              style: _metricStyle(),
              items: const [
                RemixDataListItem(
                  label: 'L',
                  alignment: RemixDataListItemAlignment.baseline,
                  child: probe,
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          tester.getTopLeft(find.text('L')).dx,
          equals(tester.getTopLeft(find.byKey(probeKey)).dx),
        );
      });
    });

    group('Vertical Layout', () {
      testWidgets('stacks label above value with labelValueSpacing', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 300,
            child: RemixDataList(
              orientation: Axis.vertical,
              style: _metricStyle().labelValueSpacing(4.0).rowSpacing(16.0),
              items: const [
                RemixDataListItem(label: 'A', value: 'first'),
                RemixDataListItem(label: 'B', value: 'second'),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final labelBottom = tester.getBottomLeft(find.text('A')).dy;
        final valueTop = tester.getTopLeft(find.text('first')).dy;
        expect(valueTop - labelBottom, equals(4.0));

        final firstValueBottom = tester.getBottomLeft(find.text('first')).dy;
        final secondLabelTop = tester.getTopLeft(find.text('B')).dy;
        expect(secondLabelTop - firstValueBottom, equals(16.0));
      });

      testWidgets('maps center and end across the horizontal cross axis', (
        tester,
      ) async {
        const probeKey = ValueKey('wide');
        await tester.pumpRemixApp(
          SizedBox(
            width: 300,
            child: RemixDataList(
              orientation: Axis.vertical,
              style: _metricStyle(),
              items: const [
                RemixDataListItem(
                  label: 'C',
                  alignment: RemixDataListItemAlignment.center,
                  child: SizedBox(key: probeKey, width: 40, height: 10),
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          tester.getCenter(find.text('C')).dx,
          equals(tester.getCenter(find.byKey(probeKey)).dx),
        );

        await tester.pumpRemixApp(
          SizedBox(
            width: 300,
            child: RemixDataList(
              orientation: Axis.vertical,
              style: _metricStyle(),
              items: const [
                RemixDataListItem(
                  label: 'E',
                  alignment: RemixDataListItemAlignment.end,
                  child: SizedBox(key: probeKey, width: 40, height: 10),
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          tester.getBottomRight(find.text('E')).dx,
          equals(tester.getBottomRight(find.byKey(probeKey)).dx),
        );
      });

      testWidgets('stretch fills the bounded cross axis', (tester) async {
        const probeKey = ValueKey('stretched');
        await tester.pumpRemixApp(
          SizedBox(
            width: 300,
            child: RemixDataList(
              orientation: Axis.vertical,
              style: _metricStyle(),
              items: const [
                RemixDataListItem(
                  label: 'S',
                  alignment: RemixDataListItemAlignment.stretch,
                  child: SizedBox(key: probeKey, width: 40, height: 10),
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.getSize(find.text('S')).width, equals(300.0));
        expect(tester.getSize(find.byKey(probeKey)).width, equals(300.0));
      });
    });

    group('Text Scale and Width Bounds', () {
      const longValue =
          'Uma descrição razoavelmente longa que quebra em várias linhas';

      testWidgets('soft-wrappable values wrap at 200% and 300% scale', (
        tester,
      ) async {
        for (final scale in [2.0, 3.0]) {
          await tester.pumpRemixApp(
            MediaQuery(
              data: MediaQueryData(textScaler: TextScaler.linear(scale)),
              child: SizedBox(
                width: 360,
                child: RemixDataList(
                  style: _metricStyle().columnSpacing(12.0),
                  items: const [
                    RemixDataListItem(label: 'Info', value: longValue),
                  ],
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          final valueHeight = tester.getSize(find.text(longValue)).height;
          expect(
            valueHeight,
            greaterThan(10.0 * scale),
            reason: 'value should wrap to multiple lines at ${scale}x',
          );
        }
      });

      testWidgets(
        'below the horizontal minimum the renderer keeps the explicit '
        'orientation and the pinned label column',
        (tester) async {
          await tester.pumpRemixApp(
            SizedBox(
              width: 80,
              child: RemixDataList(
                style: _metricStyle().minLabelWidth(120.0).columnSpacing(12.0),
                items: const [RemixDataListItem(label: 'A', value: 'v')],
              ),
            ),
          );
          await tester.pumpAndSettle();

          // No hidden orientation switch and no relaxation of the pinned
          // label column: the caller owns the responsive fallback.
          expect(tester.takeException(), isNull);
          expect(_table, findsOneWidget);
          expect(tester.getSize(_table).width, equals(80.0));
          expect(tester.getSize(find.text('A')).width, equals(120.0));
        },
      );

      testWidgets('the same data renders vertically below the minimum', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 80,
            child: RemixDataList(
              orientation: Axis.vertical,
              style: _metricStyle().minLabelWidth(120.0).columnSpacing(12.0),
              items: const [RemixDataListItem(label: 'A', value: 'v')],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(_table, findsNothing);
        expect(find.text('A'), findsOneWidget);
        expect(find.text('v'), findsOneWidget);
      });
    });
  });
}
