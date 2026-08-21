import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

/// Published packages that must always carry the identical version.
///
/// `remix_fortal` is a theme layer over `remix` and the two are only ever
/// tested against each other, so a released pair is the unit consumers
/// install. Sharing one version makes that pairing legible from the version
/// alone instead of requiring a changelog lookup.
///
/// Melos has no lockstep mode: it versions each package from its own commits,
/// and the propagation is one-way (a `remix` bump reaches `remix_fortal` as a
/// dependent, never the reverse). So a `remix_fortal`-only release would drift
/// the pair apart with nothing to stop it. This checker is that stop.
const _lockstepPackages = ['remix', 'remix_fortal'];

void main() {
  final workspaceRoot = Directory.current.absolute;
  final versions = <String, Version>{};
  final failures = <String>[];

  for (final package in _lockstepPackages) {
    final pubspecFile = File(
      '${workspaceRoot.path}/packages/$package/pubspec.yaml',
    );
    if (!pubspecFile.existsSync()) {
      failures.add('packages/$package/pubspec.yaml is missing');
      continue;
    }

    final pubspec = loadYaml(pubspecFile.readAsStringSync()) as YamlMap;
    final declared = pubspec['version'];
    if (declared is! String) {
      failures.add('$package does not declare a version');
      continue;
    }

    try {
      versions[package] = Version.parse(declared);
    } on FormatException {
      failures.add('$package declares an unparseable version "$declared"');
    }
  }

  if (versions.length == _lockstepPackages.length) {
    final distinct = versions.values.toSet();
    if (distinct.length > 1) {
      failures.add(
        'lockstep packages disagree: '
        '${versions.entries.map((e) => '${e.key} ${e.value}').join(', ')}. '
        'Release them on one version — pass the same value to both '
        '`remix_version` and `remix_fortal_version` in the version workflow.',
      );
    } else {
      stdout.writeln(
        'Lockstep versions aligned: '
        '${_lockstepPackages.join(', ')} all on ${distinct.single}.',
      );
    }
  }

  if (failures.isEmpty) return;

  stderr.writeln('Version alignment validation failed:');
  for (final failure in failures) {
    stderr.writeln('- $failure');
  }
  exitCode = 1;
}
