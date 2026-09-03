/// Verifies that the workspace playground still mirrors the bundled registry.
///
/// ```shell
/// dart run tool/check_open_code_dogfood.dart
/// ```
///
/// `apps/playground` is the repository's dogfood: `remix_cli` installed every
/// registry item into it the way a consumer would, and the result is
/// committed. Two things make that copy rot quietly. Nothing in the app
/// renders it, so a stale file compiles and no test notices. And the ownership
/// contract says a consumer *may* edit installed source, so in review a
/// forgotten resync and a deliberate customization look identical.
///
/// This check removes the ambiguity. Every item is either clean against the
/// current template, or named in [_customized] with the reason. A named item
/// that turns out to be clean fails too, so the list cannot outlive the edit
/// it describes.
///
/// It asks the CLI rather than rendering the templates itself. `add --diff` is
/// read-only, and it is the same render-then-format path an install takes —
/// which matters, because a template is *not* byte-identical to its installed
/// form. The formatter rewraps the rendered source, and how it wraps depends
/// on how long the configured prefix is.
library;

import 'dart:io';

import 'package:yaml/yaml.dart';

/// Items whose playground copy is deliberately edited, and why.
///
/// Kept to one on purpose. Every entry is a file this check can no longer
/// resync automatically, and a second example would teach the same lesson at
/// twice the cost. `installer_test.dart` and the fixture's own suite prove
/// preservation for every item; this is the one that proves it survives a
/// rerun in a real application.
const _customized = <String, String>{
  'theme':
      'an indigo primary and matching focus ring, so the dogfood proves a '
      'theme-wide value change survives a reinstall',
};

/// What `remix add --diff` prints when the installed source is up to date.
const _clean = 'No authored-source differences.';

Future<void> main(List<String> arguments) async {
  if (arguments.isNotEmpty) {
    stderr.writeln('Usage: dart run tool/check_open_code_dogfood.dart');
    exitCode = 64;
    return;
  }

  final failure = await _run(Directory.current.absolute);
  if (failure != null) {
    stderr.writeln('open-code dogfood check failed: $failure');
    exitCode = 1;
    return;
  }
  stdout.writeln(
    'Playground mirrors the registry; '
    '${_customized.length} declared customization intact.',
  );
}

Future<String?> _run(Directory root) async {
  final registry = File(
    '${root.path}/packages/remix_cli/lib/src/registry/registry.yaml',
  );
  final playground = Directory('${root.path}/apps/playground');
  if (!registry.existsSync()) return 'the bundled registry is missing.';
  if (!File('${playground.path}/remix.yaml').existsSync()) {
    return 'apps/playground has no remix.yaml, so nothing was installed there.';
  }

  final document = loadYaml(registry.readAsStringSync());
  if (document is! YamlMap || document['items'] is! YamlMap) {
    return 'registry.yaml is not in the expected shape.';
  }

  final problems = <String>[];
  final unknown = _customized.keys.toSet();
  for (final key in (document['items'] as YamlMap).keys) {
    if (key is! String) continue;
    unknown.remove(key);

    final result = await Process.run(Platform.resolvedExecutable, [
      'run',
      'remix_cli:remix',
      'add',
      key,
      '--diff',
    ], workingDirectory: playground.path);
    if (result.exitCode != 0) {
      // The exit code alone cannot be acted on from a CI log. Carry the
      // reason, which is where a missing Git or a preflight refusal is named.
      final detail = (result.stderr as String).trim();
      problems.add(
        '$key: `remix add $key --diff` exited ${result.exitCode}'
        '${detail.isEmpty ? '' : '\n    $detail'}',
      );
      continue;
    }

    final edited = !(result.stdout as String).contains(_clean);
    final reason = _customized[key];
    if (!edited && reason != null) {
      problems.add(
        '$key is listed as customized ($reason) but matches the template. '
        'Drop it from the list.',
      );
    } else if (edited && reason == null) {
      problems.add(
        '$key has diverged from the template. Rerun `dart run '
        'remix_cli:remix add $key --overwrite` in apps/playground, or record '
        'the reason in this check.',
      );
    }
  }

  for (final item in unknown) {
    problems.add('$item is listed as customized but is not a registry item.');
  }

  if (problems.isEmpty) return null;
  return 'the playground and the registry disagree:\n'
      '${problems.map((problem) => '  - $problem').join('\n')}';
}
