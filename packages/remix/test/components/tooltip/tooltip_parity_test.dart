import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets(
    'delayed trigger hover opens and content hover holds the overlay',
    (tester) async {
      const triggerKey = ValueKey('hoverable-trigger');
      const overlayKey = ValueKey('hoverable-overlay');
      await tester.pumpRemixApp(
        RemixTooltip(
          animationStyle: AnimationStyle.noAnimation,
          positioning: const OverlayPositionConfig(
            side: .bottom,
            alignment: .center,
          ),
          style: RemixTooltipStyler(
            waitDuration: const Duration(milliseconds: 100),
            dismissDuration: const Duration(milliseconds: 100),
          ),
          tooltipChild: const SizedBox(key: overlayKey, width: 120, height: 40),
          child: const SizedBox(key: triggerKey, width: 100, height: 40),
        ),
      );

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer();
      await mouse.moveTo(tester.getCenter(find.byKey(triggerKey)));
      await tester.pump(const Duration(milliseconds: 99));
      expect(find.byKey(overlayKey), findsNothing);

      await tester.pump(const Duration(milliseconds: 1));
      await tester.pumpAndSettle();
      expect(find.byKey(overlayKey), findsOneWidget);

      await mouse.moveTo(tester.getCenter(find.byKey(overlayKey)));
      await tester.pump(const Duration(milliseconds: 150));
      expect(find.byKey(overlayKey), findsOneWidget);

      await mouse.moveTo(const Offset(-1000, -1000));
      await tester.pump(const Duration(milliseconds: 150));
      await tester.pumpAndSettle();
      expect(find.byKey(overlayKey), findsNothing);
    },
  );

  testWidgets('controlled opening remains owner-authoritative', (tester) async {
    const triggerKey = ValueKey('controlled-trigger');
    final requests = <bool>[];
    await tester.pumpRemixApp(
      RemixTooltip(
        open: false,
        onOpenChanged: requests.add,
        animationStyle: AnimationStyle.noAnimation,
        style: RemixTooltipStyler(waitDuration: Duration.zero),
        tooltipChild: const Text('Rejected tooltip'),
        child: const SizedBox(key: triggerKey, width: 100, height: 40),
      ),
    );

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(mouse.removePointer);
    await mouse.addPointer();
    await mouse.moveTo(tester.getCenter(find.byKey(triggerKey)));
    await tester.pumpAndSettle();

    expect(requests, [isTrue]);
    expect(find.text('Rejected tooltip'), findsNothing);
  });

  testWidgets('focus opens instantly and Escape closes', (tester) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);
    await tester.pumpRemixApp(
      RemixTooltip(
        animationStyle: AnimationStyle.noAnimation,
        style: RemixTooltipStyler(waitDuration: Duration.zero),
        tooltipChild: const Text('Focused tooltip'),
        child: Focus(
          focusNode: focusNode,
          child: const SizedBox(width: 100, height: 40),
        ),
      ),
    );

    focusNode.requestFocus();
    await tester.pumpAndSettle();
    expect(find.text('Focused tooltip'), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.text('Focused tooltip'), findsNothing);
  });

  testWidgets('outside tap requests and accepts close', (tester) async {
    var open = true;
    await tester.pumpRemixApp(
      StatefulBuilder(
        builder: (context, setState) => RemixTooltip(
          open: open,
          onOpenChanged: (value) => setState(() => open = value),
          animationStyle: AnimationStyle.noAnimation,
          tooltipChild: const Text('Outside tooltip'),
          child: const SizedBox(width: 100, height: 40),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Outside tooltip'), findsOneWidget);

    await tester.tapAt(const Offset(4, 4));
    await tester.pumpAndSettle();
    expect(open, isFalse);
    expect(find.text('Outside tooltip'), findsNothing);
  });

  testWidgets('touch long press opens and reports the trigger', (tester) async {
    var triggers = 0;
    await tester.pumpRemixApp(
      RemixTooltip(
        onTriggered: () => triggers++,
        animationStyle: AnimationStyle.noAnimation,
        style: RemixTooltipStyler(showDuration: const Duration(seconds: 1)),
        tooltipChild: const Text('Touch tooltip'),
        child: const SizedBox(
          key: ValueKey('touch-trigger'),
          width: 100,
          height: 40,
        ),
      ),
    );

    await tester.longPressAt(
      tester.getCenter(find.byKey(const ValueKey('touch-trigger'))),
    );
    await tester.pump();
    expect(triggers, 1);
    expect(find.text('Touch tooltip'), findsOneWidget);
  });

  testWidgets('the arrow follows a collision shift and instant open', (
    tester,
  ) async {
    const triggerKey = ValueKey('shifted-tooltip-trigger');
    late OverlayPlacement placement;
    await tester.pumpRemixApp(
      Stack(
        children: [
          Positioned(
            left: 10,
            top: 120,
            child: RemixTooltip(
              open: true,
              positioning: const OverlayPositionConfig(
                side: .top,
                alignment: .center,
                sideOffset: 4,
                collisionPadding: EdgeInsets.all(10),
              ),
              minWidth: 160,
              maxWidth: 160,
              showArrow: true,
              animationStyle: const AnimationStyle(
                duration: Duration.zero,
                reverseDuration: Duration.zero,
              ),
              style: RemixTooltipStyler().arrowColor(Colors.black),
              tooltipChild: Builder(
                builder: (context) {
                  placement = OverlayPlacement.of(context);
                  return const SizedBox(height: 40);
                },
              ),
              child: const SizedBox(key: triggerKey, width: 20, height: 20),
            ),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    final arrowPaint = find.byWidgetPredicate(
      (widget) =>
          widget is CustomPaint &&
          widget.foregroundPainter.runtimeType.toString() ==
              '_RemixTooltipArrowPainter',
    );
    expect(placement.wasShifted, isTrue);
    expect(arrowPaint, findsOneWidget);

    final renderBox = tester.renderObject<RenderBox>(arrowPaint);
    final painter = tester.widget<CustomPaint>(arrowPaint).foregroundPainter!;
    final localTip =
        (painter as dynamic).debugArrowTip(renderBox.size) as Offset;
    final globalTip = renderBox.localToGlobal(localTip);
    expect(
      globalTip.dx,
      closeTo(tester.getCenter(find.byKey(triggerKey)).dx, 1),
    );
  });

  testWidgets('a collision flip reverses the arrow side', (tester) async {
    late OverlayPlacement placement;
    await tester.pumpRemixApp(
      Stack(
        children: [
          Positioned(
            left: 300,
            top: 0,
            child: RemixTooltip(
              open: true,
              positioning: const OverlayPositionConfig(
                side: .top,
                alignment: .center,
                sideOffset: 4,
                collisionPadding: EdgeInsets.all(10),
              ),
              showArrow: true,
              animationStyle: AnimationStyle.noAnimation,
              style: RemixTooltipStyler().arrowColor(Colors.black),
              tooltipChild: Builder(
                builder: (context) {
                  placement = OverlayPlacement.of(context);
                  return const SizedBox(width: 120, height: 80);
                },
              ),
              child: const SizedBox(width: 20, height: 20),
            ),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    final arrowPaint = find.byWidgetPredicate(
      (widget) =>
          widget is CustomPaint &&
          widget.foregroundPainter.runtimeType.toString() ==
              '_RemixTooltipArrowPainter',
    );
    final renderBox = tester.renderObject<RenderBox>(arrowPaint);
    final painter = tester.widget<CustomPaint>(arrowPaint).foregroundPainter!;
    final tip = (painter as dynamic).debugArrowTip(renderBox.size) as Offset;

    expect(placement.wasFlipped, isTrue);
    expect(placement.side, OverlaySide.bottom);
    expect(tip.dy, 0);
  });

  testWidgets('horizontal arrows rotate width and height geometry', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      RemixTooltip(
        open: true,
        positioning: OverlayPositionConfig(
          side: .left,
          alignment: .center,
          avoidCollisions: false,
        ),
        showArrow: true,
        arrowSize: Size(10, 5),
        animationStyle: AnimationStyle.noAnimation,
        style: RemixTooltipStyler().arrowColor(Colors.black),
        tooltipChild: const SizedBox(width: 40, height: 60),
        child: const SizedBox(width: 20, height: 20),
      ),
    );
    await tester.pumpAndSettle();

    final arrowPaint = find.byWidgetPredicate(
      (widget) =>
          widget is CustomPaint &&
          widget.foregroundPainter.runtimeType.toString() ==
              '_RemixTooltipArrowPainter',
    );
    expect(tester.getSize(arrowPaint), const Size(45, 60));
  });
}
