import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:registry_source/fortal.dart';

void main() {
  test('fortal recipes return canonical stylers', () {
    expect(fortalMenuStyle(), isA<MenuStyler>());
    expect(fortalMenuItemStyle(), isA<MenuItemStyler>());
  });
}
