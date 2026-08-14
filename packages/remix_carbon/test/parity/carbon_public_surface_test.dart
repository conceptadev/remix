import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the remix_carbon package identity and public entrypoint', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final entrypoint = File('lib/remix_carbon.dart');

    expect(pubspec, contains('name: remix_carbon\n'));
    expect(entrypoint.existsSync(), isTrue);
    expect(entrypoint.readAsStringSync(), contains('library remix_carbon;'));
    expect(File('lib/carbon.dart').existsSync(), isFalse);
  });

  test('every parity family has a library, export, API, and focused test', () {
    final manifest =
        jsonDecode(
              File('reference/carbon_1_114_0/manifest.json').readAsStringSync(),
            )
            as Map<String, Object?>;
    final families = [
      ...manifest['coreFamilies']! as List<Object?>,
      ...manifest['extensions']! as List<Object?>,
    ].cast<Map<String, Object?>>();
    final barrel = File('lib/src/components/components.dart');

    expect(barrel.existsSync(), isTrue, reason: 'Missing component barrel.');
    final exports = barrel.existsSync() ? barrel.readAsStringSync() : '';

    for (final family in families) {
      final id = family['id']! as String;
      final library = File('lib/src/components/$id/$id.dart');
      final testFile = File('test/components/carbon_${id}_test.dart');

      expect(library.existsSync(), isTrue, reason: '$id has no library.');
      expect(
        exports,
        contains("export '$id/$id.dart';"),
        reason: '$id is missing from the component barrel.',
      );
      expect(
        testFile.existsSync(),
        isTrue,
        reason: '$id has no focused component test.',
      );

      if (!library.existsSync()) continue;
      final implementation = Directory('lib/src/components/$id')
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .map((file) => file.readAsStringSync())
          .join('\n');
      for (final api in family['publicApi']! as List<Object?>) {
        expect(
          implementation,
          contains(api),
          reason: '$id does not define or generate $api.',
        );
      }
    }
  });
}
