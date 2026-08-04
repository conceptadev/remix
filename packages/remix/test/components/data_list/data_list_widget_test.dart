import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderParagraph;
import 'package:flutter/semantics.dart' hide SemanticsRole;
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

/// The horizontal renderer uses a private [Table] subclass, so match by
/// subtype instead of by exact runtime type.
final Finder _table = find.byWidgetPredicate((widget) => widget is Table);

/// Deterministic typography for geometry assertions: the FlutterTest font has
/// a 0.75em ascent and 0.25em descent, `height: 1.0` pins the line height to
/// the font size, and `letterSpacing: 0` suppresses the inherited Material
/// bodyMedium letter spacing so glyph advances are exactly 1em.
DataListStyler _metricStyle({double labelSize = 10, double valueSize = 10}) {
  return DataListStyler()
      .labelTextStyle(
        TextStyleMix(fontSize: labelSize, height: 1.0, letterSpacing: 0),
      )
      .valueTextStyle(
        TextStyleMix(fontSize: valueSize, height: 1.0, letterSpacing: 0),
      );
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

/// Maps a semantics node's rect through its ancestor transforms into global
/// coordinates, then divides out the root view's device-pixel-ratio scale so
/// the result is comparable with [WidgetTester.getRect].
Rect _globalSemanticsRect(WidgetTester tester, SemanticsNode node) {
  var rect = node.rect;
  SemanticsNode? current = node;
  while (current != null) {
    final transform = current.transform;
    if (transform != null) {
      rect = MatrixUtils.transformRect(transform, rect);
    }
    current = current.parent;
  }
  final scale = tester.view.devicePixelRatio;

  return Rect.fromLTRB(
    rect.left / scale,
    rect.top / scale,
    rect.right / scale,
    rect.bottom / scale,
  );
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

      testWidgets('horizontal orientation answers intrinsic dimensions', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          IntrinsicWidth(
            child: RemixDataList(
              style: _metricStyle().columnSpacing(12.0),
              items: const [
                RemixDataListItem(label: 'Name', value: 'Leo'),
                RemixDataListItem(label: 'Email', value: 'leo@example.com'),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(_table, findsOneWidget);
        expect(tester.getSize(_table).width, isPositive);
      });

      testWidgets('horizontal orientation renders as AlertDialog content', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          AlertDialog(
            content: RemixDataList(
              style: _metricStyle(),
              items: const [
                RemixDataListItem(label: 'Name', value: 'Leo'),
                RemixDataListItem(label: 'Email', value: 'leo@example.com'),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(_table, findsOneWidget);
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

      testWidgets('direct StyleSpec is const and bypasses style resolution', (
        tester,
      ) async {
        const widget = RemixDataList(
          style: _FailIfResolvedDataListStyler(),
          styleSpec: StyleSpec(spec: DataListSpec()),
          items: [RemixDataListItem(label: 'Name', value: 'Leo')],
        );
        final Style<DataListSpec> style = widget.style;
        final StyleSpec<DataListSpec>? styleSpec = widget.styleSpec;

        expect(style, isA<_FailIfResolvedDataListStyler>());
        expect(styleSpec?.spec, equals(const DataListSpec()));

        await tester.pumpRemixApp(widget);
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

      testWidgets('rejects a blank label at build time', (tester) async {
        await tester.pumpRemixApp(
          const RemixDataList(
            items: [RemixDataListItem(label: '   ', value: 'Leo')],
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });

      testWidgets('rejects a blank label at build time (vertical)', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixDataList(
            orientation: Axis.vertical,
            items: [RemixDataListItem(label: '\n', value: 'Leo')],
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });

      testWidgets('rejects a blank value at build time', (tester) async {
        await tester.pumpRemixApp(
          const RemixDataList(
            items: [RemixDataListItem(label: 'Name', value: '   ')],
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });

      testWidgets('rejects a blank semanticValue at build time', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixDataList(
            items: [
              RemixDataListItem(
                label: 'Name',
                semanticValue: ' \t ',
                child: SizedBox(width: 10, height: 10),
              ),
            ],
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });

      testWidgets('rejects a blank semanticLabel at build time', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixDataList(
            semanticLabel: '  ',
            items: [RemixDataListItem(label: 'Name', value: 'Leo')],
          ),
        );

        expect(tester.takeException(), isAssertionError);
      });

      testWidgets('padded caller text is displayed and announced verbatim', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();
        await tester.pumpRemixApp(
          const RemixDataList(
            items: [RemixDataListItem(label: ' Name ', value: ' Leo ')],
          ),
        );
        await tester.pumpAndSettle();

        // Blank rejection is validation only — the renderer never trims or
        // rewrites what the caller displays and announces.
        expect(tester.takeException(), isNull);
        expect(find.text(' Name '), findsOneWidget);
        final row = _rowNodes(tester).single.getSemanticsData();
        expect(row.label, equals(' Name '));
        expect(row.value, equals(' Leo '));
        handle.dispose();
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
          RemixDataList(
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
          RemixDataList(
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

      testWidgets('custom interactive child keeps its action and label once', (
        tester,
      ) async {
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
          (data) => data.label == 'Copy' && data.hasAction(SemanticsAction.tap),
        );
        expect(button, isNotNull);

        // The visual label is not announced a second time.
        expect(_countNodesWithLabel(tester, 'Status'), equals(1));

        await tester.tap(find.text('Copy'));
        await tester.pumpAndSettle();
        expect(pressed, equals(1));
        handle.dispose();
      });

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

      testWidgets(
        'horizontal row node covers the full visible row including the label',
        (tester) async {
          final handle = tester.ensureSemantics();
          await tester.pumpRemixApp(
            SizedBox(
              width: 400,
              child: RemixDataList(
                style: _metricStyle()
                    .minLabelWidth(140.0)
                    .columnSpacing(24.0)
                    .rowSpacing(12.0),
                items: const [
                  RemixDataListItem(label: 'Name', value: 'Leo'),
                  RemixDataListItem(label: 'Email', value: 'leo@example.com'),
                ],
              ),
            ),
          );
          await tester.pumpAndSettle();

          final rows = _rowNodes(tester);
          expect(rows, hasLength(2));

          final tableRect = tester.getRect(_table);
          final firstRowRect = _globalSemanticsRect(tester, rows[0]);
          final secondRowRect = _globalSemanticsRect(tester, rows[1]);

          // Touch exploration over the excluded visible label must land
          // inside the row's semantic bounds.
          expect(firstRowRect.left, equals(tableRect.left));
          expect(firstRowRect.width, equals(tableRect.width));
          expect(
            firstRowRect.contains(tester.getRect(find.text('Name')).center),
            isTrue,
          );
          expect(
            secondRowRect.contains(tester.getRect(find.text('Email')).center),
            isTrue,
          );

          // Rows tile the table without overlapping hit regions.
          expect(
            secondRowRect.top,
            greaterThanOrEqualTo(firstRowRect.bottom - 0.01),
          );
          handle.dispose();
        },
      );

      testWidgets('expanded row bounds leave nested control geometry intact', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();
        await tester.pumpRemixApp(
          SizedBox(
            width: 400,
            child: RemixDataList(
              style: _metricStyle().minLabelWidth(140.0).columnSpacing(24.0),
              items: [
                RemixDataListItem(
                  label: 'Status',
                  child: RemixButton(label: 'Copy', onPressed: () {}),
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final rows = _rowNodes(tester);
        final rowRect = _globalSemanticsRect(tester, rows.single);
        final tableRect = tester.getRect(_table);
        expect(rowRect.left, equals(tableRect.left));
        expect(rowRect.width, equals(tableRect.width));

        // The nested button's node keeps its own true geometry — the row
        // expansion must not swallow or displace it.
        final buttonNode = _findNode(
          rows.single,
          (data) => data.label == 'Copy' && data.hasAction(SemanticsAction.tap),
        );
        expect(buttonNode, isNotNull);
        final buttonNodeRect = _globalSemanticsRect(tester, buttonNode!);
        final buttonRect = tester.getRect(find.byType(RemixButton));
        expect(buttonNodeRect.width, lessThan(rowRect.width));
        expect(
          (buttonNodeRect.center - buttonRect.center).distance,
          lessThan(0.1),
        );
        expect(rowRect.contains(buttonRect.center), isTrue);
        handle.dispose();
      });

      testWidgets(
        'RTL row nodes cover the full row and keep nested action geometry',
        (tester) async {
          final handle = tester.ensureSemantics();
          var pressed = 0;
          await tester.pumpRemixApp(
            SizedBox(
              width: 400,
              child: RemixDataList(
                style: _metricStyle()
                    .minLabelWidth(140.0)
                    .columnSpacing(24.0)
                    .rowSpacing(12.0),
                items: [
                  const RemixDataListItem(label: 'Name', value: 'Leo'),
                  RemixDataListItem(
                    label: 'Status',
                    child: RemixButton(
                      label: 'Copy',
                      onPressed: () => pressed += 1,
                    ),
                  ),
                ],
              ),
            ),
            textDirection: TextDirection.rtl,
          );
          await tester.pumpAndSettle();

          final rows = _rowNodes(tester);
          expect(rows, hasLength(2));

          final tableRect = tester.getRect(_table);
          final firstRowRect = _globalSemanticsRect(tester, rows[0]);
          final secondRowRect = _globalSemanticsRect(tester, rows[1]);

          // The trailing (right-side) label column is inside each row's
          // expanded semantic rect, and rows span the full table width.
          for (final rowRect in [firstRowRect, secondRowRect]) {
            expect(rowRect.left, equals(tableRect.left));
            expect(rowRect.width, equals(tableRect.width));
          }
          final nameCenter = tester.getRect(find.text('Name')).center;
          expect(nameCenter.dx, greaterThan(tableRect.center.dx));
          expect(firstRowRect.contains(nameCenter), isTrue);
          expect(
            secondRowRect.contains(tester.getRect(find.text('Status')).center),
            isTrue,
          );

          // The nested action keeps its true rect and stays actionable. In
          // RTL a start-aligned custom child abuts the gap before the
          // trailing label column: its right edge sits exactly at
          // tableRight - minLabelWidth - columnSpacing.
          final buttonNode = _findNode(
            rows[1],
            (data) =>
                data.label == 'Copy' && data.hasAction(SemanticsAction.tap),
          );
          expect(buttonNode, isNotNull);
          final buttonNodeRect = _globalSemanticsRect(tester, buttonNode!);
          final buttonRect = tester.getRect(find.byType(RemixButton));
          expect(buttonRect.right, equals(tableRect.right - 140.0 - 24.0));
          expect(
            (buttonNodeRect.center - buttonRect.center).distance,
            lessThan(0.1),
          );
          expect(buttonNodeRect.width, lessThan(secondRowRect.width));

          await tester.tap(find.text('Copy'));
          await tester.pumpAndSettle();
          expect(pressed, equals(1));
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

        final labelWidths = [
          'A',
          'BBBB',
          'CCCCCCCC',
        ].map((label) => tester.getSize(find.text(label)).width).toList();
        expect(labelWidths[0], equals(labelWidths[1]));
        expect(labelWidths[1], equals(labelWidths[2]));

        final valueLefts = [
          'first',
          'second',
          'third',
        ].map((value) => tester.getTopLeft(find.text(value)).dx).toList();
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
              items: const [RemixDataListItem(label: 'CCCCCCCC', value: 'v')],
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

      testWidgets('rowSpacing separates consecutive rows only', (tester) async {
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
        'long label leaves a grapheme-wide text value column at ~240px',
        (tester) async {
          // FlutterTest font: 10px/char. Label ideal 260px would eat the
          // whole 240px bound; the textual value keeps one grapheme (10px)
          // while both columns wrap.
          await tester.pumpRemixApp(
            SizedBox(
              width: 240,
              child: RemixDataList(
                style: _metricStyle(),
                items: const [
                  RemixDataListItem(
                    label: 'Aaaaaaaa Bbbbbbbb Cccccccc',
                    value: 'Dddd Eeee',
                  ),
                ],
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          expect(tester.getSize(_table).width, equals(240.0));

          final valueSize = tester.getSize(find.text('Dddd Eeee'));
          expect(valueSize.width, equals(10.0));
          expect(valueSize.height, greaterThanOrEqualTo(20.0));

          final labelSize = tester.getSize(
            find.text('Aaaaaaaa Bbbbbbbb Cccccccc'),
          );
          expect(labelSize.width, equals(230.0));
          expect(labelSize.height, greaterThanOrEqualTo(20.0));
        },
      );

      testWidgets(
        'long label keeps a scaled grapheme-wide value minimum at 200%',
        (tester) async {
          await tester.pumpRemixApp(
            MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
              child: SizedBox(
                width: 240,
                child: RemixDataList(
                  style: _metricStyle(),
                  items: const [
                    RemixDataListItem(
                      label: 'Aaaaaaaa Bbbbbbbb Cccccccc',
                      value: 'Dddd Eeee',
                    ),
                  ],
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          // At 2x the textual value keeps one scaled grapheme (20px), and the
          // label receives the rest of the bounded width.
          expect(tester.getSize(_table).width, equals(240.0));
          expect(tester.getSize(find.text('Dddd Eeee')).width, equals(20.0));
          expect(
            tester.getSize(find.text('Aaaaaaaa Bbbbbbbb Cccccccc')).width,
            equals(220.0),
          );
        },
      );

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

    group('Row Identity', () {
      const itemA = RemixDataListItem(
        key: ValueKey('a'),
        label: 'Alpha',
        child: _StatefulValue(id: 'A'),
      );
      const itemB = RemixDataListItem(
        key: ValueKey('b'),
        label: 'Beta',
        child: _StatefulValue(id: 'B'),
      );
      const itemC = RemixDataListItem(
        key: ValueKey('c'),
        label: 'Gamma',
        child: _StatefulValue(id: 'C'),
      );

      Future<void> pumpItems(
        WidgetTester tester,
        Axis orientation,
        List<RemixDataListItem> items,
      ) {
        return tester.pumpRemixApp(
          SizedBox(
            width: 400,
            child: RemixDataList(orientation: orientation, items: items),
          ),
        );
      }

      for (final orientation in Axis.values) {
        testWidgets(
          'keyed rows keep custom-value state across reorder, insertion, '
          'and removal (${orientation.name})',
          (tester) async {
            await pumpItems(tester, orientation, const [itemA, itemB]);
            await tester.pumpAndSettle();
            await tester.tap(find.text('A:0'));
            await tester.pump();
            expect(find.text('A:1'), findsOneWidget);

            // Reorder: state must follow the keyed row, not the position.
            await pumpItems(tester, orientation, const [itemB, itemA]);
            await tester.pumpAndSettle();
            expect(find.text('A:1'), findsOneWidget);
            expect(find.text('B:0'), findsOneWidget);
            expect(
              tester.getTopLeft(find.text('A:1')).dy,
              greaterThan(tester.getTopLeft(find.text('B:0')).dy),
            );

            // Insertion above keeps existing state.
            await pumpItems(tester, orientation, const [itemC, itemB, itemA]);
            await tester.pumpAndSettle();
            expect(find.text('A:1'), findsOneWidget);
            expect(find.text('C:0'), findsOneWidget);

            // Removal of a sibling keeps state.
            await pumpItems(tester, orientation, const [itemC, itemA]);
            await tester.pumpAndSettle();
            expect(find.text('A:1'), findsOneWidget);
            expect(find.text('B:0'), findsNothing);
          },
        );
      }
    });

    group('Text Scale and Width Bounds', () {
      const longValue =
          'Uma descrição razoavelmente longa que quebra em várias linhas';

      testWidgets(
        'bounded textual IDs break within the value column at scale and RTL',
        (tester) async {
          const value = 'usr_01JAVERYLONGIDENTIFIERWITHOUTBREAKS_987654321';

          for (final textDirection in TextDirection.values) {
            for (final scale in [1.0, 2.0]) {
              await tester.pumpRemixApp(
                MediaQuery(
                  data: MediaQueryData(textScaler: TextScaler.linear(scale)),
                  child: SizedBox(
                    width: 180,
                    child: RemixDataList(
                      style: _metricStyle()
                          .minLabelWidth(60.0)
                          .columnSpacing(12.0),
                      items: const [
                        RemixDataListItem(label: 'ID', value: value),
                      ],
                    ),
                  ),
                ),
                textDirection: textDirection,
              );
              await tester.pumpAndSettle();

              expect(tester.takeException(), isNull);
              final tableRect = tester.getRect(_table);
              final valueRect = tester.getRect(find.text(value));
              expect(
                valueRect.left,
                greaterThanOrEqualTo(tableRect.left),
                reason:
                    'the value must stay inside its table at ${scale}x '
                    'in ${textDirection.name}',
              );
              expect(
                valueRect.right,
                lessThanOrEqualTo(tableRect.right),
                reason:
                    'the value must stay inside its table at ${scale}x '
                    'in ${textDirection.name}',
              );
              expect(
                valueRect.height,
                greaterThan(10.0 * scale),
                reason:
                    'the unbroken value must wrap at ${scale}x '
                    'in ${textDirection.name}',
              );
            }
          }
        },
      );

      testWidgets(
        'bounded textual values preserve grapheme clusters and semantics',
        (tester) async {
          final handle = tester.ensureSemantics();
          const cluster = 'e\u0301';
          const value = '$cluster$cluster$cluster$cluster$cluster';

          await tester.pumpRemixApp(
            SizedBox(
              width: 36,
              child: RemixDataList(
                style: _metricStyle().minLabelWidth(20.0).columnSpacing(4.0),
                items: const [RemixDataListItem(label: 'I', value: value)],
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          final tableRect = tester.getRect(_table);
          final valueFinder = find.text(value);
          final valueRect = tester.getRect(valueFinder);
          expect(valueRect.left, greaterThanOrEqualTo(tableRect.left));
          expect(valueRect.right, lessThanOrEqualTo(tableRect.right));
          expect(valueRect.height, greaterThan(10.0));

          final paragraph = tester.renderObject<RenderParagraph>(valueFinder);
          for (
            var offset = 0;
            offset < value.length;
            offset += cluster.length
          ) {
            final boxes = paragraph.getBoxesForSelection(
              TextSelection(
                baseOffset: offset,
                extentOffset: offset + cluster.length,
              ),
            );
            expect(boxes, isNotEmpty);
            expect(
              boxes.map((box) => box.top).toSet(),
              hasLength(1),
              reason: 'a grapheme cluster must not cross a line boundary',
            );
          }

          expect(
            _rowNodes(tester).single.getSemanticsData().value,
            equals(value),
          );
          handle.dispose();
        },
      );

      testWidgets('bounded custom children keep their intrinsic width', (
        tester,
      ) async {
        const probeKey = ValueKey('bounded-custom-value');
        await tester.pumpRemixApp(
          SizedBox(
            width: 70,
            child: RemixDataList(
              style: _metricStyle().minLabelWidth(20.0).columnSpacing(10.0),
              items: const [
                RemixDataListItem(
                  label: 'I',
                  child: SizedBox(key: probeKey, width: 60, height: 10),
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(tester.getSize(find.byKey(probeKey)).width, equals(60.0));
      });

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

/// Position-independent stateful probe: taps increment a counter that must
/// stay attached to this widget's row identity across list mutations.
class _StatefulValue extends StatefulWidget {
  const _StatefulValue({required this.id});

  final String id;

  @override
  State<_StatefulValue> createState() => _StatefulValueState();
}

class _StatefulValueState extends State<_StatefulValue> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _count += 1),
      child: Text('${widget.id}:$_count'),
    );
  }
}

final class _FailIfResolvedDataListStyler extends DataListStyler {
  const _FailIfResolvedDataListStyler() : super.create();

  @override
  StyleSpec<DataListSpec> resolve(BuildContext context) {
    throw StateError('Direct styleSpec must bypass style resolution.');
  }
}
