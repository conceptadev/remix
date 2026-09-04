import 'dart:io';

import 'package:yaml/yaml.dart';

/// The floor required by code that reaches consumer applications.
///
/// Matches `mix` and `naked_ui` so the three can be installed together on the
/// oldest Flutter any of them supports. It is the true minimum of the shipped
/// package code and the Fortal source copied by the CLI.
const _consumerFloor = {'sdk': '>=3.11.0 <4.0.0', 'flutter': '>=3.41.0'};

/// The floor everything workspace-only declares.
///
/// Higher than [_consumerFloor] because the dev toolchain, not the shipped
/// code, is what needs a newer SDK: `build_runner` pulls `analyzer`, which
/// requires `meta ^1.18.0`, and Flutter ships meta 1.18 only from 3.44. Raising
/// consumer-facing code to match would exclude applications for a constraint
/// that never reaches them.
const _workspaceFloor = {'sdk': '>=3.12.0 <4.0.0', 'flutter': '>=3.44.0'};

/// The floor for pure-Dart workspace tools.
///
/// These packages use the workspace Dart SDK but must not claim a Flutter
/// consumer constraint merely because they live beside Flutter packages.
const _pureDartFloor = {'sdk': '>=3.12.0 <4.0.0'};

/// Packages whose sources reach consumers, either through pub.dev or the
/// application-owned Fortal preset. Every other member gets [_workspaceFloor].
const _consumerFloorPackages = {
  'packages/remix',
  'packages/remix_fortal',
  'packages/remix_ui_icons',
};

/// Workspace tools that intentionally declare no Flutter environment key.
const _pureDartPackages = {'packages/remix_cli'};

/// Verifies every workspace package declares the floor its role requires.
///
/// Nothing else enforces this. Melos' `command.bootstrap.environment` is the
/// usual mechanism, but it rewrites a single value into every package it
/// manages and offers no per-package exemption, so it cannot express the split
/// above — see the note in the workspace pubspec.
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
  final members = (root['workspace'] as YamlList?)?.cast<String>().toList();
  if (members == null || members.isEmpty) {
    stderr.writeln('pubspec.yaml must declare a non-empty workspace.');
    exitCode = 1;

    return;
  }

  final unknown = _consumerFloorPackages.difference(members.toSet());
  final unknownPureDart = _pureDartPackages.difference(members.toSet());
  if (unknown.isNotEmpty || unknownPureDart.isNotEmpty) {
    stderr.writeln(
      'Packages assigned a toolchain role are missing from the workspace: '
      '${{...unknown, ...unknownPureDart}}.',
    );
    exitCode = 1;

    return;
  }

  final failures = <String>[];
  // '.' is the workspace root, which is a package in its own right.
  for (final relativePath in ['.', ...members]) {
    final expected = _expectedFloor(relativePath);
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

    for (final entry in expected.entries) {
      final declared = environment[entry.key];
      if (declared == null) {
        failures.add(
          '$relativePath does not declare environment.${entry.key}; add '
          '"${entry.key}: ${entry.value}".',
        );
      } else if (declared != entry.value) {
        failures.add(
          '$relativePath declares environment.${entry.key} $declared, but its '
          'floor is ${entry.value}.',
        );
      }
    }
    if (_pureDartPackages.contains(relativePath) &&
        environment.containsKey('flutter')) {
      failures.add(
        '$relativePath is a pure-Dart package but declares '
        'environment.flutter ${environment['flutter']}.',
      );
    }
  }

  if (failures.isNotEmpty) {
    stderr.writeln('Toolchain floor drift detected (${failures.length}):');
    for (final failure in failures) {
      stderr.writeln('- $failure');
    }
    stderr.writeln(
      'Both floors are declared in tool/check_toolchain.dart. Change them '
      'there first, then update the pubspecs to match.',
    );
    exitCode = 1;

    return;
  }

  stdout.writeln(
    'Toolchain floors are consistent: ${_consumerFloorPackages.length} '
    'consumer-source packages on Flutter ${_consumerFloor['flutter']}, '
    '${_pureDartPackages.length} pure-Dart tool on Dart '
    '${_pureDartFloor['sdk']}, and '
    '${members.length + 1 - _consumerFloorPackages.length - _pureDartPackages.length} '
    'workspace-only packages '
    'on Flutter ${_workspaceFloor['flutter']}.',
  );
}

Map<String, String> _expectedFloor(String relativePath) {
  if (_consumerFloorPackages.contains(relativePath)) return _consumerFloor;
  if (_pureDartPackages.contains(relativePath)) return _pureDartFloor;
  return _workspaceFloor;
}
