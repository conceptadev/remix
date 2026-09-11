import 'dart:io';

import 'package:remix_cli/src/cli.dart';
import 'package:remix_cli/src/installer.dart';

Future<void> main(List<String> arguments) async {
  final installer = Installer(
    projectRoot: Directory.current,
    writeOut: stdout.writeln,
  );
  exitCode = await runRemixCli(
    arguments,
    writeOut: stdout.writeln,
    writeError: stderr.writeln,
    onInit: installer.initialize,
    onAdd: installer.add,
  );
}
