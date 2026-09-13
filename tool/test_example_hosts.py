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
            'Widget createScope({required Widget child}) => child;',
            'AcmeThemeScope({AcmeThemeData? data, required Widget child});',
        ]:
            with self.subTest(source=source):
                self.assertTrue(violations('example.dart', source))
        self.assertEqual(violations('example.dart',
            'FortalScope(theme: FortalThemeConfig(brightness: Brightness.dark), child: screen)'), [])

    def test_allows_compatibility_prose_and_widgets_app(self):
        self.assertEqual(violations('guide.md', 'No MaterialApp is required.\nWidgetsApp(color: color)'), [])


if __name__ == '__main__':
    unittest.main()
