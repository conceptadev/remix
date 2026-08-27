import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:remix_cli/src/cli.dart';
import 'package:remix_cli/src/installer.dart';
import 'package:remix_cli/src/process_runner.dart';
import 'package:test/test.dart';

import 'test_support.dart';

void main() {
  late Directory root;

  setUp(() async {
    root = createFlutterPackage();
    await Installer(
      projectRoot: root,
      writeOut: (_) {},
    ).initialize(const InitOptions(prefix: 'Ui', uiPath: 'lib/ui'));
  });
  tearDown(() => root.deleteSync(recursive: true));

  test(
    'new add installs Theme before Button and runs exact processes',
    () async {
      final writer = RecordingFileWriter(root);
      final runner = happyRunner(root, addMissingDependencies: true);
      final output = <String>[];
      final installer = Installer(
        projectRoot: root,
        writeOut: output.add,
        processRunner: runner,
        fileWriter: writer,
      );

      await installer.add(
        const AddOptions(item: 'button', mode: AddMode.write),
      );

      expect(writer.paths, [
        'lib/ui/theme/tokens.dart',
        'lib/ui/theme/theme_data.dart',
        'lib/ui/theme/theme_scope.dart',
        'lib/ui/components/button.dart',
        'lib/ui/ui.dart',
      ]);
      expect(
        File(p.join(root.path, 'lib/ui/ui.dart')).readAsStringSync(),
        allOf(
          contains("export 'components/button.dart';"),
          contains("export 'theme/tokens.dart';\n\n$managedExportsEnd"),
        ),
      );
      expect(
        File(p.join(root.path, 'lib/ui/components/button.g.dart')).existsSync(),
        isTrue,
      );
      expect(runner.calls.map((call) => call.arguments.first), [
        '--version',
        'pub',
        'pub',
        'format',
        'run',
        'analyze',
      ]);
      expect(runner.calls[1].arguments, [
        'pub',
        'add',
        'remix@^1.0.0-beta.6',
        'mix_annotations@^2.2.0-beta.1',
        'dev:build_runner@^2.10.1',
        'dev:mix_generator@^2.2.0-beta.3',
      ]);
      expect(
        runner.calls[4].arguments,
        contains('--build-filter=lib/ui/components/button.g.dart'),
      );
      expect(runner.calls[5].arguments, ['analyze', 'lib/ui']);
    },
  );

  test(
    'identical add is a successful no-op for authored and generated files',
    () async {
      writeRequiredPubspec(root);
      writeRequiredLock(root);
      final firstRunner = happyRunner(root);
      await Installer(
        projectRoot: root,
        writeOut: (_) {},
        processRunner: firstRunner,
      ).add(const AddOptions(item: 'button', mode: AddMode.write));
      final before = snapshotFiles(root);

      final writer = RecordingFileWriter(root);
      final runner = happyRunner(root);
      final output = <String>[];
      await Installer(
        projectRoot: root,
        writeOut: output.add,
        processRunner: runner,
        fileWriter: writer,
      ).add(const AddOptions(item: 'button', mode: AddMode.write));

      expect(snapshotFiles(root), before);
      expect(writer.paths, isEmpty);
      expect(runner.calls.map((call) => call.arguments.first), [
        '--version',
        'pub',
        'analyze',
      ]);
      expect(output, contains('Preserved lib/ui/components/button.g.dart.'));
    },
  );

  test(
    'workspace members verify dependencies from the workspace lock',
    () async {
      final workspace = Directory.systemTemp.createTempSync(
        'remix_cli_workspace_test_',
      );
      addTearDown(() => workspace.deleteSync(recursive: true));
      final member = Directory(p.join(workspace.path, 'apps/consumer'))
        ..createSync(recursive: true);
      final remixMember = Directory(p.join(workspace.path, 'packages/remix'))
        ..createSync(recursive: true);
      Directory(p.join(member.path, 'lib')).createSync();
      File(p.join(workspace.path, 'pubspec.yaml')).writeAsStringSync('''
name: workspace
environment:
  sdk: ">=3.12.0 <4.0.0"
workspace:
  - apps/consumer
  - packages/remix
''');
      File(p.join(remixMember.path, 'pubspec.yaml')).writeAsStringSync('''
name: remix
version: 1.0.0-beta.6
environment:
  sdk: ">=3.11.0 <4.0.0"
''');
      writeRequiredPubspec(member);
      File(p.join(workspace.path, 'pubspec.lock')).writeAsStringSync('''
packages:
  mix_annotations:
    version: "2.2.0-beta.1"
  build_runner:
    version: "2.10.1"
  mix_generator:
    version: "2.2.0-beta.3"
''');
      final packageConfig = File(
        p.join(workspace.path, '.dart_tool/package_config.json'),
      )..createSync(recursive: true);
      packageConfig.writeAsStringSync('''
{
  "configVersion": 2,
  "packages": [
    {
      "name": "remix",
      "rootUri": "../packages/remix",
      "packageUri": "lib/"
    }
  ]
}
''');
      await Installer(
        projectRoot: member,
        writeOut: (_) {},
      ).initialize(const InitOptions(prefix: 'Ui', uiPath: 'lib/ui'));

      await Installer(
        projectRoot: member,
        writeOut: (_) {},
        processRunner: happyRunner(member, writeLockOnPubGet: false),
      ).add(const AddOptions(item: 'button', mode: AddMode.write));

      expect(
        File(p.join(member.path, 'lib/ui/components/button.dart')).existsSync(),
        isTrue,
      );
      expect(File(p.join(member.path, 'pubspec.lock')).existsSync(), isFalse);
    },
  );

  test('Button overwrite preserves every customized Theme byte', () async {
    await installButton(root);
    final theme = File(p.join(root.path, 'lib/ui/theme/tokens.dart'));
    final button = File(p.join(root.path, 'lib/ui/components/button.dart'));
    theme.writeAsStringSync('${theme.readAsStringSync()}// local theme\n');
    button.writeAsStringSync('${button.readAsStringSync()}// local button\n');
    final themeBytes = theme.readAsBytesSync();
    final writer = RecordingFileWriter(root);

    await Installer(
      projectRoot: root,
      writeOut: (_) {},
      processRunner: happyRunner(root),
      fileWriter: writer,
    ).add(const AddOptions(item: 'button', mode: AddMode.overwrite));

    expect(theme.readAsBytesSync(), themeBytes);
    expect(button.readAsStringSync(), isNot(contains('// local button')));
    expect(writer.paths, ['lib/ui/components/button.dart']);
  });

  test('partial dependency fails before processes or writes', () async {
    await installButton(root);
    File(p.join(root.path, 'lib/ui/theme/theme_data.dart')).deleteSync();
    final runner = happyRunner(root);
    final writer = RecordingFileWriter(root);

    await expectLater(
      Installer(
        projectRoot: root,
        writeOut: (_) {},
        processRunner: runner,
        fileWriter: writer,
      ).add(const AddOptions(item: 'button', mode: AddMode.write)),
      throwsFormatException,
    );

    expect(runner.calls, isEmpty);
    expect(writer.paths, isEmpty);
  });

  test(
    'a directory target collision fails before processes or writes',
    () async {
      final collision = Directory(p.join(root.path, 'lib/ui/theme/tokens.dart'))
        ..createSync(recursive: true);
      final runner = happyRunner(root);
      final writer = RecordingFileWriter(root);

      await expectLater(
        Installer(
          projectRoot: root,
          writeOut: (_) {},
          processRunner: runner,
          fileWriter: writer,
        ).add(const AddOptions(item: 'button', mode: AddMode.write)),
        throwsFormatException,
      );

      expect(collision.existsSync(), isTrue);
      expect(runner.calls, isEmpty);
      expect(writer.paths, isEmpty);
    },
  );

  test('a file in a target path fails before processes or writes', () async {
    final collision = File(p.join(root.path, 'lib/ui/theme'))
      ..writeAsStringSync('file');
    final runner = happyRunner(root);
    final writer = RecordingFileWriter(root);

    await expectLater(
      Installer(
        projectRoot: root,
        writeOut: (_) {},
        processRunner: runner,
        fileWriter: writer,
      ).add(const AddOptions(item: 'button', mode: AddMode.write)),
      throwsFormatException,
    );

    expect(collision.readAsStringSync(), 'file');
    expect(runner.calls, isEmpty);
    expect(writer.paths, isEmpty);
  });

  test(
    'dry-run prints a complete plan with zero project mutation or processes',
    () async {
      final before = snapshotFiles(root);
      final output = <String>[];
      final runner = happyRunner(root);

      await Installer(
        projectRoot: root,
        writeOut: output.add,
        processRunner: runner,
      ).add(const AddOptions(item: 'button', mode: AddMode.dryRun));

      expect(snapshotFiles(root), before);
      expect(runner.calls, isEmpty);
      expect(output.join('\n'), contains('Items: theme -> button'));
      expect(
        output.join('\n'),
        contains('Generated: lib/ui/components/button.g.dart'),
      );
    },
  );

  test('diff is read-only and formats only the proposal before Git', () async {
    await installButton(root);
    final button = File(p.join(root.path, 'lib/ui/components/button.dart'));
    button.writeAsStringSync('${button.readAsStringSync()}// local\n');
    final before = snapshotFiles(root);
    final runner = RecordingProcessRunner((invocation) async {
      if (invocation.executable == Platform.resolvedExecutable) {
        expect(invocation.arguments.first, 'format');
        expect(invocation.workingDirectory, isNot(root.path));
        return successProcessOutput;
      }
      expect(invocation.executable, 'git');
      expect(invocation.workingDirectory, isNot(root.path));
      expect(
        invocation.arguments,
        containsAllInOrder(['--', 'current', 'proposed']),
      );
      return const ProcessOutput(
        exitCode: 1,
        stdout: 'diff body\n',
        stderr: '',
      );
    });
    final output = <String>[];

    await Installer(
      projectRoot: root,
      writeOut: output.add,
      processRunner: runner,
    ).add(const AddOptions(item: 'button', mode: AddMode.diff));

    expect(snapshotFiles(root), before);
    expect(runner.calls, hasLength(2));
    expect(output.last, 'diff body');
  });

  test(
    'diff after a clean long-prefix install has no formatter-only changes',
    () async {
      final caseRoot = createFlutterPackage();
      addTearDown(() => caseRoot.deleteSync(recursive: true));
      await Installer(
        projectRoot: caseRoot,
        writeOut: (_) {},
      ).initialize(const InitOptions(prefix: 'Playground', uiPath: 'lib/ui'));
      writeRequiredPubspec(caseRoot);
      writeRequiredLock(caseRoot);
      await Installer(
        projectRoot: caseRoot,
        writeOut: (_) {},
        processRunner: happyRunner(caseRoot, runRealFormatter: true),
      ).add(const AddOptions(item: 'button', mode: AddMode.write));
      final before = snapshotFiles(caseRoot);
      final output = <String>[];

      await Installer(
        projectRoot: caseRoot,
        writeOut: output.add,
      ).add(const AddOptions(item: 'button', mode: AddMode.diff));

      expect(snapshotFiles(caseRoot), before);
      expect(output.last, 'No authored-source differences.');
    },
  );

  test('missing Git fails clearly without project mutation', () async {
    await installButton(root);
    final before = snapshotFiles(root);
    final runner = RecordingProcessRunner((invocation) {
      if (invocation.executable == Platform.resolvedExecutable) {
        return Future.value(successProcessOutput);
      }
      throw ProcessException('git', invocation.arguments);
    });

    await expectLater(
      Installer(
        projectRoot: root,
        writeOut: (_) {},
        processRunner: runner,
      ).add(const AddOptions(item: 'theme', mode: AddMode.diff)),
      throwsFormatException,
    );
    expect(snapshotFiles(root), before);
  });

  test('pub failure occurs before authored-source writes', () async {
    writeRequiredPubspec(root);
    final writer = RecordingFileWriter(root);
    final runner = happyRunner(root, failStage: 'pub get');

    await expectLater(
      Installer(
        projectRoot: root,
        writeOut: (_) {},
        processRunner: runner,
        fileWriter: writer,
      ).add(const AddOptions(item: 'button', mode: AddMode.write)),
      throwsStateError,
    );

    expect(writer.paths, isEmpty);
    expect(
      Directory(p.join(root.path, 'lib/ui/components')).existsSync(),
      isFalse,
    );
  });

  test('codegen and analysis failures retain inspectable source', () async {
    for (final stage in ['build', 'analyze']) {
      final caseRoot = createFlutterPackage();
      addTearDown(() => caseRoot.deleteSync(recursive: true));
      await Installer(
        projectRoot: caseRoot,
        writeOut: (_) {},
      ).initialize(const InitOptions(prefix: 'Ui', uiPath: 'lib/ui'));
      writeRequiredPubspec(caseRoot);
      writeRequiredLock(caseRoot);

      await expectLater(
        Installer(
          projectRoot: caseRoot,
          writeOut: (_) {},
          processRunner: happyRunner(caseRoot, failStage: stage),
        ).add(const AddOptions(item: 'button', mode: AddMode.write)),
        throwsStateError,
        reason: stage,
      );

      expect(
        File(
          p.join(caseRoot.path, 'lib/ui/components/button.dart'),
        ).existsSync(),
        isTrue,
      );
    }
  });

  test(
    'malformed barrel and incompatible hosted constraint fail preflight',
    () async {
      final barrel = File(p.join(root.path, 'lib/ui/ui.dart'));
      barrel.writeAsStringSync('library;\n');
      final runner = happyRunner(root);
      await expectLater(
        Installer(
          projectRoot: root,
          writeOut: (_) {},
          processRunner: runner,
        ).add(const AddOptions(item: 'button', mode: AddMode.write)),
        throwsFormatException,
      );
      expect(runner.calls, isEmpty);

      barrel.writeAsStringSync(emptyManagedBarrel);
      writeRequiredPubspec(root, remix: '^0.9.0');
      await expectLater(
        Installer(
          projectRoot: root,
          writeOut: (_) {},
          processRunner: runner,
        ).add(const AddOptions(item: 'button', mode: AddMode.write)),
        throwsFormatException,
      );
      expect(runner.calls, isEmpty);
    },
  );

  test(
    'compatible non-hosted declarations and overrides stay byte-identical',
    () async {
      final declarations = [
        '''  remix:
    path: ../remix
''',
        '''  remix:
    git: https://example.test/remix.git
''',
        '''  remix:
    hosted: https://packages.example.test
    version: ^1.0.0-beta.6
''',
      ];
      for (final declaration in declarations) {
        final caseRoot = createFlutterPackage();
        addTearDown(() => caseRoot.deleteSync(recursive: true));
        await Installer(
          projectRoot: caseRoot,
          writeOut: (_) {},
        ).initialize(const InitOptions(prefix: 'Ui', uiPath: 'lib/ui'));
        final pubspec = File(p.join(caseRoot.path, 'pubspec.yaml'))
          ..writeAsStringSync('''name: consumer
environment:
  sdk: ">=3.12.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
$declaration  mix_annotations: ^2.2.0-beta.1
dev_dependencies:
  build_runner: ^2.10.1
  mix_generator: ^2.2.0-beta.3
dependency_overrides:
  remix:
    path: ../local-remix
''');
        final before = pubspec.readAsBytesSync();
        writeRequiredLock(caseRoot);
        final runner = happyRunner(caseRoot);

        await Installer(
          projectRoot: caseRoot,
          writeOut: (_) {},
          processRunner: runner,
        ).add(const AddOptions(item: 'button', mode: AddMode.write));

        expect(pubspec.readAsBytesSync(), before, reason: declaration);
        expect(
          runner.calls.where(
            (call) => call.arguments.take(2).join(' ') == 'pub add',
          ),
          isEmpty,
        );
      }
    },
  );

  test(
    'incompatible resolved path version aborts before source writes',
    () async {
      final pubspec = File(p.join(root.path, 'pubspec.yaml'))
        ..writeAsStringSync('''name: consumer
environment:
  sdk: ">=3.12.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
  remix:
    path: ../remix
  mix_annotations: ^2.2.0-beta.1
dev_dependencies:
  build_runner: ^2.10.1
  mix_generator: ^2.2.0-beta.3
''');
      final before = pubspec.readAsBytesSync();
      writeRequiredLock(root, remix: '0.9.0');
      final writer = RecordingFileWriter(root);

      await expectLater(
        Installer(
          projectRoot: root,
          writeOut: (_) {},
          processRunner: happyRunner(root, writeLockOnPubGet: false),
          fileWriter: writer,
        ).add(const AddOptions(item: 'button', mode: AddMode.write)),
        throwsStateError,
      );

      expect(pubspec.readAsBytesSync(), before);
      expect(writer.paths, isEmpty);
    },
  );

  test(
    'runtime requirements declared only under dev_dependencies fail preflight',
    () async {
      for (final runtime in ['remix', 'mix_annotations']) {
        final caseRoot = createFlutterPackage();
        addTearDown(() => caseRoot.deleteSync(recursive: true));
        await Installer(
          projectRoot: caseRoot,
          writeOut: (_) {},
        ).initialize(const InitOptions(prefix: 'Ui', uiPath: 'lib/ui'));
        File(p.join(caseRoot.path, 'pubspec.yaml')).writeAsStringSync(
          runtime == 'remix'
              ? '''name: consumer
environment:
  sdk: ">=3.12.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
  mix_annotations: ^2.2.0-beta.1
dev_dependencies:
  remix: ^1.0.0-beta.6
  build_runner: ^2.10.1
  mix_generator: ^2.2.0-beta.3
'''
              : '''name: consumer
environment:
  sdk: ">=3.12.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
  remix: ^1.0.0-beta.6
dev_dependencies:
  mix_annotations: ^2.2.0-beta.1
  build_runner: ^2.10.1
  mix_generator: ^2.2.0-beta.3
''',
        );
        writeRequiredLock(caseRoot);
        final before = snapshotFiles(caseRoot);
        final runner = happyRunner(caseRoot);
        final writer = RecordingFileWriter(caseRoot);

        await expectLater(
          Installer(
            projectRoot: caseRoot,
            writeOut: (_) {},
            processRunner: runner,
            fileWriter: writer,
          ).add(const AddOptions(item: 'button', mode: AddMode.write)),
          throwsA(
            isFormatException.having(
              (error) => error.message,
              'message',
              allOf(
                contains(runtime),
                contains('dev_dependencies'),
                contains('Move $runtime to dependencies'),
                contains('No source was written'),
              ),
            ),
          ),
          reason: runtime,
        );

        expect(snapshotFiles(caseRoot), before, reason: runtime);
        expect(runner.calls, isEmpty, reason: runtime);
        expect(writer.paths, isEmpty, reason: runtime);
      }
    },
  );

  test(
    'development requirements are satisfied by the regular dependency section',
    () async {
      final pubspec = File(p.join(root.path, 'pubspec.yaml'))
        ..writeAsStringSync('''name: consumer
environment:
  sdk: ">=3.12.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
  remix: ^1.0.0-beta.6
  mix_annotations: ^2.2.0-beta.1
  build_runner: ^2.10.1
  mix_generator: ^2.2.0-beta.3
''');
      final before = pubspec.readAsBytesSync();
      writeRequiredLock(root);
      final runner = happyRunner(root);

      await Installer(
        projectRoot: root,
        writeOut: (_) {},
        processRunner: runner,
      ).add(const AddOptions(item: 'button', mode: AddMode.write));

      expect(pubspec.readAsBytesSync(), before);
      expect(
        runner.calls.where(
          (call) => call.arguments.take(2).join(' ') == 'pub add',
        ),
        isEmpty,
      );
    },
  );

  test('a requirement declared in both sections fails preflight', () async {
    File(p.join(root.path, 'pubspec.yaml')).writeAsStringSync('''name: consumer
environment:
  sdk: ">=3.12.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
  remix: ^1.0.0-beta.6
  mix_annotations: ^2.2.0-beta.1
dev_dependencies:
  remix: ^1.0.0-beta.6
  build_runner: ^2.10.1
  mix_generator: ^2.2.0-beta.3
''');
    writeRequiredLock(root);
    final before = snapshotFiles(root);
    final runner = happyRunner(root);
    final writer = RecordingFileWriter(root);

    await expectLater(
      Installer(
        projectRoot: root,
        writeOut: (_) {},
        processRunner: runner,
        fileWriter: writer,
      ).add(const AddOptions(item: 'button', mode: AddMode.write)),
      throwsA(
        isFormatException.having(
          (error) => error.message,
          'message',
          allOf(
            contains('remix'),
            contains('both dependencies and dev_dependencies'),
            contains('No source was written'),
          ),
        ),
      ),
    );

    expect(snapshotFiles(root), before);
    expect(runner.calls, isEmpty);
    expect(writer.paths, isEmpty);
  });

  test('overwriting a missing item reports it as added', () async {
    writeRequiredPubspec(root);
    writeRequiredLock(root);
    final output = <String>[];

    await Installer(
      projectRoot: root,
      writeOut: output.add,
      processRunner: happyRunner(root),
    ).add(const AddOptions(item: 'button', mode: AddMode.overwrite));

    expect(output, containsAll(['Added theme.', 'Added button.']));
  });

  test(
    'overwriting an installed item reports it as updated and keeps its dependencies preserved',
    () async {
      await installButton(root);
      final output = <String>[];

      await Installer(
        projectRoot: root,
        writeOut: output.add,
        processRunner: happyRunner(root),
      ).add(const AddOptions(item: 'button', mode: AddMode.overwrite));

      expect(output, containsAll(['Preserved theme.', 'Updated button.']));
    },
  );

  test(
    'overwriting a partially installed item reports it as updated',
    () async {
      await installButton(root);
      File(p.join(root.path, 'lib/ui/theme/tokens.dart')).deleteSync();
      final output = <String>[];

      await Installer(
        projectRoot: root,
        writeOut: output.add,
        processRunner: happyRunner(root),
      ).add(const AddOptions(item: 'theme', mode: AddMode.overwrite));

      expect(output, contains('Updated theme.'));
    },
  );
}

Future<void> installButton(Directory root) async {
  writeRequiredPubspec(root);
  writeRequiredLock(root);
  await Installer(
    projectRoot: root,
    writeOut: (_) {},
    processRunner: happyRunner(root),
  ).add(const AddOptions(item: 'button', mode: AddMode.write));
}

RecordingProcessRunner happyRunner(
  Directory root, {
  bool addMissingDependencies = false,
  bool writeLockOnPubGet = true,
  bool runRealFormatter = false,
  String? failStage,
}) => RecordingProcessRunner((invocation) async {
  if (invocation.executable == 'flutter' &&
      invocation.arguments.join(' ') == '--version --machine') {
    return ProcessOutput(
      exitCode: 0,
      stdout: fakeFlutterMachineJson(root),
      stderr: '',
    );
  }
  final command = invocation.arguments.join(' ');
  if (command.startsWith('pub add')) {
    if (failStage == 'pub add') {
      return const ProcessOutput(
        exitCode: 1,
        stdout: '',
        stderr: 'pub add failed',
      );
    }
    if (addMissingDependencies) writeRequiredPubspec(root);
    return successProcessOutput;
  }
  if (command == 'pub get') {
    if (failStage == 'pub get') {
      return const ProcessOutput(
        exitCode: 1,
        stdout: '',
        stderr: 'pub get failed',
      );
    }
    if (writeLockOnPubGet) writeRequiredLock(root);
    return successProcessOutput;
  }
  if (command.startsWith('format ')) {
    if (!runRealFormatter) return successProcessOutput;
    return const SystemProcessRunner().run(
      ProcessInvocation(
        executable: Platform.resolvedExecutable,
        arguments: invocation.arguments,
        workingDirectory: invocation.workingDirectory,
      ),
    );
  }
  if (command.startsWith('run build_runner build')) {
    if (failStage == 'build') {
      return const ProcessOutput(
        exitCode: 1,
        stdout: '',
        stderr: 'build failed',
      );
    }
    for (final filter in invocation.arguments.where(
      (argument) => argument.startsWith('--build-filter='),
    )) {
      File(
          p.joinAll([
            root.path,
            ...p.posix.split(filter.substring('--build-filter='.length)),
          ]),
        )
        ..createSync(recursive: true)
        ..writeAsStringSync('// generated\n');
    }
    return successProcessOutput;
  }
  if (command.startsWith('analyze ')) {
    if (failStage == 'analyze') {
      return const ProcessOutput(
        exitCode: 1,
        stdout: '',
        stderr: 'analyze failed',
      );
    }
    return successProcessOutput;
  }
  throw StateError('Unexpected process: ${invocation.display}');
});
