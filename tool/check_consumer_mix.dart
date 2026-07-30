import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

void main() {
  final workspaceRoot = Directory.current.absolute;
  final remixPubspec = File(
    '${workspaceRoot.path}/packages/remix/pubspec.yaml',
  );
  final lockfile = File('${workspaceRoot.path}/pubspec.lock');
  if (!remixPubspec.existsSync() || !lockfile.existsSync()) {
    stderr.writeln('Run this checker from the Remix workspace root.');
    exitCode = 64;
    return;
  }

  final pubspec = loadYaml(remixPubspec.readAsStringSync()) as YamlMap;
  final lock = loadYaml(lockfile.readAsStringSync()) as YamlMap;
  final declared = (pubspec['dependencies'] as YamlMap)['mix'] as String;
  final resolved = (lock['packages'] as YamlMap)['mix'] as YamlMap;
  final constraint = VersionConstraint.parse(declared);
  final source = resolved['source'] as String;
  final dependency = resolved['dependency'] as String;
  final version = Version.parse(resolved['version'] as String);
  final failures = <String>[];

  if (source != 'hosted') {
    failures.add('expected a hosted source, found $source');
  }
  if (dependency.contains('overridden')) {
    failures.add('the workspace overrides the consumer dependency');
  }
  if (!constraint.allows(version)) {
    failures.add('$version does not satisfy the declared $constraint');
  }

  stdout.writeln(
    'Mix consumer resolution: $source $version ($dependency); '
    'declared $constraint.',
  );
  if (failures.isEmpty) return;

  stderr.writeln('Mix consumer validation failed:');
  for (final failure in failures) {
    stderr.writeln('- $failure');
  }
  exitCode = 1;
}
