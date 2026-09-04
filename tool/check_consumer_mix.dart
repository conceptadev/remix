import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

/// Published packages whose runtime Mix constraints are a consumer contract.
///
/// Fortal is installed as application-owned source and inherits these floors
/// from the Remix registry entry, so only the hosted Remix package belongs in
/// this check.
const _publishedPackages = ['remix'];

/// Runtime Mix dependencies a consumer resolves alongside those packages.
///
/// `mix_generator` is deliberately absent: it is a dev dependency and never
/// reaches a consumer's resolution.
const _runtimeDependencies = ['mix', 'mix_annotations'];

void main() {
  final workspaceRoot = Directory.current.absolute;
  final lockfile = File('${workspaceRoot.path}/pubspec.lock');
  if (!lockfile.existsSync()) {
    stderr.writeln('Run this checker from the Remix workspace root.');
    exitCode = 64;

    return;
  }

  final lock = loadYaml(lockfile.readAsStringSync()) as YamlMap;
  final lockedPackages = lock['packages'] as YamlMap;
  final failures = <String>[];

  for (final package in _publishedPackages) {
    final pubspecFile = File(
      '${workspaceRoot.path}/packages/$package/pubspec.yaml',
    );
    if (!pubspecFile.existsSync()) {
      failures.add('packages/$package/pubspec.yaml is missing');
      continue;
    }

    final pubspec = loadYaml(pubspecFile.readAsStringSync()) as YamlMap;
    final dependencies = pubspec['dependencies'] as YamlMap;
    for (final dependency in _runtimeDependencies) {
      final declared = dependencies[dependency];
      if (declared is! String) {
        failures.add('$package does not declare a $dependency constraint');
        continue;
      }
      final resolved = lockedPackages[dependency];
      if (resolved is! YamlMap) {
        failures.add('$dependency is absent from pubspec.lock');
        continue;
      }

      final constraint = VersionConstraint.parse(declared);
      final source = resolved['source'] as String;
      final kind = resolved['dependency'] as String;
      final version = Version.parse(resolved['version'] as String);

      if (source != 'hosted') {
        failures.add('$package: $dependency expected hosted, found $source');
      }
      if (kind.contains('overridden')) {
        failures.add('$package: the workspace overrides $dependency');
      }
      if (!constraint.allows(version)) {
        failures.add(
          '$package: $dependency $version does not satisfy $constraint',
        );
      }

      stdout.writeln(
        '$package -> $dependency: $source $version ($kind); '
        'declared $constraint.',
      );
    }
  }

  if (failures.isEmpty) return;

  stderr.writeln('Mix consumer validation failed:');
  for (final failure in failures) {
    stderr.writeln('- $failure');
  }
  exitCode = 1;
}
