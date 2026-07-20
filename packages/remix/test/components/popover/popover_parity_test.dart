import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_surface.dart' show RemixSurfaceBox;

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixPopover content geometry', () {
    test('styler call forwards all content constraints', () {
      final styler = RemixPopoverStyler();
      final anchorKey = GlobalKey();
      final popover = styler(
        popoverChild: const Text('Content'),
        child: const Text('Trigger'),
        width: 320,
        minWidth: 240,
        maxWidth: 480,
        height: 200,
        minHeight: 120,
        maxHeight: 360,
        matchTriggerWidth: true,
        anchorKey: anchorKey,
      );

      expect(popover.style, same(styler));
      expect(popover.width, 320);
      expect(popover.minWidth, 240);
      expect(popover.maxWidth, 480);
      expect(popover.height, 200);
      expect(popover.minHeight, 120);
      expect(popover.maxHeight, 360);
      expect(popover.matchTriggerWidth, isTrue);
      expect(popover.anchorKey, same(anchorKey));
    });

    testWidgets('positions against a separate keyed anchor', (tester) async {
      final anchorKey = GlobalKey();
      const triggerKey = Key('separate-trigger');
      const contentKey = Key('separate-content');

      await tester.pumpRemixApp(
        SizedBox(
          width: 500,
          height: 300,
          child: Stack(
            children: [
              Positioned(
                left: 40,
                top: 30,
                child: SizedBox(key: anchorKey, width: 120, height: 40),
              ),
              Positioned(
                left: 320,
                top: 180,
                child: RemixPopover(
                  anchorKey: anchorKey,
                  positioning: const OverlayPositionConfig(
                    side: .bottom,
                    alignment: .start,
                    avoidCollisions: false,
                  ),
                  popoverChild: const SizedBox(
                    key: contentKey,
                    width: 80,
                    height: 30,
                    child: Text('Separate content'),
                  ),
                  child: const SizedBox(
                    key: triggerKey,
                    width: 40,
                    height: 30,
                    child: Text('Separate trigger'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tapAt(tester.getCenter(find.byKey(triggerKey)));
      await tester.pumpAndSettle();

      expect(
        tester.getTopLeft(find.byKey(contentKey)),
        tester.getBottomLeft(find.byKey(anchorKey)),
      );
    });

    testWidgets('propagates hovered and open states into its trigger subtree', (
      tester,
    ) async {
      const triggerKey = ValueKey('stateful-popover-trigger');
      WidgetStateProvider? triggerStates;
      await tester.pumpRemixApp(
        RemixPopover(
          popoverChild: const Text('Stateful content'),
          child: Builder(
            builder: (context) {
              triggerStates = WidgetStateProvider.of(context);
              return const SizedBox(key: triggerKey, width: 100, height: 40);
            },
          ),
        ),
      );

      expect(triggerStates?.hovered, isFalse);
      expect(triggerStates?.selected, isFalse);

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer();
      await mouse.moveTo(tester.getCenter(find.byKey(triggerKey)));
      await tester.pump();
      expect(triggerStates?.hovered, isTrue);

      await tester.tapAt(tester.getCenter(find.byKey(triggerKey)));
      await tester.pumpAndSettle();
      expect(triggerStates?.selected, isTrue);
      expect(find.text('Stateful content'), findsOneWidget);
    });

    testWidgets('reports collisionFlipped and collisionShifted placement', (
      tester,
    ) async {
      const triggerKey = ValueKey('colliding-popover-trigger');
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
                child: RemixPopover(
                  positioning: const OverlayPositionConfig(
                    side: .top,
                    alignment: .center,
                    collisionPadding: EdgeInsets.all(10),
                  ),
                  popoverChild: Builder(
                    builder: (context) {
                      placement = OverlayPlacement.of(context);
                      return const SizedBox(width: 160, height: 100);
                    },
                  ),
                  child: const SizedBox(key: triggerKey, width: 20, height: 20),
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

    testWidgets('applies explicit width and height to overlay content', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixPopover(
          width: 320,
          height: 200,
          popoverChild: Text('Content'),
          child: Text('Open'),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(
        tester.getSize(find.byType(RemixSurfaceBox)),
        const Size(320, 200),
      );
    });

    testWidgets('can match the trigger minimum width', (tester) async {
      await tester.pumpRemixApp(
        const RemixPopover(
          matchTriggerWidth: true,
          maxWidth: 480,
          popoverChild: Text('Content'),
          child: SizedBox(width: 240, child: Text('Open')),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(tester.getSize(find.byType(RemixSurfaceBox)).width, 240);
    });

    testWidgets('scrolls content constrained by maxHeight', (tester) async {
      await tester.pumpRemixApp(
        const RemixPopover(
          width: 320,
          maxHeight: 200,
          popoverChild: SizedBox(height: 600, child: Text('Tall content')),
          child: Text('Open'),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.byType(RemixSurfaceBox)).height, 200);
      expect(
        find.descendant(
          of: find.byType(RemixSurfaceBox),
          matching: find.byType(SingleChildScrollView),
        ),
        findsOneWidget,
      );
    });
  });

  group('FortalPopover 3.3.0 contract', () {
    test('defaults to size 2, trigger width, 480 max, and 8 side offset', () {
      const popover = FortalPopover(
        popoverChild: Text('Content'),
        child: Text('Trigger'),
      );

      expect(popover.size, FortalPopoverSize.size2);
      expect(popover.maxWidth, 480);
      expect(popover.matchTriggerWidth, isTrue);
      expect(popover.positioning.side, OverlaySide.bottom);
      expect(popover.positioning.alignment, OverlayAlignment.start);
      expect(popover.positioning.sideOffset, 8);
    });

    testWidgets('resolves the exact size padding and radius matrix', (
      tester,
    ) async {
      final paddings = <FortalPopoverSize, EdgeInsetsGeometry?>{};
      final radii = <FortalPopoverSize, BorderRadiusGeometry>{};

      await tester.pumpRemixApp(
        Builder(
          builder: (context) {
            for (final size in FortalPopoverSize.values) {
              final spec = fortalPopoverStyler(
                size: size,
              ).resolve(context).spec;
              paddings[size] = spec.container.spec.padding;
              radii[size] = spec.surface!.borderRadius;
            }
            return const SizedBox.shrink();
          },
        ),
      );

      expect(paddings, <FortalPopoverSize, EdgeInsetsGeometry>{
        FortalPopoverSize.size1: const EdgeInsets.all(12),
        FortalPopoverSize.size2: const EdgeInsets.all(16),
        FortalPopoverSize.size3: const EdgeInsets.all(24),
        FortalPopoverSize.size4: const EdgeInsets.all(32),
      });
      expect(radii, <FortalPopoverSize, BorderRadiusGeometry>{
        FortalPopoverSize.size1: BorderRadius.circular(8),
        FortalPopoverSize.size2: BorderRadius.circular(8),
        FortalPopoverSize.size3: BorderRadius.circular(12),
        FortalPopoverSize.size4: BorderRadius.circular(12),
      });
    });

    testWidgets('forwards official content geometry', (tester) async {
      final anchorKey = GlobalKey();
      await tester.pumpRemixApp(
        FortalPopover(
          size: .size4,
          width: 300,
          minHeight: 120,
          maxHeight: 360,
          anchorKey: anchorKey,
          popoverChild: const Text('Content'),
          child: const Text('Trigger'),
        ),
      );

      final popover = tester.widget<RemixPopover>(find.byType(RemixPopover));
      expect(popover.width, 300);
      expect(popover.maxWidth, 480);
      expect(popover.minHeight, 120);
      expect(popover.maxHeight, 360);
      expect(popover.matchTriggerWidth, isTrue);
      expect(popover.anchorKey, same(anchorKey));
    });
  });
}
