import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:remix_cli/src/project_config.dart';
import 'package:remix_cli/src/template_renderer.dart';
import 'package:test/test.dart';

/// The prefix templates are rendered with before they are formatted.
///
/// "Formatter-clean" is only meaningful at a stated prefix, because the
/// formatter wraps on line width and the prefix is substituted into type names.
/// This is the prefix of the rendering the repository already commits: the
/// default preset is mirrored into `apps/playground`.
const _referencePrefix = 'Playground';

void main() {
  // Only the hand-authored preset needs this. `fortal` is generated from
  // `remix_fortal`'s formatted source by `tool/build_fortal_preset.dart`, which
  // holds it byte-identical through a round-trip assertion, so its templates are
  // formatter-clean by construction.
  //
  // No consumer is affected either way: `add` formats the tree it writes, so
  // installed source is formatted regardless of what the template looked like.
  // This keeps the committed templates diffable instead of differing by pure
  // whitespace, which nothing else could see.
  test('every default-preset template renders as formatter-clean Dart', () {
    // `dart test` runs with the package root as the current directory.
    final templates = Directory(
      p.join('lib', 'src', 'registry', 'default', 'templates'),
    );
    expect(templates.existsSync(), isTrue, reason: templates.path);

    // Both prefixes come from the code the installer itself uses, so this can
    // never drift from what `add` writes.
    final config = ProjectConfig.create(
      packageRoot: Directory.current,
      prefix: _referencePrefix,
      preset: 'default',
      uiPath: p.join('lib', 'ui'),
    );
    const renderer = TemplateRenderer();

    final sources = <String, File>{};
    final staging = Directory.systemTemp.createTempSync('remix_tmpl_format_');
    addTearDown(() => staging.deleteSync(recursive: true));

    // Every rendered template lands in one flat directory so a single formatter
    // invocation covers all of them.
    for (final template
        in templates
            .listSync(recursive: true)
            .whereType<File>()
            .where((file) => file.path.endsWith('.dart.tmpl'))) {
      final relative = p.relative(template.path, from: templates.path);
      final name =
          '${relative.replaceAll(p.separator, '__').replaceAll('.dart.tmpl', '')}.dart';
      File(p.join(staging.path, name)).writeAsStringSync(
        renderer.render(
          template.readAsStringSync(),
          typePrefix: config.prefix,
          valuePrefix: config.valuePrefix,
        ),
      );
      sources[name] = template;
    }
    expect(sources, isNotEmpty);

    final rendered = {
      for (final name in sources.keys)
        name: File(p.join(staging.path, name)).readAsStringSync(),
    };

    final result = Process.runSync(Platform.resolvedExecutable, [
      'format',
      staging.path,
    ]);
    expect(
      result.exitCode,
      0,
      reason: 'the formatter failed: ${result.stdout}${result.stderr}',
    );

    final drifted = <String>[
      for (final name in sources.keys)
        if (File(p.join(staging.path, name)).readAsStringSync() !=
            rendered[name])
          p.relative(sources[name]!.path),
    ]..sort();

    expect(
      drifted,
      isEmpty,
      reason:
          'these templates do not match the formatter when rendered with '
          'prefix $_referencePrefix. Render one, format it, and reverse the '
          'prefix substitution to update it.',
    );
  });
}
