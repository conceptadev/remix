import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  test('fortal recipes return canonical stylers', () {
    expect(fortalMenuStyle(), isA<MenuStyler>());
    expect(fortalMenuItemStyle(), isA<MenuItemStyler>());
  });
}
