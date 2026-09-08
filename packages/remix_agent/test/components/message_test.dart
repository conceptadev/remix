import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
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
