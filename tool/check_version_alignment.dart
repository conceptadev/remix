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

/// The registry file whose `remix` constraint must floor at the released
/// `remix` version.
const _registryPath = 'packages/remix_cli/lib/src/registry/registry.yaml';

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

  final remixVersion = versions['remix'];
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
