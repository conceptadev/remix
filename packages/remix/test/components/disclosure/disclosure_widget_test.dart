import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixDisclosure', () {
    testWidgets('toggles an uncontrolled content panel', (tester) async {
      await tester.pumpRemixApp(
        const RemixDisclosure(
          trigger: Text('Account details'),
          content: Text('Jane Appleseed'),
        ),
      );

      expect(find.text('Jane Appleseed'), findsNothing);

      await tester.tap(find.text('Account details'));
      await tester.pumpAndSettle();
      expect(find.text('Jane Appleseed'), findsOneWidget);

      await tester.tap(find.text('Account details'));
      await tester.pumpAndSettle();
      expect(find.text('Jane Appleseed'), findsNothing);
    });

    testWidgets('reports controlled requests without changing owner state', (
      tester,
    ) async {
      final requests = <bool>[];
      await tester.pumpRemixApp(
        RemixDisclosure(
          expanded: false,
          onExpandedChanged: requests.add,
          trigger: const Text('Account details'),
          content: const Text('Jane Appleseed'),
        ),
      );

      await tester.tap(find.text('Account details'));
      await tester.pump();

      expect(requests, [true]);
      expect(find.text('Jane Appleseed'), findsNothing);
    });

    testWidgets('trigger builder receives the expanded state', (tester) async {
      await tester.pumpRemixApp(
        RemixDisclosure(
          trigger: const Text('Account details'),
          content: const Text('Jane Appleseed'),
          triggerBuilder: (context, state, child) {
            return Text(state.isExpanded ? 'Hide details' : 'Show details');
          },
        ),
      );

      expect(find.text('Show details'), findsOneWidget);
      await tester.tap(find.text('Show details'));
      await tester.pumpAndSettle();
      expect(find.text('Hide details'), findsOneWidget);
    });

    testWidgets('resolves expanded variants across trigger and content', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixDisclosure(
          trigger: const Text('Account details'),
          content: const Text('Jane Appleseed'),
          style: DisclosureStyler()
              .color(Colors.red)
              .content(.padding(.all(4)))
              .onExpanded(
                DisclosureStyler()
                    .color(Colors.green)
                    .content(.padding(.all(12))),
              ),
        ),
      );

      expect(
        _boxColors(tester, find.text('Account details')),
        contains(Colors.red),
      );

      await tester.tap(find.text('Account details'));
      await tester.pumpAndSettle();

      expect(
        _boxColors(tester, find.text('Account details')),
        contains(Colors.green),
      );
      expect(
        _boxPaddings(tester, find.text('Jane Appleseed')),
        contains(const EdgeInsets.all(12)),
      );
    });

    testWidgets('forwards disclosure semantics and hint', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        const RemixDisclosure(
          semanticLabel: 'Account details',
          semanticHint: 'Shows the full account record',
          trigger: Icon(Icons.person),
          content: Text('Jane Appleseed'),
        ),
      );

      final trigger = find.bySemanticsLabel('Account details');
      expect(
        tester.getSemantics(trigger),
        isSemantics(
          label: 'Account details',
          hint: 'Shows the full account record',
          isButton: true,
          hasTapAction: true,
          hasExpandedState: true,
          isExpanded: false,
        ),
      );
      semantics.dispose();
    });

    testWidgets('derives its accessible name from visible trigger text', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        const RemixDisclosure(
          defaultExpanded: true,
          trigger: Text('Account details'),
          content: Text('Jane Appleseed'),
        ),
      );

      expect(
        tester.getSemantics(find.text('Account details')),
        isSemantics(
          label: 'Account details',
          isButton: true,
          hasTapAction: true,
          hasExpandedState: true,
          isExpanded: true,
        ),
      );
      semantics.dispose();
    });

    testWidgets('delegates the trigger-to-content semantics relationship', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        const RemixDisclosure(
          defaultExpanded: true,
          trigger: Text('Account details'),
          content: Text('Jane Appleseed'),
        ),
      );

      final trigger = tester.getSemantics(find.text('Account details'));
      final controlsNodes = trigger.getSemanticsData().controlsNodes;
      expect(controlsNodes, hasLength(1));

      final panelIdentifier = controlsNodes!.single;
      final panel = find.semantics.byPredicate(
        (node) => node.identifier == panelIdentifier,
      );
      expect(panel, findsOne);
      expect(panel.evaluate().single.id, isNot(trigger.id));
      expect(
        find.semantics.descendant(
          of: panel,
          matching: find.semantics.byLabel('Jane Appleseed'),
        ),
        findsOne,
      );

      await tester.tap(find.text('Account details'));
      await tester.pump();

      expect(
        tester
            .getSemantics(find.text('Account details'))
            .getSemanticsData()
            .controlsNodes,
        isNull,
      );
      expect(panel, findsNothing);
      semantics.dispose();
    });

    testWidgets('disabled triggers expose no tap action', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        const RemixDisclosure(
          enabled: false,
          trigger: Text('Account details'),
          content: Text('Jane Appleseed'),
        ),
      );

      expect(
        tester.getSemantics(find.text('Account details')),
        isSemantics(
          label: 'Account details',
          isButton: true,
          hasEnabledState: true,
          isEnabled: false,
          hasExpandedState: true,
          isExpanded: false,
          hasTapAction: false,
        ),
      );
      semantics.dispose();
    });

    group('Default transition', () {
      testWidgets('anchors the panel to the top start while expanding', (
        tester,
      ) async {
        // Pins the alignment the builder actually renders, so the
        // `axisAlignment` spelling it uses to stay on Flutter 3.41 cannot drift
        // away from `AlignmentDirectional.topStart`.
        final animation = AlwaysStoppedAnimation<double>(0.5);

        await tester.pumpRemixApp(
          Builder(
            builder: (context) {
              return RemixDisclosure.defaultDisclosureTransitionBuilder(
                context,
                animation,
                const Text('Panel'),
              );
            },
          ),
        );

        final align = tester.widget<Align>(
          find.descendant(
            of: find.byType(SizeTransition),
            matching: find.byType(Align),
          ),
        );

        expect(align.alignment, AlignmentDirectional.topStart);
        expect(align.heightFactor, 0.5);
      });
    });

    test('styleFrom and callable stylers preserve the style', () {
      final style = RemixDisclosure.styleFrom(
        trigger: BoxStyler().padding(.all(8)),
      );
      final disclosure = style(
        trigger: const Text('Trigger'),
        content: const Text('Content'),
      );

      expect(disclosure.style, same(style));
    });
  });
}

Iterable<Color?> _boxColors(WidgetTester tester, Finder descendant) {
  return tester
      .widgetList<Box>(
        find.ancestor(of: descendant, matching: find.byType(Box)),
      )
      .map((box) => (box.styleSpec?.spec.decoration as BoxDecoration?)?.color);
}

Iterable<EdgeInsetsGeometry?> _boxPaddings(
  WidgetTester tester,
  Finder descendant,
) {
  return tester
      .widgetList<Box>(
        find.ancestor(of: descendant, matching: find.byType(Box)),
      )
      .map((box) => box.styleSpec?.spec.padding);
}
