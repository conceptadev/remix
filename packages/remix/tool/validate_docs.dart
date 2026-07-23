import 'dart:convert';
import 'dart:io';

final _retiredApis = <(RegExp, String)>[
  (
    RegExp(
      r'Fortal(?:Accordion|Avatar|Badge|Button|Callout|Card|Checkbox|IconButton|Menu|Progress|Radio|Slider|Switch|TextField|Toggle|ToggleGroup)'
      r'(?:<[^>]+>)?\s*\((?:[^()]|\([^()]*\)){0,1200}?'
      r'\bvariant\s*:\s*(?:Fortal[A-Za-z0-9_]+Variant\s*)?'
      r'\.(?:classic|solid|soft|surface|outline|ghost)',
    ),
    'static Fortal variant argument; use its named constructor',
  ),
  (
    RegExp(
      r'Remix(?:MenuTrigger|MenuItemData|MenuDivider|ButtonTextBuilder|ButtonIconBuilder|IconButtonIconBuilder|BadgeLabelBuilder)\b',
    ),
    'retired component type',
  ),
  (RegExp(r'\bsnapDivisions\b'), 'retired scalar Slider property'),
  (
    RegExp(r'\b(?:targetAnchor|followerAnchor)\s*:'),
    'retired overlay anchor API',
  ),
  (RegExp(r'\b(?:menuContainer|trackContainer)\s*\('), 'retired style slot'),
  (
    RegExp(
      r'\b(?:RemixPaintShadow(?:Kind|Mix|ListToken)?|RemixSurface(?:Layer|Effects)?(?:Spec|Mix)?|remixSurface(?:Box|FlexBox))\b',
    ),
    'retired surface-effects API',
  ),
  (
    RegExp(
      r'\b(?:remixBoxWithEffects|remixFlexBoxWithEffects|remixInheritedContentStyle)\b',
    ),
    'removed internal widget helper',
  ),
  (RegExp(r'\.effects\s*\('), 'retired generic effects styler'),
  (
    RegExp(r'generated Fortal', caseSensitive: false),
    'stale generated-wrapper claim',
  ),
];

final _progressInvocation = RegExp(r'\b(?:RemixProgress|FortalProgress)\s*\(');
final _legacyFractionalProgressValue = RegExp(
  r'\bvalue\s*:\s*0\.(?:\d*[1-9]\d*)(?![\d.])',
);
final _explicitProgressMax = RegExp(r'\bmax\s*:');
final _remixImport = RegExp(
  r'''import\s+['"]package:remix/remix\.dart['"]\s*;''',
);
final _remixPublicReference = RegExp(
  r'\b(?:Remix[A-Z][A-Za-z0-9_]*|Fortal[A-Z][A-Za-z0-9_]*|'
  r'FortalTokens|ButtonStyler|fortal[A-Z][A-Za-z0-9_]*|'
  r'OverlayPositionConfig|OverlaySide|OverlayAlignment)\b',
);
final _apiReferenceSignature = RegExp(
  r'^(?:(?:\s*//[^\n]*\n)+)?\s*'
  r'(?:const\s+(?:Remix|Fortal)[A-Z][A-Za-z0-9_]*(?:<[^>]+>)?\s*\(\{'
  r'|Future<[^>]+>\s+showRemix[A-Z][A-Za-z0-9_]*(?:<[^>]+>)?\s*\(\{)',
);

const _exampleSourceDirectories = <String>[
  'packages/demo/lib',
  'packages/example/lib',
  'packages/playground/lib',
  'packages/remix/example',
];

Future<void> main() async {
  final packageRoot = Directory.current.absolute;
  final pubspec = File('${packageRoot.path}/pubspec.yaml');
  if (!pubspec.existsSync() ||
      !pubspec.readAsStringSync().contains('name: remix')) {
    stderr.writeln('Run this validator from packages/remix.');
    exitCode = 64;
    return;
  }

  final workspaceRoot = packageRoot.parent.parent;
  final docsRoot = Directory('${workspaceRoot.path}/docs');
  final docsConfig = File('${workspaceRoot.path}/docs.json');
  final failures = <String>[];

  final docs =
      docsRoot
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.mdx'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  if (docs.isEmpty) failures.add('No MDX documentation files were found.');

  for (final file in docs) {
    final relativePath = _relativePath(workspaceRoot, file);
    final source = file.readAsStringSync();
    if (!source.startsWith('---\n')) {
      failures.add('$relativePath is missing YAML front matter.');
    }
    if ('```'.allMatches(source).length.isOdd) {
      failures.add('$relativePath has an unclosed code fence.');
    }
    if ('<CodeGroup'.allMatches(source).length !=
        '</CodeGroup>'.allMatches(source).length) {
      failures.add('$relativePath has unbalanced CodeGroup tags.');
    }
    _checkRetiredApis(source, relativePath, failures);
  }

  final exampleSourceCount = _checkExampleSources(workspaceRoot, failures);

  _checkNavigation(workspaceRoot, docsConfig, failures);
  _checkFortalScopeTopology(workspaceRoot, failures);

  if (failures.isNotEmpty) {
    _finish(failures);
    return;
  }

  final snippets = _extractAnalyzableSnippets(docs, workspaceRoot, failures);
  if (failures.isNotEmpty) {
    _finish(failures);
    return;
  }

  final tempRoot = Directory(
    '${packageRoot.path}/tool/.docs_validation_${pid}_${DateTime.now().microsecondsSinceEpoch}',
  );
  tempRoot.createSync(recursive: true);
  try {
    for (final (index, snippet) in snippets.indexed) {
      final file = File('${tempRoot.path}/snippet_$index.dart');
      file.writeAsStringSync(
        '// Generated temporarily by tool/validate_docs.dart.\n'
        '${snippet.source}\n',
      );
    }

    final result = await Process.run(Platform.resolvedExecutable, [
      'analyze',
      tempRoot.path,
    ], workingDirectory: packageRoot.path);
    if (result.exitCode != 0) {
      failures
        ..add('Dart documentation examples do not analyze.')
        ..add('${result.stdout}${result.stderr}'.trim())
        ..add(
          'Snippet map:\n${snippets.indexed.map((entry) => '  '
              'snippet_${entry.$1}.dart = ${entry.$2.path}').join('\n')}',
        );
    }
  } finally {
    if (tempRoot.existsSync()) tempRoot.deleteSync(recursive: true);
  }

  if (failures.isNotEmpty) {
    _finish(failures);
    return;
  }

  stdout.writeln(
    'Documentation validation passed: ${docs.length} MDX files, '
    '${snippets.length} analyzable Dart examples, and '
    '$exampleSourceCount app/example Dart sources.',
  );
}

int _checkExampleSources(Directory workspaceRoot, List<String> failures) {
  final sources = <File>[];
  for (final relativeDirectory in _exampleSourceDirectories) {
    final directory = Directory('${workspaceRoot.path}/$relativeDirectory');
    if (!directory.existsSync()) {
      failures.add('Missing app/example source directory: $relativeDirectory.');
      continue;
    }
    sources.addAll(
      directory
          .listSync(recursive: true)
          .whereType<File>()
          .where(
            (file) =>
                file.path.endsWith('.dart') && !file.path.endsWith('.g.dart'),
          ),
    );
  }
  sources.sort((a, b) => a.path.compareTo(b.path));

  for (final file in sources) {
    final relativePath = _relativePath(workspaceRoot, file);
    final source = file.readAsStringSync();
    _checkRetiredApis(source, relativePath, failures);
  }

  return sources.length;
}

void _checkRetiredApis(
  String source,
  String relativePath,
  List<String> failures,
) {
  for (final (pattern, description) in _retiredApis) {
    final match = pattern.firstMatch(source);
    if (match != null) {
      failures.add(
        '$relativePath contains a $description at offset ${match.start}.',
      );
    }
  }
  _checkLegacyProgressScale(source, relativePath, failures);
}

void _checkLegacyProgressScale(
  String source,
  String relativePath,
  List<String> failures,
) {
  for (final invocation in _progressInvocation.allMatches(source)) {
    final openingParenthesis = invocation.end - 1;
    final closingParenthesis = _matchingParenthesis(source, openingParenthesis);
    if (closingParenthesis == null) continue;
    final arguments = source.substring(
      openingParenthesis + 1,
      closingParenthesis,
    );
    final legacyValue = _legacyFractionalProgressValue.firstMatch(arguments);
    if (legacyValue == null || _explicitProgressMax.hasMatch(arguments)) {
      continue;
    }
    failures.add(
      '$relativePath contains a Progress value on the retired 0-1 default '
      'scale at offset ${openingParenthesis + 1 + legacyValue.start}; use '
      'the 0-100 default scale or declare an explicit max.',
    );
  }
}

int? _matchingParenthesis(String source, int openingParenthesis) {
  var depth = 0;
  for (var index = openingParenthesis; index < source.length; index += 1) {
    switch (source[index]) {
      case '(':
        depth += 1;
      case ')':
        depth -= 1;
        if (depth == 0) return index;
    }
  }
  return null;
}

void _checkNavigation(
  Directory workspaceRoot,
  File config,
  List<String> failures,
) {
  if (!config.existsSync()) {
    failures.add('Missing docs.json.');
    return;
  }
  Object? decoded;
  try {
    decoded = jsonDecode(config.readAsStringSync());
  } on FormatException catch (error) {
    failures.add('docs.json is invalid JSON: $error');
    return;
  }
  if (decoded is! Map<String, Object?>) {
    failures.add('docs.json must contain a JSON object.');
    return;
  }

  final hrefs = <String>[];
  void collect(Object? value) {
    switch (value) {
      case Map<String, Object?> map:
        if (map['href'] case final String href) hrefs.add(href);
        for (final child in map.values) {
          collect(child);
        }
      case List<Object?> list:
        for (final child in list) {
          collect(child);
        }
    }
  }

  collect(decoded['sidebar']);
  for (final href in hrefs) {
    final path = href == '/'
        ? '${workspaceRoot.path}/docs/index.mdx'
        : '${workspaceRoot.path}/docs$href.mdx';
    if (!File(path).existsSync()) {
      failures.add(
        'docs.json links $href to missing ${_relative(path, workspaceRoot)}.',
      );
    }
  }
}

void _checkFortalScopeTopology(Directory workspaceRoot, List<String> failures) {
  final index = File('${workspaceRoot.path}/docs/index.mdx').readAsStringSync();
  final topology = RegExp(
    r'return\s+FortalScope\s*\(\s*child:\s*MaterialApp\s*\(',
    dotAll: true,
  );
  if (!topology.hasMatch(index)) {
    failures.add(
      'docs/index.mdx must place the root FortalScope above MaterialApp.',
    );
  }
}

List<({String path, String source})> _extractAnalyzableSnippets(
  List<File> docs,
  Directory workspaceRoot,
  List<String> failures,
) {
  final snippets = <({String path, String source})>[];
  final fence = RegExp(r'```dart\s*\n([\s\S]*?)\n```');
  for (final file in docs) {
    final relativePath = _relativePath(workspaceRoot, file);
    final source = file.readAsStringSync();
    for (final (index, match) in fence.allMatches(source).indexed) {
      final snippet = match.group(1)!;
      final importsRemix = _remixImport.hasMatch(snippet);
      if (!importsRemix && !_remixPublicReference.hasMatch(snippet)) continue;
      if (snippet.contains('...')) {
        failures.add(
          '$relativePath Dart example ${index + 1} uses Remix but contains an '
          'ellipsis and cannot be compile-validated.',
        );
        continue;
      }
      snippets.add((
        path: '$relativePath#${index + 1}',
        source: importsRemix
            ? snippet
            : _apiReferenceSignature.hasMatch(snippet)
            ? _wrapApiReferenceSignature(snippet)
            : _wrapRemixFragment(snippet),
      ));
    }
  }
  return snippets;
}

String _wrapRemixFragment(String snippet) {
  if (RegExp(r'^\s*class\s+').hasMatch(snippet)) {
    return '$_generatedImports$snippet';
  }

  return '''
$_generatedImports
void main() {
$snippet
}
''';
}

String _wrapApiReferenceSignature(String snippet) {
  if (RegExp(r'\bFuture<[^>]+>\s+showRemix').hasMatch(snippet)) {
    final declaration = snippet
        .replaceFirst(RegExp(r'\bFuture<'), 'external Future<')
        .replaceFirst(RegExp(r'\}\)\s*$'), '});');
    return '$_generatedImports$declaration';
  }

  var signatureIndex = 0;
  final declarations = snippet
      .replaceAllMapped(
        RegExp(
          r'^(\s*)const\s+(?:Remix|Fortal)[A-Z][A-Za-z0-9_]*'
          r'(<[^>]+>)?\s*\(\{',
          multiLine: true,
        ),
        (match) =>
            '${match[1]}void _docsApiSignature${signatureIndex++}'
            '${match[2] ?? ''}({',
      )
      .replaceAll(RegExp(r'^\s*\}\)\s*$', multiLine: true), '}) {}');
  return '$_generatedImports$declarations';
}

const _generatedImports = '''
// ignore_for_file: unused_element, unused_element_parameter, unused_import
// ignore_for_file: unused_local_variable
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

''';

String _relativePath(Directory root, File file) => _relative(file.path, root);

String _relative(String path, Directory root) {
  final prefix = '${root.path}${Platform.pathSeparator}';
  return path.startsWith(prefix) ? path.substring(prefix.length) : path;
}

void _finish(List<String> failures) {
  stderr.writeln('Documentation validation failed (${failures.length}):');
  for (final failure in failures) {
    stderr.writeln('- $failure');
  }
  exitCode = 1;
}
