import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:remix_cli/src/installer.dart';
import 'package:remix_cli/src/process_runner.dart';
import 'package:yaml/yaml.dart';

/// The `remix` constraint the bundled registry declares, read from the file
/// itself rather than restated here.
///
/// A literal copy would go stale on the next `remix` bump and fail every
/// fixture in this suite with `does not satisfy`, inside the release pull
/// request a bot opened. Deriving it means the bump moves one line.
final String registryRemixConstraint = _readRegistryRemixConstraint();

/// The lowest `remix` version [registryRemixConstraint] admits.
///
/// `tool/check_version_alignment.dart` holds this equal to the version in
/// `packages/remix/pubspec.yaml`, so it is also the version the registry
/// templates were authored against.
final Version registryRemixFloor =
    (VersionConstraint.parse(registryRemixConstraint) as VersionRange).min!;

String _readRegistryRemixConstraint() {
  // `dart test` runs with the package root as the current directory.
  final document = loadYaml(
    File(p.join('lib', 'src', 'registry', 'registry.yaml')).readAsStringSync(),
  );
  final items = (document as YamlMap)['items'] as YamlMap;
  for (final item in items.values) {
    final dependencies = (item as YamlMap)['dependencies'];
    if (dependencies is YamlMap && dependencies['remix'] is String) {
      return dependencies['remix'] as String;
    }
  }
  throw StateError('registry.yaml declares no remix constraint.');
}

Directory createFlutterPackage() {
  final root = Directory.systemTemp.createTempSync('remix_cli_test_');
  File(p.join(root.path, 'pubspec.yaml')).writeAsStringSync('''name: consumer
environment:
  sdk: ">=3.12.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
''');
  Directory(p.join(root.path, 'lib')).createSync();
  return root;
}

Map<String, List<int>> snapshotFiles(Directory root) {
  final snapshot = <String, List<int>>{};
  for (final entity in root.listSync(recursive: true)) {
    if (entity is File) {
      snapshot[p.relative(entity.path, from: root.path)] = entity
          .readAsBytesSync();
    }
  }
  return snapshot;
}

void writeRequiredPubspec(
  Directory root, {
  String? remix,
  String mixAnnotations = '^2.2.0-beta.1',
  String? remixUiIcons,
  String buildRunner = '^2.10.1',
  String mixGenerator = '^2.2.0-beta.3',
}) {
  final remixUiIconsDependency = remixUiIcons == null
      ? ''
      : '  remix_ui_icons: $remixUiIcons\n';
  File(p.join(root.path, 'pubspec.yaml')).writeAsStringSync('''name: consumer
environment:
  sdk: ">=3.12.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
  remix: ${remix ?? registryRemixConstraint}
  mix_annotations: $mixAnnotations
${remixUiIconsDependency}dev_dependencies:
  build_runner: $buildRunner
  mix_generator: $mixGenerator
''');
}

void writeRequiredLock(
  Directory root, {
  String? remix,
  String mixAnnotations = '2.2.0-beta.1',
  String? remixUiIcons,
  String buildRunner = '2.10.1',
  String mixGenerator = '2.2.0-beta.3',
}) {
  final remixUiIconsPackage = remixUiIcons == null
      ? ''
      : '  remix_ui_icons:\n    version: "$remixUiIcons"\n';
  File(p.join(root.path, 'pubspec.lock')).writeAsStringSync('''packages:
  remix:
    version: "${remix ?? registryRemixFloor}"
  mix_annotations:
    version: "$mixAnnotations"
${remixUiIconsPackage}  build_runner:
    version: "$buildRunner"
  mix_generator:
    version: "$mixGenerator"
''');
}

final class RecordingProcessRunner implements ProcessRunner {
  RecordingProcessRunner(this.handler);

  final Future<ProcessOutput> Function(ProcessInvocation invocation) handler;
  final calls = <ProcessInvocation>[];

  @override
  Future<ProcessOutput> run(ProcessInvocation invocation) {
    calls.add(invocation);
    return handler(invocation);
  }
}

const successProcessOutput = ProcessOutput(exitCode: 0, stdout: '', stderr: '');

String fakeFlutterMachineJson(Directory root) =>
    '{"flutterRoot":"${root.path}","frameworkVersion":"3.44.0"}';

final class RecordingFileWriter implements ProjectFileWriter {
  RecordingFileWriter(this.root);

  final Directory root;
  final paths = <String>[];
  final AtomicProjectFileWriter _delegate = const AtomicProjectFileWriter();

  @override
  void write(File target, String contents) {
    paths.add(p.relative(target.path, from: root.path));
    _delegate.write(target, contents);
  }
}
