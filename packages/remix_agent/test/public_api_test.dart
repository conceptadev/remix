import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

void main() {
  test('barrel exports the v1 catalog', () {
    const composer = AgentComposer();
    const message = AgentMessage(
      role: AgentRole.user,
      child: SizedBox.shrink(),
    );
    const answer = AgentAnswer(child: SizedBox.shrink());
    const permission = AgentPermission(tool: 't');
    const execution = AgentExecution(
      tool: 't',
      title: 'T',
      child: SizedBox.shrink(),
    );
    const plan = AgentPlan(items: []);
    const activity = AgentActivity(items: []);

    expect(composer, isA<AgentComposer>());
    expect(message.role, AgentRole.user);
    expect(answer.status, AgentAnswerStatus.streaming);
    expect(permission.status, AgentPermissionStatus.pending);
    expect(execution.status, AgentExecutionStatus.running);
    expect(plan.items, isEmpty);
    expect(activity.status, AgentRunStatus.working);
    expect(const AgentComposerSpec(), isA<AgentComposerSpec>());
    expect(const AgentTranscript(children: []), isA<AgentTranscript>());
    expect(
      const AgentPermission(
        tool: 't',
        parameters: [RemixDataListItem(label: 'a', value: 'b')],
      ),
      isA<AgentPermission>(),
    );
  });

  test('library sources do not import Material', () {
    final lib = Directory('lib').existsSync()
        ? Directory('lib')
        : Directory('packages/remix_agent/lib');
    expect(lib.existsSync(), isTrue);
    final hits = <String>[];
    for (final entity in lib.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }
      final source = entity.readAsStringSync();
      if (source.contains('package:flutter/material.dart') ||
          source.contains('package:flutter/src/material/')) {
        hits.add(entity.path);
      }
    }
    expect(hits, isEmpty);
  });

  test('barrel hides implementation and test seams', () {
    final barrel = File('lib/remix_agent.dart').existsSync()
        ? File('lib/remix_agent.dart')
        : File('packages/remix_agent/lib/remix_agent.dart');
    final source = barrel.readAsStringSync();
    for (final seam in [
      'behavior/live_edge.dart',
      'components/disclosure.dart',
      'components/clip_reveal.dart',
      'models/permission_parameter.dart',
      'style/defaults.dart',
      'style/motion.dart',
    ]) {
      expect(source, isNot(contains(seam)));
    }
  });
}
