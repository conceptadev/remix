import 'dart:io';

import 'package:remix_cli/src/cli.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  test('--help prints usage successfully', () async {
    final output = <String>[];

    final code = await runRemixCli(
      ['--help'],
      writeOut: output.add,
      writeError: fail,
    );

    expect(code, successExitCode);
    expect(output.join('\n'), contains('Usage: remix <command>'));
  });

  test('bare help prints usage exactly once', () async {
    final output = <String>[];

    final code = await runRemixCli(
      ['help'],
      writeOut: output.add,
      writeError: fail,
    );

    expect(code, successExitCode);
    expect(
      'Usage: remix <command>'.allMatches(output.join('\n')).length,
      1,
      reason: 'CommandRunner help plus the null-result fallback printed twice.',
    );
  });

  test('command help is routed through the injected writer', () async {
    final output = <String>[];

    final code = await runRemixCli(
      ['init', '--help'],
      writeOut: output.add,
      writeError: fail,
    );

    expect(code, successExitCode);
    expect(output.join('\n'), contains('Usage: remix init'));
  });

  test('help after command arguments prints command usage once', () async {
    for (final arguments in [
      ['add', 'button', '--help'],
      ['init', '--prefix', 'Acme', '--help'],
    ]) {
      final result = await Process.run(Platform.resolvedExecutable, [
        'run',
        'bin/remix.dart',
        ...arguments,
      ]);

      expect(result.exitCode, successExitCode);
      expect(result.stderr, isEmpty);
      expect('Usage: remix '.allMatches(result.stdout as String), hasLength(1));
      expect(result.stdout, contains('Usage: remix ${arguments.first}'));
      expect(result.stdout, isNot(contains('Usage: remix <command>')));
    }
  });

  test('missing and unknown commands are usage errors', () async {
    final errors = <String>[];

    expect(
      await runRemixCli([], writeOut: fail, writeError: errors.add),
      usageExitCode,
    );
    expect(errors.join('\n'), contains('Usage: remix <command>'));

    errors.clear();
    expect(
      await runRemixCli(['unknown'], writeOut: fail, writeError: errors.add),
      usageExitCode,
    );
    expect(errors.join('\n'), contains('Could not find a command named'));
  });

  test('--version agrees with pubspec.yaml', () async {
    final output = <String>[];
    final pubspec =
        loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;

    final code = await runRemixCli(
      ['--version'],
      writeOut: output.add,
      writeError: fail,
    );

    expect(code, successExitCode);
    expect(output, [pubspec['version']]);
  });

  test('init dispatches parsed defaults and custom values', () async {
    InitOptions? received;
    Future<void> onInit(InitOptions options) async => received = options;

    expect(
      await runRemixCli(
        ['init'],
        writeOut: fail,
        writeError: fail,
        onInit: onInit,
      ),
      successExitCode,
    );
    expect(received!.prefix, 'Ui');
    expect(received!.preset, 'default');
    expect(received!.uiPath, 'lib/ui');

    await runRemixCli(
      [
        'init',
        '--prefix',
        'Acme',
        '--preset',
        'default',
        '--ui-path',
        'lib/design_system',
      ],
      writeOut: fail,
      writeError: fail,
      onInit: onInit,
    );
    expect(received!.prefix, 'Acme');
    expect(received!.preset, 'default');
    expect(received!.uiPath, 'lib/design_system');
  });

  test('add dispatches one item and mode', () async {
    AddOptions? received;

    final code = await runRemixCli(
      ['add', 'button', '--diff'],
      writeOut: fail,
      writeError: fail,
      onAdd: (options) async => received = options,
    );

    expect(code, successExitCode);
    expect(received!.item, 'button');
    expect(received!.mode, AddMode.diff);
  });

  test('mutually exclusive add modes fail before dispatch', () async {
    var dispatched = false;
    final errors = <String>[];

    final code = await runRemixCli(
      ['add', 'button', '--dry-run', '--overwrite'],
      writeOut: fail,
      writeError: errors.add,
      onAdd: (_) async => dispatched = true,
    );

    expect(code, usageExitCode);
    expect(dispatched, isFalse);
    expect(errors.join('\n'), contains('mutually exclusive'));
  });

  test('runtime handler failures use a stable failure exit', () async {
    final errors = <String>[];

    final code = await runRemixCli(
      ['init'],
      writeOut: fail,
      writeError: errors.add,
      onInit: (_) async => throw StateError('broken'),
    );

    expect(code, failureExitCode);
    expect(errors.single, contains('broken'));
  });
}
