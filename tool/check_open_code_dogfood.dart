/// Verifies that the workspace dogfood apps still mirror the bundled registry.
///
/// ```shell
/// dart run tool/check_open_code_dogfood.dart
/// ```
///
/// Playground expects the full default registry; the Agent example expects
/// only its Composer dependencies. Check expected items even when their files
/// are missing. The CLI owns config parsing, template rendering, and diffing.
///
/// Application-owned source may be customized. Each deliberate edit belongs in
/// [_customized]; an entry that matches the template again is also an error.
library;

import 'dart:io';

import 'package:yaml/yaml.dart';

/// Deliberate source edits, keyed by `consumer/item`.
const _customized = <String, String>{
  'apps/playground/theme':
      'an indigo primary and matching focus ring, so the dogfood proves a '
      'theme-wide value change survives a reinstall',
};

/// Expected items per consumer; null means the entire default registry.
const _consumers = <String, List<String>?>{
  'apps/playground': null,
  'packages/remix_agent/example': ['theme', 'card', 'textfield', 'icon_button'],
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

  for (final consumer in _consumers.keys) {
    final directory = Directory('${root.path}/$consumer');
    final expected = _consumers[consumer] ?? items.keys.cast<String>();
    for (final key in expected) {
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
  }

  for (final item in unknown) {
    problems.add('$item is listed as customized but is not an expected item.');
  }

  if (problems.isEmpty) return null;
  return 'a consumer and the registry disagree:\n'
      '${problems.map((problem) => '  - $problem').join('\n')}';
}
