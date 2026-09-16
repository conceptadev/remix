import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import '../packages/remix_cli/lib/src/registry.dart';

/// Derives the bundled registry presets from analyzer-checked Dart source.
///
/// Run without arguments to synchronize every committed preset. Pass `--check`
/// to compare in memory and fail on drift without writing, and `--preset` to
/// narrow the run to one preset.
void main(List<String> arguments) {
  final usage =
      'Usage: dart run tool/build_registry.dart '
      '[--preset ${presetSpecs.keys.join('|')}|all] [--check]';
  final check = arguments.contains('--check');
  final rest = arguments.where((argument) => argument != '--check').toList();
  var preset = 'all';
  if (rest.isNotEmpty) {
    if (rest.first != '--preset' || rest.length != 2) {
      stderr.writeln(usage);
      exitCode = 64;
      return;
    }
    preset = rest[1];
  }
  if (preset != 'all' && !presetSpecs.containsKey(preset)) {
    stderr.writeln(usage);
    exitCode = 64;
    return;
  }

  final repositoryRoot = Directory.current.absolute;
  final pubspec = File(p.join(repositoryRoot.path, 'pubspec.yaml'));
  if (!pubspec.existsSync() ||
      !RegExp(
        r'^name:\s*remix_workspace\s*$',
        multiLine: true,
      ).hasMatch(pubspec.readAsStringSync())) {
    stderr.writeln('Run this tool from the Remix workspace root.');
    exitCode = 64;
    return;
  }

  final selected = preset == 'all' ? presetSpecs.keys : [preset];
  for (final name in selected) {
    if (!_runPreset(repositoryRoot, name, check: check)) {
      exitCode = 1;
      return;
    }
  }
}

/// Derives one preset and either writes or verifies its committed output.
///
/// A preset is a list of specs rather than a single one because the writer
/// may merge a partially owned extension into the tree it owns. Returns false
/// once the preset is stale or underivable, having already reported why.
bool _runPreset(Directory repositoryRoot, String name, {required bool check}) {
  try {
    final builders = [
      for (final spec in presetSpecs[name]!)
        PresetBuilder.forRepository(repositoryRoot, spec: spec),
    ];
    final writer = builders.first;
    var output = writer.derive();
    for (final builder in builders.skip(1)) {
      output = mergePresetOutputs(output, builder.derive());
    }
    if (!check) {
      writer.write(output);
      stdout.writeln(
        'Wrote the $name preset: ${output.files.length - 1} templates and '
        'registry.yaml.',
      );
      return true;
    }

    final drift = writer.drift(output);
    if (drift.isNotEmpty) {
      stderr
        ..writeln('The committed $name preset is stale:')
        ..writeln(drift.map((entry) => '  - $entry').join('\n'))
        ..writeln(
          'Run `dart run tool/build_registry.dart --preset $name` and commit '
          'the result.',
        );
      return false;
    }
    stdout.writeln('The committed $name preset matches authored source.');
    return true;
  } on Object catch (error) {
    stderr.writeln(error);
    return false;
  }
}

/// One derivable source package, and everything that distinguishes it.
///
/// The builder below turns analyzer-checked Dart source into a bundled
/// registry tree. It does not know which package it is reading, what word
/// stands in for the consumer's prefix, or which items exist outside the
/// component directory. Those live here, so a second source package is a new
/// [PresetSpec] rather than a second copy of the builder.
final class PresetSpec {
  const PresetSpec({
    required this.name,
    required this.sourceRoot,
    required this.sourcePackage,
    required this.typeWord,
    required this.valueWord,
    required this.componentDirectory,
    required this.sharedItems,
    required this.copiedItems,
    this.fileItems = const [],
    required this.ignoredSourceFiles,
    required this.floorPackages,
    required this.detectedPackages,
    required this.composedRegistryDependencies,
    this.recipeItems = const [],
    this.behavior,
    this.extensionDirectory,
  });

  /// Preset name, and the directory it occupies under the bundled registry.
  final String name;

  /// Set on an extension: a second source package whose items derive into
  /// this template subtree of another spec's preset. An extension never
  /// writes; the preset's own spec merges and owns the whole tree.
  final String? extensionDirectory;

  String get templateDirectory => extensionDirectory ?? 'templates';

  /// Repository-relative directory of the authored source, e.g.
  /// `registry_source/lib/src/fortal`. Everything under it derives.
  final String sourceRoot;

  /// Name of the package [sourceRoot] belongs to.
  ///
  /// Installed source may never import it: an item ships the source itself.
  final String sourcePackage;

  /// Identifier casing replaced by `{{typePrefix}}`, e.g. `Fortal`.
  final String typeWord;

  /// Lowercase casing replaced by `{{valuePrefix}}`, e.g. `fortal`.
  final String valueWord;

  /// Source directory holding one file per component item.
  final String componentDirectory;

  /// Items assembled from a source directory that components may import.
  final List<SharedItemSpec> sharedItems;

  /// Items copied verbatim from the default preset rather than derived.
  final List<CopiedItemSpec> copiedItems;

  /// Items derived from one authored file at the source root.
  final List<FileItemSpec> fileItems;

  /// Source files that are legal to author but own no registry item.
  final Set<String> ignoredSourceFiles;

  /// Packages whose constraint must be readable from the default registry.
  final Set<String> floorPackages;

  /// Packages declared on an item when its source imports them.
  final List<String> detectedPackages;

  /// Registry dependencies a component composes but never imports.
  ///
  /// Import inference misses `sidebar_layout` -> `sidebar`: its `sidebar`
  /// field is typed `Widget`, not `FortalSidebar`, so nothing imports
  /// `components/sidebar.dart`. The default preset's hand-authored
  /// registry.yaml declares the same dependency for the same reason.
  final Map<String, List<String>> composedRegistryDependencies;

  /// Items derived from `recipes/<name>.dart`: preset-specific stylings of
  /// [behavior], composed from this preset's own components and theme.
  final List<String> recipeItems;

  /// The behavior the recipes style while authoring, and how its import lands
  /// in installed source. Required once [recipeItems] is non-empty.
  final BehaviorSpec? behavior;

  /// Source directories this preset reads, shared items first.
  List<String> get sourceDirectories => [
    for (final item in sharedItems) item.directory,
    componentDirectory,
    if (recipeItems.isNotEmpty) recipeDirectory,
  ];

  static const recipeDirectory = 'recipes';

  /// Item name owning each shared source directory.
  Map<String, String> get itemsByDirectory => {
    for (final item in sharedItems) item.directory: item.name,
  };

  /// Package imports that must never appear in installed source.
  List<String> get forbiddenImportPrefixes => [
    'package:$sourcePackage/',
    'package:mix/',
    'package:naked_ui/',
  ];
}

/// An item derived from every file in one source directory.
final class SharedItemSpec {
  const SharedItemSpec({
    required this.name,
    required this.directory,
    required this.requiredFile,
    required this.packages,
    required this.exports,
    this.registryDependencies = const [],
  });

  final String name;

  /// Source directory, also the installed target directory under `@ui/`.
  final String directory;

  /// Source path that must exist, or the preset is not derivable.
  final String requiredFile;

  final Set<String> packages;
  final List<String> exports;
  final List<String> registryDependencies;
}

/// An item taken verbatim from the default preset instead of from source.
final class CopiedItemSpec {
  const CopiedItemSpec({
    required this.name,
    required this.templatePath,
    required this.target,
    required this.registryDependencies,
    required this.packages,
    required this.exports,
  });

  final String name;
  final String templatePath;
  final String target;
  final List<String> registryDependencies;
  final Set<String> packages;
  final List<String> exports;
}

/// An item derived from a single file at the source root, e.g. `icons.dart`.
final class FileItemSpec {
  const FileItemSpec({
    required this.name,
    required this.file,
    required this.packages,
    required this.registryDependencies,
    required this.exports,
  });

  final String name;

  /// Source path relative to `lib/src`, also the installed path under `@ui/`.
  final String file;

  final Set<String> packages;
  final List<String> registryDependencies;
  final List<String> exports;
}

/// Behavior a preset's recipes style: the sibling source directory it is
/// authored in, and the word that source is authored under.
///
/// A recipe is analyzed against that source, so it names
/// `AgentComposerStyler` and imports `../../agent/components/composer.dart`.
/// The installed recipe sits beside the installed behavior instead, so the
/// derivation rewrites that import to `../components/` and the identifier
/// prefix `Agent` to the consumer prefix, before the preset's own word goes.
final class BehaviorSpec {
  const BehaviorSpec({
    required this.directory,
    required this.typeWord,
    required this.valueWord,
    required this.componentDirectory,
  });

  /// Directory beside the preset's [PresetSpec.sourceRoot], e.g. `agent`.
  final String directory;
  final String typeWord;
  final String valueWord;
  final String componentDirectory;

  /// The authoring import prefix that becomes `../` in installed source.
  String get importPrefix => '../../$directory/';
}

/// Agent behavior as recipes reach it: `registry_source/lib/src/agent`.
const agentBehavior = BehaviorSpec(
  directory: 'agent',
  typeWord: 'Agent',
  valueWord: 'agent',
  componentDirectory: 'components',
);

/// The eight Agent surfaces each preset styles. Dependencies are inferred
/// from each recipe's imports.
const agentRecipes = [
  'activity_recipe',
  'answer_recipe',
  'composer_recipe',
  'execution_recipe',
  'message_recipe',
  'permission_recipe',
  'plan_recipe',
  'transcript_recipe',
];

/// The default preset as application-owned registry source.
///
/// `Vanilla` is the authoring word: it stands in for the consumer prefix and
/// appears nowhere else in the source, so plain substitution is exact.
const defaultPreset = PresetSpec(
  name: 'default',
  sourceRoot: 'registry_source/lib/src/default',
  sourcePackage: 'registry_source',
  typeWord: 'Vanilla',
  valueWord: 'vanilla',
  componentDirectory: 'components',
  sharedItems: [
    SharedItemSpec(
      name: 'theme',
      directory: 'theme',
      requiredFile: 'theme/tokens.dart',
      packages: {'remix'},
      exports: [
        'theme/tokens.dart',
        'theme/theme_data.dart',
        'theme/theme_scope.dart',
      ],
    ),
  ],
  copiedItems: [],
  fileItems: [
    FileItemSpec(
      name: 'icons',
      file: 'icons.dart',
      packages: {'remix_ui_icons'},
      registryDependencies: ['theme'],
      exports: ['icons.dart'],
    ),
  ],
  ignoredSourceFiles: {},
  floorPackages: {
    'remix',
    'mix_annotations',
    'build_runner',
    'mix_generator',
    'mix_chart',
    'remix_ui_icons',
  },
  detectedPackages: ['mix_chart', 'remix_ui_icons'],
  // A layout, not a styled component: `sidebar_layout` composes an installed
  // Sidebar through a `Widget`-typed field, so its source never imports
  // components/sidebar.dart and import inference alone would miss it.
  composedRegistryDependencies: {
    'sidebar_layout': ['sidebar'],
  },
  recipeItems: agentRecipes,
  behavior: agentBehavior,
);

/// The Fortal design system as application-owned registry source.
const fortalPreset = PresetSpec(
  name: 'fortal',
  sourceRoot: 'registry_source/lib/src/fortal',
  sourcePackage: 'registry_source',
  typeWord: 'Fortal',
  valueWord: 'fortal',
  componentDirectory: 'components',
  sharedItems: [
    SharedItemSpec(
      name: 'theme',
      directory: 'theme',
      requiredFile: 'theme/theme.dart',
      packages: {'remix'},
      exports: ['theme/theme.dart'],
    ),
  ],
  copiedItems: [
    CopiedItemSpec(
      name: 'icons',
      templatePath: 'templates/icons/icons.dart.tmpl',
      target: '@ui/icons.dart',
      registryDependencies: ['theme'],
      packages: {'remix_ui_icons'},
      exports: ['icons.dart'],
    ),
  ],
  // Authored for the package's own use. The registry item copies the default
  // preset's icons template instead, so this file owns no item.
  ignoredSourceFiles: {'icons.dart'},
  floorPackages: {
    'remix',
    'mix_annotations',
    'build_runner',
    'mix_generator',
    'mix_chart',
    'remix_ui_icons',
  },
  detectedPackages: ['mix_chart', 'remix_ui_icons'],
  composedRegistryDependencies: {
    'sidebar_layout': ['sidebar'],
  },
  recipeItems: agentRecipes,
  behavior: agentBehavior,
);

/// Agent behavior merged into the Fortal preset. The Fortal spec owns the
/// tree; this extension only derives into `templates/agent/`.
const fortalAgentExtension = PresetSpec(
  name: 'fortal',
  sourceRoot: 'registry_source/lib/src/agent',
  sourcePackage: 'registry_source',
  typeWord: 'Agent',
  valueWord: 'agent',
  componentDirectory: 'components',
  extensionDirectory: 'templates/agent',
  sharedItems: [
    SharedItemSpec(
      name: 'models',
      directory: 'models',
      requiredFile: 'models/statuses.dart',
      packages: {},
      exports: [
        'models/activity_item.dart',
        'models/plan_item.dart',
        'models/statuses.dart',
      ],
    ),
    SharedItemSpec(
      name: 'support',
      directory: 'support',
      requiredFile: 'support/functional_glyph.dart',
      packages: {},
      registryDependencies: ['theme'],
      exports: [],
    ),
  ],
  copiedItems: [],
  ignoredSourceFiles: {},
  floorPackages: {
    'mix_annotations',
    'build_runner',
    'mix_generator',
    'remix_ui_icons',
  },
  detectedPackages: ['remix_ui_icons'],
  composedRegistryDependencies: {},
);

/// Agent behavior merged into the default preset, as above.
const defaultAgentExtension = PresetSpec(
  name: 'default',
  sourceRoot: 'registry_source/lib/src/agent',
  sourcePackage: 'registry_source',
  typeWord: 'Agent',
  valueWord: 'agent',
  componentDirectory: 'components',
  extensionDirectory: 'templates/agent',
  sharedItems: [
    SharedItemSpec(
      name: 'models',
      directory: 'models',
      requiredFile: 'models/statuses.dart',
      packages: {},
      exports: [
        'models/activity_item.dart',
        'models/plan_item.dart',
        'models/statuses.dart',
      ],
    ),
    SharedItemSpec(
      name: 'support',
      directory: 'support',
      requiredFile: 'support/functional_glyph.dart',
      packages: {},
      // The source imports Remix primitives, not the installed theme, but the
      // existing theme item is the sole owner of the default Remix floor.
      registryDependencies: ['theme'],
      exports: [],
    ),
  ],
  copiedItems: [],
  ignoredSourceFiles: {},
  floorPackages: {
    'mix_annotations',
    'build_runner',
    'mix_generator',
    'remix_ui_icons',
  },
  detectedPackages: ['remix_ui_icons'],
  composedRegistryDependencies: {},
);

/// Every bundled preset and the specs that derive it, writer first.
///
/// The first spec owns the preset. Any spec after it is an extension whose
/// items derive from a second source package into the same tree.
const presetSpecs = <String, List<PresetSpec>>{
  'default': [defaultPreset, defaultAgentExtension],
  'fortal': [fortalPreset, fortalAgentExtension],
};

PresetOutput mergePresetOutputs(PresetOutput base, PresetOutput extension) {
  final files = <String, String>{...base.files};
  for (final entry in extension.files.entries) {
    if (entry.key == 'registry.yaml') continue;
    if (files.containsKey(entry.key)) {
      throw StateError('Preset outputs collide at ${entry.key}.');
    }
    files[entry.key] = entry.value;
  }
  final items = <String, YamlMap>{};
  final targets = <String, String>{};
  for (final output in [base, extension]) {
    final document = loadYaml(output.files['registry.yaml']!) as YamlMap;
    final entries = document['items'] as YamlMap?;
    if (entries == null) continue;
    for (final entry in entries.entries) {
      final name = entry.key as String;
      if (items.containsKey(name)) {
        throw StateError('Preset items collide at $name.');
      }
      final item = entry.value as YamlMap;
      items[name] = item;
      final sources = item['files'] as YamlList? ?? const [];
      for (final source in sources) {
        if (!files.containsKey(source['source'])) {
          throw StateError(
            'Preset item $name references missing template ${source['source']}.',
          );
        }
      }
      final paths = [
        for (final source in sources) source['target'] as String,
        ...?item['generated'] as YamlList?,
      ];
      for (final target in paths.cast<String>()) {
        final previous = targets[target];
        if (previous != null) {
          throw StateError(
            'Preset targets collide at $target ($previous and $name).',
          );
        }
        targets[target] = name;
      }
    }
  }
  for (final entry in items.entries) {
    for (final dependency
        in entry.value['registryDependencies'] as YamlList? ?? const []) {
      if (!items.containsKey(dependency)) {
        throw StateError(
          'Preset item ${entry.key} has missing dependency $dependency.',
        );
      }
    }
  }
  String body(String yaml) =>
      yaml.substring(yaml.indexOf('items:') + 7).trimRight();
  files['registry.yaml'] =
      '${base.files['registry.yaml']!.split('items:').first}items:\n${body(base.files['registry.yaml']!)}\n\n${body(extension.files['registry.yaml']!)}\n';
  return PresetOutput(
    files: Map.unmodifiable(files),
    sourceByTemplate: Map.unmodifiable({
      ...base.sourceByTemplate,
      ...extension.sourceByTemplate,
    }),
  );
}

/// A deterministic snapshot of every file owned by one derived preset.
final class PresetOutput {
  const PresetOutput({required this.files, required this.sourceByTemplate});

  /// Output paths relative to the preset root. `registry.yaml` is an in-memory
  /// metadata snapshot; partial-preset writers assert it instead of writing it.
  final Map<String, String> files;

  /// Original authored source keyed by its derived template output path.
  ///
  /// This makes the substitution round trip directly testable without
  /// exposing filesystem implementation details.
  final Map<String, String> sourceByTemplate;
}

/// Builds one bundled registry tree from analyzer-checked Dart source.
final class PresetBuilder {
  const PresetBuilder({
    required this.spec,
    required this.sourceRoot,
    required this.defaultRegistryRoot,
    required this.outputRoot,
  });

  factory PresetBuilder.forRepository(
    Directory repositoryRoot, {
    PresetSpec spec = fortalPreset,
  }) {
    final registryRoot = Directory(
      p.join(
        repositoryRoot.path,
        'packages',
        'remix_cli',
        'lib',
        'src',
        'registry',
      ),
    );
    return PresetBuilder(
      spec: spec,
      sourceRoot: Directory(
        p.joinAll([repositoryRoot.path, ...p.posix.split(spec.sourceRoot)]),
      ),
      defaultRegistryRoot: Directory(p.join(registryRoot.path, 'default')),
      outputRoot: Directory(p.join(registryRoot.path, spec.name)),
    );
  }

  final PresetSpec spec;
  final Directory sourceRoot;
  final Directory defaultRegistryRoot;
  final Directory outputRoot;

  PresetOutput derive() {
    if (!sourceRoot.existsSync()) {
      throw FormatException(
        '${spec.name} source root is missing: ${sourceRoot.path}',
      );
    }

    final sources = _readSources();
    _validateSources(sources);

    final floors = _readDefaultFloors();
    final output = <String, String>{};
    final sourceByTemplate = <String, String>{};
    final items = <String, _RegistryItemDraft>{};
    final componentPrefix = '${spec.componentDirectory}/';
    final componentNames = {
      for (final path in sources.keys)
        if (path.startsWith(componentPrefix))
          p.posix.basenameWithoutExtension(path),
    };

    for (final shared in spec.sharedItems) {
      final sharedSources = sources.entries
          .where((entry) => entry.key.startsWith('${shared.directory}/'))
          .toList();
      if (!sharedSources.any((entry) => entry.key == shared.requiredFile)) {
        throw FormatException(
          '${spec.name} source must contain ${shared.requiredFile} and the '
          'rest of ${shared.directory}/.',
        );
      }

      final files = <_RegistryFileDraft>[];
      for (final entry in sharedSources) {
        final name = p.posix.basename(entry.key);
        final templatePath =
            '${spec.templateDirectory}/${shared.directory}/$name.tmpl';
        output[templatePath] = _templateFor(entry.key, entry.value);
        sourceByTemplate[templatePath] = entry.value;
        files.add(
          _RegistryFileDraft(
            source: templatePath,
            target: '@ui/${shared.directory}/$name',
          ),
        );
      }
      items[shared.name] = _RegistryItemDraft(
        name: shared.name,
        registryDependencies: {
          ...shared.registryDependencies,
          for (final entry in sharedSources)
            ..._registryDependencies(
              sourcePath: entry.key,
              imports: _imports(entry.value),
              componentNames: componentNames,
            ),
        }.toList(),
        dependencies: {
          for (final package in shared.packages) package: floors[package]!,
          for (final package in spec.detectedPackages)
            if (sharedSources.any(
              (entry) => _imports(
                entry.value,
              ).any((uri) => uri.startsWith('package:$package/')),
            ))
              package: floors[package]!,
        },
        files: files,
        exports: shared.exports,
      );
    }

    for (final copied in spec.copiedItems) {
      final template = File(
        p.joinAll([
          defaultRegistryRoot.path,
          ...p.posix.split(copied.templatePath),
        ]),
      );
      if (!template.existsSync()) {
        throw FormatException(
          'Default ${copied.name} template is missing: ${template.path}',
        );
      }
      output[copied.templatePath] = template.readAsStringSync();
      items[copied.name] = _RegistryItemDraft(
        name: copied.name,
        registryDependencies: copied.registryDependencies,
        dependencies: {
          for (final package in copied.packages) package: floors[package]!,
        },
        files: [
          _RegistryFileDraft(
            source: copied.templatePath,
            target: copied.target,
          ),
        ],
        exports: copied.exports,
      );
    }

    for (final item in spec.fileItems) {
      final source = sources[item.file];
      if (source == null) {
        throw FormatException('${spec.name} source must contain ${item.file}.');
      }
      final name = p.posix.basename(item.file);
      final templatePath = '${spec.templateDirectory}/${item.name}/$name.tmpl';
      final imports = _imports(source);
      output[templatePath] = _templateFor(item.file, source);
      sourceByTemplate[templatePath] = source;
      items[item.name] = _RegistryItemDraft(
        name: item.name,
        registryDependencies: {
          ...item.registryDependencies,
          ..._registryDependencies(
            sourcePath: item.file,
            imports: imports,
            componentNames: componentNames,
          ),
        }.toList(),
        dependencies: {
          for (final package in item.packages) package: floors[package]!,
          for (final package in spec.detectedPackages)
            if (imports.any((uri) => uri.startsWith('package:$package/')))
              package: floors[package]!,
        },
        files: [
          _RegistryFileDraft(source: templatePath, target: '@ui/${item.file}'),
        ],
        exports: item.exports,
      );
    }

    for (final entry in sources.entries.where(
      (entry) => entry.key.startsWith(componentPrefix),
    )) {
      final name = p.posix.basenameWithoutExtension(entry.key);
      final templatePath = '${spec.templateDirectory}/$name/$name.dart.tmpl';
      final generated = _generatedPart(entry.value);
      final imports = _imports(entry.value);
      final registryDependencies = _registryDependencies(
        sourcePath: entry.key,
        imports: imports,
        componentNames: componentNames,
      );
      final dependencies = <String, String>{};
      final devDependencies = <String, String>{};
      if (generated != null) {
        dependencies['mix_annotations'] = floors['mix_annotations']!;
        devDependencies
          ..['build_runner'] = floors['build_runner']!
          ..['mix_generator'] = floors['mix_generator']!;
      }
      for (final package in spec.detectedPackages) {
        if (imports.any((uri) => uri.startsWith('package:$package/'))) {
          dependencies[package] = floors[package]!;
        }
      }

      output[templatePath] = _templateFor(entry.key, entry.value);
      sourceByTemplate[templatePath] = entry.value;
      items[name] = _RegistryItemDraft(
        name: name,
        registryDependencies: registryDependencies,
        dependencies: dependencies,
        devDependencies: devDependencies,
        files: [
          _RegistryFileDraft(
            source: templatePath,
            target: '@ui/$componentPrefix$name.dart',
          ),
        ],
        generated: generated == null
            ? const []
            : ['@ui/$componentPrefix$generated'],
        exports: ['$componentPrefix$name.dart'],
      );
    }

    final recipePrefix = '${PresetSpec.recipeDirectory}/';
    final recipeSources = sources.keys.where(
      (path) => path.startsWith(recipePrefix),
    );
    for (final path in recipeSources) {
      final name = p.posix.basenameWithoutExtension(path);
      if (!spec.recipeItems.contains(name)) {
        throw FormatException('$path is not a declared ${spec.name} recipe.');
      }
    }
    for (final name in spec.recipeItems) {
      final path = '$recipePrefix$name.dart';
      final authored = sources[path];
      if (authored == null) {
        throw FormatException('${spec.name} source must contain $path.');
      }
      final source = _recipeSource(path, authored);
      final templatePath = '${spec.templateDirectory}/$path.tmpl';
      output[templatePath] = _templateFor(path, source);
      sourceByTemplate[templatePath] = source;
      items[name] = _RegistryItemDraft(
        name: name,
        registryDependencies: _registryDependencies(
          sourcePath: path,
          imports: _imports(source),
          componentNames: componentNames,
          // The behavior components live in the extension, so they are
          // validated when the preset outputs merge rather than here.
          allowForeignComponents: true,
        ),
        files: [_RegistryFileDraft(source: templatePath, target: '@ui/$path')],
        exports: [path],
      );
    }

    final expected =
        componentNames.length +
        spec.sharedItems.length +
        spec.copiedItems.length +
        spec.fileItems.length +
        spec.recipeItems.length;
    if (items.length != expected) {
      throw StateError('${spec.name} registry item names collided.');
    }

    output['registry.yaml'] = _renderRegistry(items);
    return PresetOutput(
      files: Map.unmodifiable(_sortedMap(output)),
      sourceByTemplate: Map.unmodifiable(_sortedMap(sourceByTemplate)),
    );
  }

  /// Synchronizes the whole tree beneath [outputRoot] to [output].
  void write(PresetOutput output) {
    _validateOutput(output);
    outputRoot.createSync(recursive: true);
    final expected = output.files.keys.toSet();
    for (final file in _outputFiles()) {
      final relative = _relative(file, outputRoot);
      if (!expected.contains(relative)) file.deleteSync();
    }
    for (final entry in output.files.entries) {
      final file = File(
        p.joinAll([outputRoot.path, ...p.posix.split(entry.key)]),
      );
      if (file.existsSync() && file.readAsStringSync() == entry.value) continue;
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(entry.value);
    }
  }

  /// Returns stable, human-readable differences without mutating output.
  List<String> drift(PresetOutput output) {
    _validateOutput(output);
    final differences = <String>[];
    final actual = {
      for (final file in _outputFiles()) _relative(file, outputRoot): file,
    };
    for (final entry in output.files.entries) {
      final file = actual.remove(entry.key);
      if (file == null) {
        differences.add('missing ${entry.key}');
      } else if (file.readAsStringSync() != entry.value) {
        differences.add('changed ${entry.key}');
      }
    }
    for (final stale in actual.keys) {
      differences.add('stale $stale');
    }
    differences.sort();
    return differences;
  }

  /// Reject the entire write before pruning, including links already on disk.
  ///
  /// Only a preset's own spec writes; an extension's output is merged into
  /// it first, so the registry it validates is always the whole preset.
  void _validateOutput(PresetOutput output) {
    if (spec.extensionDirectory != null) {
      throw StateError(
        '${spec.name} extension output must be merged into the preset before '
        'it is written or checked.',
      );
    }
    final registry = output.files['registry.yaml'];
    if (registry == null) {
      throw const FormatException('Missing derived registry metadata.');
    }
    for (final path in output.files.keys) {
      _validateRelativeOutput(path);
      _rejectOutputLinks(path);
    }
    // Validate even when the derived output is empty.
    _rejectOutputLinks('.');
    _outputFiles();
    validate(output);
  }

  /// Holds a merged preset to the contract the installer enforces: no
  /// dependency cycles or target collisions, and every relative import in an
  /// installed recipe resolving to something the preset also installs.
  void validate(PresetOutput output) {
    final document = loadYaml(output.files['registry.yaml']!);
    if (document is! YamlMap || document['items'] is! YamlMap) {
      throw const FormatException('Registry must contain an items map.');
    }
    RegistryCatalog.parse(
      jsonEncode(document),
      preset: spec.name,
      rootUri: outputRoot.uri,
    );
    final items = document['items'] as YamlMap;
    final targets = <String>{
      for (final item in items.values)
        for (final file in item['files'] as YamlList? ?? const [])
          file['target'] as String,
    };
    for (final entry in items.entries) {
      for (final file in entry.value['files'] as YamlList? ?? const []) {
        final source = file['source'] as String;
        final target = file['target'] as String;
        for (final uri in _imports(output.files[source] ?? '')) {
          if (uri.startsWith('package:') || uri.startsWith('dart:')) continue;
          final resolved = p.posix.normalize(
            p.posix.join(p.posix.dirname(target), uri),
          );
          if (!targets.contains(resolved)) {
            throw FormatException(
              '${entry.key} imports $uri, which nothing in the ${spec.name} '
              'preset installs.',
            );
          }
        }
      }
    }
  }

  void _validateRelativeOutput(String path) {
    if (path.isEmpty ||
        path == '.' ||
        path.contains('\\') ||
        p.posix.isAbsolute(path) ||
        p.windows.isAbsolute(path) ||
        p.posix.normalize(path) != path ||
        p.posix.split(path).contains('..')) {
      throw FormatException('Unsafe output path: $path');
    }
  }

  void _rejectOutputLinks(String relative) {
    var current = outputRoot.path;
    for (final segment in ['', ...p.posix.split(relative)]) {
      if (segment.isNotEmpty) current = p.join(current, segment);
      if (FileSystemEntity.typeSync(current, followLinks: false) ==
          FileSystemEntityType.link) {
        throw FormatException('Output path contains a symbolic link: $current');
      }
    }
  }

  Map<String, String> _readSources() {
    final files =
        sourceRoot
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .where(
              (file) =>
                  file.path.endsWith('.dart') && !file.path.endsWith('.g.dart'),
            )
            .toList()
          ..sort((left, right) => left.path.compareTo(right.path));
    return {
      for (final file in files)
        _relative(file, sourceRoot): file.readAsStringSync(),
    };
  }

  void _validateSources(Map<String, String> sources) {
    final failures = <String>[];
    for (final entry in sources.entries) {
      final path = entry.key;
      final content = entry.value;
      if (p.posix
          .split(path)
          .any((segment) => segment.toLowerCase().contains(spec.valueWord))) {
        failures.add('$path: a path segment contains "${spec.valueWord}"');
      }
      if (content.contains('{{')) {
        failures.add('$path: source contains the reserved template token "{{"');
      }
      final behavior = spec.behavior;
      final recipe = path.startsWith('${PresetSpec.recipeDirectory}/');
      for (final match in _directivePattern.allMatches(content)) {
        final uri = match.group(2)!;
        if (uri.contains(spec.typeWord) || uri.contains(spec.valueWord)) {
          failures.add('$path: directive URI would be rewritten: $uri');
        }
        if (!uri.startsWith('package:') && !uri.startsWith('dart:')) {
          final resolved = p.posix.normalize(
            p.posix.join(p.posix.dirname(path), uri),
          );
          final generated = match.group(1) == 'part' && uri.endsWith('.g.dart');
          if (resolved.startsWith('../')) {
            // Only a recipe may leave the preset, and only for the behavior
            // components it styles. Anything else would install an import
            // that points outside the application's own tree.
            final components =
                '${behavior?.importPrefix}${behavior?.componentDirectory}/';
            if (behavior == null || !recipe) {
              failures.add('$path: only recipes may import $uri');
            } else if (!uri.startsWith(components) ||
                uri.contains('/', components.length)) {
              failures.add(
                '$path: recipes import behavior components only: $uri',
              );
            } else if (!File(
              p.joinAll([sourceRoot.path, ...p.posix.split(resolved)]),
            ).existsSync()) {
              failures.add('$path: missing behavior source $uri');
            }
          } else if (!generated && !sources.containsKey(resolved)) {
            failures.add('$path: missing relative source $uri');
          }
        }
        if (spec.forbiddenImportPrefixes.any(uri.startsWith)) {
          failures.add('$path: forbidden installed-source import $uri');
        }
      }
      if (recipe && behavior == null) {
        failures.add('$path: ${spec.name} declares no behavior to style');
      }
      if (!spec.ignoredSourceFiles.contains(path) &&
          !spec.fileItems.any((item) => item.file == path) &&
          !spec.sourceDirectories.any(
            (directory) => path.startsWith('$directory/'),
          )) {
        failures.add('$path: unsupported ${spec.name} source placement');
      }
    }
    if (failures.isNotEmpty) {
      failures.sort();
      throw FormatException(
        'Cannot derive the ${spec.name} preset:\n'
        '${failures.map((failure) => '  - $failure').join('\n')}',
      );
    }
  }

  Map<String, String> _readDefaultFloors() {
    final registry = File(p.join(defaultRegistryRoot.path, 'registry.yaml'));
    if (!registry.existsSync()) {
      throw FormatException('Default registry is missing: ${registry.path}');
    }
    final document = loadYaml(registry.readAsStringSync());
    if (document is! YamlMap || document['items'] is! YamlMap) {
      throw FormatException('${registry.path} is not a registry map.');
    }
    final constraints = <String, Set<String>>{};
    for (final item in (document['items'] as YamlMap).values) {
      if (item is! YamlMap) continue;
      for (final sectionName in const ['dependencies', 'devDependencies']) {
        final section = item[sectionName];
        if (section is! YamlMap) continue;
        for (final entry in section.entries) {
          if (entry.key is String && entry.value is String) {
            constraints
                .putIfAbsent(entry.key as String, () => <String>{})
                .add(entry.value as String);
          }
        }
      }
    }

    final floors = <String, String>{};
    for (final package in spec.floorPackages) {
      final values = constraints[package];
      if (values == null || values.length != 1) {
        throw FormatException(
          'Default registry must declare one $package constraint; found '
          '${values?.join(', ') ?? 'none'}.',
        );
      }
      floors[package] = values.single;
    }
    return floors;
  }

  /// Rewrites an authored recipe into the form an application authored under
  /// this preset's own word would hold, so [_templateFor] can take it from
  /// there with its round trip intact.
  ///
  /// The behavior import becomes the relative path the installed behavior
  /// lives at, and the behavior's identifier prefix becomes the preset word.
  /// Only identifier-initial occurrences move: `FortalAgentComposerRecipe`
  /// keeps its domain name, `AgentComposerStyler` becomes the installed
  /// `FortalComposerStyler`. Directives are re-sorted afterwards because the
  /// rewritten import changes group.
  String _recipeSource(String path, String authored) {
    final behavior = spec.behavior;
    if (behavior == null) {
      throw StateError('${spec.name} recipes need a behavior spec.');
    }
    final rewritten = authored
        .replaceAll(behavior.importPrefix, '../')
        .replaceAllMapped(
          RegExp('(?<![A-Za-z0-9_])${behavior.typeWord}(?=[A-Z])'),
          (_) => spec.typeWord,
        )
        .replaceAllMapped(
          RegExp('(?<![A-Za-z0-9_])${behavior.valueWord}(?=[A-Z])'),
          (_) => spec.valueWord,
        );
    return _sortDirectives(path, rewritten);
  }

  /// Swaps the preset's own naming for the consumer prefix placeholders.
  ///
  /// The round trip is asserted rather than assumed: a substitution that does
  /// not reverse exactly means the source says the preset's name somewhere the
  /// consumer's prefix does not belong.
  String _templateFor(String path, String source) {
    final template = source
        .replaceAll(spec.typeWord, '{{typePrefix}}')
        .replaceAll(spec.valueWord, '{{valuePrefix}}');
    final roundTrip = template
        .replaceAll('{{typePrefix}}', spec.typeWord)
        .replaceAll('{{valuePrefix}}', spec.valueWord);
    if (roundTrip != source) {
      throw StateError('$path did not survive the template round trip.');
    }
    return template;
  }

  /// Infers one item's registry dependencies from its relative imports.
  List<String> _registryDependencies({
    required String sourcePath,
    required List<String> imports,
    required Set<String> componentNames,
    bool allowForeignComponents = false,
  }) {
    final owners = spec.itemsByDirectory;
    final dependencies = <String>{};
    for (final uri in imports) {
      if (uri.startsWith('package:') || uri.startsWith('dart:')) continue;
      final resolved = p.posix.normalize(
        p.posix.join(p.posix.dirname(sourcePath), uri),
      );
      final directory = p.posix.split(resolved).first;
      final owner = owners[directory];
      if (owner != null) {
        if (owner == owners[p.posix.split(sourcePath).first]) continue;
        dependencies.add(owner);
        continue;
      }
      if (directory != spec.componentDirectory) continue;
      final component = p.posix.basenameWithoutExtension(resolved);
      if (component == p.posix.basenameWithoutExtension(sourcePath)) continue;
      if (!componentNames.contains(component) && !allowForeignComponents) {
        throw FormatException(
          '$sourcePath imports missing component source $uri.',
        );
      }
      dependencies.add(component);
    }
    final name = p.posix.basenameWithoutExtension(sourcePath);
    for (final component
        in spec.composedRegistryDependencies[name] ?? const []) {
      if (!componentNames.contains(component)) {
        throw FormatException(
          '$sourcePath declares missing component dependency $component.',
        );
      }
      dependencies.add(component);
    }
    // Shared items lead, in spec order, so a graph reads foundation-first the
    // way the hand-authored default registry does.
    return [
      for (final shared in spec.sharedItems)
        if (dependencies.remove(shared.name)) shared.name,
      ...dependencies.toList()..sort(),
    ];
  }

  /// Renders `registry.yaml`: shared, copied, and file items, then components.
  String _renderRegistry(Map<String, _RegistryItemDraft> items) {
    final leading = [
      for (final shared in spec.sharedItems) shared.name,
      for (final copied in spec.copiedItems) copied.name,
      for (final item in spec.fileItems) item.name,
    ];
    final ordered = <_RegistryItemDraft>[
      for (final name in leading) items[name]!,
      ...items.entries
          .where((entry) => !leading.contains(entry.key))
          .map((entry) => entry.value)
          .toList()
        ..sort((left, right) => left.name.compareTo(right.name)),
    ];
    final buffer = StringBuffer()
      ..writeln('# Generated by tool/build_registry.dart. Do not edit.')
      ..writeln('schema: 1')
      ..writeln('items:');
    for (final item in ordered) {
      buffer.writeln('  ${item.name}:');
      _writeStringList(
        buffer,
        'registryDependencies',
        item.registryDependencies,
      );
      _writeConstraintMap(buffer, 'dependencies', item.dependencies);
      _writeConstraintMap(buffer, 'devDependencies', item.devDependencies);
      buffer.writeln('    files:');
      for (final file in item.files) {
        buffer
          ..writeln('      - source: ${file.source}')
          ..writeln('        target: "${file.target}"');
      }
      _writeStringList(buffer, 'generated', item.generated, quote: true);
      _writeStringList(buffer, 'exports', item.exports);
      buffer.writeln();
    }
    return '${buffer.toString().trimRight()}\n';
  }

  List<File> _outputFiles() {
    _rejectOutputLinks('.');
    if (!outputRoot.existsSync()) return const [];
    final entries = outputRoot.listSync(recursive: true, followLinks: false);
    for (final link in entries.whereType<Link>()) {
      throw FormatException('Output contains a symbolic link: ${link.path}');
    }
    return entries.whereType<File>().toList()
      ..sort((left, right) => left.path.compareTo(right.path));
  }
}

final class _RegistryItemDraft {
  const _RegistryItemDraft({
    required this.name,
    this.registryDependencies = const [],
    this.dependencies = const {},
    this.devDependencies = const {},
    required this.files,
    this.generated = const [],
    required this.exports,
  });

  final String name;
  final List<String> registryDependencies;
  final Map<String, String> dependencies;
  final Map<String, String> devDependencies;
  final List<_RegistryFileDraft> files;
  final List<String> generated;
  final List<String> exports;
}

final class _RegistryFileDraft {
  const _RegistryFileDraft({required this.source, required this.target});

  final String source;
  final String target;
}

List<String> _imports(String source) => [
  for (final match in _importPattern.allMatches(source)) match.group(1)!,
];

String? _generatedPart(String source) {
  final matches = RegExp(
    r'''^\s*part\s+['"]([^'"]+\.g\.dart)['"]\s*;''',
    multiLine: true,
  ).allMatches(source).toList();
  if (matches.length > 1) {
    throw const FormatException(
      'A component declares multiple generated parts.',
    );
  }
  return matches.singleOrNull?.group(1);
}

void _writeStringList(
  StringBuffer buffer,
  String name,
  List<String> values, {
  bool quote = false,
}) {
  if (values.isEmpty) return;
  buffer.writeln('    $name:');
  for (final value in values) {
    buffer.writeln('      - ${quote ? '"$value"' : value}');
  }
}

void _writeConstraintMap(
  StringBuffer buffer,
  String name,
  Map<String, String> values,
) {
  if (values.isEmpty) return;
  buffer.writeln('    $name:');
  for (final key in values.keys.toList()..sort()) {
    buffer.writeln('      $key: ${values[key]}');
  }
}

Map<String, String> _sortedMap(Map<String, String> source) {
  final keys = source.keys.toList()..sort();
  return {for (final key in keys) key: source[key]!};
}

String _relative(File file, Directory root) =>
    p.posix.joinAll(p.split(p.relative(file.path, from: root.path)));

final _importPattern = RegExp(
  r'''^\s*import\s+['"]([^'"]+)['"]''',
  multiLine: true,
);

/// Re-sorts a file's single-line import block into `dart:`, `package:`, and
/// relative groups, one blank line apart, the way `directives_ordering` reads
/// it. Anything else inside the block is refused rather than moved.
String _sortDirectives(String path, String source) {
  final lines = source.split('\n');
  final indexes = [
    for (var i = 0; i < lines.length; i++)
      if (lines[i].startsWith('import ')) i,
  ];
  if (indexes.isEmpty) return source;
  final block = lines.sublist(indexes.first, indexes.last + 1);
  if (block.any(
    (line) => !line.startsWith('import ') && line.trim().isNotEmpty,
  )) {
    throw FormatException('$path: imports must be single-line and contiguous.');
  }
  String uri(String line) => _importPattern.firstMatch(line)!.group(1)!;
  final imports = block.where((line) => line.startsWith('import ')).toList();
  final groups = [
    for (final test in [
      (String u) => u.startsWith('dart:'),
      (String u) => u.startsWith('package:'),
      (String u) => !u.startsWith('dart:') && !u.startsWith('package:'),
    ])
      imports.where((line) => test(uri(line))).toList()
        ..sort((a, b) => uri(a).compareTo(uri(b))),
  ];
  final sorted = <String>[];
  for (final group in groups) {
    if (group.isEmpty) continue;
    if (sorted.isNotEmpty) sorted.add('');
    sorted.addAll(group);
  }
  return [
    ...lines.sublist(0, indexes.first),
    ...sorted,
    ...lines.sublist(indexes.last + 1),
  ].join('\n');
}

final _directivePattern = RegExp(
  r'''^\s*(import|export|part)\s+['"]([^'"]+)['"]''',
  multiLine: true,
);
