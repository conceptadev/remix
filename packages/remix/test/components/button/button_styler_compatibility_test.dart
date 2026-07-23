import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('keeps RemixButtonStyler source-compatible during migration', () {
    // ignore: deprecated_member_use
    final RemixButtonStyler legacy = RemixButtonStyler().paddingX(12);
    // ignore: deprecated_member_use
    const emptyLegacy = RemixButtonStyler.create();
    // ignore: deprecated_member_use
    final legacyFactory = RemixButtonStyler.color(Colors.blue);

    final ButtonStyler canonical = legacy;
    final legacyWidget = RemixButtonStylerRemixHelpers(
      legacy,
    ).call(child: const Text('Legacy button'));

    expect(canonical, same(legacy));
    expect(legacy.merge(emptyLegacy), isA<ButtonStyler>());
    expect(legacyFactory, isA<ButtonStyler>());
    expect(legacyWidget, isA<RemixButton>());
    expect(legacy.runtimeType, ButtonStyler);
  });
}
