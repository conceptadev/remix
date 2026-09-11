import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('static transcript preserves chronological child order', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 300,
        height: 120,
        child: AgentTranscript(
          followOutput: false,
          children: [Text('First'), Text('Second'), Text('Third')],
        ),
      ),
    );

    expect(
      tester.getTopLeft(find.text('First')).dy,
      lessThan(tester.getTopLeft(find.text('Second')).dy),
    );
    expect(
      tester.getTopLeft(find.text('Second')).dy,
      lessThan(tester.getTopLeft(find.text('Third')).dy),
    );
  });

  testWidgets('builder remains lazy for large transcripts', (tester) async {
    var builds = 0;
    await pumpAgent(
      tester,
      SizedBox(
        width: 300,
        height: 100,
        child: AgentTranscript.builder(
          followOutput: false,
          itemCount: 1000,
          itemBuilder: (context, index) {
            builds++;
            return SizedBox(height: 24, child: Text('Item $index'));
          },
        ),
      ),
    );

    expect(builds, lessThan(20));
    expect(find.text('Item 0'), findsOneWidget);
    expect(find.text('Item 999'), findsNothing);
  });

  testWidgets('clipBehavior is forwarded to static and builder lists', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        height: 100,
        child: AgentTranscript(
          clipBehavior: Clip.none,
          children: [Text('static')],
        ),
      ),
    );
    expect(
      tester.widget<ListView>(find.byType(ListView)).clipBehavior,
      Clip.none,
    );

    await pumpAgent(
      tester,
      SizedBox(
        height: 100,
        child: AgentTranscript.builder(
          clipBehavior: Clip.antiAlias,
          itemCount: 1,
          itemBuilder: (context, index) => const Text('builder'),
        ),
      ),
    );
    expect(
      tester.widget<ListView>(find.byType(ListView)).clipBehavior,
      Clip.antiAlias,
    );
  });

  testWidgets('zero items build a valid empty lazy transcript', (tester) async {
    await pumpAgent(
      tester,
      SizedBox(
        height: 100,
        child: AgentTranscript.builder(
          itemCount: 0,
          itemBuilder: (context, index) => const Text('unreachable'),
        ),
      ),
    );

    expect(find.text('unreachable'), findsNothing);
    expect(find.byType(ListView), findsOneWidget);
  });
}
