import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:remix_cli/src/project_config.dart';
import 'package:test/test.dart';

import 'test_support.dart';

void main() {
  late Directory root;

  setUp(() => root = createFlutterPackage());
  tearDown(() => root.deleteSync(recursive: true));

  test('reads schema 1 as default and encodes schema 2', () {
    final config = ProjectConfig.parse('''schema: 1
prefix: Acme
paths:
  ui: lib/design_system
''', packageRoot: root);

    expect(config.prefix, 'Acme');
    expect(config.valuePrefix, 'acme');
    expect(config.preset, 'default');
    expect(config.uiPath, 'lib/design_system');
    expect(config.encode(), '''schema: 2
prefix: Acme
preset: default
paths:
  ui: lib/design_system
''');
  });

  test('parses the exact schema 2 shape', () {
    final config = ProjectConfig.parse('''schema: 2
prefix: Acme
preset: default
paths:
  ui: lib/design_system
''', packageRoot: root);

    expect(config.prefix, 'Acme');
    expect(config.preset, 'default');
    expect(config.uiPath, 'lib/design_system');
  });

  test('rejects invalid and reserved prefixes', () {
    for (final prefix in ['', 'ui', '_Ui', 'Ui-name', 'Üi', 'Class', 'Is']) {
      expect(
        () => ProjectConfig.create(
          packageRoot: root,
          prefix: prefix,
          preset: 'default',
          uiPath: 'lib/ui',
        ),
        throwsFormatException,
        reason: prefix,
      );
    }
  });

  test('rejects unknown, missing, and unsupported config fields', () {
    for (final source in [
      'schema: 3\nprefix: Ui\npreset: default\npaths:\n  ui: lib/ui\n',
      'schema: 2\nprefix: Ui\npaths:\n  ui: lib/ui\n',
      'schema: 1\npaths:\n  ui: lib/ui\n',
      'schema: 1\nprefix: Ui\npaths:\n  ui: lib/ui\nstyle: new\n',
      'schema: 1\nprefix: Ui\npaths:\n  ui: lib/ui\n  extra: lib/x\n',
    ]) {
      expect(
        () => ProjectConfig.parse(source, packageRoot: root),
        throwsFormatException,
        reason: source,
      );
    }
  });

  test('rejects invalid and unbundled presets', () {
    for (final preset in ['', 'Default', 'default-name', 'fortal']) {
      expect(
        () => ProjectConfig.create(
          packageRoot: root,
          prefix: 'Ui',
          preset: preset,
          uiPath: 'lib/ui',
        ),
        throwsFormatException,
        reason: preset,
      );
    }
  });

  test('rejects absolute, unnormalized, traversing, and non-lib UI paths', () {
    for (final uiPath in [
      '/lib/ui',
      'lib/../outside',
      'lib/ui/',
      '../lib/ui',
      r'lib\ui',
      'assets/ui',
      'lib',
    ]) {
      expect(
        () => ProjectConfig.create(
          packageRoot: root,
          prefix: 'Ui',
          preset: 'default',
          uiPath: uiPath,
        ),
        throwsFormatException,
        reason: uiPath,
      );
    }
  });

  test('rejects a symlink chain that escapes the package root', () {
    final outside = Directory.systemTemp.createTempSync('remix_cli_outside_');
    addTearDown(() => outside.deleteSync(recursive: true));
    Link(p.join(root.path, 'lib', 'ui')).createSync(outside.path);

    expect(
      () => ProjectConfig.create(
        packageRoot: root,
        prefix: 'Ui',
        preset: 'default',
        uiPath: 'lib/ui',
      ),
      throwsFormatException,
    );
  });

  test('encoded configuration round-trips YAML-significant UI paths', () {
    for (final uiPath in ['lib/ui #brand', 'lib/ui: brand']) {
      final encoded = ProjectConfig.create(
        packageRoot: root,
        prefix: 'Acme',
        preset: 'default',
        uiPath: uiPath,
      ).encode();

      final reparsed = ProjectConfig.parse(encoded, packageRoot: root);

      expect(reparsed.uiPath, uiPath, reason: encoded);
    }
  });
}
