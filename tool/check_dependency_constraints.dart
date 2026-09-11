import 'dart:io';

import 'package:yaml/yaml.dart';

/// Verifies every shared dependency constraint comes from the melos config.
///
/// `melos bootstrap` rewrites the constraints listed under
/// `melos.command.bootstrap` into each melos package that already declares
/// them. Two gaps remain, and this check closes both:
///
/// * The workspace root is not a melos package, so bootstrap never rewrites
///   its own constraints.
/// * A dependency that several pubspecs declare but the config omits is never
///   synchronized, so its constraints can drift apart unnoticed.
///
/// A dependency declared by a single pubspec stays local to it.
void main() {
  final workspaceRoot = Directory.current.absolute;
  final rootPubspec = File('${workspaceRoot.path}/pubspec.yaml');
  if (!rootPubspec.existsSync() ||
      !rootPubspec.readAsStringSync().contains('name: remix_workspace')) {
    stderr.writeln('Run this checker from the workspace root.');
    exitCode = 64;

    return;
  }

  final root = loadYaml(rootPubspec.readAsStringSync()) as YamlMap;
  final members = (root['workspace'] as YamlList?)?.cast<String>() ?? const [];
  final bootstrap =
      ((root['melos'] as YamlMap?)?['command'] as YamlMap?)?['bootstrap']
          as YamlMap?;

  final failures = <String>[];
  final managed = <String, String>{};
  for (final section in const ['dependencies', 'dev_dependencies']) {
    (bootstrap?[section] as YamlMap?)?.forEach((name, constraint) {
      final previous = managed[name as String];
      if (previous != null && previous != '$constraint') {
        failures.add('melos manages $name as both $previous and $constraint.');
      }
      managed[name] = '$constraint';
    });
  }

  // Only hosted constraints are compared. SDK, path, and Git dependencies
  // carry no version to share.
  final declarations = <String, Map<String, String>>{};
  // '.' is the workspace root, which is a package in its own right.
  for (final relativePath in ['.', ...members]) {
    final pubspec = File(
      relativePath == '.'
          ? rootPubspec.path
          : '${workspaceRoot.path}/$relativePath/pubspec.yaml',
    );
    if (!pubspec.existsSync()) {
      failures.add('$relativePath is missing a pubspec.yaml.');
      continue;
    }

    final document = loadYaml(pubspec.readAsStringSync()) as YamlMap;
    for (final section in const ['dependencies', 'dev_dependencies']) {
      (document[section] as YamlMap?)?.forEach((name, constraint) {
        if (constraint == null || constraint is YamlMap) return;
        declarations.putIfAbsent(name as String, () => {})[relativePath] =
            '$constraint';
      });
    }
  }

  for (final MapEntry(key: name, value: declared) in declarations.entries) {
    final expected = managed[name];
    if (expected == null) {
      if (declared.length > 1) {
        failures.add(
          '$name is declared by ${declared.keys.join(', ')} but is not '
          'managed by melos.',
        );
      }
      continue;
    }
    declared.forEach((relativePath, constraint) {
      if (constraint != expected) {
        failures.add(
          '$relativePath declares $name $constraint, but melos manages '
          '$expected.',
        );
      }
    });
  }
  for (final name in managed.keys) {
    if (!declarations.containsKey(name)) {
      failures.add(
        'melos manages $name, but no workspace pubspec declares it.',
      );
    }
  }

  if (failures.isNotEmpty) {
    stderr.writeln(
      'Dependency constraint drift detected (${failures.length}):',
    );
    for (final failure in failures) {
      stderr.writeln('- $failure');
    }
    stderr.writeln(
      'Shared constraints live under melos.command.bootstrap in the root '
      'pubspec. Change them there, run `dart run melos bootstrap`, and update '
      "the root pubspec's own entries by hand.",
    );
    exitCode = 1;

    return;
  }

  stdout.writeln(
    '${managed.length} shared dependency constraints come from melos and '
    'match in all ${members.length + 1} workspace pubspecs.',
  );
}
