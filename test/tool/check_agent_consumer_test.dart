import 'dart:io';

import 'package:test/test.dart';

import '../../tool/check_agent_consumer.dart' as checker;

void main() {
  late Directory sandbox;

  setUp(() {
    sandbox = Directory.systemTemp.createTempSync('agent_consumer_tool_test_');
  });

  tearDown(() {
    if (sandbox.existsSync()) sandbox.deleteSync(recursive: true);
  });

  test('the committed fixture is the expected consumer contract', () {
    final fixture = Directory(
      '${Directory.current.path}/open_code/agent_fixture',
    );

    expect(checker.agentFixtureContractProblem(fixture), isNull);
  });

  group('fixture contract', () {
    test('requires every copied file', () {
      const files = [
        'analysis_options.yaml',
        'lib/main.dart',
        'lib/agent/composer.dart',
        'test/agent_consumer_test.dart',
      ];

      for (var index = 0; index < files.length; index += 1) {
        final fixture = Directory('${sandbox.path}/fixture$index');
        _writeValidFixture(fixture);
        File('${fixture.path}/${files[index]}').deleteSync();

        expect(
          checker.agentFixtureContractProblem(fixture),
          contains('${files[index]} is missing'),
          reason: files[index],
        );
      }
    });

    test('rejects a consumer build.yaml', () {
      final fixture = Directory('${sandbox.path}/fixture');
      _writeValidFixture(fixture);
      File('${fixture.path}/build.yaml').writeAsStringSync('targets: {}\n');

      expect(
        checker.agentFixtureContractProblem(fixture),
        contains('declares a consumer build.yaml'),
      );
    });

    test('rejects committed dependency overrides', () {
      final fixture = Directory('${sandbox.path}/fixture');
      _writeValidFixture(fixture);
      File('${fixture.path}/pubspec.yaml').writeAsStringSync('''
name: agent_consumer_fixture
dependencies:
  flutter:
    sdk: flutter
  remix_agent: any
dev_dependencies:
  flutter_test:
    sdk: flutter
dependency_overrides:
  remix_agent:
    path: ../../packages/remix_agent
''');

      expect(
        checker.agentFixtureContractProblem(fixture),
        contains('declares dependency_overrides'),
      );
    });

    test('rejects a remix_agent version that cannot be resolved', () {
      final fixture = Directory('${sandbox.path}/fixture');
      _writeValidFixture(fixture);
      File('${fixture.path}/pubspec.yaml').writeAsStringSync('''
name: agent_consumer_fixture
dependencies:
  flutter:
    sdk: flutter
  remix_agent: ^0.1.0-beta.1
dev_dependencies:
  flutter_test:
    sdk: flutter
''');

      expect(
        checker.agentFixtureContractProblem(fixture),
        contains('Agent is unpublished'),
      );
    });

    test('rejects a dependency the CLI should have installed', () {
      final fixture = Directory('${sandbox.path}/fixture');
      _writeValidFixture(fixture);
      File('${fixture.path}/pubspec.yaml').writeAsStringSync('''
name: agent_consumer_fixture
dependencies:
  flutter:
    sdk: flutter
  remix: ^1.0.0-beta.8
  remix_agent: any
dev_dependencies:
  flutter_test:
    sdk: flutter
''');

      expect(
        checker.agentFixtureContractProblem(fixture),
        contains('runtime declares unexpected remix'),
      );
    });
  });

  group('installed UI boundary', () {
    test('accepts exactly the four items the recipe uses', () {
      final app = Directory('${sandbox.path}/app');
      _writeInstalledUi(app);

      expect(checker.agentInstalledUiProblem(app), isNull);
    });

    test('rejects an item the composer recipe does not use', () {
      final app = Directory('${sandbox.path}/app');
      _writeInstalledUi(app);
      File(
        '${app.path}/lib/ui/components/dialog.dart',
      ).writeAsStringSync('library;\n');

      expect(
        checker.agentInstalledUiProblem(app),
        contains('unexpected file: components/dialog.dart'),
      );
    });

    // The dependency runs one way. The application composes installed recipes
    // into an Agent call site; an installed file that imported Agent would
    // make the two inseparable.
    test('rejects an installed file that imports Agent', () {
      final app = Directory('${sandbox.path}/app');
      _writeInstalledUi(app);
      File(
        '${app.path}/lib/ui/components/card.dart',
      ).writeAsStringSync("import 'package:remix_agent/remix_agent.dart';\n");

      expect(
        checker.agentInstalledUiProblem(app),
        contains('imports package:remix_agent'),
      );
    });

    test('rejects a generated consumer build.yaml', () {
      final app = Directory('${sandbox.path}/app');
      _writeInstalledUi(app);
      File('${app.path}/build.yaml').writeAsStringSync('targets: {}\n');

      expect(
        checker.agentInstalledUiProblem(app),
        contains('created a consumer build.yaml'),
      );
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
    'lib/agent/composer.dart',
    'test/agent_consumer_test.dart',
  ];
  for (final relative in files) {
    final file = File('${fixture.path}/$relative');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync('');
  }
  File('${fixture.path}/pubspec.yaml').writeAsStringSync('''
name: agent_consumer_fixture
dependencies:
  flutter:
    sdk: flutter
  remix_agent: any
dev_dependencies:
  flutter_test:
    sdk: flutter
''');
}

/// Mirrors the checker's own file list, so an item added to the recipe without
/// being added to the checker still shows up as a failing boundary test.
void _writeInstalledUi(Directory app) {
  const files = [
    'ui.dart',
    'theme/tokens.dart',
    'theme/theme_data.dart',
    'theme/theme_scope.dart',
    'components/card.dart',
    'components/card.g.dart',
    'components/textfield.dart',
    'components/textfield.g.dart',
    'components/icon_button.dart',
    'components/icon_button.g.dart',
  ];
  for (final relative in files) {
    final file = File('${app.path}/lib/ui/$relative');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync('library;\n');
  }
}
