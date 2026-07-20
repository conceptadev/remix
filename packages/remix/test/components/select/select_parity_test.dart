import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixSelect structural contract', () {
    test(
      'entries model supports Radix item, group, label, and separator parts',
      () {
        const entries = <RemixSelectEntry<String>>[
          RemixSelectGroup(
            semanticLabel: 'Fruit',
            entries: [
              RemixSelectLabel(label: 'Fruit'),
              RemixSelectItem(value: 'apple', label: 'Apple'),
              RemixSelectSeparator(),
              RemixSelectItem(value: 'pear', label: 'Pear'),
            ],
          ),
        ];

        expect(entries.single, isA<RemixSelectGroup<String>>());
        expect(
          (entries.single as RemixSelectGroup<String>).entries,
          hasLength(4),
        );
      },
    );

    test(
      'spec separates trigger and content surfaces and structural slots',
      () {
        const spec = RemixSelectSpec(
          trigger: StyleSpec(
            spec: RemixSelectTriggerSpec(
              surface: RemixSurfaceLayerSpec(color: Colors.red),
              overlay: RemixSurfaceLayerSpec(color: Colors.orange),
            ),
          ),
          content: StyleSpec(
            spec: RemixSelectContentSpec(
              surface: RemixSurfaceLayerSpec(color: Colors.blue),
            ),
          ),
          label: StyleSpec(spec: RemixSelectLabelSpec()),
          separator: StyleSpec(spec: BoxSpec()),
        );

        expect(spec.trigger.spec.surface?.color, Colors.red);
        expect(spec.trigger.spec.overlay?.color, Colors.orange);
        expect(spec.content.spec.surface?.color, Colors.blue);
        expect(spec.label.spec, isA<RemixSelectLabelSpec>());
        expect(spec.separator.spec, isA<BoxSpec>());
      },
    );

    testWidgets('renders nested entries and resolves a nested selected label', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          entries: const [
            RemixSelectGroup(
              semanticLabel: 'Fruit',
              entries: [
                RemixSelectLabel(label: 'Fruit'),
                RemixSelectItem(value: 'apple', label: 'Apple'),
                RemixSelectSeparator(),
                RemixSelectItem(value: 'pear', label: 'Pear'),
              ],
            ),
          ],
          selectedValue: 'pear',
          onChanged: (_) {},
        ),
      );

      expect(find.text('Pear'), findsOneWidget);
      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();

      expect(find.text('Fruit'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Pear'), findsNWidgets(2));
    });

    testWidgets('selects an option nested in a group through NakedSelect', (
      tester,
    ) async {
      String? selected;
      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) => RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Choose'),
            entries: const [
              RemixSelectGroup(
                entries: [
                  RemixSelectItem(value: 'apple', label: 'Apple'),
                  RemixSelectItem(value: 'pear', label: 'Pear'),
                ],
              ),
            ],
            selectedValue: selected,
            onChanged: (value) => setState(() => selected = value),
          ),
        ),
      );

      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle();

      expect(selected, 'apple');
      expect(find.text('Apple'), findsOneWidget);
    });

    testWidgets('controlled opening remains owner-authoritative', (
      tester,
    ) async {
      final openRequests = <bool>[];
      await tester.pumpRemixApp(
        RemixSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          entries: const [RemixSelectItem(value: 'apple', label: 'Apple')],
          onChanged: (_) {},
          open: false,
          onOpenChanged: openRequests.add,
        ),
      );

      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();

      expect(openRequests, [isTrue]);
      expect(find.text('Apple'), findsNothing);
    });

    testWidgets('content is never narrower than its trigger', (tester) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 220,
          child: RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Choose'),
            entries: const [RemixSelectItem(value: 'a', label: 'A')],
            onChanged: (_) {},
          ),
        ),
      );

      final triggerWidth = tester
          .getSize(find.byType(RemixSelect<String>))
          .width;
      await tester.tap(find.byType(RemixSelect<String>));
      await tester.pumpAndSettle();

      final matchingConstraint = find.byWidgetPredicate(
        (widget) =>
            widget is ConstrainedBox &&
            widget.constraints.minWidth == triggerWidth,
      );
      expect(matchingConstraint, findsOneWidget);
    });

    testWidgets('reports collisionFlipped and collisionShifted placement', (
      tester,
    ) async {
      const triggerKey = ValueKey('colliding-select-trigger');
      late OverlayPlacement placement;
      await tester.pumpRemixApp(
        SizedBox(
          width: 800,
          height: 600,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  key: triggerKey,
                  width: 80,
                  child: RemixSelect<String>(
                    positioning: const OverlayPositionConfig(
                      side: .top,
                      alignment: .center,
                      collisionPadding: EdgeInsets.all(10),
                    ),
                    trigger: const RemixSelectTrigger(placeholder: 'Choose'),
                    entries: const [
                      RemixSelectItem(value: 'apple', label: 'Apple'),
                    ],
                    onChanged: (_) {},
                    contentWrapper: (context, child) => Builder(
                      builder: (context) {
                        placement = OverlayPlacement.of(context);
                        return SizedBox(width: 160, height: 100, child: child);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tapAt(tester.getCenter(find.byKey(triggerKey)));
      await tester.pumpAndSettle();

      expect(placement.side, OverlaySide.bottom);
      expect(placement.wasFlipped, isTrue);
      expect(placement.wasShifted, isTrue);
    });

    testWidgets(
      'exposes trigger, menu-item, label, and decorative boundaries',
      (tester) async {
        final handle = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixSelect<String>(
              semanticLabel: 'Fruit picker',
              trigger: const RemixSelectTrigger(placeholder: 'Choose'),
              entries: const [
                RemixSelectLabel(label: 'Fruit'),
                RemixSelectItem(value: 'apple', label: 'Apple'),
                RemixSelectSeparator(),
              ],
              onChanged: (_) {},
            ),
          );

          expect(
            find.descendant(
              of: find.byType(NakedSelect<String>),
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
            _semanticsRoleWithin(
              find.byType(NakedSelectOption<String>),
              SemanticsRole.menuItem,
            ),
            findsOneWidget,
          );
          expect(
            find.ancestor(
              of: find.text('Fruit'),
              matching: find.byWidgetPredicate(
                (widget) =>
                    widget is Semantics && widget.properties.header == true,
              ),
            ),
            findsOneWidget,
          );
          expect(find.byType(ExcludeSemantics), findsWidgets);
        } finally {
          handle.dispose();
        }
      },
    );
  });

  group('FortalSelect public contract', () {
    test('defaults to size2, surface trigger, and solid content', () {
      const select = FortalSelect<String>(
        trigger: RemixSelectTrigger(placeholder: 'Choose'),
        entries: [RemixSelectItem(value: 'a', label: 'A')],
      );

      expect(select.size, FortalSelectSize.size2);
      expect(select.triggerVariant, FortalSelectTriggerVariant.surface);
      expect(select.contentVariant, FortalSelectContentVariant.solid);
      expect(select.triggerColor, isNull);
      expect(select.triggerRadius, isNull);
      expect(select.contentColor, isNull);
      expect(select.contentHighContrast, isFalse);
      expect(select.open, isNull);
      expect(select.onOpenChanged, isNull);
    });

    testWidgets('forwards owner-controlled opening', (tester) async {
      final openRequests = <bool>[];
      await tester.pumpRemixApp(
        FortalSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Choose'),
          entries: const [RemixSelectItem(value: 'apple', label: 'Apple')],
          onChanged: (_) {},
          open: false,
          onOpenChanged: openRequests.add,
        ),
      );

      await tester.tap(find.byType(FortalSelect<String>));
      await tester.pumpAndSettle();

      expect(openRequests, [isTrue]);
      expect(find.text('Apple'), findsNothing);
    });

    test('exposes the exact Radix trigger and content variant sets', () {
      expect(FortalSelectTriggerVariant.values, [
        FortalSelectTriggerVariant.classic,
        FortalSelectTriggerVariant.surface,
        FortalSelectTriggerVariant.soft,
        FortalSelectTriggerVariant.ghost,
      ]);
      expect(FortalSelectContentVariant.values, [
        FortalSelectContentVariant.solid,
        FortalSelectContentVariant.soft,
      ]);
    });
  });
}

Finder _semanticsRoleWithin(Finder ancestor, SemanticsRole role) {
  return find.descendant(
    of: ancestor,
    matching: find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.role == role,
    ),
  );
}
