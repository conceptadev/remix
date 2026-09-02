import 'dart:io';

import 'package:yaml/yaml.dart';

/// Rewrites `remix_cli`'s bundled registry constraint to floor at the current
/// `packages/remix` version.
///
/// ```shell
/// dart run tool/sync_registry_remix.dart
/// ```
///
/// `melos version` rewrites the `remix` constraint of every pubspec dependent,
/// which is how `remix_fortal`'s parity pin stays in step. The registry is
/// data, not a pubspec, so melos never reaches it — this tool is the step that
/// does. `tool/check_version_alignment.dart` is the checker that fails when it
/// has not been run; the two are deliberately separate, because no `check_*`
/// tool in this workspace writes.
void main(List<String> arguments) {
  if (arguments.isNotEmpty) {
    stderr.writeln('Unsupported arguments: ${arguments.join(', ')}');
    stderr.writeln('Usage: dart run tool/sync_registry_remix.dart');
    exitCode = 64;
    return;
  }

  final workspaceRoot = Directory.current;
  final pubspec = File('${workspaceRoot.path}/pubspec.yaml');
  if (!pubspec.existsSync() ||
      !RegExp(
        r'^name:\s*remix_workspace\s*$',
        multiLine: true,
      ).hasMatch(pubspec.readAsStringSync())) {
    stderr.writeln('Run this tool from the workspace root.');
    exitCode = 64;
    return;
  }

  final remixPubspec = File(
    '${workspaceRoot.path}/packages/remix/pubspec.yaml',
  );
  if (!remixPubspec.existsSync()) {
    stderr.writeln('Missing ${remixPubspec.path}.');
    exitCode = 1;
    return;
  }
  final declared =
      (loadYaml(remixPubspec.readAsStringSync()) as YamlMap)['version'];
  if (declared is! String) {
    stderr.writeln('packages/remix does not declare a version.');
    exitCode = 1;
    return;
  }

  final registry = File(
    '${workspaceRoot.path}/packages/remix_cli/lib/src/registry/registry.yaml',
  );
  if (!registry.existsSync()) {
    stderr.writeln('Missing ${registry.path}.');
    exitCode = 1;
    return;
  }

  // One line, matched with its indentation preserved: rewriting the parsed
  // document would reformat every other item in the file.
  final line = RegExp(r'^([ \t]*remix:[ \t]*)\^(\S+)[ \t]*$', multiLine: true);
  final source = registry.readAsStringSync();
  final matches = line.allMatches(source).toList();
  if (matches.length != 1) {
    stderr.writeln(
      'Expected exactly one caret remix constraint in registry.yaml, '
      'found ${matches.length}.',
    );
    exitCode = 1;
    return;
  }

  final match = matches.single;
  final current = match[2]!;
  if (current == declared) {
    stdout.writeln('registry.yaml already ^$declared.');
    return;
  }

  registry.writeAsStringSync(
    source.replaceRange(match.start, match.end, '${match[1]}^$declared'),
  );
  stdout.writeln('registry.yaml remix ^$current -> ^$declared.');
}
