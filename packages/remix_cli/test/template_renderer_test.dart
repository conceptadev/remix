import 'package:remix_cli/src/template_renderer.dart';
import 'package:test/test.dart';

void main() {
  const renderer = TemplateRenderer();

  test('renders Ui and Acme identifiers everywhere literally', () {
    const source = '''/// {{typePrefix}}Button calls {{valuePrefix}}ButtonStyle.
class {{typePrefix}}Button {}
void {{valuePrefix}}ButtonStyle() {}
''';

    expect(
      renderer.render(source, typePrefix: 'Ui', valuePrefix: 'ui'),
      contains('class UiButton'),
    );
    final acme = renderer.render(
      source,
      typePrefix: 'Acme',
      valuePrefix: 'acme',
    );
    expect(acme, contains('AcmeButton calls acmeButtonStyle'));
    expect(acme, isNot(contains('{{')));
  });

  test('rejects every unsupported or unresolved token', () {
    for (final source in [
      '{{unknown}}',
      '{{ typePrefix }}',
      '{{condition}}body{{/condition}}',
    ]) {
      expect(
        () => renderer.render(source, typePrefix: 'Ui', valuePrefix: 'ui'),
        throwsFormatException,
      );
    }
  });
}
