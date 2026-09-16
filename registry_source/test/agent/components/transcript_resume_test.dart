import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registry_source/agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('explicitly re-enabling follow resumes later output growth', (
    tester,
  ) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    late StateSetter update;
    var following = true;
    var count = 30;
    await pumpAgent(
      tester,
      StatefulBuilder(
        builder: (context, setState) {
          update = setState;
          return SizedBox(
            width: 300,
            height: 200,
            child: AgentTranscript(
              controller: controller,
              followOutput: following,
              onFollowChanged: (value) => update(() => following = value),
              children: List.generate(
                count,
                (index) => SizedBox(height: 40, child: Text('Turn $index')),
              ),
            ),
          );
        },
      ),
    );
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, 300));
    await tester.pumpAndSettle();
    expect(following, isFalse);

    // Match the application's visible Return to latest action.
    update(() => following = true);
    controller.jumpTo(controller.position.maxScrollExtent);
    await tester.pumpAndSettle();
    update(() => count += 10);
    await tester.pumpAndSettle();
    expect(controller.position.extentAfter, lessThanOrEqualTo(1));
  });
}
