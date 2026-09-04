import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

/// Published Remix manifest whose version owns the registry floor.
const _remixPubspecPath = 'packages/remix/pubspec.yaml';

/// The registry file whose `remix` constraint must floor at the released
/// `remix` version.
const _registryPath =
    'packages/remix_cli/lib/src/registry/default/registry.yaml';

void main() {
  final workspaceRoot = Directory.current.absolute;
  final failures = <String>[];
  final remixPubspec = File('${workspaceRoot.path}/$_remixPubspecPath');
  Version? remixVersion;
  if (!remixPubspec.existsSync()) {
    failures.add('$_remixPubspecPath is missing');
  } else {
    final pubspec = loadYaml(remixPubspec.readAsStringSync()) as YamlMap;
    final declared = pubspec['version'];
    if (declared is! String) {
      failures.add('remix does not declare a version');
    } else {
      try {
        remixVersion = Version.parse(declared);
      } on FormatException {
        failures.add('remix declares an unparseable version "$declared"');
      }
    }
  }

  if (remixVersion != null) {
    _checkRegistryFloor(workspaceRoot, remixVersion, failures);
  }

  if (failures.isEmpty) return;

  stderr.writeln('Version alignment validation failed:');
  for (final failure in failures) {
    stderr.writeln('- $failure');
  }
  exitCode = 1;
}

/// Holds `remix_cli`'s bundled registry constraint to the released `remix`.
///
/// The registry is data, not a pubspec dependency, so `melos version` never
/// rewrites it. Left alone, `remix: ^1.0.0-beta.7` would keep admitting every
/// later beta while the templates were only ever tested against the floor —
/// and nothing would say so. This is the coupling that makes the floor mean
/// "the version this snapshot was authored against", which is what the
/// installer's drift notice reports.
///
/// Equality is strict on purpose. Accepting `floor <= remix` would let a
/// hand-run bump drift the two apart with no failure to stop it.
void _checkRegistryFloor(
  Directory workspaceRoot,
  Version remixVersion,
  List<String> failures,
) {
  final registryFile = File('${workspaceRoot.path}/$_registryPath');
  if (!registryFile.existsSync()) {
    failures.add('$_registryPath is missing');
    return;
  }

  final document = loadYaml(registryFile.readAsStringSync());
  final items = document is YamlMap ? document['items'] : null;
  if (items is! YamlMap) {
    failures.add('$_registryPath is not in the expected shape');
    return;
  }

  // Every item but one inherits the constraint through `registryDependencies`,
  // so a second declaration would be a second thing to keep in step.
  final declaring = <String, String>{};
  for (final entry in items.entries) {
    final dependencies = (entry.value as YamlMap)['dependencies'];
    if (dependencies is! YamlMap) continue;
    final constraint = dependencies['remix'];
    if (constraint is String) declaring['${entry.key}'] = constraint;
  }
  if (declaring.length != 1) {
    failures.add(
      'the registry declares remix in ${declaring.length} items '
      '(${declaring.keys.join(', ')}); exactly one item must declare it so '
      'there is a single constraint to keep aligned',
    );
    return;
  }

  final item = declaring.keys.single;
  final declared = declaring.values.single;
  final VersionConstraint constraint;
  try {
    constraint = VersionConstraint.parse(declared);
  } on FormatException {
    failures.add(
      '$_registryPath item $item declares an unparseable remix '
      'constraint "$declared"',
    );
    return;
  }

  final floor = constraint is VersionRange ? constraint.min : null;
  if (floor == null) {
    failures.add(
      '$_registryPath item $item declares remix "$declared", which has no '
      'lower bound. The floor is what records the tested version, so the '
      'constraint must name one.',
    );
    return;
  }
  if (floor != remixVersion) {
    failures.add(
      '$_registryPath item $item declares remix "$declared", flooring at '
      '$floor, but packages/remix is $remixVersion. '
      'Run `dart run tool/sync_registry_remix.dart`.',
    );
    return;
  }

  stdout.writeln(
    'Registry floor aligned: remix_cli item $item declares remix "$declared" '
    'against remix $remixVersion.',
  );
}
