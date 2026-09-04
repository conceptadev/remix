import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

/// Analyzes Remix Carbon outside the workspace against its declared Remix floor.
///
/// The workspace always resolves `package:remix` to the local sibling package,
/// which can hide accidental use of APIs that are newer than the hosted version
/// promised by `packages/remix_carbon/pubspec.yaml`. This checker copies only
/// the package sources to a temporary standalone package, pins Remix to the
/// declared constraint's inclusive minimum, and analyzes that copy.
Future<void> main() async {
  final workspaceRoot = Directory.current.absolute;
  final rootPubspec = File('${workspaceRoot.path}/pubspec.yaml');
  if (!rootPubspec.existsSync() ||
      !rootPubspec.readAsStringSync().contains('name: remix_workspace')) {
    stderr.writeln('Run this checker from the Remix workspace root.');
    exitCode = 64;

    return;
  }

  final packageRoot = Directory('${workspaceRoot.path}/packages/remix_carbon');
  final sourcePubspec = File('${packageRoot.path}/pubspec.yaml');
  final sourceOptions = File('${packageRoot.path}/analysis_options.yaml');
  final sourceLibrary = Directory('${packageRoot.path}/lib');
  if (!sourcePubspec.existsSync() ||
      !sourceOptions.existsSync() ||
      !sourceLibrary.existsSync()) {
    stderr.writeln('Remix Carbon package sources are incomplete.');
    exitCode = 1;

    return;
  }

  final pubspecContents = sourcePubspec.readAsStringSync();
  final pubspec = loadYaml(pubspecContents) as YamlMap;
  final remixDeclaration = (pubspec['dependencies'] as YamlMap?)?['remix'];
  if (remixDeclaration is! String) {
    stderr.writeln('remix_carbon must declare a hosted Remix constraint.');
    exitCode = 1;

    return;
  }

  final VersionConstraint constraint;
  try {
    constraint = VersionConstraint.parse(remixDeclaration);
  } on FormatException catch (error) {
    stderr.writeln('Invalid Remix constraint "$remixDeclaration": $error');
    exitCode = 1;

    return;
  }

  if (constraint is! VersionRange ||
      constraint.min == null ||
      !constraint.includeMin) {
    stderr.writeln(
      'Remix constraint "$remixDeclaration" needs an inclusive minimum so '
      'its consumer floor can be tested.',
    );
    exitCode = 1;

    return;
  }
  final remixFloor = constraint.min!;

  final dependencyLine = RegExp(
    r'^(\s{2}remix:\s*)\S+(\s*(?:#.*)?)$',
    multiLine: true,
  );
  if (dependencyLine.allMatches(pubspecContents).length != 1) {
    stderr.writeln(
      'Expected exactly one two-space-indented Remix dependency declaration.',
    );
    exitCode = 1;

    return;
  }

  final standalonePubspec = pubspecContents
      .replaceFirst(
        RegExp(r'^resolution:\s*workspace[ \t]*(?:\r?\n)?', multiLine: true),
        '',
      )
      .replaceFirstMapped(
        dependencyLine,
        (match) => '${match[1]}$remixFloor${match[2]}',
      );

  final flutter = _flutterExecutable();
  if (!flutter.existsSync()) {
    stderr.writeln(
      'Could not locate Flutter beside ${Platform.resolvedExecutable}. '
      'Run this checker with Flutter\'s bundled Dart SDK.',
    );
    exitCode = 64;

    return;
  }

  final tempRoot = Directory.systemTemp.createTempSync(
    'remix_carbon_consumer_',
  );
  final standaloneRoot = Directory('${tempRoot.path}/remix_carbon')
    ..createSync();
  try {
    File(
      '${standaloneRoot.path}/pubspec.yaml',
    ).writeAsStringSync(standalonePubspec);
    sourceOptions.copySync('${standaloneRoot.path}/analysis_options.yaml');
    _copyDirectory(sourceLibrary, Directory('${standaloneRoot.path}/lib'));

    final getResult = await Process.run(flutter.path, [
      'pub',
      'get',
    ], workingDirectory: standaloneRoot.path);
    if (getResult.exitCode != 0) {
      _reportProcessFailure('flutter pub get', getResult);

      return;
    }

    final lock =
        loadYaml(File('${standaloneRoot.path}/pubspec.lock').readAsStringSync())
            as YamlMap;
    final resolvedRemix = (lock['packages'] as YamlMap?)?['remix'];
    if (resolvedRemix is! YamlMap ||
        resolvedRemix['source'] != 'hosted' ||
        resolvedRemix['version'] != '$remixFloor') {
      stderr.writeln(
        'Standalone resolution must use hosted Remix $remixFloor; found '
        '${resolvedRemix ?? 'no Remix lock entry'}.',
      );
      exitCode = 1;

      return;
    }

    final analyzeResult = await Process.run(Platform.resolvedExecutable, [
      'analyze',
      'lib',
    ], workingDirectory: standaloneRoot.path);
    if (analyzeResult.exitCode != 0) {
      _reportProcessFailure('dart analyze lib', analyzeResult);

      return;
    }

    stdout.writeln(
      'Remix Carbon consumer validation passed against hosted Remix '
      '$remixFloor.',
    );
  } finally {
    if (tempRoot.existsSync()) tempRoot.deleteSync(recursive: true);
  }
}

File _flutterExecutable() {
  final flutterBin = File(
    Platform.resolvedExecutable,
  ).parent.parent.parent.parent;
  final executableName = Platform.isWindows ? 'flutter.bat' : 'flutter';

  return File('${flutterBin.path}/$executableName');
}

void _copyDirectory(Directory source, Directory destination) {
  destination.createSync(recursive: true);
  for (final entity in source.listSync(recursive: true, followLinks: false)) {
    final relativePath = entity.path.substring(source.path.length + 1);
    if (entity is Directory) {
      Directory(
        '${destination.path}/$relativePath',
      ).createSync(recursive: true);
    } else if (entity is File) {
      final output = File('${destination.path}/$relativePath');
      output.parent.createSync(recursive: true);
      entity.copySync(output.path);
    }
  }
}

void _reportProcessFailure(String command, ProcessResult result) {
  stderr.writeln('$command failed with exit code ${result.exitCode}.');
  final output = '${result.stdout}${result.stderr}'.trim();
  if (output.isNotEmpty) stderr.writeln(output);
  exitCode = result.exitCode == 0 ? 1 : result.exitCode;
}
