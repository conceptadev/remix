import 'dart:convert';

import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

const specStylerBuilder = 'mix_generator:spec_styler_generator';

/// Enables generation for installed source without narrowing an existing builder.
/// Existing settings and comments remain application-owned. Explicit opt-outs
/// and split targets require the host to resolve the conflict, not an overwrite.
String configureSpecStylers(
  String source,
  List<String> inputs, {
  required String packageName,
}) {
  final document = loadYaml(source);
  if (document != null && document is! YamlMap) {
    throw const FormatException('build.yaml must contain a map.');
  }
  if (document == null) {
    final paths = inputs.map(Glob.quote).toList()..sort();
    final prefix = source.isEmpty || source.endsWith('\n')
        ? source
        : '$source\n';
    return '${prefix}targets:\n'
        '  \$default:\n'
        '    builders:\n'
        '      $specStylerBuilder:\n'
        '        enabled: true\n'
        '        generate_for:\n'
        '${paths.map((input) => '          - ${jsonEncode(input)}\n').join()}';
  }
  final root = document as YamlMap;
  final targets = root['targets'];
  if (targets != null && targets is! YamlMap) {
    throw const FormatException('build.yaml targets must be a map.');
  }
  var targetKey = r'$default';
  if (targets is YamlMap) {
    final defaultKeys = [
      for (final key in targets.keys)
        if (key == r'$default' ||
            key == packageName ||
            key == ':$packageName' ||
            key == '$packageName:$packageName')
          key as String,
    ];
    if (defaultKeys.length > 1) {
      throw const FormatException(
        'build.yaml declares the default target twice.',
      );
    }
    if (defaultKeys.isNotEmpty) targetKey = defaultKeys.single;
    for (final entry in targets.entries) {
      if (entry.key == targetKey) continue;
      if (entry.value is! YamlMap ||
          inputs.any((input) => _includes(entry.value['sources'], input))) {
        throw const FormatException(
          'Agent source must belong to the default build.yaml target. '
          'Exclude installed UI from other targets before using remix add.',
        );
      }
    }
  }
  final target = targets?[targetKey];
  if (target != null && target is! YamlMap) {
    throw const FormatException('build.yaml default target must be a map.');
  }
  for (final input in inputs) {
    if (!_includes(target?['sources'], input)) {
      throw FormatException(
        'build.yaml default target excludes $input. '
        'Include the installed source before using remix add.',
      );
    }
  }
  final builders = target?['builders'];
  if (builders != null && builders is! YamlMap) {
    throw const FormatException('build.yaml builders must be a map.');
  }
  const alias = 'mix_generator|spec_styler_generator';
  if (builders?[specStylerBuilder] != null && builders?[alias] != null) {
    throw const FormatException(
      'build.yaml declares the spec-styler builder twice.',
    );
  }
  final key = builders?[alias] != null ? alias : specStylerBuilder;
  final existing = builders?[key];
  if (existing != null && existing is! YamlMap) {
    throw const FormatException(
      'build.yaml spec-styler settings must be a map.',
    );
  }
  if (existing?['enabled'] == false) {
    throw const FormatException(
      'build.yaml explicitly disables spec-styler generation. '
      'Enable it for the installed Agent source before using remix add.',
    );
  }
  final editor = YamlEditor(source);
  final path = <String>['targets', targetKey, 'builders', key];
  for (var length = 1; length <= path.length; length++) {
    final prefix = path.take(length).toList();
    if (editor.parseAt(prefix, orElse: () => wrapAsYamlNode(null)).value ==
        null) {
      editor.update(prefix, <String, Object?>{});
    }
  }
  editor.update([...path, 'enabled'], true);
  final generateFor = existing?['generate_for'];
  if (existing == null) {
    editor.update([
      ...path,
      'generate_for',
    ], inputs.map(Glob.quote).toList()..sort());
  } else if (generateFor != null) {
    final missing = inputs
        .where((input) => !_includes(generateFor, input))
        .toList();
    if (generateFor is YamlMap) {
      final excluded = generateFor['exclude'];
      if (missing.any(
        (input) => _matches(excluded, input, defaultValue: false),
      )) {
        throw const FormatException(
          'build.yaml excludes installed Agent source '
          'from spec-styler generation. Adjust generate_for before remix add.',
        );
      }
      if (missing.isNotEmpty) {
        editor.update(
          [...path, 'generate_for', 'include'],
          [
            ...generateFor['include'] as List? ?? const [],
            ...missing.map(Glob.quote).toList()..sort(),
          ],
        );
      }
    } else if (generateFor is YamlList) {
      if (missing.isNotEmpty) {
        editor.update(
          [...path, 'generate_for'],
          [...generateFor, ...missing.map(Glob.quote).toList()..sort()],
        );
      }
    } else {
      throw const FormatException(
        'build.yaml generate_for must be a list or map.',
      );
    }
  }
  return editor.toString();
}

bool _includes(Object? filter, String input) {
  if (filter is Map) {
    return _matches(filter['include'], input, defaultValue: true) &&
        !_matches(filter['exclude'], input, defaultValue: false);
  }
  return _matches(filter, input, defaultValue: true);
}

bool _matches(Object? patterns, String input, {required bool defaultValue}) {
  if (patterns == null) return defaultValue;
  if (patterns is! List || patterns.any((pattern) => pattern is! String)) {
    throw const FormatException(
      'build.yaml source patterns must be lists of strings.',
    );
  }
  if (patterns.isEmpty) return defaultValue;
  return patterns.cast<String>().any((pattern) => Glob(pattern).matches(input));
}
