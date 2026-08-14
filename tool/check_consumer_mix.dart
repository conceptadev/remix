import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

/// Library packages whose runtime Mix constraints are a consumer contract.
///
/// Both are checked because the workspace resolves a single Mix version for
/// everything; a constraint bumped in one package and forgotten in the other
/// still resolves locally and only fails once a consumer installs them.
const _libraryPackages = ['remix', 'remix_fortal', 'remix_carbon'];

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
  final declarations = <String, Map<String, String>>{};

  for (final package in _libraryPackages) {
    final pubspecFile = File(
      '${workspaceRoot.path}/packages/$package/pubspec.yaml',
    );
    if (!pubspecFile.existsSync()) {
      failures.add('packages/$package/pubspec.yaml is missing');
      continue;
    }

    final pubspec = loadYaml(pubspecFile.readAsStringSync()) as YamlMap;
    final dependencies = pubspec['dependencies'] as YamlMap;
    declarations[package] = {};

    for (final dependency in _runtimeDependencies) {
      final declared = dependencies[dependency];
      if (declared is! String) {
        failures.add('$package does not declare a $dependency constraint');
        continue;
      }
      declarations[package]![dependency] = declared;

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

  // The published packages ship together, so a floor raised in one and not the
  // other is a publishing hazard the single workspace lockfile cannot surface.
  for (final dependency in _runtimeDependencies) {
    final declared = {
      for (final package in _libraryPackages)
        if (declarations[package]?[dependency] case final constraint?)
          package: constraint,
    };
    final distinct = declared.values.toSet();
    if (distinct.length > 1) {
      failures.add(
        '$dependency constraints diverge across library packages: '
        '${declared.entries.map((e) => '${e.key} ${e.value}').join(', ')}',
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
