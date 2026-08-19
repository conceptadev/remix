import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
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
    expect(kDefaultLiveEdgeThreshold, 56);
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
}
