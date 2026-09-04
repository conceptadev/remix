import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:remix_cli/src/cli.dart';
import 'package:remix_cli/src/installer.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'test_support.dart';

void main() {
  test(
    'the active Flutter SDK previews and installs editable source',
    () async {
      final root = createFlutterPackage();
      addTearDown(() => root.deleteSync(recursive: true));
      final output = <String>[];
      final installer = Installer(projectRoot: root, writeOut: output.add);

      expect(
        await runRemixCli(
          [
            'init',
            '--prefix',
            'Acme',
            '--ui-path',
            'lib/design system [brand] #1',
          ],
          writeOut: output.add,
          writeError: fail,
          onInit: installer.initialize,
        ),
        successExitCode,
      );
      final before = snapshotFiles(root);
      output.clear();

      await installer.add(const AddOptions(item: 'button', mode: AddMode.diff));

      expect(output.join('\n'), contains('AcmeButton'));
      expect(output.join('\n'), contains('components/button.dart'));
      expect(snapshotFiles(root), before);

      final remixRoot = Directory(p.join('..', 'remix')).absolute.path;
      File(p.join(root.path, 'pubspec_overrides.yaml')).writeAsStringSync('''
dependency_overrides:
  remix:
    path: ${jsonEncode(remixRoot)}
''');
      await installer.add(
        const AddOptions(item: 'button', mode: AddMode.write),
      );

      final pubspec =
          loadYaml(File(p.join(root.path, 'pubspec.yaml')).readAsStringSync())
              as YamlMap;
      expect(
        (pubspec['dependencies'] as YamlMap)['remix'],
        registryRemixConstraint,
      );

      final button = File(
        p.join(
          root.path,
          'lib/design system [brand] #1/components/button.dart',
        ),
      );
      expect(button.readAsStringSync(), contains('AcmeButtonVariant'));
      expect(
        File(
          p.join(
            root.path,
            'lib/design system [brand] #1/components/button.g.dart',
          ),
        ).readAsStringSync(),
        contains('class AcmeButton'),
      );
      button.writeAsStringSync(
        '${button.readAsStringSync()}\n// Application edit.\n',
      );
      final edited = button.readAsBytesSync();
      await installer.add(
        const AddOptions(item: 'button', mode: AddMode.write),
      );
      expect(button.readAsBytesSync(), edited);
    },
    timeout: const Timeout(Duration(minutes: 3)),
  );
}
