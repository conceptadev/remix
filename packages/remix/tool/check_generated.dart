import 'dart:io';

Future<void> main() async {
  final packageRoot = Directory.current.absolute;
  final pubspec = File('${packageRoot.path}/pubspec.yaml');
  if (!pubspec.existsSync() ||
      !pubspec.readAsStringSync().contains('name: remix')) {
    stderr.writeln('Run this checker from packages/remix.');
    exitCode = 64;
    return;
  }

  final libraryRoot = Directory('${packageRoot.path}/lib');
  final before = _generatedSnapshot(libraryRoot);
  if (before.isEmpty) {
    stderr.writeln('No committed generated Dart files were found.');
    exitCode = 1;
    return;
  }

  for (final path in before.keys) {
    File('${libraryRoot.path}/$path').deleteSync();
  }

  final process = await Process.start(
    Platform.resolvedExecutable,
    ['run', 'build_runner', 'build'],
    workingDirectory: packageRoot.path,
    mode: ProcessStartMode.inheritStdio,
  );
  final buildExitCode = await process.exitCode;
  if (buildExitCode != 0) {
    _restore(libraryRoot, before, _generatedSnapshot(libraryRoot));
    exitCode = buildExitCode;
    return;
  }

  final after = _generatedSnapshot(libraryRoot);
  final paths = {...before.keys, ...after.keys}.toList()..sort();
  final drift = <String>[];
  for (final path in paths) {
    final oldBytes = before[path];
    final newBytes = after[path];
    if (oldBytes == null) {
      drift.add('$path (created)');
    } else if (newBytes == null) {
      drift.add('$path (missing)');
    } else if (!_sameBytes(oldBytes, newBytes)) {
      drift.add('$path (changed)');
    }
  }

  if (drift.isNotEmpty) {
    stderr.writeln('Clean generated source drift detected (${drift.length}):');
    for (final path in drift) {
      stderr.writeln('- $path');
    }
    _restore(libraryRoot, before, after);
    exitCode = 1;
    return;
  }

  stdout.writeln(
    'Clean generation reproduced ${after.length} committed artifacts '
    'byte-for-byte.',
  );
}

Map<String, List<int>> _generatedSnapshot(Directory root) {
  final snapshot = <String, List<int>>{};
  for (final entity in root.listSync(recursive: true, followLinks: false)) {
    if (entity is! File || !entity.path.endsWith('.g.dart')) continue;
    snapshot[_relativePath(root, entity)] = entity.readAsBytesSync();
  }
  return snapshot;
}

void _restore(
  Directory root,
  Map<String, List<int>> before,
  Map<String, List<int>> after,
) {
  for (final path in after.keys.where((path) => !before.containsKey(path))) {
    File('${root.path}/$path').deleteSync();
  }
  for (final entry in before.entries) {
    final file = File('${root.path}/${entry.key}');
    file.parent.createSync(recursive: true);
    file.writeAsBytesSync(entry.value);
  }
}

String _relativePath(Directory root, File file) =>
    file.path.substring(root.path.length + 1);

bool _sameBytes(List<int> left, List<int> right) {
  if (left.length != right.length) return false;
  for (var index = 0; index < left.length; index += 1) {
    if (left[index] != right[index]) return false;
  }
  return true;
}
