/// Verifies that the workspace dogfood apps still mirror the bundled registry.
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
/// `packages/remix_agent/example` is the second dogfood, and it rots for the
/// opposite reason: it installs only the four items its composer recipe
/// composes, so a template change nobody re-ran is invisible until someone
/// opens the app. Only installed items are checked there, which is why the
/// walk asks each consumer's `remix.yaml` what it holds rather than assuming
/// the whole catalog.
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

/// Items whose dogfood copy is deliberately edited, keyed by `consumer/item`.
///
/// Kept to one on purpose. Every entry is a file this check can no longer
/// resync automatically, and a second example would teach the same lesson at
/// twice the cost. `installer_test.dart` and the fixture's own suite prove
/// preservation for every item; this is the one that proves it survives a
/// rerun in a real application.
const _customized = <String, String>{
  'apps/playground/theme':
      'an indigo primary and matching focus ring, so the dogfood proves a '
      'theme-wide value change survives a reinstall',
};

/// The consumers that hold committed, CLI-installed source.
const _consumers = <String>['apps/playground', 'packages/remix_agent/example'];

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
    '${_consumers.length} consumers mirror the registry; '
    '${_customized.length} declared customization intact.',
  );
}

Future<String?> _run(Directory root) async {
  final registry = File(
    '${root.path}/packages/remix_cli/lib/src/registry/default/registry.yaml',
  );
  if (!registry.existsSync()) return 'the bundled registry is missing.';

  final document = loadYaml(registry.readAsStringSync());
  if (document is! YamlMap || document['items'] is! YamlMap) {
    return 'registry.yaml is not in the expected shape.';
  }
  final items = document['items'] as YamlMap;

  final problems = <String>[];
  final unknown = _customized.keys.toSet();

  for (final consumer in _consumers) {
    final directory = Directory('${root.path}/$consumer');
    final config = File('${directory.path}/remix.yaml');
    if (!config.existsSync()) {
      problems.add('$consumer has no remix.yaml, so nothing was installed.');
      continue;
    }
    final uiPath = _uiPath(config.readAsStringSync());
    if (uiPath == null) {
      problems.add('$consumer/remix.yaml declares no paths.ui.');
      continue;
    }

    var checked = 0;
    for (final key in items.keys) {
      if (key is! String) continue;
      // Only what this consumer installed. The playground holds every item;
      // the Agent example holds the four its composer recipe composes, and
      // asking about the rest would report every absent file as drift.
      if (!_isInstalled(directory, uiPath, items[key])) continue;
      checked += 1;

      final label = '$consumer/$key';
      unknown.remove(label);

      final result = await Process.run(Platform.resolvedExecutable, [
        'run',
        'remix_cli:remix',
        'add',
        key,
        '--diff',
      ], workingDirectory: directory.path);
      if (result.exitCode != 0) {
        // The exit code alone cannot be acted on from a CI log. Carry the
        // reason, which is where a missing Git or a preflight refusal is named.
        final detail = (result.stderr as String).trim();
        problems.add(
          '$label: `remix add $key --diff` exited ${result.exitCode}'
          '${detail.isEmpty ? '' : '\n    $detail'}',
        );
        continue;
      }

      final edited = !(result.stdout as String).contains(_clean);
      final reason = _customized[label];
      if (!edited && reason != null) {
        problems.add(
          '$label is listed as customized ($reason) but matches the template. '
          'Drop it from the list.',
        );
      } else if (edited && reason == null) {
        problems.add(
          '$label has diverged from the template. Rerun `dart run '
          'remix_cli:remix add $key --overwrite` in $consumer, or record the '
          'reason in this check.',
        );
      }
    }

    if (checked == 0) {
      problems.add('$consumer installed no registry item this check can see.');
    }
  }

  for (final item in unknown) {
    problems.add('$item is listed as customized but is not installed.');
  }

  if (problems.isEmpty) return null;
  return 'a consumer and the registry disagree:\n'
      '${problems.map((problem) => '  - $problem').join('\n')}';
}

/// The `paths.ui` a consumer's `remix.yaml` declares.
String? _uiPath(String source) {
  final document = loadYaml(source);
  if (document is! YamlMap) return null;
  final paths = document['paths'];
  if (paths is! YamlMap) return null;
  final ui = paths['ui'];
  return ui is String ? ui : null;
}

/// Whether [consumer] holds the authored file [item] installs.
///
/// The registry's targets are written `@ui/...`; the consumer's `remix.yaml`
/// says where `@ui` lives.
bool _isInstalled(Directory consumer, String uiPath, Object? item) {
  if (item is! YamlMap) return false;
  final files = item['files'];
  if (files is! YamlList) return false;
  for (final file in files) {
    if (file is! YamlMap) continue;
    final target = file['target'];
    if (target is! String || !target.startsWith('@ui/')) continue;
    final relative = target.substring('@ui/'.length);
    if (File('${consumer.path}/$uiPath/$relative').existsSync()) return true;
  }
  return false;
}
