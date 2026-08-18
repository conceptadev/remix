import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/icons_index.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'fortal_icons_by_name_expected.dart';

void main() {
  test('opt-in index lists every FortalIcons constant by Dart member name', () {
    expect(fortalIconsByName, hasLength(318));
    expect(fortalIconsByName.keys, expectedFortalIconsByName.keys);
    expect(fortalIconsByName, expectedFortalIconsByName);

    expect(fortalIconsByName['accessibility'], FortalIcons.accessibility);
    expect(fortalIconsByName['check'], FortalIcons.check);
    expect(fortalIconsByName['switchIcon'], FortalIcons.switchIcon);
    expect(fortalIconsByName['zoomOut'], FortalIcons.zoomOut);

    for (final entry in fortalIconsByName.entries) {
      expect(entry.key, matches(RegExp(r'^[a-z][A-Za-z0-9]*$')));
      expect(entry.value.fontFamily, 'FortalIcons');
      expect(entry.value.fontPackage, 'remix_fortal');
    }
  });

  test('main library does not export the index; provider stays map-free', () {
    final library = File('lib/remix_fortal.dart').readAsStringSync();
    final provider = File(
      'lib/src/radix/icons/generated/fortal_icons.dart',
    ).readAsStringSync();

    expect(library, isNot(contains('icons_index')));
    expect(library, isNot(contains('fortalIconsByName')));
    expect(provider, isNot(contains('Map<String')));
    expect(provider, contains('abstract final class FortalIcons'));
  });
}
