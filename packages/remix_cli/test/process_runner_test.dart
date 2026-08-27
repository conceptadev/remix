import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:remix_cli/src/process_runner.dart';
import 'package:test/test.dart';

void main() {
  test('SystemProcessRunner passes every argument without a shell', () async {
    final root = Directory.systemTemp.createTempSync('remix_process_test_');
    addTearDown(() => root.deleteSync(recursive: true));
    final script = File(p.join(root.path, 'arguments.dart'))
      ..writeAsStringSync('''import 'dart:convert';
import 'dart:io';
void main(List<String> arguments) => stdout.write(jsonEncode(arguments));
''');

    final output = await const SystemProcessRunner().run(
      ProcessInvocation(
        executable: Platform.resolvedExecutable,
        arguments: [script.path, 'two words', r'$HOME', '; echo unsafe'],
        workingDirectory: root.path,
      ),
    );

    expect(output.exitCode, 0);
    expect(output.stdout, '["two words","\$HOME","; echo unsafe"]');
    expect(output.stderr, isEmpty);
  });

  test('ProcessFailure reports the exact invocation and diagnostics', () {
    const invocation = ProcessInvocation(
      executable: '/sdk/dart',
      arguments: ['analyze', 'lib/ui'],
      workingDirectory: '/project',
    );
    const failure = ProcessFailure(
      invocation,
      ProcessOutput(exitCode: 2, stdout: '', stderr: 'bad source'),
      detail: 'Analysis failed',
    );

    expect(failure.toString(), contains('/sdk/dart analyze lib/ui'));
    expect(failure.toString(), contains('bad source'));
  });
}
