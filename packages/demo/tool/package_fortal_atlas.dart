import 'dart:convert';
import 'dart:io';

import 'package:mix_atlas_capture/producer.dart';

void main(List<String> arguments) {
  final unknown = arguments.where((argument) => argument != '--check').toList();
  if (unknown.isNotEmpty) {
    stderr.writeln('Unknown arguments: ${unknown.join(' ')}');
    exitCode = 64;

    return;
  }

  final checkOnly = arguments.contains('--check');
  final packageRoot = Directory.current;
  final workspaceRoot = packageRoot.parent.parent;
  final sourceRoot = Directory('${packageRoot.path}/test/atlas/goldens');
  final bundleRoot = Directory('${workspaceRoot.path}/atlas/fortal');
  final input = AtlasCapturePackageInput(
    sourceDirectory: sourceRoot,
    outputDirectory: bundleRoot,
    metadata: AtlasCapturePackageMetadata(
      id: 'fortal',
      atlasVersion: '0.1.0',
      mixProtocolVersion: '1.0.0',
      mixProtocolFormat: 1,
      flutterVersion: _flutterVersion(workspaceRoot),
      catalogPath: 'catalog.json',
      themes: const [
        AtlasCaptureThemeSpec(
          id: 'light',
          documentPath: 'themes/light.mix.json',
        ),
        AtlasCaptureThemeSpec(id: 'dark', documentPath: 'themes/dark.mix.json'),
      ],
      components: const [
        AtlasCaptureComponentSpec(
          id: 'button',
          documentPath: 'components/button.component.json',
        ),
      ],
      protocolCoveragePath: 'protocol/coverage.json',
    ),
    assets: [
      const AtlasCaptureAsset(
        sourcePath: 'catalog.json',
        destinationPath: 'catalog.json',
      ),
      ..._directoryAssets(sourceRoot, 'light'),
      ..._directoryAssets(sourceRoot, 'dark'),
      const AtlasCaptureAsset(
        sourcePath: 'protocol/themes/light.mix.json',
        destinationPath: 'themes/light.mix.json',
      ),
      const AtlasCaptureAsset(
        sourcePath: 'protocol/themes/dark.mix.json',
        destinationPath: 'themes/dark.mix.json',
      ),
      const AtlasCaptureAsset(
        sourcePath: 'protocol/themes/light.remix-surfaces.json',
        destinationPath: 'themes/light.remix-surfaces.json',
      ),
      const AtlasCaptureAsset(
        sourcePath: 'protocol/themes/dark.remix-surfaces.json',
        destinationPath: 'themes/dark.remix-surfaces.json',
      ),
      const AtlasCaptureAsset(
        sourcePath: 'protocol/coverage.json',
        destinationPath: 'protocol/coverage.json',
      ),
      const AtlasCaptureAsset(
        sourcePath: 'protocol/fixtures/fortal-tokenized-flex-box.mix.json',
        destinationPath: 'protocol/fixtures/fortal-tokenized-flex-box.mix.json',
      ),
      ..._directoryAssets(sourceRoot, 'components'),
      ..._directoryAssets(sourceRoot, 'styles'),
    ],
    preservedPaths: const {'README.md'},
  );
  final result = checkOnly
      ? AtlasCapturePackager.check(input)
      : AtlasCapturePackager.build(input);

  if (!result.isCurrent) {
    stderr.writeln(
      'Fortal Atlas bundle drift: ${result.driftPaths.join(', ')}',
    );
    stderr.writeln(
      'Run `fvm dart run tool/package_fortal_atlas.dart` to regenerate it.',
    );
    exitCode = 1;

    return;
  }

  stdout.writeln(
    '${checkOnly ? 'Verified' : 'Packaged'} Fortal Atlas bundle: '
    '${result.fileCount} files, ${result.totalBytes} bytes.',
  );
}

List<AtlasCaptureAsset> _directoryAssets(
  Directory sourceRoot,
  String relativePath,
) {
  final directory = Directory('${sourceRoot.path}/$relativePath');
  if (!directory.existsSync()) {
    throw StateError('Missing generated Atlas directory: ${directory.path}');
  }
  final assets = <AtlasCaptureAsset>[
    for (final entity in directory.listSync(recursive: true))
      if (entity is File)
        AtlasCaptureAsset(
          sourcePath: entity.path.substring(sourceRoot.path.length + 1),
          destinationPath: entity.path.substring(sourceRoot.path.length + 1),
        ),
  ];
  assets.sort((left, right) => left.sourcePath.compareTo(right.sourcePath));

  return assets;
}

String _flutterVersion(Directory workspaceRoot) {
  final config = jsonDecode(
    File('${workspaceRoot.path}/.fvmrc').readAsStringSync(),
  );
  if (config is! Map<String, Object?> || config['flutter'] is! String) {
    throw const FormatException('.fvmrc must contain a Flutter version.');
  }

  return config['flutter']! as String;
}
