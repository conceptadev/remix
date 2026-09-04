import 'package:args/command_runner.dart';

import 'version.dart';

/// Conventional successful process exit.
const successExitCode = 0;

/// Conventional command-line usage failure.
const usageExitCode = 64;

/// A runtime failure after valid command parsing.
const failureExitCode = 1;

typedef LineWriter = void Function(String line);

typedef InitHandler = Future<void> Function(InitOptions options);
typedef AddHandler = Future<void> Function(AddOptions options);

final class InitOptions {
  const InitOptions({required this.prefix, required this.uiPath});

  final String prefix;
  final String uiPath;
}

enum AddMode { write, dryRun, diff, overwrite }

final class AddOptions {
  const AddOptions({required this.item, required this.mode});

  final String item;
  final AddMode mode;
}

Future<int> runRemixCli(
  List<String> arguments, {
  required LineWriter writeOut,
  required LineWriter writeError,
  InitHandler? onInit,
  AddHandler? onAdd,
}) async {
  final runner =
      CommandRunner<int>('remix', 'Install editable Remix UI source.')
        ..argParser.addFlag(
          'version',
          negatable: false,
          help: 'Print the remix_cli version.',
        )
        ..addCommand(_InitCommand(onInit))
        ..addCommand(_AddCommand(onAdd));

  final helpCode = _writeRequestedHelp(
    arguments,
    runner: runner,
    writeOut: writeOut,
    writeError: writeError,
  );
  if (helpCode != null) return helpCode;

  if (arguments.contains('--version')) {
    if (arguments.length != 1) {
      writeError('The --version option cannot be combined with a command.');
      return usageExitCode;
    }
    writeOut(remixCliVersion);
    return successExitCode;
  }

  if (arguments.isEmpty) {
    writeError(runner.usage);
    return usageExitCode;
  }

  try {
    // CommandRunner already prints help when it returns no command result.
    return await runner.run(arguments) ?? successExitCode;
  } on UsageException catch (error) {
    writeError(error.message);
    writeError(error.usage);
    return usageExitCode;
  } on Object catch (error) {
    writeError(error.toString());
    return failureExitCode;
  }
}

int? _writeRequestedHelp(
  List<String> arguments, {
  required CommandRunner<int> runner,
  required LineWriter writeOut,
  required LineWriter writeError,
}) {
  // Route the common help forms through the injected output callback.
  if (arguments.length == 1 &&
      (arguments.single == '--help' ||
          arguments.single == '-h' ||
          arguments.single == 'help')) {
    writeOut(runner.usage);
    return successExitCode;
  }

  String? commandName;
  if (arguments.length == 2 && arguments.first == 'help') {
    commandName = arguments.last;
  } else if (arguments.length == 2 &&
      (arguments.last == '--help' || arguments.last == '-h')) {
    commandName = arguments.first;
  }
  if (commandName == null) return null;

  final command = runner.commands[commandName];
  if (command == null || commandName == 'help') {
    writeError('Could not find a command named "$commandName".');
    writeError(runner.usage);
    return usageExitCode;
  }
  writeOut(command.usage);
  return successExitCode;
}

final class _InitCommand extends Command<int> {
  _InitCommand(this._handler) {
    argParser
      ..addOption('prefix', defaultsTo: 'Ui')
      ..addOption('ui-path', defaultsTo: 'lib/ui');
  }

  final InitHandler? _handler;

  @override
  String get name => 'init';

  @override
  String get description => 'Initialize Remix source installation settings.';

  @override
  Future<int> run() async {
    if (argResults!.rest.isNotEmpty) {
      usageException('init accepts no positional arguments.');
    }
    final handler = _handler;
    if (handler == null) {
      throw StateError('The init command is not available.');
    }
    await handler(
      InitOptions(
        prefix: argResults!.option('prefix')!,
        uiPath: argResults!.option('ui-path')!,
      ),
    );
    return successExitCode;
  }
}

final class _AddCommand extends Command<int> {
  _AddCommand(this._handler) {
    argParser
      ..addFlag('dry-run', negatable: false)
      ..addFlag('diff', negatable: false)
      ..addFlag('overwrite', negatable: false);
  }

  final AddHandler? _handler;

  @override
  String get name => 'add';

  @override
  String get description => 'Install one bundled registry item.';

  @override
  Future<int> run() async {
    final positional = argResults!.rest;
    if (positional.length != 1) {
      usageException('add requires exactly one item.');
    }

    final modes = <AddMode>[
      if (argResults!.flag('dry-run')) AddMode.dryRun,
      if (argResults!.flag('diff')) AddMode.diff,
      if (argResults!.flag('overwrite')) AddMode.overwrite,
    ];
    if (modes.length > 1) {
      usageException(
        '--dry-run, --diff, and --overwrite are mutually exclusive.',
      );
    }

    final handler = _handler;
    if (handler == null) {
      throw StateError('The add command is not available.');
    }
    await handler(
      AddOptions(
        item: positional.single,
        mode: modes.isEmpty ? AddMode.write : modes.single,
      ),
    );
    return successExitCode;
  }
}
