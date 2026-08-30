import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:remix_icons/icons_index.dart';
import 'package:remix_icons/remix_icons.dart';

void main() {
  test('opt-in index lists every RemixIcons constant by Dart member name', () {
    expect(remixIconsByName, hasLength(318));

    expect(
      identical(remixIconsByName['accessibility'], RemixIcons.accessibility),
      isTrue,
    );
    expect(identical(remixIconsByName['check'], RemixIcons.check), isTrue);
    expect(
      identical(remixIconsByName['switchIcon'], RemixIcons.switchIcon),
      isTrue,
    );
    expect(identical(remixIconsByName['zoomOut'], RemixIcons.zoomOut), isTrue);

    final codePoints = <int>{};
    for (final entry in remixIconsByName.entries) {
      expect(entry.key, matches(RegExp(r'^[a-z][A-Za-z0-9]*$')));
      expect(entry.value.fontFamily, 'RemixIcons');
      expect(entry.value.fontPackage, 'remix_icons');
      expect(codePoints.add(entry.value.codePoint), isTrue);
    }
  });

  test('main library does not export the index; provider stays map-free', () {
    final library = File('lib/remix_icons.dart').readAsStringSync();
    final provider = File(
      'lib/src/generated/remix_icons.dart',
    ).readAsStringSync();

    expect(library, isNot(contains('icons_index')));
    expect(library, isNot(contains('remixIconsByName')));
    expect(provider, isNot(contains('Map<String')));
    expect(provider, contains('abstract final class RemixIcons'));
  });
}
