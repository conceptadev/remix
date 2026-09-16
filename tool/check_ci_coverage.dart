import 'dart:io';

import 'package:yaml/yaml.dart';

/// Verifies that every step of `melos run ci` is actually run by CI.
///
/// The pipeline runs the `ci` script's steps as parallel jobs rather than as
/// one sequential job, which is what took it from ~20 minutes to roughly the
/// cost of its slowest job. That speed has a failure mode: the workflow no
/// longer derives its work from the `ci` script, it restates it. A step added
/// to `ci` but not to the workflow would simply never run on CI, and nothing
/// would report it -- a job that does not exist cannot go red. The pipeline
/// would be green because it was not looking.
///
/// So the duplication is deliberate, and this checker is the thing that makes
/// it safe. Nothing else enforces it.
const _workflow = '.github/workflows/ci.yaml';

/// Matches `melos run <script>` however it is spelled: `dart run melos run x`,
/// `dart run melos:melos run x`, or a bare `melos run x`.
///
/// The script name is captured loosely, because it may still hold a
/// `${{ matrix.preset }}` expression at this point; [_expand] resolves those
/// against the job's own matrix before anything is compared.
/// A `${{ ... }}` expression holds spaces, so the script name cannot simply be
/// "characters up to whitespace" -- it is a run of ordinary characters and
/// whole expressions, either of which may come first.
final _invocation = RegExp(
  r'melos(?::melos)?\s+run\s+((?:\$\{\{[^}]*\}\}|[^\s|&;])+)',
);

final _matrixRef = RegExp(r'\$\{\{\s*matrix\.([A-Za-z0-9_-]+)\s*\}\}');

/// Every concrete script name [raw] can expand to under [matrix].
///
/// A matrix job names its scripts through the matrix variable, so the literal
/// text in the workflow is not a script name and must be expanded to the set
/// of names the job will really run. Returns null when an expression survives
/// expansion, which means the checker cannot know what runs and must say so
/// rather than pass.
List<String>? _expand(String raw, Map<String, List<String>> matrix) {
  var candidates = <String>[raw];
  for (final entry in matrix.entries) {
    final next = <String>[];
    for (final candidate in candidates) {
      final token = RegExp(
        r'\$\{\{\s*matrix\.' + RegExp.escape(entry.key) + r'\s*\}\}',
      );
      if (!token.hasMatch(candidate)) {
        next.add(candidate);
        continue;
      }
      for (final value in entry.value) {
        next.add(candidate.replaceAll(token, value));
      }
    }
    candidates = next;
  }

  return candidates.any(_matrixRef.hasMatch) ? null : candidates;
}

void main() {
  final workspaceRoot = Directory.current.absolute;
  final rootPubspec = File('${workspaceRoot.path}/pubspec.yaml');
  if (!rootPubspec.existsSync() ||
      !rootPubspec.readAsStringSync().contains('name: remix_workspace')) {
    stderr.writeln('Run this checker from the workspace root.');
    exitCode = 64;

    return;
  }

  final scripts =
      ((loadYaml(rootPubspec.readAsStringSync()) as YamlMap)['melos']
              as YamlMap?)?['scripts']
          as YamlMap?;
  if (scripts == null) {
    stderr.writeln('The workspace pubspec declares no melos scripts.');
    exitCode = 1;

    return;
  }

  final ciSteps = ((scripts['ci'] as YamlMap?)?['steps'] as YamlList?)
      ?.cast<String>()
      .toList();
  if (ciSteps == null || ciSteps.isEmpty) {
    stderr.writeln('The `ci` script must declare a non-empty `steps` list.');
    exitCode = 1;

    return;
  }

  final workflowFile = File('${workspaceRoot.path}/$_workflow');
  if (!workflowFile.existsSync()) {
    stderr.writeln('$_workflow is missing.');
    exitCode = 1;

    return;
  }

  final failures = <String>[];
  final jobs =
      (loadYaml(workflowFile.readAsStringSync()) as YamlMap)['jobs']
          as YamlMap?;
  if (jobs == null) {
    stderr.writeln('$_workflow declares no jobs.');
    exitCode = 1;

    return;
  }

  final invoked = <String>{};
  jobs.forEach((jobName, job) {
    if (job is! YamlMap) return;

    final matrix = <String, List<String>>{};
    final declared = (job['strategy'] as YamlMap?)?['matrix'] as YamlMap?;
    declared?.forEach((key, value) {
      if (value is YamlList) {
        matrix['$key'] = value.map((entry) => '$entry').toList();
      }
    });

    for (final step in (job['steps'] as YamlList?) ?? const []) {
      if (step is! YamlMap) continue;
      final run = step['run'];
      if (run is! String) continue;
      for (final match in _invocation.allMatches(run)) {
        final expanded = _expand(match.group(1)!, matrix);
        if (expanded == null) {
          failures.add(
            'Job `$jobName` runs `melos run ${match.group(1)}`, whose matrix '
            'expression this checker cannot resolve, so its coverage is '
            'unknown.',
          );
          continue;
        }
        invoked.addAll(expanded);
      }
    }
  });

  for (final step in ciSteps) {
    if (!invoked.contains(step)) {
      failures.add(
        '`$step` is a step of `melos run ci` but no job in $_workflow runs '
        'it, so it would never run on CI.',
      );
    }
  }

  // The reverse direction is just as silent: a workflow job calling a script
  // that `ci` does not list runs on CI but not for anyone locally.
  for (final script in invoked) {
    if (script == 'ci') continue;
    if (!scripts.containsKey(script)) {
      failures.add(
        '$_workflow runs `melos run $script`, which is not a declared melos '
        'script.',
      );
      continue;
    }
    if (!ciSteps.contains(script)) {
      failures.add(
        '$_workflow runs `melos run $script`, which is not a step of `ci`, so '
        '`melos run ci` does not reproduce CI locally.',
      );
    }
  }

  if (failures.isNotEmpty) {
    stderr.writeln('CI coverage drift detected (${failures.length}):');
    for (final failure in failures) {
      stderr.writeln('- $failure');
    }
    stderr.writeln(
      'The `ci` script and $_workflow must list the same steps. Add the step '
      'to both, or remove it from both.',
    );
    exitCode = 1;

    return;
  }

  stdout.writeln(
    'CI coverage is consistent: all ${ciSteps.length} `ci` steps run as jobs '
    'in $_workflow.',
  );
}
