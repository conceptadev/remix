import 'dart:io';

import 'package:test/test.dart';

import '../../tool/check_open_code.dart' as checker;

void main() {
  late Directory sandbox;

  setUp(() {
    sandbox = Directory.systemTemp.createTempSync('open_code_tool_test_');
  });

  tearDown(() {
    if (sandbox.existsSync()) sandbox.deleteSync(recursive: true);
  });

  test('the committed fixture is the minimal pre-install contract', () {
    final fixture = Directory('${Directory.current.path}/open_code/fixture');

    expect(checker.fixtureContractProblem(fixture), isNull);
  });

  group('fixture contract', () {
    test('requires every committed generated adapter', () {
      const snapshots = [
        'expected/acme_button.g.dart',
        'expected/acme_tabs.g.dart',
      ];

      for (var index = 0; index < snapshots.length; index += 1) {
        final fixture = Directory('${sandbox.path}/fixture$index');
        _writeValidFixture(fixture);
        File('${fixture.path}/${snapshots[index]}').deleteSync();

        expect(
          checker.fixtureContractProblem(fixture),
          contains('${snapshots[index]} is missing'),
          reason: snapshots[index],
        );
      }
    });

    test('rejects a consumer build.yaml', () {
      final fixture = Directory('${sandbox.path}/fixture');
      _writeValidFixture(fixture);
      File('${fixture.path}/build.yaml').writeAsStringSync('targets: {}\n');

      expect(
        checker.fixtureContractProblem(fixture),
        contains('declares a consumer build.yaml'),
      );
    });

    test('rejects dependencies that bypass CLI installation', () {
      final fixture = Directory('${sandbox.path}/fixture');
      _writeValidFixture(fixture);
      File('${fixture.path}/pubspec.yaml').writeAsStringSync('''
name: open_code_fixture
dependencies:
  flutter:
    sdk: flutter
  remix: ^1.0.0-beta.6
dev_dependencies:
  flutter_test:
    sdk: flutter
''');

      expect(
        checker.fixtureContractProblem(fixture),
        contains('unexpected runtime dependency remix'),
      );
    });

    test('rejects dependency overrides', () {
      final fixture = Directory('${sandbox.path}/fixture');
      _writeValidFixture(fixture);
      File('${fixture.path}/pubspec.yaml').writeAsStringSync('''
name: open_code_fixture
dependencies:
  flutter:
    sdk: flutter
dev_dependencies:
  flutter_test:
    sdk: flutter
dependency_overrides:
  remix:
    path: ../../packages/remix
''');

      expect(
        checker.fixtureContractProblem(fixture),
        contains('declares dependency_overrides'),
      );
    });
  });

  group('installed UI boundary', () {
    test('accepts the exact registry output without build.yaml', () {
      final app = Directory('${sandbox.path}/app');
      _writeInstalledUi(app);

      expect(checker.installedUiProblem(app), isNull);
    });

    test('rejects a generated consumer build.yaml', () {
      final app = Directory('${sandbox.path}/app');
      _writeInstalledUi(app);
      File('${app.path}/build.yaml').writeAsStringSync('targets: {}\n');

      expect(
        checker.installedUiProblem(app),
        contains('created a consumer build.yaml'),
      );
    });

    test('rejects an extra installed file', () {
      final app = Directory('${sandbox.path}/app');
      _writeInstalledUi(app);
      File('${app.path}/lib/ui/surprise.dart').writeAsStringSync('library;\n');

      expect(
        checker.installedUiProblem(app),
        contains('unexpected file: surprise.dart'),
      );
    });

    test('checks every URI in conditional directives', () {
      final app = Directory('${sandbox.path}/app');
      _writeInstalledUi(app);
      File('${app.path}/lib/ui/ui.dart').writeAsStringSync('''
import 'package:flutter/widgets.dart'
    if (dart.library.io) 'package:unexpected_package/io.dart'
    if (dart.library.html) '../../outside.dart';
''');

      final problem = checker.installedUiProblem(app);

      expect(problem, contains('imports package:unexpected_package'));
      expect(problem, contains('`../../outside.dart` escapes lib/ui'));
    });
  });

  test('retained failure reporting includes the temporary directory', () {
    expect(
      checker.retainedFailureMessage(sandbox, StateError('synthetic failure')),
      allOf(
        contains('synthetic failure'),
        contains('Temporary application preserved at ${sandbox.path}'),
      ),
    );
  });
}

void _writeValidFixture(Directory fixture) {
  const files = [
    'analysis_options.yaml',
    'lib/main.dart',
    'test/open_code_test.dart',
    'expected/acme_button.g.dart',
    'expected/acme_tabs.g.dart',
  ];
  for (final relative in files) {
    final file = File('${fixture.path}/$relative');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync('');
  }
  File('${fixture.path}/pubspec.yaml').writeAsStringSync('''
name: open_code_fixture
dependencies:
  flutter:
    sdk: flutter
dev_dependencies:
  flutter_test:
    sdk: flutter
''');
}

/// Mirrors the checker's own item list; kept here so a new registry item that
/// the checker forgot still shows up as a failing boundary test.
const _registryItems = <String>[
  'avatar',
  'badge',
  'button',
  'callout',
  'card',
  'checkbox',
  'divider',
  'icon_button',
  'link',
  'progress',
  'skeleton',
  'spinner',
  'tabs',
  'toggle',
];

void _writeInstalledUi(Directory app) {
  final files = [
    'ui.dart',
    'theme/tokens.dart',
    'theme/theme_data.dart',
    'theme/theme_scope.dart',
    for (final item in _registryItems) ...[
      'components/$item.dart',
      'components/$item.g.dart',
    ],
  ];
  for (final relative in files) {
    final file = File('${app.path}/lib/ui/$relative');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync('library;\n');
  }
}
