import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('activity renders detail through its dedicated text slot', (
    tester,
  ) async {
    const detailColor = Color(0xFFAA0000);
    await pumpAgent(
      tester,
      AgentActivity(
        style: AgentActivityStyler(itemDetail: TextStyler().color(detailColor)),
        items: const [
          AgentActivityItem(id: 'one', title: 'Read', detail: 'brief.md'),
        ],
      ),
    );

    final detail = tester.renderObject<RenderParagraph>(find.text('brief.md'));
    expect(detail.text.style?.color, detailColor);
  });

  testWidgets('activity preserves optional child action semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpAgent(
      tester,
      AgentActivity(
        items: [
          AgentActivityItem(
            id: 'one',
            title: 'Read',
            child: RemixButton(label: 'Inspect output', onPressed: () {}),
          ),
        ],
      ),
    );

    expect(find.bySemanticsLabel('Inspect output'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('custom status builder replaces the functional glyph', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      AgentActivity(
        statusBuilder: (context, item) => const SizedBox(
          key: ValueKey('custom-activity-status'),
          width: 8,
          height: 8,
        ),
        items: const [AgentActivityItem(id: 'one', title: 'Read')],
      ),
    );

    expect(
      find.byKey(const ValueKey('custom-activity-status')),
      findsOneWidget,
    );
  });
}
