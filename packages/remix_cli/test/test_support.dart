import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:remix_cli/src/installer.dart';
import 'package:remix_cli/src/process_runner.dart';

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
  String remix = '^1.0.0-beta.6',
  String mixAnnotations = '^2.2.0-beta.1',
  String buildRunner = '^2.10.1',
  String mixGenerator = '^2.2.0-beta.3',
}) {
  File(p.join(root.path, 'pubspec.yaml')).writeAsStringSync('''name: consumer
environment:
  sdk: ">=3.12.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
  remix: $remix
  mix_annotations: $mixAnnotations
dev_dependencies:
  build_runner: $buildRunner
  mix_generator: $mixGenerator
''');
}

void writeRequiredLock(
  Directory root, {
  String remix = '1.0.0-beta.6',
  String mixAnnotations = '2.2.0-beta.1',
  String buildRunner = '2.10.1',
  String mixGenerator = '2.2.0-beta.3',
}) {
  File(p.join(root.path, 'pubspec.lock')).writeAsStringSync('''packages:
  remix:
    version: "$remix"
  mix_annotations:
    version: "$mixAnnotations"
  build_runner:
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
