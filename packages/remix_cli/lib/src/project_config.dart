import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

const projectConfigFileName = 'remix.yaml';
const supportedProjectSchema = 1;

final class ProjectConfig {
  ProjectConfig._({required this.prefix, required this.uiPath});

  factory ProjectConfig.create({
    required Directory packageRoot,
    required String prefix,
    required String uiPath,
  }) {
    _validatePrefix(prefix);
    _validateUiPath(packageRoot, uiPath);
    return ProjectConfig._(prefix: prefix, uiPath: uiPath);
  }

  factory ProjectConfig.parse(String source, {required Directory packageRoot}) {
    final Object? document;
    try {
      document = loadYaml(source);
    } on YamlException catch (error) {
      throw FormatException('Invalid $projectConfigFileName: $error');
    }
    if (document is! YamlMap) {
      throw const FormatException('$projectConfigFileName must contain a map.');
    }
    _requireExactKeys(document, {'schema', 'prefix', 'paths'}, 'configuration');

    final schema = document['schema'];
    if (schema != supportedProjectSchema) {
      throw FormatException(
        'Unsupported remix.yaml schema $schema; remix_cli supports schema 1.',
      );
    }
    final prefix = document['prefix'];
    if (prefix is! String) {
      throw const FormatException('remix.yaml prefix must be a string.');
    }
    final paths = document['paths'];
    if (paths is! YamlMap) {
      throw const FormatException('remix.yaml paths must be a map.');
    }
    _requireExactKeys(paths, {'ui'}, 'paths');
    final uiPath = paths['ui'];
    if (uiPath is! String) {
      throw const FormatException('remix.yaml paths.ui must be a string.');
    }
    return ProjectConfig.create(
      packageRoot: packageRoot,
      prefix: prefix,
      uiPath: uiPath,
    );
  }

  final String prefix;
  final String uiPath;

  String get valuePrefix =>
      '${prefix.substring(0, 1).toLowerCase()}${prefix.substring(1)}';

  String encode() =>
      '''schema: 1
prefix: $prefix
paths:
  ui: ${_encodeYamlPath(uiPath)}
''';
}

void validateProjectFilePath(Directory packageRoot, String relativePath) {
  _validateProjectPath(packageRoot, relativePath, _ProjectPathKind.file);
}

void _validateProjectPath(
  Directory packageRoot,
  String relativePath,
  _ProjectPathKind targetKind,
) {
  if (relativePath.isEmpty ||
      p.isAbsolute(relativePath) ||
      p.posix.isAbsolute(relativePath) ||
      relativePath.contains('\\')) {
    throw FormatException('$relativePath must be a project-relative path.');
  }
  final normalized = p.posix.normalize(relativePath);
  if (normalized != relativePath ||
      normalized == '..' ||
      normalized.startsWith('../')) {
    throw FormatException(
      '$relativePath must be normalized without traversal.',
    );
  }

  final root = packageRoot.resolveSymbolicLinksSync();
  final segments = p.posix.split(relativePath);
  var current = root;
  for (var index = 0; index < segments.length; index++) {
    final segment = segments[index];
    current = p.join(current, segment);
    final type = FileSystemEntity.typeSync(current, followLinks: false);
    if (type == FileSystemEntityType.notFound) {
      break;
    }
    final String resolved;
    try {
      resolved = switch (type) {
        FileSystemEntityType.directory => Directory(
          current,
        ).resolveSymbolicLinksSync(),
        FileSystemEntityType.file => File(current).resolveSymbolicLinksSync(),
        FileSystemEntityType.link => Link(current).resolveSymbolicLinksSync(),
        _ => throw FormatException(
          '$relativePath has an unsupported path type.',
        ),
      };
    } on FileSystemException {
      throw FormatException('$relativePath contains an unresolved link.');
    }
    if (resolved != root && !p.isWithin(root, resolved)) {
      throw FormatException('$relativePath resolves outside the package root.');
    }

    final effectiveType = type == FileSystemEntityType.link
        ? FileSystemEntity.typeSync(current)
        : type;
    final isTarget = index == segments.length - 1;
    if (!isTarget && effectiveType != FileSystemEntityType.directory) {
      throw FormatException(
        '$relativePath crosses a path that is not a directory.',
      );
    }
    if (isTarget &&
        targetKind == _ProjectPathKind.directory &&
        effectiveType != FileSystemEntityType.directory) {
      throw FormatException('$relativePath must be a directory path.');
    }
    if (isTarget &&
        targetKind == _ProjectPathKind.file &&
        effectiveType != FileSystemEntityType.file) {
      throw FormatException('$relativePath must be a file path.');
    }
    current = resolved;
  }
}

Directory validateFlutterPackageRoot(Directory directory) {
  final root = directory.absolute;
  final pubspec = File(p.join(root.path, 'pubspec.yaml'));
  if (!pubspec.existsSync()) {
    throw const FormatException(
      'Run remix from a Flutter package root containing pubspec.yaml.',
    );
  }

  final Object? document;
  try {
    document = loadYaml(pubspec.readAsStringSync());
  } on YamlException catch (error) {
    throw FormatException('Invalid pubspec.yaml: $error');
  }
  if (document is! YamlMap) {
    throw const FormatException('pubspec.yaml must contain a map.');
  }
  final dependencies = document['dependencies'];
  final flutter = dependencies is YamlMap ? dependencies['flutter'] : null;
  if (flutter is! YamlMap || flutter['sdk'] != 'flutter') {
    throw const FormatException(
      'Run remix from a Flutter package whose dependencies include the Flutter SDK.',
    );
  }
  return root;
}

void _validatePrefix(String prefix) {
  if (!RegExp(r'^[A-Z][A-Za-z0-9]*$').hasMatch(prefix)) {
    throw const FormatException(
      'prefix must be an ASCII UpperCamel Dart identifier.',
    );
  }
  final valuePrefix =
      '${prefix.substring(0, 1).toLowerCase()}${prefix.substring(1)}';
  if (_dartReservedWords.contains(valuePrefix)) {
    throw FormatException(
      '$prefix derives the reserved Dart word $valuePrefix.',
    );
  }
}

void _validateUiPath(Directory packageRoot, String uiPath) {
  _validateProjectPath(packageRoot, uiPath, _ProjectPathKind.directory);
  if (!uiPath.startsWith('lib/')) {
    throw const FormatException('paths.ui must be inside lib/.');
  }
}

String _encodeYamlPath(String value) =>
    _plainYamlPath.hasMatch(value) ? value : jsonEncode(value);

void _requireExactKeys(YamlMap map, Set<String> expected, String location) {
  final keys = map.keys.whereType<String>().toSet();
  if (keys.length != map.length) {
    throw FormatException('$location keys must be strings.');
  }
  final missing = expected.difference(keys);
  final unknown = keys.difference(expected);
  if (missing.isNotEmpty) {
    throw FormatException('$location is missing ${missing.join(', ')}.');
  }
  if (unknown.isNotEmpty) {
    throw FormatException('$location has unknown keys: ${unknown.join(', ')}.');
  }
}

const _dartReservedWords = <String>{
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'base',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'Function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'of',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'sealed',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'when',
  'while',
  'with',
  'yield',
};

enum _ProjectPathKind { directory, file }

final _plainYamlPath = RegExp(r'^[A-Za-z0-9_./-]+$');
