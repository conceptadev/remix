import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('renders sender-aware slots', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentMessageGroup(
          children: [
            AgentMessage(
              role: AgentRole.user,
              header: Text('You'),
              footer: Text('now'),
              child: Text('Hello'),
            ),
            AgentMessage(
              role: AgentRole.assistant,
              placeholderAvatar: true,
              child: Text('Hi there'),
            ),
          ],
        ),
      ),
    );

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('Hi there'), findsOneWidget);
    expect(find.text('You'), findsOneWidget);
    expect(find.text('now'), findsOneWidget);
    expect(find.byType(AgentMessage), findsNWidgets(2));
    expect(find.text('Show more'), findsNothing);
    expect(find.byType(RemixAvatar), findsNothing);
    expect(
      find.descendant(of: find.byType(RemixCard), matching: find.text('Hello')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(RemixCard), matching: find.text('You')),
      findsNothing,
    );
    expect(
      find.descendant(of: find.byType(RemixCard), matching: find.text('now')),
      findsNothing,
    );
  });

  testWidgets('user body sits end-ward of the assistant body', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentMessageGroup(
          children: [
            AgentMessage(role: AgentRole.user, child: Text('Hello')),
            AgentMessage(role: AgentRole.assistant, child: Text('Hi there')),
          ],
        ),
      ),
    );

    final user = tester.getRect(find.text('Hello'));
    final assistant = tester.getRect(find.text('Hi there'));
    expect(user.left, greaterThan(assistant.left));
    expect(user.width, lessThan(assistant.width));
    expect(find.byType(RemixCard), findsOneWidget);
  });

  testWidgets('user bubble is fill-only 14/10 with a 14/24 run', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentMessageGroup(
          children: [
            AgentMessage(role: AgentRole.user, child: Text('Hello')),
            AgentMessage(role: AgentRole.assistant, child: Text('Hi there')),
          ],
        ),
      ),
    );

    final card = find.byType(RemixCard);
    final cardRect = tester.getRect(card);
    final user = tester.getRect(find.text('Hello'));
    final assistant = tester.getRect(find.text('Hi there'));
    expect(user.left - cardRect.left, closeTo(14, 0.6));
    expect(user.top - cardRect.top, closeTo(10, 0.6));
    expect(assistant.top - cardRect.bottom, closeTo(6, 1));

    final hello = tester.renderObject<RenderParagraph>(find.text('Hello'));
    expect(hello.text.style?.fontSize, 14);
    expect(hello.text.style?.height, 24 / 14);
    expect(hello.text.style?.color, const Color(0xFF18181B));
  });

  testWidgets('user bubble is capped at 82% and floors at 36', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentMessage(
          role: AgentRole.user,
          child: Text(
            'A long user turn that should wrap instead of spanning the row.',
          ),
        ),
      ),
    );

    expect(tester.getRect(find.byType(RemixCard)).width, closeTo(328, 1));

    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentMessage(
          role: AgentRole.user,
          child: SizedBox(width: 1, height: 14),
        ),
      ),
    );

    expect(tester.getSize(find.byType(RemixCard)).width, 36);
  });

  testWidgets('showAvatar false drops the avatar slot', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentMessage(
          role: AgentRole.assistant,
          showAvatar: false,
          child: Text('No face'),
        ),
      ),
    );

    expect(find.byType(RemixAvatar), findsNothing);
    expect(find.text('No face'), findsOneWidget);
  });

  testWidgets('long copy clamps to 4 lines with a fade and expand pill', (
    tester,
  ) async {
    const copyKey = ValueKey('agent-message-copy');
    const moreKey = ValueKey('agent-message-more');
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentMessage(
          role: AgentRole.user,
          child: SizedBox(
            width: 200,
            height: 160,
            child: Text('Long copy that should clamp.'),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.getSize(find.byKey(copyKey)).height, closeTo(96, 1));
    expect(find.byType(ShaderMask), findsOneWidget);
    expect(find.text('Show more'), findsOneWidget);

    final copy = tester.getRect(find.byKey(copyKey));
    final more = tester.getRect(find.byKey(moreKey));
    expect(more.top - copy.bottom, closeTo(8, 1));
    expect(more.height, closeTo(28, 1));

    final label = tester.getRect(find.text('Show more'));
    expect(label.left - more.left, closeTo(8, 1));
    final caret = tester.getRect(
      find.descendant(
        of: find.byKey(moreKey),
        matching: find.byType(CustomPaint),
      ),
    );
    expect(caret.left - label.right, closeTo(4, 1));

    final run = tester.renderObject<RenderParagraph>(find.text('Show more'));
    expect(run.text.style?.fontSize, 12);
    expect(run.text.style?.fontWeight, FontWeight.w500);
    expect(
      run.text.style?.color,
      const Color(0xFF18181B).withValues(alpha: 0.62),
    );

    await tester.tap(find.byKey(moreKey));
    await tester.pump();
    expect(find.text('Show less'), findsOneWidget);
    expect(find.byType(ShaderMask), findsNothing);
    expect(tester.getSize(find.byKey(copyKey)).height, closeTo(160, 1));
  });
}
