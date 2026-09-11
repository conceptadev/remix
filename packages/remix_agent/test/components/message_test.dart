import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  for (final direction in TextDirection.values) {
    testWidgets('message roles align to opposite edges in $direction', (
      tester,
    ) async {
      await pumpAgent(
        tester,
        Directionality(
          textDirection: direction,
          child: SizedBox(
            width: 500,
            child: AgentMessageGroup(
              children: [
                AgentMessage(
                  role: .user,
                  child: SizedBox(
                    key: ValueKey('user'),
                    width: 100,
                    height: 20,
                  ),
                ),
                AgentMessage(
                  role: .assistant,
                  child: SizedBox(
                    key: ValueKey('assistant'),
                    width: 100,
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      final user = tester.getRect(find.byKey(const ValueKey('user')));
      final assistant = tester.getRect(find.byKey(const ValueKey('assistant')));
      expect(user.width, 100);
      expect(assistant.width, 100);
      expect(
        user.left - assistant.left,
        direction == TextDirection.ltr ? 400 : -400,
      );
    });
  }

  testWidgets('header and footer remain outside the message card', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const AgentMessage(
        role: AgentRole.assistant,
        header: Text('Header'),
        footer: Text('Footer'),
        child: Text('Body'),
      ),
    );

    final card = find.byType(RemixCard);
    expect(
      find.descendant(of: card, matching: find.text('Body')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: card, matching: find.text('Header')),
      findsNothing,
    );
    expect(
      find.descendant(of: card, matching: find.text('Footer')),
      findsNothing,
    );
    expect(find.byType(IntrinsicWidth), findsNothing);
  });

  testWidgets('resolved and direct maximum widths cap loose message layout', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentMessage(
          role: AgentRole.user,
          styleSpec: AgentMessageSpec(maxWidth: 140),
          child: Text('A message wide enough to use the cap.'),
        ),
      ),
    );
    expect(
      tester.getSize(find.byType(RemixCard)).width,
      lessThanOrEqualTo(140),
    );

    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentMessage(
          role: AgentRole.user,
          maxWidth: 110,
          styleSpec: AgentMessageSpec(maxWidth: 140),
          child: Text('The constructor wins.'),
        ),
      ),
    );
    expect(
      tester.getSize(find.byType(RemixCard)).width,
      lessThanOrEqualTo(110),
    );
  });

  testWidgets('collapsible toggle appears only for actual overflow', (
    tester,
  ) async {
    final style = AgentMessageCollapsibleStyler(collapsedHeight: 40);
    await pumpAgent(
      tester,
      AgentMessageCollapsible(
        style: style,
        child: const SizedBox(height: 20, child: Text('Short')),
      ),
    );
    await tester.pump();
    expect(find.text('Show more'), findsNothing);

    await pumpAgent(
      tester,
      AgentMessageCollapsible(
        style: style,
        child: const SizedBox(height: 100, child: Text('Long')),
      ),
    );
    await tester.pump();
    expect(find.text('Show more'), findsOneWidget);
  });

  testWidgets(
    'collapsed content paints at a nonzero offset and stays clipped',
    (tester) async {
      const boundaryKey = ValueKey('message-paint');
      await pumpAgent(
        tester,
        RepaintBoundary(
          key: boundaryKey,
          child: ColoredBox(
            color: const Color(0xFFFFFFFF),
            child: SizedBox(
              width: 200,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 40),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 160,
                    child: AgentMessageCollapsible(
                      style: AgentMessageCollapsibleStyler(collapsedHeight: 20),
                      child: const SizedBox(
                        height: 100,
                        child: ColoredBox(color: Color(0xFFFF0000)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byKey(boundaryKey),
      );
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        try {
          final bytes = (await image.toByteData(
            format: ui.ImageByteFormat.rawRgba,
          ))!;
          List<int> pixel(int x, int y) {
            final offset = (y * image.width + x) * 4;
            return bytes.buffer.asUint8List(offset, 4).toList();
          }

          expect(pixel(35, 45), [255, 0, 0, 255]);
          expect(pixel(35, 130), [255, 255, 255, 255]);
        } finally {
          image.dispose();
        }
      });
    },
  );

  testWidgets('collapsed copy stays readable to assistive technology', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpAgent(
      tester,
      AgentMessageCollapsible(
        style: AgentMessageCollapsibleStyler(collapsedHeight: 20),
        child: const SizedBox(
          height: 100,
          child: Text('Complete readable message'),
        ),
      ),
    );
    await tester.pump();

    final labels = tester.semantics.simulatedAccessibilityTraversal().map(
      (node) => node.getSemanticsData().label,
    );
    expect(
      labels.any((label) => label.contains('Complete readable message')),
      isTrue,
    );
    semantics.dispose();
  });
}
