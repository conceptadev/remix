import unittest
import tempfile
import zipfile
from pathlib import Path
from check_example_hosts import violations, check_hosts


class ExampleHostPolicyTest(unittest.TestCase):
    def test_catches_default_and_named_constructors_in_code_and_dartdoc(self):
        errors = violations('example.dart', '\nMaterialApp(home: screen)\n/// MaterialApp.router(routerConfig: router)')
        self.assertEqual(len(errors), 2)
        self.assertTrue(errors[0].startswith('example.dart:2:'))
        self.assertTrue(errors[1].startswith('example.dart:3:'))

    def test_checks_generator_template_files(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            template = root / 'packages/remix_cli/templates/theme_scope.dart.tmpl'
            template.parent.mkdir(parents=True)
            template.write_text('/// MaterialApp(home: {{typePrefix}}Screen())')
            archive = root / 'docs/assets/remix-cli-tutorial/sample-projects.zip'
            archive.parent.mkdir(parents=True)
            with zipfile.ZipFile(archive, 'w'):
                pass
            errors = check_hosts(root)
            self.assertEqual(len(errors), 1)
            self.assertIn('theme_scope.dart.tmpl:1:', errors[0])

    def test_rejects_removed_scope_parameters_but_allows_theme_data(self):
        for source in [
            'AcmeThemeScope(data: theme, child: screen)',
            'AcmeThemeScope(child: screen, data: theme)',
            'AcmeThemeScope (child: screen, data: theme)',
            'FortalScope(brightness: Brightness.dark, child: screen)',
            'AcmeScope(lightTheme: theme, child: screen)',
            'const {{typePrefix}}ThemeScope({this.data, required this.child});',
            'config.createScope(child: screen)',
            'FortalThemeData.dark().createScope(child: screen)',
            'FortalThemeConfig? appearance; appearance.createScope(child: screen)',
            'class FortalThemeConfig { Widget createScope({required Widget child}) => child; }',
            'AcmeThemeScope({AcmeThemeData? data, required Widget child});',
        ]:
            with self.subTest(source=source):
                self.assertTrue(violations('example.dart', source))
        self.assertEqual(violations('example.dart',
            'FortalScope(theme: FortalThemeConfig(brightness: Brightness.dark), child: screen)'), [])

    def test_comments_strings_and_unrelated_scopes(self):
        self.assertTrue(violations('example.dart',
            'FortalScope(/* mode */ brightness: Brightness.dark, child: screen)'))
        self.assertTrue(violations('example.dart',
            'FortalScope createScope({required Widget child}) => FortalScope(child: child);'))
        self.assertEqual(violations('example.dart',
            'AccountScope(data: account, child: screen)'), [])
        self.assertEqual(violations('example.dart',
            "final sample = 'MaterialApp(home: screen)'; // MaterialApp()"), [])
        self.assertTrue(violations('example.dart',
            "FortalScope(child: Text('), brightness: ignored'), /* nested /* ) */ */ brightness: .dark)"))
        self.assertEqual(violations('example.dart',
            'class FortalThemeData {} service.createScope(child: screen)'), [])
        self.assertTrue(violations('example.dart',
            'class BrandThemeData {} BrandScope.named(lightTheme: theme)', {'BrandScope'}))

    def test_comparisons_and_callbacks_do_not_hide_arguments(self):
        for expression in ['count < 2 ? a : b', '() => screen', 'Map<String, Widget>()']:
            self.assertTrue(violations('example.dart',
                f'FortalScope(child: {expression}, brightness: .dark)'))

    def test_consumer_tests_and_archive_tests_are_checked(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / 'open_code/custom/test/host_test.dart'
            source.parent.mkdir(parents=True)
            source.write_text('BrandScope(brightness: .dark, child: screen)')
            config = root / 'apps/example/remix.yaml'
            config.parent.mkdir(parents=True)
            config.write_text('prefix: Brand')
            isolated = root / 'packages/example/test/host_test.dart'
            isolated.parent.mkdir(parents=True)
            isolated.write_text('MaterialApp(home: screen)')
            archive = root / 'docs/assets/remix-cli-tutorial/sample-projects.zip'
            archive.parent.mkdir(parents=True)
            with zipfile.ZipFile(archive, 'w') as z:
                z.writestr('default_demo/test/workflow_test.dart', 'MaterialApp(home: screen)')
            errors = check_hosts(root)
            self.assertEqual(len(errors), 2)
            self.assertTrue(any('host_test.dart:1:' in e for e in errors))
            self.assertTrue(any('!default_demo/test/workflow_test.dart:1:' in e for e in errors))

    def test_markdown_prose_cannot_hide_code(self):
        self.assertTrue(violations('guide.mdx',
            "The app's host.\n```dart\nMaterialApp(home: screen)\n```\n"))
        self.assertTrue(violations('source.dart',
            "/// The app's host.\n/// ```dart\n/// MaterialApp(home: screen)\n/// ```\n"))

    def test_allows_compatibility_prose_and_widgets_app(self):
        self.assertEqual(violations('guide.md', 'No MaterialApp is required.\nWidgetsApp(color: color)'), [])


if __name__ == '__main__':
    unittest.main()
