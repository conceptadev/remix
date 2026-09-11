import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

const bundledPresets = <String>{'default', 'fortal'};

abstract interface class RegistryAssetLoader {
  Future<String> read(Uri uri);
}

final class PackageRegistryAssetLoader implements RegistryAssetLoader {
  const PackageRegistryAssetLoader();

  @override
  Future<String> read(Uri uri) async {
    final resolved = await Isolate.resolvePackageUri(uri);
    if (resolved == null) {
      throw StateError('Could not resolve bundled registry asset $uri.');
    }
    if (resolved.scheme != 'file') {
      throw StateError('Registry asset $uri did not resolve to a file.');
    }
    return File.fromUri(resolved).readAsString();
  }
}

final class RegistryCatalog {
  RegistryCatalog._({
    required this.preset,
    required this.items,
    required Uri rootUri,
    required RegistryAssetLoader loader,
  }) : _rootUri = rootUri,
       _loader = loader;

  factory RegistryCatalog.parse(
    String source, {
    required String preset,
    required Uri rootUri,
    RegistryAssetLoader loader = const PackageRegistryAssetLoader(),
  }) {
    final Object? document;
    try {
      document = loadYaml(source);
    } on YamlException catch (error) {
      throw FormatException('Invalid registry.yaml: $error');
    }
    final root = _map(document, 'registry');
    _exactKeys(root, {'schema', 'items'}, 'registry');
    if (root['schema'] != 1) {
      throw FormatException(
        'Unsupported registry schema ${root['schema']}; remix_cli supports schema 1.',
      );
    }
    final itemMap = _map(root['items'], 'registry.items');
    final items = <String, RegistryItem>{};
    for (final entry in itemMap.nodes.entries) {
      final name = _stringScalar(entry.key, 'registry item name');
      if (!_packageName.hasMatch(name)) {
        throw FormatException('Invalid registry item name $name.');
      }
      items[name] = _parseItem(name, entry.value.value);
    }
    final catalog = RegistryCatalog._(
      preset: preset,
      items: Map.unmodifiable(items),
      rootUri: rootUri,
      loader: loader,
    );
    catalog._validateGraphAndTargets();
    return catalog;
  }

  static Future<RegistryCatalog> loadBundled({
    required String preset,
    RegistryAssetLoader loader = const PackageRegistryAssetLoader(),
  }) async {
    if (!bundledPresets.contains(preset)) {
      throw FormatException(
        'Unknown preset $preset. Bundled presets: '
        '${bundledPresets.join(', ')}.',
      );
    }
    final uri = Uri.parse(
      'package:remix_cli/src/registry/$preset/registry.yaml',
    );
    final source = await loader.read(uri);
    return RegistryCatalog.parse(
      source,
      preset: preset,
      rootUri: uri.resolve('.'),
      loader: loader,
    );
  }

  final String preset;
  final Map<String, RegistryItem> items;
  final Uri _rootUri;
  final RegistryAssetLoader _loader;

  List<RegistryItem> resolve(String requested) {
    if (!items.containsKey(requested)) {
      throw FormatException(
        'Unknown registry item $requested in the $preset preset.',
      );
    }
    final ordered = <RegistryItem>[];
    final visited = <String>{};
    void visit(String name) {
      if (!visited.add(name)) return;
      final item = items[name]!;
      for (final dependency in item.registryDependencies) {
        visit(dependency);
      }
      ordered.add(item);
    }

    visit(requested);
    return List.unmodifiable(ordered);
  }

  Future<String> readTemplate(RegistryFile file) =>
      _loader.read(_rootUri.resolve(file.source));

  void _validateGraphAndTargets() {
    final visiting = <String>{};
    final visited = <String>{};
    void visit(String name, List<String> path) {
      if (visiting.contains(name)) {
        throw FormatException(
          'Registry dependency cycle: ${[...path, name].join(' -> ')}.',
        );
      }
      if (!visited.add(name)) return;
      visiting.add(name);
      for (final dependency in items[name]!.registryDependencies) {
        if (!items.containsKey(dependency)) {
          throw FormatException('$name depends on missing item $dependency.');
        }
        visit(dependency, [...path, name]);
      }
      visiting.remove(name);
    }

    for (final name in items.keys) {
      visit(name, const []);
    }

    final owners = <String, String>{};
    for (final item in items.values) {
      final targets = [
        ...item.files.map((file) => file.target),
        ...item.generated,
      ];
      for (final target in targets) {
        final previous = owners[target];
        if (previous != null) {
          throw FormatException(
            '${item.name} and $previous both target $target.',
          );
        }
        owners[target] = item.name;
      }
    }
  }
}

final class RegistryItem {
  const RegistryItem({
    required this.name,
    required this.registryDependencies,
    required this.dependencies,
    required this.devDependencies,
    required this.files,
    required this.generated,
    required this.exports,
  });

  final String name;
  final List<String> registryDependencies;
  final Map<String, VersionConstraint> dependencies;
  final Map<String, VersionConstraint> devDependencies;
  final List<RegistryFile> files;
  final List<String> generated;
  final List<String> exports;
}

final class RegistryFile {
  const RegistryFile({required this.source, required this.target});

  final String source;
  final String target;
}

RegistryItem _parseItem(String name, Object? source) {
  final map = _map(source, 'item $name');
  _exactKeys(
    map,
    {
      'registryDependencies',
      'dependencies',
      'devDependencies',
      'files',
      'generated',
      'exports',
    },
    'item $name',
    optional: {
      'registryDependencies',
      'dependencies',
      'devDependencies',
      'generated',
      'exports',
    },
  );
  final registryDependencies = _stringList(
    map['registryDependencies'],
    'item $name registryDependencies',
  );
  if (registryDependencies.toSet().length != registryDependencies.length) {
    throw FormatException('item $name has duplicate registryDependencies.');
  }
  final filesNode = map['files'];
  if (filesNode is! YamlList || filesNode.isEmpty) {
    throw FormatException('item $name files must be a non-empty list.');
  }
  final files = <RegistryFile>[];
  for (var index = 0; index < filesNode.length; index++) {
    final file = _map(filesNode[index], 'item $name files[$index]');
    _exactKeys(file, {'source', 'target'}, 'item $name files[$index]');
    final sourcePath = _string(file['source'], 'source');
    _validateRelative(
      sourcePath,
      label: 'template source',
      prefix: 'templates/',
    );
    final target = _string(file['target'], 'target');
    _validateTarget(target);
    files.add(RegistryFile(source: sourcePath, target: target));
  }
  final generated = _stringList(map['generated'], 'item $name generated');
  for (final target in generated) {
    _validateTarget(target);
  }
  final exports = _stringList(map['exports'], 'item $name exports');
  for (final export in exports) {
    _validateRelative(export, label: 'export');
  }
  return RegistryItem(
    name: name,
    registryDependencies: List.unmodifiable(registryDependencies),
    dependencies: _constraints(map['dependencies'], 'item $name dependencies'),
    devDependencies: _constraints(
      map['devDependencies'],
      'item $name devDependencies',
    ),
    files: List.unmodifiable(files),
    generated: List.unmodifiable(generated),
    exports: List.unmodifiable(exports),
  );
}

Map<String, VersionConstraint> _constraints(Object? source, String label) {
  if (source == null) return const {};
  final map = _map(source, label);
  final result = <String, VersionConstraint>{};
  for (final entry in map.nodes.entries) {
    final name = _stringScalar(entry.key, '$label name');
    if (!_packageName.hasMatch(name)) {
      throw FormatException('$label has invalid package name $name.');
    }
    final value = _stringScalar(entry.value, '$label.$name');
    try {
      result[name] = VersionConstraint.parse(value);
    } on FormatException {
      throw FormatException('$label.$name has invalid constraint $value.');
    }
  }
  return Map.unmodifiable(result);
}

List<String> _stringList(Object? source, String label) {
  if (source == null) return const [];
  if (source is! YamlList) throw FormatException('$label must be a list.');
  return [for (final value in source) _string(value, label)];
}

YamlMap _map(Object? source, String label) {
  if (source is! YamlMap) throw FormatException('$label must be a map.');
  return source;
}

String _string(Object? source, String label) {
  if (source is! String || source.isEmpty) {
    throw FormatException('$label must be a non-empty string.');
  }
  return source;
}

String _stringScalar(YamlNode node, String label) => _string(node.value, label);

void _exactKeys(
  YamlMap map,
  Set<String> allowed,
  String label, {
  Set<String> optional = const {},
}) {
  final keys = map.keys.whereType<String>().toSet();
  if (keys.length != map.length) {
    throw FormatException('$label keys must be strings.');
  }
  final unknown = keys.difference(allowed);
  if (unknown.isNotEmpty) {
    throw FormatException('$label has unknown keys: ${unknown.join(', ')}.');
  }
  final missing = allowed.difference(optional).difference(keys);
  if (missing.isNotEmpty) {
    throw FormatException('$label is missing ${missing.join(', ')}.');
  }
}

void _validateTarget(String target) {
  if (!target.startsWith('@ui/')) {
    throw FormatException('Registry target $target must start with @ui/.');
  }
  _validateRelative(target.substring(4), label: 'registry target');
}

void _validateRelative(String value, {required String label, String? prefix}) {
  if (value.contains('\\') ||
      p.posix.isAbsolute(value) ||
      p.posix.normalize(value) != value ||
      value == '..' ||
      value.startsWith('../') ||
      (prefix != null && !value.startsWith(prefix))) {
    throw FormatException('$label $value must be a normalized safe path.');
  }
}

final _packageName = RegExp(r'^[a-z][a-z0-9_]*$');
