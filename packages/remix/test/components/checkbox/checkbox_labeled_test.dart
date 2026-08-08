import 'dart:ui' show CheckedState, SemanticsAction;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('labeled checkbox interaction target', () {
    testWidgets('defaults to a 48 logical pixel minimum tap target', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          semanticLabel: 'Receive updates',
          onChanged: (_) {},
          style: CheckboxStyler().size(16, 16),
        ),
      );

      expect(tester.getSize(find.byType(RemixCheckbox)), const Size.square(48));
    });

    testWidgets('box, label, gap, and target edges each toggle exactly once', (
      tester,
    ) async {
      var changes = 0;
      const label = 'Receive updates';

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          label: label,
          onChanged: (_) => changes += 1,
          style: CheckboxStyler().size(16, 16).labelSpacing(12),
        ),
      );

      final checkbox = find.byType(RemixCheckbox);
      final boxRect = tester.getRect(find.byType(Box));
      final labelRect = tester.getRect(find.text(label));
      final targetRect = tester.getRect(checkbox);
      final tapLocations = <Offset>[
        boxRect.center,
        labelRect.center,
        Offset((boxRect.right + labelRect.left) / 2, targetRect.center.dy),
        targetRect.topLeft + const Offset(1, 1),
        targetRect.topRight + const Offset(-1, 1),
        targetRect.bottomLeft + const Offset(1, -1),
        targetRect.bottomRight + const Offset(-1, -1),
      ];

      for (var i = 0; i < tapLocations.length; i++) {
        await tester.tapAt(tapLocations[i]);
        await tester.pump();
        expect(changes, i + 1, reason: 'tap location ${tapLocations[i]}');
      }
    });

    testWidgets('explicit Size.zero opts into compact visual geometry', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          semanticLabel: 'Compact checkbox',
          minimumTapTargetSize: Size.zero,
          onChanged: (_) {},
          style: CheckboxStyler().size(16, 16),
        ),
      );

      expect(tester.getSize(find.byType(RemixCheckbox)), const Size.square(16));
    });

    testWidgets('rejects non-finite and negative minimum target dimensions', (
      tester,
    ) async {
      for (final invalidSize in const <Size>[
        Size(double.infinity, 48),
        Size(48, double.infinity),
        Size(-1, 48),
      ]) {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: false, minimumTapTargetSize: invalidSize),
        );
        expect(tester.takeException(), isA<AssertionError>());
        await tester.pumpWidget(const SizedBox.shrink());
      }
    });

    testWidgets('meets Android, iOS, and labeled tap target guidelines', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          label: 'Receive updates',
          onChanged: (_) {},
          style: CheckboxStyler().size(16, 16),
        ),
      );

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });
  });

  group('labeled checkbox semantics', () {
    testWidgets('exposes one exact unchecked enabled checkbox node', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          label: 'Receive updates',
          onChanged: (_) {},
        ),
      );

      _expectSingleCheckboxNode(tester);
      expect(
        tester.getSemantics(find.byType(RemixCheckbox)),
        matchesSemantics(
          label: 'Receive updates',
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

    testWidgets('exposes one exact checked enabled checkbox node', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: true,
          label: 'Receive updates',
          onChanged: (_) {},
        ),
      );

      _expectSingleCheckboxNode(tester);
      expect(
        tester.getSemantics(find.byType(RemixCheckbox)),
        matchesSemantics(
          label: 'Receive updates',
          textDirection: TextDirection.ltr,
          hasCheckedState: true,
          isChecked: true,
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

    testWidgets('exposes one exact mixed enabled checkbox node', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: null,
          tristate: true,
          label: 'Receive updates',
          onChanged: (_) {},
        ),
      );

      _expectSingleCheckboxNode(tester);
      expect(
        tester.getSemantics(find.byType(RemixCheckbox)),
        matchesSemantics(
          label: 'Receive updates',
          textDirection: TextDirection.ltr,
          hasCheckedState: true,
          isCheckStateMixed: true,
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

    testWidgets('exposes one exact disabled checkbox node without actions', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpRemixApp(
        const RemixCheckbox(
          selected: false,
          enabled: false,
          label: 'Receive updates',
        ),
      );

      _expectSingleCheckboxNode(tester);
      expect(
        tester.getSemantics(find.byType(RemixCheckbox)),
        matchesSemantics(
          label: 'Receive updates',
          textDirection: TextDirection.ltr,
          hasCheckedState: true,
          hasEnabledState: true,
          children: const <Matcher>[],
        ),
      );
      handle.dispose();
    });

    testWidgets('semanticLabel overrides visible label without duplication', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          label: 'API updates',
          semanticLabel: 'Receive API product updates',
          onChanged: (_) {},
        ),
      );

      final checkboxNode = _expectSingleCheckboxNode(tester);
      expect(
        checkboxNode.getSemanticsData().label,
        'Receive API product updates',
      );
      expect(find.text('API updates'), findsOneWidget);
      expect(_semanticsSubtree(checkboxNode), hasLength(1));
      handle.dispose();
    });

    testWidgets('semantic tap and focus actions activate the whole control', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      var changes = 0;

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          label: 'Receive updates',
          focusNode: focusNode,
          onChanged: (_) => changes += 1,
        ),
      );

      final node = _expectSingleCheckboxNode(tester);
      node.owner!.performAction(node.id, SemanticsAction.tap);
      await tester.pump();
      expect(changes, 1);

      node.owner!.performAction(node.id, SemanticsAction.focus);
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);
      handle.dispose();
    });

    testWidgets('rejects blank visible and semantic labels', (tester) async {
      for (final checkbox in const <RemixCheckbox>[
        RemixCheckbox(selected: false, label: '  '),
        RemixCheckbox(selected: false, semanticLabel: '\n'),
      ]) {
        await tester.pumpRemixApp(checkbox);
        expect(tester.takeException(), isA<AssertionError>());
        await tester.pumpWidget(const SizedBox.shrink());
      }
    });
  });

  group('labeled checkbox layout and styling', () {
    for (final direction in TextDirection.values) {
      testWidgets('uses ambient ${direction.name} visual order', (
        tester,
      ) async {
        const label = 'Receive updates';

        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            label: label,
            onChanged: (_) {},
            style: CheckboxStyler().size(16, 16).labelSpacing(12),
          ),
          textDirection: direction,
        );

        final boxRect = tester.getRect(find.byType(Box));
        final labelRect = tester.getRect(find.text(label));
        final gap = direction == TextDirection.ltr
            ? labelRect.left - boxRect.right
            : boxRect.left - labelRect.right;
        expect(gap, 12);
        expect(
          direction == TextDirection.ltr
              ? boxRect.left < labelRect.left
              : boxRect.left > labelRect.left,
          isTrue,
        );
      });
    }

    testWidgets('wraps a long label at 3x text scaling when width is bounded', (
      tester,
    ) async {
      const label =
          'Receive detailed release notes and important API migration updates';

      await tester.pumpRemixApp(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(3)),
          child: SizedBox(
            width: 220,
            child: RemixCheckbox(
              selected: false,
              label: label,
              onChanged: (_) {},
              style: CheckboxStyler().size(16, 16),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.byType(RemixCheckbox)).width, 220);
      expect(tester.getSize(find.text(label)).height, greaterThan(48));
    });

    testWidgets('generated label and spacing styles resolve and render', (
      tester,
    ) async {
      const label = 'Receive updates';

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          label: label,
          onChanged: (_) {},
          style: CheckboxStyler()
              .size(16, 16)
              .labelColor(Colors.purple)
              .labelSpacing(14),
        ),
      );

      final boxRect = tester.getRect(find.byType(Box));
      final labelRect = tester.getRect(find.text(label));
      expect(labelRect.left - boxRect.right, 14);
      expect(tester.widget<Text>(find.text(label)).style?.color, Colors.purple);
    });

    testWidgets('raw styleSpec controls label style and spacing', (
      tester,
    ) async {
      const label = 'Receive updates';
      const spec = CheckboxSpec(
        container: StyleSpec(
          spec: BoxSpec(
            constraints: BoxConstraints(
              minWidth: 16,
              maxWidth: 16,
              minHeight: 16,
              maxHeight: 16,
            ),
          ),
        ),
        label: StyleSpec(
          spec: TextSpec(style: TextStyle(color: Colors.orange)),
        ),
        labelSpacing: 10,
      );

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          label: label,
          onChanged: (_) {},
          styleSpec: spec,
        ),
      );

      final boxRect = tester.getRect(find.byType(Box));
      final labelRect = tester.getRect(find.text(label));
      expect(labelRect.left - boxRect.right, 10);
      expect(tester.widget<Text>(find.text(label)).style?.color, Colors.orange);
    });
  });

  group('disabled labeled checkbox behavior', () {
    testWidgets('does not tap, hover with click cursor, or request focus', (
      tester,
    ) async {
      final key = UniqueKey();
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      var changes = 0;

      await tester.pumpRemixApp(
        RemixCheckbox(
          key: key,
          selected: false,
          enabled: false,
          label: 'Receive updates',
          focusNode: focusNode,
          onChanged: (_) => changes += 1,
        ),
      );

      await tester.tap(find.text('Receive updates'));
      await tester.pump();
      expect(changes, 0);

      final mouseRegion = tester.widget<MouseRegion>(
        find
            .descendant(of: find.byKey(key), matching: find.byType(MouseRegion))
            .first,
      );
      expect(mouseRegion.cursor, SystemMouseCursors.basic);

      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isFalse);
    });

    testWidgets('a null callback has the same disabled contract', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpRemixApp(
        RemixCheckbox(
          selected: false,
          label: 'Receive updates',
          focusNode: focusNode,
        ),
      );

      final data = _expectSingleCheckboxNode(tester).getSemanticsData();
      expect(data.hasAction(SemanticsAction.tap), isFalse);
      expect(data.hasAction(SemanticsAction.focus), isFalse);
      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isFalse);
      handle.dispose();
    });
  });

  group('CheckboxStyler call surface', () {
    test('forwards the labeled checkbox API', () {
      final checkbox = CheckboxStyler().call(
        selected: false,
        label: 'Receive updates',
        minimumTapTargetSize: Size.zero,
      );

      expect(checkbox.label, 'Receive updates');
      expect(checkbox.minimumTapTargetSize, Size.zero);
    });
  });
}

SemanticsNode _expectSingleCheckboxNode(WidgetTester tester) {
  final root = tester.getSemantics(find.byType(RemixCheckbox));
  final checkboxNodes = _semanticsSubtree(root)
      .where(
        (node) =>
            node.getSemanticsData().flagsCollection.isChecked !=
            CheckedState.none,
      )
      .toList();
  expect(checkboxNodes, hasLength(1));
  return checkboxNodes.single;
}

List<SemanticsNode> _semanticsSubtree(SemanticsNode root) {
  final nodes = <SemanticsNode>[];

  void visit(SemanticsNode node) {
    nodes.add(node);
    node.visitChildren((child) {
      visit(child);
      return true;
    });
  }

  visit(root);
  return nodes;
}
