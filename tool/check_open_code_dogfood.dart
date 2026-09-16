/// Verifies that the workspace dogfood apps still mirror the bundled registry.
///
/// ```shell
/// dart run tool/check_open_code_dogfood.dart
/// ```
///
/// Playground expects the full default registry; demo and dashboard list the
/// Fortal items they install explicitly, since only the default manifest is
/// read here.
/// Check expected items even when their files are missing. The CLI owns config parsing, template rendering, and diffing.
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
  // The Fortal review catalog: every non-Agent Fortal item.
  'apps/demo': [
    'theme',
    'icons',
    'accordion',
    'avatar',
    'badge',
    'base_button',
    'button',
    'callout',
    'card',
    'chart',
    'checkbox',
    'code',
    'data_list',
    'data_table',
    'dialog',
    'disclosure',
    'divider',
    'heading',
    'icon_button',
    'kbd',
    'link',
    'menu',
    'popover',
    'progress',
    'radio',
    'segmented_control',
    'select',
    'sidebar',
    'sidebar_layout',
    'skeleton',
    'slider',
    'spinner',
    'switch',
    'tabs',
    'text',
    'textfield',
    'toast',
    'toggle',
    'toggle_group',
    'tooltip',
    'typography',
  ],
  // Every Fortal item, Agent surfaces and recipes included.
  'apps/dashboard': [
    'theme',
    'icons',
    'accordion',
    'activity_recipe',
    'answer_recipe',
    'avatar',
    'badge',
    'base_button',
    'button',
    'callout',
    'card',
    'chart',
    'checkbox',
    'code',
    'composer_recipe',
    'data_list',
    'data_table',
    'dialog',
    'disclosure',
    'divider',
    'execution_recipe',
    'heading',
    'icon_button',
    'kbd',
    'link',
    'menu',
    'message_recipe',
    'permission_recipe',
    'plan_recipe',
    'popover',
    'progress',
    'radio',
    'segmented_control',
    'select',
    'sidebar',
    'sidebar_layout',
    'skeleton',
    'slider',
    'spinner',
    'switch',
    'tabs',
    'text',
    'textfield',
    'toast',
    'toggle',
    'toggle_group',
    'tooltip',
    'transcript_recipe',
    'typography',
    'models',
    'support',
    'activity',
    'answer',
    'composer',
    'execution',
    'message',
    'permission',
    'plan',
    'transcript',
  ],
};

/// What `remix add --diff` prints when the installed source is up to date.
///
/// The CLI prints a preamble and then exactly one verdict: this line, or a
/// `git diff`. Both are recognized below so that a third shape can be reported
/// as itself rather than silently read as divergence.
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

      // Classifying on the sentinel alone means any reword of it reports all
      // 40 items as diverged and sends the reader to `--overwrite`, which
      // cannot fix a change in the CLI's own output. Recognize both verdicts
      // instead, and name the case where neither or both appear.
      final lines = (result.stdout as String).split('\n');
      final clean = lines.any((line) => line.trimRight() == _clean);
      final diffed = lines.any((line) => line.startsWith('diff --git '));
      if (clean == diffed) {
        problems.add(
          '$label: `remix add $key --diff` printed '
          '${clean ? 'both a clean verdict and a diff' : 'no recognizable verdict'}'
          '. The CLI output contract moved; update `_clean` in this check to '
          'match `installer.dart`.',
        );
        continue;
      }

      final edited = diffed;
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
  problems.addAll(_sourcePackageImports(root));

  if (problems.isEmpty) return null;
  return 'a consumer and the registry disagree:\n'
      '${problems.map((problem) => '  - $problem').join('\n')}';
}

/// Applications consume installed source only. Outside their `lib/ui/`, no
/// file may reach the authoring packages the registry derives from.
Iterable<String> _sourcePackageImports(Directory root) sync* {
  final forbidden = RegExp(
    r"""^\s*(?:import|export)\s+['"]package:(registry_source)/""",
    multiLine: true,
  );
  for (final consumer in _consumers.keys) {
    final lib = Directory('${root.path}/$consumer/lib');
    if (!lib.existsSync()) continue;
    for (final file in lib.listSync(recursive: true).whereType<File>()) {
      if (!file.path.endsWith('.dart')) continue;
      final relative = file.path.substring(root.path.length + 1);
      if (relative.startsWith('$consumer/lib/ui/')) continue;
      final match = forbidden.firstMatch(file.readAsStringSync());
      if (match != null) {
        yield '$relative imports package:${match.group(1)}; applications '
            'consume installed source only.';
      }
    }
  }
}
