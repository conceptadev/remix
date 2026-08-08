import 'dart:io';

import 'package:yaml/yaml.dart';

/// Verifies every workspace package declares the melos-managed toolchain floor.
///
/// `melos.command.bootstrap.environment` is the source of truth, but melos only
/// enforces part of it: bootstrap always rewrites `sdk`, and rewrites any other
/// key *only on packages that already declare it* (melos 7
/// `_updateEnvironment`). A package added without a `flutter:` entry escapes the
/// shared floor silently — bootstrap reports success, and the drift surfaces
/// only when a consumer on an older Flutter installs a package that cannot
/// build.
///
/// Asserting the declaration rather than re-running bootstrap keeps this
/// meaningful in a CI job that has already bootstrapped.
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
  final managed = _managedEnvironment(root);
  if (managed == null) {
    stderr.writeln(
      'pubspec.yaml must declare melos.command.bootstrap.environment.',
    );
    exitCode = 1;

    return;
  }

  final members = (root['workspace'] as YamlList?)?.cast<String>().toList();
  if (members == null || members.isEmpty) {
    stderr.writeln('pubspec.yaml must declare a non-empty workspace.');
    exitCode = 1;

    return;
  }

  final failures = <String>[];
  // The root is a package too, but sits outside `melos.packages`, so melos
  // never syncs it. Check it so its two environment blocks cannot diverge.
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

    final environment =
        (loadYaml(pubspec.readAsStringSync()) as YamlMap)['environment']
            as YamlMap?;
    if (environment == null) {
      failures.add('$relativePath declares no environment.');
      continue;
    }

    for (final entry in managed.entries) {
      final declared = environment[entry.key];
      if (declared == null) {
        failures.add(
          '$relativePath does not declare environment.${entry.key}; melos '
          'cannot sync a key a package omits, so add "${entry.key}: '
          '${entry.value}".',
        );
      } else if (declared != entry.value) {
        failures.add(
          '$relativePath declares environment.${entry.key} $declared, but the '
          'workspace floor is ${entry.value}. Run `melos bootstrap`.',
        );
      }
    }
  }

  if (failures.isNotEmpty) {
    stderr.writeln('Toolchain floor drift detected (${failures.length}):');
    for (final failure in failures) {
      stderr.writeln('- $failure');
    }
    exitCode = 1;

    return;
  }

  final summary = managed.entries
      .map((entry) => '${entry.key} ${entry.value}')
      .join(', ');
  stdout.writeln(
    'Toolchain floor is consistent across ${members.length + 1} pubspecs: '
    '$summary.',
  );
}

Map<String, String>? _managedEnvironment(YamlMap root) {
  final environment =
      ((root['melos'] as YamlMap?)?['command'] as YamlMap?)?['bootstrap']
          as YamlMap?;
  final values = environment?['environment'] as YamlMap?;
  if (values == null) return null;

  return {
    for (final entry in values.entries)
      entry.key as String: entry.value as String,
  };
}
