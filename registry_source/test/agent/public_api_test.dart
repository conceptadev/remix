import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:registry_source/agent.dart';

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
        : Directory('registry_source/lib');
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

  test('every component ships a worksheet', () {
    final root = Directory('lib').existsSync() ? '' : 'registry_source/';
    final components = Directory('${root}lib/src/agent/components')
        .listSync()
        .whereType<File>()
        .map((file) => file.uri.pathSegments.last)
        .where((name) => name.endsWith('.dart') && !name.endsWith('.g.dart'))
        .map((name) => name.substring(0, name.length - '.dart'.length))
        .toSet();
    final worksheets = Directory('${root}specs/components')
        .listSync()
        .whereType<File>()
        .map((file) => file.uri.pathSegments.last)
        .where((name) => name.endsWith('.yaml'))
        .map((name) => name.substring(0, name.length - '.yaml'.length))
        .toSet();

    // skills/building-remix-design-system documents the worksheet as a
    // component's first artifact, written before any code. Comparing both
    // directions keeps that true: a component added without one fails, and so
    // does a worksheet outliving the component it described.
    expect(worksheets, components);
  });

  test('barrel exports exactly the pinned public surface', () {
    final barrel = File('lib/agent.dart').existsSync()
        ? File('lib/agent.dart')
        : File('registry_source/lib/agent.dart');
    final exported = RegExp(r"^export '([^']+)';", multiLine: true)
        .allMatches(barrel.readAsStringSync())
        .map((match) => match.group(1)!)
        .toSet();

    // Compared as a set, not asserted absent one path at a time: an equality
    // fails on a *new* export too, which is the direction that leaks. Everything
    // under `src/support/` is an implementation seam -- `functional_glyph.dart`,
    // `live_edge.dart` -- and stays out by omission.
    expect(exported, {
      'src/agent/components/activity.dart',
      'src/agent/components/answer.dart',
      'src/agent/components/composer.dart',
      'src/agent/components/execution.dart',
      'src/agent/components/message.dart',
      'src/agent/components/permission.dart',
      'src/agent/components/plan.dart',
      'src/agent/components/transcript.dart',
      'src/agent/models/activity_item.dart',
      'src/agent/models/plan_item.dart',
      'src/agent/models/statuses.dart',
    });
  });
}
