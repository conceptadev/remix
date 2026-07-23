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
  final before = _snapshot(libraryRoot);
  final process = await Process.start(
    Platform.resolvedExecutable,
    ['run', 'build_runner', 'build'],
    workingDirectory: packageRoot.path,
    mode: ProcessStartMode.inheritStdio,
  );
  final buildExitCode = await process.exitCode;
  if (buildExitCode != 0) {
    exitCode = buildExitCode;
    return;
  }

  final after = _snapshot(libraryRoot);
  final paths = {...before.keys, ...after.keys}.toList()..sort();
  final drift = <String>[];
  for (final path in paths) {
    final oldBytes = before[path];
    final newBytes = after[path];
    if (oldBytes == null) {
      drift.add('$path (created)');
    } else if (newBytes == null) {
      drift.add('$path (deleted)');
    } else if (!_sameBytes(oldBytes, newBytes)) {
      drift.add('$path (changed)');
    }
  }

  if (drift.isNotEmpty) {
    stderr.writeln('Generated source drift detected (${drift.length}):');
    for (final path in drift) {
      stderr.writeln('- $path');
    }
    exitCode = 1;
    return;
  }

  stdout.writeln(
    'Generated sources are current: ${after.length} library Dart files '
    'remained byte-for-byte unchanged.',
  );
}

Map<String, List<int>> _snapshot(Directory root) {
  final snapshot = <String, List<int>>{};
  for (final entity in root.listSync(recursive: true, followLinks: false)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    snapshot[_relativePath(root, entity)] = entity.readAsBytesSync();
  }
  return snapshot;
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
