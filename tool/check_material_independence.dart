import 'dart:io';

// Fortal stays here because these sources are copied into consumer apps even
// though the authoring package itself is no longer published.
const _consumerSourcePackages = ['remix', 'remix_fortal'];

final _forbiddenLibraryDirective = RegExp(
  r'''^\s*(?:import|export)\s+['"]package:(?:flutter/(?:material\.dart|src/material/[^'"]+)|material_ui/[^'"]+)['"]''',
  multiLine: true,
);

final _materialUiDependency = RegExp(
  r'^\s{0,4}material_ui\s*:',
  multiLine: true,
);

final _materialFontFlag = RegExp(
  r'^\s*uses-material-design\s*:',
  multiLine: true,
);

void main() {
  final workspace = Directory.current.absolute;
  final failures = <String>[];

  for (final package in _consumerSourcePackages) {
    final packageDirectory = Directory('${workspace.path}/packages/$package');
    final libraryDirectory = Directory('${packageDirectory.path}/lib');
    final pubspec = File('${packageDirectory.path}/pubspec.yaml');

    if (!libraryDirectory.existsSync() || !pubspec.existsSync()) {
      failures.add('packages/$package is missing its lib directory or pubspec');
      continue;
    }

    for (final entity in libraryDirectory.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;

      final source = entity.readAsStringSync();
      for (final match in _forbiddenLibraryDirective.allMatches(source)) {
        final relativePath = entity.path.substring(workspace.path.length + 1);
        final line =
            '\n'.allMatches(source.substring(0, match.start)).length + 1;
        failures.add('$relativePath:$line imports a Material library');
      }
    }

    final manifest = pubspec.readAsStringSync();
    if (_materialUiDependency.hasMatch(manifest)) {
      failures.add('packages/$package/pubspec.yaml declares material_ui');
    }
    if (_materialFontFlag.hasMatch(manifest)) {
      failures.add(
        'packages/$package/pubspec.yaml declares uses-material-design',
      );
    }
  }

  if (failures.isEmpty) {
    stdout.writeln(
      'Remix and application-owned Fortal sources have no direct Material '
      'usage.',
    );
    return;
  }

  stderr.writeln('Direct Material usage validation failed:');
  for (final failure in failures) {
    stderr.writeln('- $failure');
  }
  exitCode = 1;
}
