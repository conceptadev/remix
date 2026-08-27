import 'package:remix_cli/src/cli.dart';
import 'package:remix_cli/src/installer.dart';
import 'package:test/test.dart';

import 'test_support.dart';

void main() {
  test(
    'CLI add dry-run uses the initialized installer without processes',
    () async {
      final root = createFlutterPackage();
      addTearDown(() => root.deleteSync(recursive: true));
      final output = <String>[];
      final runner = RecordingProcessRunner(
        (invocation) => throw StateError('Unexpected ${invocation.display}'),
      );
      final installer = Installer(
        projectRoot: root,
        writeOut: output.add,
        processRunner: runner,
      );
      await installer.initialize(
        const InitOptions(prefix: 'Ui', uiPath: 'lib/ui'),
      );

      final code = await runRemixCli(
        ['add', 'button', '--dry-run'],
        writeOut: output.add,
        writeError: fail,
        onAdd: installer.add,
      );

      expect(code, successExitCode);
      expect(output.join('\n'), contains('Items: theme -> button'));
      expect(runner.calls, isEmpty);
    },
  );

  test('unknown item fails without project writes or processes', () async {
    final root = createFlutterPackage();
    addTearDown(() => root.deleteSync(recursive: true));
    final runner = RecordingProcessRunner(
      (invocation) => throw StateError('Unexpected ${invocation.display}'),
    );
    final installer = Installer(
      projectRoot: root,
      writeOut: (_) {},
      processRunner: runner,
    );
    await installer.initialize(
      const InitOptions(prefix: 'Ui', uiPath: 'lib/ui'),
    );
    final before = snapshotFiles(root);
    final errors = <String>[];

    final code = await runRemixCli(
      ['add', 'missing'],
      writeOut: (_) {},
      writeError: errors.add,
      onAdd: installer.add,
    );

    expect(code, failureExitCode);
    expect(errors.single, contains('Unknown registry item'));
    expect(snapshotFiles(root), before);
    expect(runner.calls, isEmpty);
  });
}
