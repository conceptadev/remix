final class TemplateRenderer {
  const TemplateRenderer();

  String render(
    String source, {
    required String typePrefix,
    required String valuePrefix,
  }) {
    final rendered = source
        .replaceAll('{{typePrefix}}', typePrefix)
        .replaceAll('{{valuePrefix}}', valuePrefix);
    final unresolved = RegExp(r'\{\{[^\n{}]*\}\}').firstMatch(rendered);
    if (unresolved != null) {
      throw FormatException(
        'Template contains unsupported token ${unresolved.group(0)}.',
      );
    }
    return rendered;
  }
}
